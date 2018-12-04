---
layout: post
title: 2018 Survey Results
author: Matt
tags: newsletter
# image:
excerpt_separator: <!--more-->
---

Thank you to everyone who filled out the first annual Buckets Community Survey!  Your answers have helped us confirm some suspicions and are helping to direct future work for Buckets.  Read the results here:

<!--more-->

<script src="/js/Chart.bundle.min.js"></script>
<script>
// http://tristen.ca/hcl-picker/#/hlc/25/1.08/EE7C6C/FDA057
const COLORS = ['#88BF60', '#5BB2D6', '#EA7FA1', '#EEA64C', '#B3B848', '#5AC181', '#EE7C6C', '#C8B344', '#92A4D9', '#77ABDA', '#42C193', '#AA9CD4', '#24BBC3', '#1ABEB5', '#FDA057', '#D28CC0', '#2AC0A5', '#F07C8F', '#F17B7D', '#DCAD45', '#E085B1', '#3EB7CE', '#71C070', '#9EBC52', '#C094CC']
</script>

## Hello!

Buckets users come from all over the world!  Ahoj, Bonjour, Ciao, Cześć, Dia dhuit, Hallo, Hello, Hola, Kumusta, Namaste, Oi, Olá, Salut, Xin chao, Zdravo to all of you!

## Countries

<canvas id="countryChart"></canvas>

<script>
var ctx = document.getElementById('countryChart').getContext('2d');
var countryChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                1, 3, 2, 1, 6, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 2, 1, 2, 3,
                20,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "Argentina", "Australia", "Austria", "Belgium", "Brasil", "Canada", "China", "Croatia", "Czech Republic", "France", "Germany", "India", "Ireland", "Italy", "Netherlands", "Poland", "Spain", "Switzerland", "UK",
            "USA",
        ],
    },
});
</script>

## Operating Systems

<img src="{{ site.url }}/img/survey2018results/os.png">

- macOS: 18
- Windows: 17
- Linux: 10
- macOS + Windows: 6
- Linux + Windows: 2
- macOS + Windows + Linux: 2

## Trial vs Paid

<canvas id="paidChart"></canvas>

<script>
var ctx = document.getElementById('paidChart').getContext('2d');
var paidChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                16, 30,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "Paid", "Trial Version",
        ],
    },
});
</script>

This only includes responses for those who use Buckets.  Although it would be generous, I'm not expecting people to pay for Buckets if they don't use it :wink:

## Professions

Although professions are varied, most Buckets users do computery work.  Here's the full list:

Architecture, Bank officer, Consultant, Control Analyst, CTO, Developer, Digital Consultant, Engineer, Event Planner, Full time mom, Graduate Student, Graphic Designer, IT, Marketer , Office guy, Physician, Product Manager, Project Admin, Public Transport, Realty Specialist , Retired, Small Business Owner, Software QA, Student, System Analyst, Tax consultant, Teacher, UX designer


## Age

<canvas id="ageChart"></canvas>

<script>
var ctx = document.getElementById('ageChart').getContext('2d');
var ageChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                20, 29, 2, 3, 2,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "20s", "30s", "40s", "50s", "60s",
        ],
    },
});
</script>

## What do you hope budgeting well will do for you?

The top reasons:

1. (63%) Bring peace of mind for retirement
2. (60%) Give me money to do fun things
3. (40%) Let me buy some other big purchases
4. (36%) Vacations!
5. (33%) Bring more harmony to my marriage/relationships
6. (31%) Allow me to help more people

## Proposed features

Regarding some proposed features, here's what people want most according to the following admittedly arbitrarily-weighted scale.  Scores were a sum of the values from the following mapping:

- "I need this" = 10 points
- "I'd like this" = 3 points
- "Not important to me" = 0 points

I'm not surprised by the mobile apps scores, but I was surprised that *Encrypted budget files* didn't rank higher.

<canvas id="featuresChart"></canvas>

<script>
var ctx = document.getElementById('featuresChart').getContext('2d');
var featuresChart = new Chart(ctx, {
    type: 'bar',
    data: {
        datasets: [{
            data: [
                235,
                234,
                231,
                202,
                183,
                148,
                136,
                114,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            'Android app',
            'iOS app',
            'Automatic categorization',
            'Keyboard shortcuts',
            'More bucket types',
            'Encrypted budget files',
            'Printable reports',
            'Multiple currency support',
        ],
    },
});
</script>

## How much should Buckets cost?

We asked this question because we've been wanting to raise the price.  Here are responses for various groups:

- Average all responses: $37
- Average actual users (self-reported): $34
- Average paid users: $37
- Average trial users: $36
- Lowest: $10
- Highest: $99

Based on the results, we *will* be raising the price soon (we'll make an official announcement before that happens).

## What's the best part about Buckets?

Here are some representative comments:

- "It is simple!"
- "You own and control your data"
- "Support"
- "Visually appealing and very intuitive"
- "Not a subscription"
- "...plus scripted record pulling from my bank"
- "Multiplatform yet private"

## What is Buckets' greatest weakness?

- "Lack of mobile app"
- "No phone app"
- "No mobile app"
- "No IOS / Android App"
- "Falta de um app android"

I get the feeling that people want a mobile app :wink:  It's getting closer.  Follow along here: [Issue #72](https://github.com/buckets/application/issues/72)

- "Auto categorisation" [#98](https://github.com/buckets/application/issues/98)
- "It doesn't SEEM easy to connect to banks, even though it's pretty easy." [#319](https://github.com/buckets/application/issues/319)
- "lack of split transactions"  (I guess I need to document this better &mdash; because this is one of my favorite features in Buckets)
- "Increate font sizes throughout..."
- "Lack of keyboard support" [#133](https://github.com/buckets/application/issues/133)
- "Lack of scheduled transactions" [#201](https://github.com/buckets/application/issues/201)
- "It's sometime slow"
- More reports/analysis
- "No Move money tool" (I need to document this better, too).

There are several other ideas/requests that we'll work on.

Another one that was brought up a few times is the [bus factor](https://en.wikipedia.org/wiki/Bus_factor) of Buckets.  To address that, I will no longer cross streets :smile:

But really, I will work on [getting a formal plan](https://github.com/buckets/application/issues/320) in place in case the bus and I do cross paths.  The likely outcome will be that Buckets will be open-sourced.  One nice thing about how Buckets works now, though, is that even if there were never any more updates, it would continue working as-is for a long time (until operating systems move out from under it).

## Prove you're human

Most people got this question right.  13% didn't.  Here's the answer key:

- A white duck **IS** a duck
- A rhinoceros **IS NOT** a duck
- A mallard duck **IS** a duck
- A tractor **IS NOT** a duck

![Ducks and not]({{ site.url }}/img/survey2018results/ducks.png)

## Have you recommended Buckets to anyone?

Lastly, most of you have recommended Buckets to others.  Thank you!


<canvas id="shareChart"></canvas>

<script>
var ctx = document.getElementById('shareChart').getContext('2d');
var shareChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                9, 25,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "No", "Yes",
        ],
    },
});
</script>


## Thank you!

It has been a great year for Buckets, thanks to all of you!  And as 2019 approaches I'm excited about where Buckets is going to go.

Thanks and happy budgeting!

&mdash; Matt
