---
layout: post
title: "New Feature: New Wealth Charts"
author: Matt
tags: newsletter
image: /img/net-wealth/netwealthchart.png
excerpt_separator: <!--more-->
---

With the release of Buckets v0.51.0, you can now track your net wealth over time.

<figure>
<img alt="Net Wealth Chart" src="{{ site.url }}/img/net-wealth/netwealthchart.png"/>
</figure>

<!--more-->

Find the new charts by clicking *Analysis* then *Net Wealth*.  This is a first draft.  I imagine the look of the charts may change over time. Now would be a good time for feedback :wink:

Every time I work on charts, I'm surprised how many decisions have to be made to make the chart work well.  For instance, using a continuous line to represent Net Wealth is deceptive.  In the above chart the line somewhat implies that half way between the end of April and the end of May the Net Wealth was around -20,000.  In reality, it changed in one big leap from -34,000 to -10,000.

So we chose to make the line dashed instead of solid to help indicate that not every point on the line actually happened.

Anyway, feedback is welcome :)

## Why "Wealth" instead of "Worth?"

Buckets intentionally uses the term *Net Wealth* instead of the standard accounting term *Net Worth* because Buckets doesn't have the ability to measure your worth, only your wealth.

It's too easy to get tricked into thinking that our worth is defined by some number in a bank account.  We are worth so much more than that.  As evidence, here's one of my daughters&mdash;worth everything in the world to me but without a cent to her name.

<img alt="A baby" src="{{site.url}}/img/net-wealth/baby.jpg" style="border-radius: 6px;"/>

And remember that someone else feels about you the same way I feel about her.

Okay, sentimental preachiness over :)

&mdash; Matt
