---
layout: post
title: 'New Feature: Debt Handling'
author: Matt
tags: newsletter
# image:
# excerpt_separator: <!--more-->
---

If you have debt, Buckets v0.50.0 offers better help managing it.  Either enable Beta Updates, [download it here](https://github.com/buckets/application/releases/tag/v0.50.0) or wait for the stable release in a week or two.

## Negative rain, be gone!

Suppose you have $1,000 in Savings and a credit card debt of $3,000.  That might look like this in Buckets:

<img src="{{site.url}}/img/debt/before.png" />

That negative rain amount makes budgeting difficult.  How do you allocate -$2,000 into buckets?

"Let's see, I'll spend -$400 on food this month, -$500 on rent..."

Instead, you can now change the Credit Card account to a *Debt* account and budget the money you *do* have, debt notwithstanding:

<img src="{{ site.url }}/img/debt/after.png" />

With this setup, you can split the $1000 you have into buckets of your choosing.

## Debt payment bucket

A second effect of changing an account to a *Debt* account is the automatic creation of a debt payment bucket.  This bucket is meant to collect funds until it's time to make a payment.

<figure>
<img src="{{ site.url }}/img/debt/debt-payment-bucket.png" />
</figure>

The debt payment bucket will mirror every transaction into your *Debt* account.  It follows these 2 simple rules:

- if you deposit $50 into your debt account, the payment bucket balance will decrease by $50 indicating that your pending payment has gone down.
- if you withdraw $50 from your debt account, the payment bucket balance will increase by $50 indicating that your pending payment has gone up.

In addition, you can add money to the debt payment bucket just like any ordinary bucket.

Because many debt accounts bill a month behind (e.g. on July 25th you pay for transactions that happened May 25th - June 25th) it can be tricky to get the debt payment bucket balance to accurately tell you what you should pay on your card.  See the [guide](https://docs.budgetwithbuckets.com/app/debt/) article for tips on how to manage this.

---

For even more details (or if this blog post is outdated) the most up-to-date documentation is [in the guide](https://docs.budgetwithbuckets.com/app/debt/).

Happy budgeting!

&mdash; Matt
