---
layout: post
title: "Sometimes You Shouldn't Store Timestamps in UTC"
author: Matt
tags: newsletter
image: /img/always-store-utc/clocks.jpg
excerpt_separator: <!--more-->
---

![Clocks]({{ site.baseurl }}/img/always-store-utc/clocks.jpg)

Most database guides recommend storing timestamps in the UTC timezone (search "store timestamp utc" for plenty of examples).  Doing so will let you compare timestamps easily, localize to a variety of locales and avoid (or at least delay) some of the headache that Daylight Saving can cause.

<!--more-->

Given this, I naturally chose to store timestamps in UTC for Buckets budget files (which are just [SQLite databases](/2017/11/02/sqlite.html)).

However, this last weekend was Daylight Saving time.  And I've since realized there's at least one case where it's better to store timestamps in local times.

## Walled Months

Buckets is a monthly budgeting program.  You budget what you'll spend in a month, earn income in a month, adjust during the month, then do it again for the next month.  Having these walled-in months makes it easy to be "done" with a month.  "Done" typically means:

- all budgeting has happened
- all income is recorded
- all expenses are recorded
- everything is reconciled and the numbers all add up

Everything has been going swimmingly, until this past weekend.  Monday, a user reported missing transactions and empty buckets.  No one likes having empty buckets.

After some digging and false starts on not-the-real-problem I realized the main problem with storing these particular dates in UTC&mdash;

## What is a March?

I have completed my budget for March. Yay!

But what is "March?"

It depends where you live.  I live in beautiful Utah, where "March" runs

- from March 1 at 7AM UTC
- to April 1 at 6AM UTC

If I finished my March budget in Utah then moved to India "March" would go

- from February 28 at 6:30pm UTC
- to March 31 at 6:30pm UTC

And there's the problem.  If my budget's transactions are all stored in UTC time, then when I move timezones, my completed "March" is different.  A few transactions might leak out one side and a few more could leak in the other side.

So, the newest version of Buckets stores transaction posting dates in "local time" wherever that happens to be.  A transaction that happened on March 1st at midnight in Utah will still show as having happened March 1st at midnight in India.


&mdash; Matt
