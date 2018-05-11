---
layout: post
title: 'Desktop App: Lessons Learned'
author: Matt
tags: tech
image: /img/desktop-lessons/bucketsondesktop.jpg
excerpt_separator: <!--more-->
---

Last year I finished porting [Buckets](https://www.budgetwithbuckets.com) from the web to a desktop app.  I'm pleased both with how it turned out and with what I've learned.  For the benefit of anyone else making desktop applications in 2018, here's a few thoughts.

![Photo by Clément H on Unsplash with cheesy addition of Buckets logo by me]({{site.url}}/img/desktop-lessons/bucketsondesktop.jpg)

<!--more-->

## The most important feature is bug reporting

Buckets' **most important feature** has nothing to do with budgeting&mdash;it's bug reporting.  Arguably, this is true for web applications too.  In either case, you want to know when your program fails.  But even in the worst web environment, you usually still have access logs.  For a desktop app, you get nothing by default.

For bug reporting:

- **Spend the time**
  
  I've spent much more time working on the error reporting and logging features than I planned to.  But it has been worth it.  Make bug reporting seamless.

- **Test often**
  
  As in any context, if your bug reporting feature is broken... there's no way for users to report it :)  So one step in my release process for *every* version is to submit a bug and make sure I get the report.

- **Simplify**

  In an earlier version, errors would prompt users with three actions: report the error, ignore the error or chat with me about it.  Since cutting it down to just **report** and **ignore** the number of bug reports has increased.  I may further simplify the error form, too.

![Error form]({{site.url}}/img/desktop-lessons/error-prompt.png)


## No server is the best server

Since moving to the desktop, I haven't received a single complaint about the website being down...  because the database has never gone down...  because there is no database.  [Stripe](https://stripe.com), [PayPal](https://www.paypal.com) and email are my database.

And I **love** it!

- **Peace**

  Knowing that the website can go down and people will still be able to use their application gives me peace.

- **Privacy**

  I store almost nothing about users.  If you buy a license or email me, I'll have your email address, and that's about it.

- **Cost**

  The cost of running a mostly static site is very low.


## Translations

The value of internationalization (I18N) surprised me.  Early on in development, somewhat on a whim, I translated Buckets into Spanish.  I hesitated a bit because I knew it would increase the complexity of the application (potentially, by a lot).  But I'm glad I did, because it has made Buckets available to more people.

- **International users**

  Getting to interact with people who speak other languages is very fun for me (I'm kind of a language nerd).  And I've been pleasantly surprised by the [volunteer translators](https://github.com/buckets/translations#current-language-support) efforts.  But I hadn't considered how much I18N and L10N would increase Buckets' appeal.  There are people all over the world using Buckets.

- **Forced simplicity**

  Knowing that whatever I write will have to be translated forces me to be simpler in how I communicate.  Take a sentence like "You have 5 left."  Suppose the 5 might sometimes be 4, sometimes 1 and sometimes 0.  How do you translate that into Spanish?  What's the gender of the noun?  What are the variations in German?  Instead of attempting to deal with these possible problems, it's often easier to put an icon next to a 5.

- **Do it early**

  I'm glad I put I18N and L10N in early on.  It would be a lot of work to retrofit.  That said, it wouldn't be *impossible* to retrofit and supporting multiple languages may not be a requirement for your app.

### Translation technical details

The localization module is homegrown and uses TypeScript to provide context to translators and ensure that translations aren't omitted (see below).  I may later open source it if there's interest.  I can mark up strings in one of three ways (similar to gettext):

1. Simple (for short strings)
    
    ```typescript
    sss('Click me')
    ```

2. Tagged (for long strings)

    ```typescript
    sss('look-out', "Look out behind you, good sir.")
    ```

3. Function (for anything you can imagine)

    ```typescript
    sss('x-left', (x:number) => {
        return `You have ${x} left.`
    })
    ```

Additional context can be put in a comment.   (Since comments are removed during compilation, *in theory* this reduces the app's file size and JavaScript loading time.  In *practice*, Buckets is an Electron app, so executable size is already ridiculous):

```typescript
sss('Ugly'/* adjective referring to a boat */)
```

Using TypeScript's compiler, message files [like these](https://github.com/buckets/translations/blob/master/langs/fr.tsx#L31) are extracted from the source.  Here's an example message as would be given to a translator:

```typescript
  "Animation": {
    /* Label for application preference enabling/disabling animations */
    val: "Animations",
    translated: true,
    h: "Vk4XaMgXNIEY4+Gcal1n+qdnamgr4Q5af/+wzFRoIHU=",
  },
  "match-count": {
    val: (current_match:number, total_matches:number) => {
        return `${current_match} parmi ${total_matches}`;
      },
    translated: true,
    h: "gGpkwXhLiDpxY0YOCXAFl6Q8D6sb7BX93TqgFRObOqo=",
  },
```

Yes, the translators are translating a TypeScript function.  It beats inventing a new message format.

## Electron

Buckets is an [Electron](https://electronjs.org) app.  I like Electron.  I've enjoyed how easy it has been for me to make a cross-platform app.  Perhaps it was especially easy given that Buckets was a web app first.

- **Hello, World!**

  Of all the cross-platform application libraries out there, Electron has the [best Hello World](https://github.com/electron/electron-quick-start#to-use).  With Electron, I went from nothing to cross-platform app in minutes.

  That said, a Hello World is only one metric (and possibly a deceptive one).  Easy to start does not necessarily mean easy to maintain.

- **Auto updating**

  Thanks to [electron-builder](https://electron.build), it's pretty easy to have an auto-updating app *that doesn't even require running another server.*  Check out [my most popular repo on GitHub :)](https://github.com/iffy/electron-updater-example)

Electron justifiably has critics.  It consumes a good chunk of memory, can hog the CPU and application file sizes are large.  But the simple startup and familiar technologies win.  I'm always looking at [alternatives](https://docs.google.com/spreadsheets/d/1dTZIp6z2J1IL7YgBlHG_x68x0_zfecU0MTsjTXn1E3A/edit?usp=sharing), but I still haven't successfully launched a Qt application.

### Challenge 

In fact, I offer a challenge to every cross-platform app-making technology.  Provide a single GitHub repo that:

- Launches a dev build of a Hello World app with a single command (e.g. `electron .`)
- Builds a distributable version of the app with a single command (e.g. `electron-builder -mwl`)
- Auto-updates from GitHub (or an HTTP server)
- Is code signed

## Would do it again

Moving to a desktop app was the right move for Buckets.  Maybe it's the right move for your app?

(And if you're looking for a budgeting app, give [Buckets](https://www.budgetwithbuckets.com) a try)


&mdash; Matt
