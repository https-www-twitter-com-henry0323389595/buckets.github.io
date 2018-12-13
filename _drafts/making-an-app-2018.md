---
layout: post
title: Making a Cross-Platform App in 2019
author: Matt
tags: tech
image: /img/making-an-app-2018/nuts.jpg
excerpt_separator: <!--more-->
---

What does it take to make a cross platform (macOS, Linux, Windows, Android and iOS) application in 2019?  Insanity, mostly.  It's a little bit nuts.

<img alt="Nuts" src="{{site.url}}/img/making-an-app-2018/nuts.jpg" style="border-radius: 6px;"/>

Read on for what I found while researching options for the upcoming [Buckets](https://www.budgetwithbuckets.com) mobile apps.  Keep in mind that I have specific requirements that might not be *your* requirements.

<!--more-->

## tl;dr

My desktop app is currently in JavaScript.  If I have to move away from JavaScript, I'd rather move up the portability continuum, not down.  C is one of the most portable languages there is.  But JavaScript is a safe bet&mdash;it isn't going anywhere.  So I'm going to try a combination of C (via Nim) and JavaScript.

---

Here are the top contenders ordered by my preference (though there are [many, many more](https://docs.google.com/spreadsheets/d/1dTZIp6z2J1IL7YgBlHG_x68x0_zfecU0MTsjTXn1E3A/edit?usp=sharing)).

| Framework                    | Desktop | Mobile | Language | Comment |
|------------------------------|:-------:|:------:|-----------|---------|
| Wiish                        | :star: | :star: | Nim + JS | I might spend more time working on Wiish than on Buckets if I go this route.  But it's fast and has great potential.  If it doesn't work out, I'll also still have a portable C library. |
| ReactNative                  |    -   | :star: | JS | I spent too much time digging into native Android/iOS (getting the right version of SQLite). I feel like the promise of *easy* will never actually be easy with this.  If I have to spend a lot of time digging down into the native layer, I might as well just do a native app.  I'm also doubtful about FB continuing to support it. |
| Electron                     | :star: |    -   | JS | For desktop, this works fine. |
| JUCE                         | :star: | :star: | C++ | If Wiish doesn't work out, this is another favorite option, though the watermark in the free version is annoying.  The lack of accessibility is also a problem. |
| Flutter                      |    -   | :star: | Dart | I have high hopes for Flutter.  Once it supports [C libs through FFI](https://github.com/dart-lang/sdk/issues/34452), I'll consider it. |
| OpenFL                       | :star: | :star: | Haxe | This is *great* for games, but not so much for text-heavy productivity apps. |
| webview                      | :star: |    -   | C | This could one day be a great alternative to Electron.  It's just missing some of the auxiliary features that make Electron shine. |
| Android native               |    -   | Android only  | Java | Maximum flexibility on the platform.  But Java... |
| iOS native                   |    -   | iOS only | Swift/ObjC | Maximum flexibility on the platform.  Good C integration.  Might not be a bad idea. |
| QT                           | :star: | :star: | C, QML | Licensing is too onerous for a single dev.  Not even a real option. |

And here's some subjective scoring:

- *Accessibility* - For those with disabilities
- *Sunk Cost* - If I choose this option, how much will I regret it if the project is abandoned or I otherwise want to use something else?  Will I have to start over or will I get to use/port parts of what I've done?
- *C Interop* - How well does it integrate with C libraries (e.g. SQLite).
- *JS Code Reuse* - How much of my existing JS code do I get to reuse?
- *Shared Code* - How much of the code gets shared between platforms?

| Framework | Accessibility | Sunk Cost | C Interop | JS Code Reuse | Shared Code |
|---|:-:|:-:|:-:|:-:|:-:|
| Wiish | :star: | :star: | :star: | :star: | :star: |
| ReactNative | [:star:](https://facebook.github.io/react-native/docs/accessibility.html) | :star: | meh | :star: | :star: |
| Electron | :star: | :star: | meh | :star: | :star: |
| JUCE | :x: | meh | :star: | :x: | :star: |
| Flutter | [:star:](https://flutter.io/docs/development/accessibility-and-localization/accessibility) | :x: | :question: | :x: | :star: |
| OpenFL | [:question:](https://api.haxe.org/flash/accessibility/AccessibilityProperties.html) | meh | :star: | :x: | :star: |
| webview | :star: | :star: | :star: | :star: | :star: |
| Android native | :star: | meh | meh | :x: | :x: |
| iOS native | :star: | meh | :star: | :x: | :x: |


## Detailed Blabbering

### Wiish

[Wiish](https://github.com/iffy/wiish) is a Nim library that can make desktop or mobile apps.  The UI layer is swappable, so you can use webviews (and JavaScript) or SDL2/OpenGL if that's more your thing.

Pros:

- Can be speedy
- Very lightweight
- JavaScript reuse
- Generates C
- Nim is pleasant to use

Cons:

- Maintained by me :)
- Nim is pre v1
- A bit buggy at this point

### ReactNative

[ReactNative](https://facebook.github.io/react-native/) lets you use JavaScript to build native interfaces.  It provides access to native APIs.

Pros:

- Speedy
- Native widgets
- JavaScript code reuse

Cons:

- Integrating with C libs is non-trivial
- Bug fixes not super speedy
- I don't trust Facebook's longevity


### Electron

[Electron](https://electronjs.org/) has been a game-changer for desktop app development.  You can write your application in JavaScript (including the never-ending JavaScript ecosystem):

Pros:


- Easy to get started quickly
- Built-in automatic updates
- Heavy code reuse (JavaScript, in this case)

Cons:

- Massive application file size
- Heavy memory consumption
- Lackluster speed in some cases

### JUCE

[JUCE](https://juce.com/) includes a full IDE for making applications in C/C++.  It has primarily been used for audio applications and is optimized for that case, but could be used for other types of application.

Pros:

- Great UI builder
- Very cross platform
- Speedy
- Some hot-reload capabilities for UI development

Cons:

- No accessibility
- You write in C++
- Licensing/cost

### Flutter

[Flutter](https://flutter.io/) is a Google project that has its own versions of native widgets.  You use the Dart language.

Pros:

- Speedy
- Looks pleasant to use
- Hot code reload

Cons:

- Dart language.  If I choose Dart, it won't be easy to move to something else later.
- Google projects have short lives
- Lacks good C interop (but it's coming!)


### OpenFL

[OpenFL](https://www.openfl.org/) is an open implementation of Flash and lets you write apps using the Haxe language (which compiles to C).

Pros:

- Very cross platform
- Haxe is a fun language
- Good C interoperability

Cons:

- Not great for text-heavy applications
- Some quirks involved in Flash API

### webview

[webview](https://github.com/zserge/webview) is a C library that provides you a window with a browser in it.  There are various language bindings if you don't want to write C.

Pros:

- Very lightweight
- JavaScript reuse
- Speedy

Cons:

- Browser differences
- Not feature complete yet


### Android native

Pros:

- Full, unlayered access to APIs
- Good UI builder

Cons:

- Java
- Little to no code reuse for iOS app

### iOS native

Pros:

- Full, unlayered access to APIs
- C interoperability is nice
- Great UI builder

Cons:

- Little to no code reuse for Android app

## Conclusion

And here's a little tease to end with :)

<div style="display: flex; align-items: flex-start; justify-content: space-around; margin: 2rem 0;">
    <div>
        <img height="437" alt="iPhone showing Buckets launching" src="{{site.url}}/img/making-an-app-2018/iphone.gif" style="border-radius: 4px;">
    </div>
    <div>
        <img height="437" alt="Android with Buckets icon" src="{{site.url}}/img/making-an-app-2018/android.png">
    </div>
</div>

Comment below if you have had good success with other options for mobile/desktop app development.

Happy budgeting!

&mdash; Matt
