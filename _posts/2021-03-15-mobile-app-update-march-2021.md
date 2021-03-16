---
layout: post
title: Buckets Mobile Update &mdash; March 2021
author: Matt
tags: newsletter
# image: /img/STUB/image.png
# excerpt_separator: <!--more-->
---

Hello again! I wanted to post an update about the upcoming Buckets mobile app.  Before too many words, here's what it looks like in the iOS Simulator:

<div style="text-align: center;">
<img alt="Buckets Mobile home screen" src="{{site.url}}/img/mobile-app-update-march-2021/homescreen.png">
</div>

Yes, the grey buttons aren't much to look at, but I'd rather have the app working first and beautiful later.  Android will look the same (no screenshot at the moment because I recently broke some things there).  Rather than follow the operating system's styling, Buckets Mobile will be consistent among platforms.

So what exactly is the status?

# iOS

I've submitted the first draft of Buckets Mobile to Apple's App Store!  From reading others' experience developing iOS apps, there will be several more submissions before the app is validated and accepted.  I can't adequately explain how relieved I felt when I finally submitted it.  It's been a long time coming!

Once it's accepted, a limited number of alpha testers will be sent an email with instructions for installing the app.  [Sign up here](https://docs.google.com/forms/d/e/1FAIpQLSfti1Bmm6Zi8I8zauwPpZcMLNUZgwRG9QRWkW6Ki6Szi9lLlw/viewform?usp=sf_link) if you'd like to be one of them. Since Apple limits the number of testers, I can't guarantee you'll get a spot but I'll give out as many invitations as I can!

# Android

Since the codebase is largely the same for iOS and Android, I only need to fix some Android-specific shared library compilation before an alpha version is ready for Android.  If the iOS app review process takes a long time, Android might be ready first.

If you want to be a tester for Android, [sign up with the same link.](https://docs.google.com/forms/d/e/1FAIpQLSfti1Bmm6Zi8I8zauwPpZcMLNUZgwRG9QRWkW6Ki6Szi9lLlw/viewform?usp=sf_link)

# Expectations

I need to clearly set some expectations about the initial release of the mobile app.

First, though, more eye candy :candy:  Here's a snapshot of how it currently looks when pairing two devices. (Yes, that's the Trial Version of Buckets&mdash;I really ought to save up for a license some day...)

<img alt="Buckets Mobile syncing with Buckets Desktop" src="{{site.url}}/img/mobile-app-update-march-2021/linking.png">

So... expectations: please lower them :grin: It has taken months and months for this app to come out. You would be justified in thinking that Buckets Mobile is going to be amazing. It certainly has taken a long time, but most of the work has been effort required for making any generic mobile app. The budgeting part of Buckets Mobile? Accounts, buckets and transaction? That took a few days.  The iOS skeleton, Java-to-C interoperation, desktop-to-mobile communication and shared-code extraction has taken 90% or more of the time.

As noted [when we first sent out the call for alpha testers](/2019/09/07/mobile-update-sep2019.html), this first version is just Phase 1.  Once Phase 1 is out and some long-standing bugs are fixed in Buckets Desktop, I expect Phase 2 will follow very quickly. In summary the phases are:

- Phase 1: Desktop-to-mobile, one-way wifi sync. Mobile devices can't alter the budget.
- Phase 2: Two-way wifi sync. Mobile devices can alter the budget (e.g. add and categorize transactions, create buckets, etc...) *This is the version you're probably waiting for!*
- Phase 3: Sync over the Internet, via a Buckets-provided relay or your own system (i.e. Dropbox, Google Drive, some other filesharing service, etc...)

Thank you all for supporting Buckets! It brings me great pleasure knowing that Buckets helps you with your finances. Stay tuned and happy budgeting!

(One more screenshot, just for fun)

<div style="text-align: center;">
<img alt="Buckets Mobile month picker" src="{{site.url}}/img/mobile-app-update-march-2021/monthpicker.png">
</div>

&mdash; Matt
