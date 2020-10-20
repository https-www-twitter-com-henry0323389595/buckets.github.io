---
layout: post
title: What's Taking so Long on the Buckets Mobile App?
author: Matt
tags: newsletter
image: /img/whats-taking-so-long/clock.jpg
excerpt_separator: <!--more-->
---

All you Buckets users are very patient! The mobile app has been in development for a long, *long* time.  And it's fair for you to ask: "what's taking so long?"  Hopefully the post will shed some light on the process.

<img alt="Picture of a clock -- Photo by Ralph Hutter" src="{{site.url}}/img/whats-taking-so-long/clock.jpg" style="border-radius: 6px;"/>

<!--more-->

## Life

Buckets is a part-time project. I also have a full-time job, a family, [SimpleFIN](https://bridge.simplefin.org), a pandemic, etc... I *really enjoy* the time I get to spend working on making Buckets. And every time my wife and I sit down to use it, I'm reminded how much I like Buckets as a tool for doing our budget.  I don't get as much time as I'd like, though thankfully I do get quite a bit of time, considering all of life's demands.

When I do spend time on Buckets, the mobile app is at the top of my list.  Literally.  Here's the list that's been on my desk for a while:

<img alt="A todo list with the second item being Mobile App" src="{{site.url}}/img/whats-taking-so-long/todolist.jpg" style="border-radius: 6px;"/>

## I'm learning

I've never made a mobile app before, and I'm walking up the app-making learning curve as I work on Buckets mobile.  So then...

## Why not let someone else make the mobile app?

Several generous developers have offered to make or help make a mobile app. I don't have money to pay another developer, so that leaves two other options:

1. An open source, community-built mobile app
2. Make the app myself

I'm not opposed to the community-built app, and I'm not opposed to people making tools to interface with Buckets or budget files.  It makes me happy to see programmers writing scripts to import transactions or automatically categorize them.  But **right now** it would difficult for an open source app to work with the desktop app in an always-backward-compatible way because, other than the budget file, there's no shared code to be used as a basis for a mobile app and desktop app.

This lack of desktop-mobile shared code is the biggest reason why progress is slow and where I spend most of my time.

## Growing a Shared Basis

Buckets was originally written for the desktop in JavaScript with an SQLite database.  It looked like this:

<style>
line {
  stroke: black;
  stroke-width: 1px;
}
text {
  font-size: 1em;
}
.javascript {
  fill: #1abc9c;
}
.sqlite {
  fill: #e67e22;
}
.nim {
  fill: #e74c3c;
}
.desktop {
  fill: #3498db;
}
.mobile {
  fill: #9b59b6;
}
</style>

<svg viewBox="0 0 600 100" width="600" height="100" xmlns="http://www.w3.org/2000/svg">
  <!-- SQLITE to JavaScript -->
  <line x1="50" y1="60" x2="150" y2="60" />
  <!-- JavaScript to Desktop -->
  <line x1="150" y1="60" x2="300" y2="60" />

  <circle r="16" cx="50" cy="60" class="sqlite" />
  <text x="50" y="12" text-anchor="middle">SQLite</text>
  <circle r="36" cx="150" cy="60" class="javascript" />
  <text x="150" y="12" text-anchor="middle">JavaScript</text>

  <circle r="16" cx="300" cy="60" class="desktop" />
  <text x="300" y="12" text-anchor="middle">Buckets Desktop</text>
</svg>

The JavaScript code is responsible for everything that happens in Buckets; things such as:

- Computing your budget's *Rain* amount
- Matching imported transactions to existing transactions
- Determining self-debt
- etc...

It's important that the desktop and mobile app match *exactly.*  It's not acceptable for one version of the application to say you have $1000 Rain and the other to say $999.  While I've explored [some methods](/2018/12/13/making-an-app-2018.html) for sharing JavaScript code between desktop apps and mobile apps, after trying to make the mobile app with only JavaScript, it quickly became apparent that the code wasn't as portable as I hoped.

So I've been extracting segments of the JavaScript into the [Nim](https://nim-lang.org/) language.  Nim can emit both C (which is highly portable) and JavaScript. Some logic is also being pushed into SQLite.

The process looks a bit like this now:

<style>
@keyframes shrink {
  0% { transform: scale(1); }
  10% { transform: scale(0.95); }
  100% { transform: scale(1); }
}
.shrink {
  animation: shrink 3s ease-out 1s infinite normal;
}
@keyframes grow {
  0% { transform: scale(1); }
  10% { transform: scale(1.1); }
  100% { transform: scale(1); }
}
.grow {
  animation: grow 3s ease-out 2.5s infinite normal;
}
</style>

<svg viewBox="0 0 600 200" width="600" height="200" xmlns="http://www.w3.org/2000/svg">

  <!-- JavaScript to Desktop -->
  <line x1="150" y1="60" x2="300" y2="60" />
  <!-- Nim to SQLite -->
  <line x1="50" y1="60" x2="100" y2="140" />
  <!-- JavaScript to Nim -->
  <line x1="150" y1="60" x2="100" y2="140" />
  <!-- Mobile to Nim -->
  <line x1="100" y1="140" x2="300" y2="140" />
  <!-- Mobile to JavaScript -->
  <line x1="150" y1="60" x2="300" y2="140" />
  <!-- Desktop to Nim -->
  <line x1="100" y1="140" x2="300" y2="60" />

  <circle id="jstonim" r="5" cx="150" cy="60" class="nim jstonim" />
  <animate 
    xlink:href="#jstonim"
    attributeName="cy"
    from="60"
    to="140" 
    dur="3s"
    repeatCount="indefinite" />
  <animate 
    xlink:href="#jstonim"
    attributeName="cx"
    from="150"
    to="100" 
    dur="3s"
    repeatCount="indefinite" />
  
  <circle id="jstosqlite" r="5" cx="150" cy="60" class="sqlite jstosqlite" />
  <animate 
    xlink:href="#jstosqlite"
    attributeName="cy"
    from="60"
    to="60" 
    dur="3s"
    repeatCount="indefinite" />
  <animate 
    xlink:href="#jstosqlite"
    attributeName="cx"
    from="150"
    to="50" 
    dur="3s"
    repeatCount="indefinite" />

  <circle r="16" cx="50" cy="60" class="sqlite grow" style="transform-origin: 50px 60px;"/>
  <text x="50" y="12" text-anchor="middle">SQLite</text>
  <circle r="36" cx="150" cy="60" class="javascript shrink" style="transform-origin: 150px 60px;"/>
  <text x="150" y="12" text-anchor="middle">JavaScript</text>

  <circle r="16" cx="300" cy="60" class="desktop" />
  <text x="300" y="12" text-anchor="middle">Buckets Desktop</text>

  <circle r="16" cx="100" cy="140" class="nim grow" style="transform-origin: 100px 140px;"/>
  <text x="100" y="180" text-anchor="middle">Nim</text>

  <circle r="16" cx="300" cy="140" class="mobile" />
  <text x="300" y="180" text-anchor="middle">Buckets Mobile</text>
</svg>

The end result is cross-platform, cross-language code that can be used as a solid basis for Buckets Desktop and Buckets Mobile.  (And Buckets Command Line, but that's a secret).  Beyond portability, this porting from JavaScript to Nim also makes for a smaller application size and some increased speed.

It's slow, but the mobile app is coming!

&mdash; Matt
