---
layout: post
title: "Sometimes You Shouldn't Store Timestamps in UTC"
author: Matt
tags: tech
image: /img/always-store-utc/clocks.jpg
excerpt_separator: <!--more-->
---

![Clocks]({{ site.baseurl }}/img/always-store-utc/clocks.jpg)

A bug turned up in Buckets after this Daylight Saving weekend, and while fixing it, I realized that it was a mistake to store some particular timestamps in UTC.

Most database guides recommend storing timestamps in the UTC timezone (search "store timestamp utc" for plenty of examples).  In general, this is the right advice.  Doing so will let you compare timestamps easily, localize to a variety of locales and avoid (or at least delay) some of the headache that Daylight Saving can cause.

But here's one case where I ought to have thought more carefully about the data.

<!--more-->

## Walled Months

Buckets is a monthly budgeting program.  You budget what you'll spend in a month, earn income in a month, adjust during the month, then do it again for the next month.  Having these walled-in months makes it easy to be "done" with a month.  "Done" typically means:

- all budgeting has happened
- all income is recorded
- all expenses are recorded
- everything is reconciled and the numbers all add up

It's very nice at the end of March to say "I've completed my budget for March.  Yay!"

## But what is "March?"

The definition of "March" depends where you live.  I live in [beautiful Utah](https://duckduckgo.com/?q=pictures+of+utah&t=hf&ia=images&iax=images), where "March" runs from March 1 at 7AM UTC to April 1 at 6AM UTC.  However, in India, "March" is from February 28 at 6:30pm UTC to March 31 at 6:30pm UTC.

![March in various time zones]({{ site.baseurl }}/img/always-store-utc/march.png)

If I completed my March budget in Utah, then moved to India, suddenly, a transaction that happened Feb 28 at 10pm is included in my Indian March and a transaction that happened late in my Utah March is now part of Indian April.

So, to fix both some Daylight Saving bugs and to keep the definition of "March" consistent per user, the [newest version of Buckets](https://www.budgetwithbuckets.com/) stores transaction posting dates in "local time" wherever that happens to be.  However, Buckets still stores some timestamps in UTC time (e.g. database row creation times).

In conclusion, use recommendations but also break away from them when needed.

&mdash; Matt
