---
layout: post
title: Buckets Mobile Alpha Testers
author: Matt
tags: newsletter
image: /img/mobile-update-sep2019/mobilehero.jpg
excerpt_separator: <!--more-->
---

Long time no blog!  A summer of changes has ended, with the biggest change being that we drove across the United States to our new company headquarters.  They weren't kidding; Iowa has a *lot* of corn fields.

<img alt="Photo of corn by Jake Gard on Unsplash" src="{{site.url}}/img/mobile-update-sep2019/corn.jpg" style="border-radius: 6px;"/>

While the move has been a very fun, time-consuming and exciting adventure for our family, you're probably more excited to hear about the Buckets mobile app.

<!--more-->

## Alpha testers

Please [sign up here](https://docs.google.com/forms/d/e/1FAIpQLSfti1Bmm6Zi8I8zauwPpZcMLNUZgwRG9QRWkW6Ki6Szi9lLlw/viewform?usp=sf_link) to be a Buckets Mobile Alpha tester!  In the coming weeks (I'm sorry I don't have a definite day&mdash;everything takes longer than expected) we'll send out instructions for installing the app on Android and iOS.  If there's another OS you'd like Buckets to run on (PureOS maybe?) note it on the sign-up sheet.

The first version is going to have bugs and be very limited in functionality (see the Roadmap below).  If there are any security concerns with the initial release, I'll highlight them in the email to help make sure you don't put your real budget information at risk.

And did I mention it's going to have bugs? :)

But I think you're going to love it.


<img alt="Buckets Mobile icon on a dark blue background" src="{{site.url}}/img/mobile-update-sep2019/mobilehero.jpg" style="border-radius: 6px;"/>

## Roadmap

Buckets Mobile has been a *long* time coming because it involves two tricky problems:

**First, making a mobile app.**  This is my first mobile app and the mobile app development process is [kind of messy](/2018/12/13/making-an-app-2018.html), *especially* if you want to make your code work on iOS, Android, macOS, Windows and Linux.

**Second, making a secure, reliable and *private* way to sync data between your devices.**  If Buckets stored your information in the cloud, this would be trivial.  But because Buckets is committed to privacy, your data resides only on your devices and we can't access it.  Any synchronization solution will have to be completely private as well.  I'm happy to release software early and often even if it's clunky (as you've no-doubt noticed), but I'm unwilling to release a potentially insecure app just to get it out sooner.

To that end, here is the current roadmap complete with pretty arrows and icons:

### Phase 1 - One way, wifi sync and read-only mobile

![]({{site.url}}/img/mobile-update-sep2019/phase1.png)

- Buckets Mobile will contain read-only functions.  That is, you will *not* be able to modify budget data on your phone but you *will* be able to see how much is left in your Ice Cream Sundae bucket.
- The Buckets Sync Server will run from within Buckets Desktop and will only be available on your local network.  Or whatever insecure, public wifi you're connected to.
- Buckets Mobile will likely only be in English.
- We'll work out kinks with app installation and distribution, and with syncing to the desktop.


### Phase 2 - Two way, wifi sync and read/write mobile

![]({{site.url}}/img/mobile-update-sep2019/phase2.png)

- Buckets Mobile will gain some ability to modify data (e.g. record or categorize transactions).  The first data-manipulating features will be the trickiest.  I expect more to be added soon afterward.
- Hopefully, it will become available on the Apple and Android app stores for everyone.
- It will be available in a variety of languages.  Seja bem-vindo! Graag gedaan!
- During this phase, we'll work on more problems with desktop syncing.

### Phase 3 - Sync over the Internet

![]({{site.url}}/img/mobile-update-sep2019/phase3.png)

- Buckets Mobile will continue to gain more functionality.
- We'll start hosting a Buckets Sync Relay Server online so that you can sync between devices from nearly anywhere.  End-to-end encryption will prevent the relay server from ever seeing your budget data.
- We'll also release an open source Buckets Sync Relay Server so that you can run your own!

### Phase 4 - Beyond

We'll consider adding Bluetooth, NFC and WebDAV as options for syncing.  Honestly, this is pretty far down the road, so we'll see about all this when we get there.

---

As I said, this has been a long time coming and will still take more time.  We appreciate your patience and look forward to your bug reports when Buckets Mobile makes its debut!

&mdash; Matt


