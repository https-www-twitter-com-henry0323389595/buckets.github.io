---
layout: post
title: Implementing a Change Log with SQLite
author: Matt
tags: tech
# image:
excerpt_separator: <!--more-->
---

Sometimes you want a log of all changes to the data in your database (every INSERT, UPDATE and DELETE).  In Buckets' case, such a log is used to help merge budget files.

In this post, I'll show you how to add change tracking to your SQLite database in a manner that is superior to every other method I've seen online.

<!--more-->

I'm not saying *I'm* superior; this *method* is.  Also, someone has probably already done this and I just couldn't find it.

## Do you need it?

Before you start tracking every single change in your database, decide if you really need it.  You might be able to get away with tracking specific columns, for instance.

---

## The Data

I have a `people` table created with the following SQL:

```sql
CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name TEXT,
    age INTEGER
);
```

## Some Okay Options

Searching online, most approaches to this problem do one of the following.  There are variations of each these.  Also, I'm intentionally not showing all the triggers required to make these work for the sake of brevity.

### A) Log Columns

One method has you log each column's changes individually.  Such a table might look like this:

```sql
CREATE TABLE column_log (
    id INTEGER PRIMARY KEY,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    table_name TEXT,
    column_name TEXT,
    oldval TEXT,
    newval TEXT
);
```

Pros:

- Highly granular
- Records only columns that changed

Cons:

- Creates lots of rows
- You lose type info
- A single UPDATE/INSERT is broken up into many rows (which may be cumbersome to reconstruct)

### B) Custom Log Tables

This method requires that you create a log table per data table and keep the schema in sync.  Something like:

```sql
CREATE TABLE people_log (
    id INTEGER PRIMARY KEY,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_id INTEGER,
    new_id INTEGER,
    old_created TIMESTAMP,
    new_created TIMESTAMP,
    old_name TEXT,
    new_name TEXT,
    old_age TEXT,
    new_age TEXT
);
```

Pros:

- Your change log entry's schema will always match your data's schema.


Cons:

- You have to remember to update the log table's schema.
- Double the number of tables

### C) Store SQL

