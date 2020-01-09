---
layout: post
title: 2019 Survey Results
author: Matt
tags: newsletter
# image:
excerpt_separator: <!--more-->
---

Thank you, international Buckets community, for all your support and enthusiasm!  Ahoj, Bonjour, Ciao, Cześć , Dia Ghuit, G'day, Hallo, Hei, Hej, Hello, Hola, Kumusta, Namaste, Oi, Olá, Zdravo, Привте!  

From your survey responses, it's clear that Buckets is helping you manage your finances.   And, as before, you've given helpful feedback about what needs to improve.

Here's a look at who Buckets users are:

<!--more-->

<script src="/js/Chart.bundle.min.js"></script>
<script>
// http://tristen.ca/hcl-picker/#/hlc/25/1.08/EE7C6C/FDA057
const COLORS = ['#88BF60', '#5BB2D6', '#EA7FA1', '#EEA64C', '#B3B848', '#5AC181', '#EE7C6C', '#C8B344', '#92A4D9', '#77ABDA', '#42C193', '#AA9CD4', '#24BBC3', '#1ABEB5', '#FDA057', '#D28CC0', '#2AC0A5', '#F07C8F', '#F17B7D', '#DCAD45', '#E085B1', '#3EB7CE', '#71C070', '#9EBC52', '#C094CC']
</script>

## Countries

<img src="{{site.url}}/img/surveyresults2019/map.png" title="Map with these highlighted countries: Australia, Austria, Belgium, Brasil, Canada, China, Croatia, Denmark, Finland, France, Germany, Ireland, Italy, México, Poland, Portugal, Singapore, Spain, Sweden, The Netherlands, United Kingdom, United States of America" />

## Operating Systems

<img src="{{site.url}}/img/surveyresults2019/os.png" title="Venn diagram showing Linux, Windows and macOS usages" />

Similar to last year, with a larger Windows bubble.

- Linux: 17%
- macOS: 33%
- Windows: 50%

## Trial vs Paid

<canvas id="paidChart"></canvas>

<script>
var ctx = document.getElementById('paidChart').getContext('2d');
var paidChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                41, 59,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "Paid", "Trial Version",
        ],
    },
});
</script>


## Professions

Like last year most users do computery work, but there are many more people in other fields than before.  Here's a summarized list (and I apologize if I incorrectly lumped your profession with others):

Accountant, Administration , Airline, Art Student, Bank Officer, Business Analyst, Civil Engineer, Computer Programmer, Construction Engineer, Control Analyst, Customer Service, Data Scientist, Electrical Engineer, Engineer, ICT Manager, IT, Librarian, Management, Office Guy, Marketing, Optician, PhD Student, Procurement, Project Administrator, Project Manager, Retired, Sales, Scientist, Software Tester, Statistician, Student, Tax and Accounting Consultant , Teacher, Video Editor, Writer

## Age


The crowd is trending slightly older than last year and includes at least one self-reporting octogenarian!

<canvas id="ageChart"></canvas>

<script>
var ctx = document.getElementById('ageChart').getContext('2d');
var ageChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                26.5, 48.2, 12.0, 4.8, 7.2, 0, 1.2,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "20s", "30s", "40s", "50s", "60s", "70s", "80s",
        ],
    },
});
</script>

## What's the best part about Buckets?

You're all very kind.  The most prevalent comments are:

- One-time payment
- Buckets is fast
- Private and locally-stored data
- Low-pressure, free trial
- "Make it rain" :grin:
- Linux support

## What does Buckets lack?

My favorite comment was "SO wants better emoji support" :smile:

It won't surprise you that the vast majority see a mobile app as the most urgent need.  And while I knew about many of the other mentioned issues, there were a few I wasn't aware of (e.g. Buckets not working well on small screens).  So thank you!

I've filed issues for everything mentioned.  Here are the top problems you brought up:

- Mobile app [#72](https://github.com/buckets/application/issues/72)
- Scheduled/recurring transactions [#212](https://github.com/buckets/application/issues/212)
- Better reports [#221](https://github.com/buckets/application/issues/221)
- Sync budgets between computers [#232](https://github.com/buckets/application/issues/232)
- Improve bank macros [(various)](https://github.com/buckets/application/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+label%3Amacros+)
- Automatic categorization [#98](https://github.com/buckets/application/issues/98)
- Filter/sort transactions [#334](https://github.com/buckets/application/issues/334), [#267](https://github.com/buckets/application/issues/267)
- Payees (not just Memo) [#101](https://github.com/buckets/application/issues/101)
- Small screen problems [#436](https://github.com/buckets/application/issues/436)
- Faded cents are annoying [#344](https://github.com/buckets/application/issues/344)
- Budget encryption [#251](https://github.com/buckets/application/issues/251)

The [Roadmap](https://github.com/buckets/application/projects/2?fullscreen=true) has been updated to better indicate priorities.  It's just a guide, though&mdash;don't fret if your favorite issue is missing.

I apologize that the desktop app didn't receive as much attention this year&mdash;due to the mobile app, some lawyery-businessy-contracty stuff, moving across the country and starting a new job.  I just want you to know that *I'm still here and still enjoy working on Buckets!*


## Have you recommended Buckets to anyone?

Thank you for telling your friends about Buckets!


<canvas id="shareChart"></canvas>

<script>
var ctx = document.getElementById('shareChart').getContext('2d');
var shareChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                55.4, 44.6,
            ],
            backgroundColor: COLORS,
        }],
        labels: [
            "Yes", "No",
        ],
    },
});
</script>

Here's to a great new year for Buckets!


&mdash; Matt