You could store the SQL used to make each change (or unmake it, if you prefer), similar to the Undo/Redo technique described [here](https://www.sqlite.org/undoredo.html).  Buckets uses a version of this method for its undo/redo feature.

```sql
CREATE TABLE change_log_sql (
    id INTEGER PRIMARY KEY,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT
);

-- Inserts
CREATE TRIGGER people_insert
AFTER INSERT ON people
BEGIN
    INSERT INTO change_log_sql (action)
    VALUES ('INSERT INTO people(id,created,name,age)
        VALUES(
            '||quote(NEW.id)||',
            '||quote(NEW.created)||',
            '||quote(NEW.name)||',
            '||quote(NEW.age)||')');
END;

-- Updates
CREATE TRIGGER people_update
AFTER UPDATE ON people
BEGIN
    INSERT INTO change_log_sql (action)
    VALUES ('UPDATE people SET
        id='||quote(NEW.id)||',
        created='||quote(NEW.created)||',
        name='||quote(NEW.name)||',
        age='||quote(NEW.age)||' WHERE id='||quote(OLD.id));
END;

-- and similarly for deletes...
```

Pros:

- You could easily replay these.
- Type information is preserved.

Cons:

- You have to parse SQL to do anything other than replay.

---

## SQLite + JSON

SQLite includes some [nice JSON functions](https://www.sqlite.org/json1.html).  Before showing you how to use them to make a change log, here's how each function works on its own:

### json_array

```sql
sqlite> select json_array(1, "hello", "world") as data;
data               
-------------------
[1,"hello","world"]   
```

### json_extract

```sql
sqlite> select json_extract('{"foo": "bar"}', '$.foo') as data;
data      
----------
bar      
```

### json_group_object

This is an aggregate function.

```sql
sqlite> create temporary table foo (a, b);
sqlite> insert into foo (a, b) values ("Alice", 30), ("Bob", 42);
sqlite> select json_group_object(a, b) as data from foo;
data
-----------------------
{"Alice":30,"Bob":42}
```

### json_each

This is a table-value function (it produces a table).

```sql
sqlite> select * from json_each(json_array("apple","banana","cow"));
key         value       type        atom        id          parent      fullkey     path      
----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
0           apple       text        apple       1                       $[0]        $         
1           banana      text        banana      2                       $[1]        $         
2           cow         text        cow         3                       $[2]        $         
```

## JSON Change Logs

Using the above functions, you can make change logs.

### Version 1 - Track Everything

The following change log table tracks all changes to all columns:

```sql
-- Data table
CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name TEXT,
    age INTEGER
);

-- Change log table
CREATE TABLE change_log (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT,
    table_name TEXT,
    obj_id INTEGER,
    changes TEXT
);

-- Insert Trigger
CREATE TRIGGER people_track_insert
AFTER INSERT ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'INSERT', 'people', NEW.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', null, NEW.id),
            json_array('created', null, NEW.created),
            json_array('name', null, NEW.name),
            json_array('age', null, NEW.age)
          )
        )
      )
    );
END;

-- Update Trigger
CREATE TRIGGER people_track_update
AFTER UPDATE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'UPDATE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, NEW.id),
            json_array('created', OLD.created, NEW.created),
            json_array('name', OLD.name, NEW.name),
            json_array('age', OLD.age, NEW.age)
          )
        )
      )
    );
END;

-- Delete Trigger
CREATE TRIGGER people_track_delete
AFTER DELETE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'DELETE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, null),
            json_array('created', OLD.created, null),
            json_array('name', OLD.name, null),
            json_array('age', OLD.age, null)
          )
        )
      )
    );
END;
```

```
sqlite> INSERT INTO people (name, age) VALUES ('Alice', 30), ('Bob', 42);
sqlite> UPDATE people SET age = age + 2;
sqlite> UPDATE people SET name = 'Eva' WHERE name='Alice';
sqlite> DELETE FROM people WHERE name = 'Bob';
sqlite> SELECT * FROM change_log;
id   created     action      table_name  obj_id  changes                                                                         
---  ----------  ----------  ----------  ------  --------------------------------------------------------------------------------
1    2018-08-27  INSERT      people      1       {"id":[null,1],"created":[null,"2018-08-27 21:53:02"],"name":[null,"Alice"],"age
2    2018-08-27  INSERT      people      2       {"id":[null,2],"created":[null,"2018-08-27 21:53:02"],"name":[null,"Bob"],"age":
3    2018-08-27  UPDATE      people      1       {"id":[1,1],"created":["2018-08-27 21:53:02","2018-08-27 21:53:02"],"name":["Ali
4    2018-08-27  UPDATE      people      2       {"id":[2,2],"created":["2018-08-27 21:53:02","2018-08-27 21:53:02"],"name":["Bob
5    2018-08-27  UPDATE      people      1       {"id":[1,1],"created":["2018-08-27 21:53:02","2018-08-27 21:53:02"],"name":["Ali
6    2018-08-27  DELETE      people      2       {"id":[2,null],"created":["2018-08-27 21:53:02",null],"name":["Bob",null],"age":
```

### Version 2 - Only Track Changes

There's a lot of duplicate information in the above version (for instance, the created timestamp never changes after INSERT but it recorded twice for every UPDATE).  This version improves on the other by only recording values that have changed.

```sql
-- Data table
CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name TEXT,
    age INTEGER
);

-- Change log table
CREATE TABLE change_log (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT,
    table_name TEXT,
    obj_id INTEGER,
    changes TEXT
);

-- Insert Trigger
CREATE TRIGGER people_track_insert
AFTER INSERT ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'INSERT', 'people', NEW.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', null, NEW.id),
            json_array('created', null, NEW.created),
            json_array('name', null, NEW.name),
            json_array('age', null, NEW.age)
          )
        )
      WHERE oldval IS NOT newval
      )
    );
END;

-- Update Trigger
CREATE TRIGGER people_track_update
AFTER UPDATE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'UPDATE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, NEW.id),
            json_array('created', OLD.created, NEW.created),
            json_array('name', OLD.name, NEW.name),
            json_array('age', OLD.age, NEW.age)
          )
        )
      WHERE oldval IS NOT newval
      )
    );
END;

-- Delete Trigger
CREATE TRIGGER people_track_delete
AFTER DELETE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, changes)
  SELECT
    'DELETE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, json_array(oldval, newval)) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, null),
            json_array('created', OLD.created, null),
            json_array('name', OLD.name, null),
            json_array('age', OLD.age, null)
          )
        )
      WHERE oldval IS NOT newval
      )
    );
END;
```

```
sqlite> INSERT INTO people (name, age) VALUES ('Alice', 30), ('Bob', 42);
sqlite> UPDATE people SET age = age + 2;
sqlite> UPDATE people SET name = 'Eva' WHERE name='Alice';
sqlite> DELETE FROM people WHERE name = 'Bob';
sqlite> SELECT * FROM change_log;
id   created     action      table_name  obj_id  changes                                                                         
---  ----------  ----------  ----------  ------  --------------------------------------------------------------------------------
1    2018-08-27  INSERT      people      1       {"id":[null,1],"created":[null,"2018-08-27 21:53:25"],"name":[null,"Alice"],"age
2    2018-08-27  INSERT      people      2       {"id":[null,2],"created":[null,"2018-08-27 21:53:25"],"name":[null,"Bob"],"age":
3    2018-08-27  UPDATE      people      1       {"age":[30,32]}                                                                 
4    2018-08-27  UPDATE      people      2       {"age":[42,44]}                                                                 
5    2018-08-27  UPDATE      people      1       {"name":["Alice","Eva"]}                                                        
6    2018-08-27  DELETE      people      2       {"id":[2,null],"created":["2018-08-27 21:53:25",null],"name":["Bob",null],"age":
```

### Version 3 - Only Old Values

In Buckets, most records are inserted and never updated, and very few are deleted.  So to save on space, there's another optimization that favors this use case.  Instead of storing both old and new values, only storing old values means that:

- no information is duplicated for INSERTS
- each change entry is smaller, too.

More application work is required to piece together a full change log but all the information is still available.

```sql
-- Data table
CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name TEXT,
    age INTEGER
);

-- Change log table
CREATE TABLE change_log (
    id INTEGER PRIMARY KEY,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action TEXT,
    table_name TEXT,
    obj_id INTEGER,
    oldvals TEXT
);

-- Insert Trigger
CREATE TRIGGER people_track_insert
AFTER INSERT ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id)
  VALUES ('INSERT', 'people', NEW.id);
END;

-- Update Trigger
CREATE TRIGGER people_track_update
AFTER UPDATE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, oldvals)
  SELECT
    'UPDATE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, oldval) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, NEW.id),
            json_array('created', OLD.created, NEW.created),
            json_array('name', OLD.name, NEW.name),
            json_array('age', OLD.age, NEW.age)
          )
        )
      WHERE oldval IS NOT newval
      )
    );
END;

-- Delete Trigger
CREATE TRIGGER people_track_delete
AFTER DELETE ON people
BEGIN
  INSERT INTO change_log (action, table_name, obj_id, oldvals)
  SELECT
    'DELETE', 'people', OLD.id, changes
  FROM
    (SELECT
      json_group_object(col, oldval) AS changes
    FROM
      (SELECT
        json_extract(value, '$[0]') as col,
        json_extract(value, '$[1]') as oldval,
        json_extract(value, '$[2]') as newval
      FROM
        json_each(
          json_array(
            json_array('id', OLD.id, null),
            json_array('created', OLD.created, null),
            json_array('name', OLD.name, null),
            json_array('age', OLD.age, null)
          )
        )
      WHERE oldval IS NOT newval
      )
    );
END;
```

```
sqlite> INSERT INTO people (name, age) VALUES ('Alice', 30), ('Bob', 42);
sqlite> UPDATE people SET age = age + 2;
sqlite> UPDATE people SET name = 'Eva' WHERE name='Alice';
sqlite> DELETE FROM people WHERE name = 'Bob';
sqlite> SELECT * FROM change_log;
id   created     action      table_name  obj_id  oldvals                                                                         
---  ----------  ----------  ----------  ------  --------------------------------------------------------------------------------
1    2018-08-27  INSERT      people      1                                                                                       
2    2018-08-27  INSERT      people      2                                                                                       
3    2018-08-27  UPDATE      people      1       {"age":30}                                                                      
4    2018-08-27  UPDATE      people      2       {"age":42}                                                                      
5    2018-08-27  UPDATE      people      1       {"name":"Alice"}                                                                
6    2018-08-27  DELETE      people      2       {"id":2,"created":"2018-08-27 21:53:53","name":"Bob","age":44}                  
```

## Using sqlite_master and table_info

To make sure I never miss a column, I use `sqlite_master` and `PRAGMA table_info(TABLENAME)` to generate the trigger SQL as in this pseudo code:

```python
rows = Query("SELECT name FROM sqlite_master WHERE type='table'")
for row in rows:
  columns = Query("PRAGMA table_info(" + row.name + ")")
  # generate SQL using this table and column list
```

&mdash; Matt
