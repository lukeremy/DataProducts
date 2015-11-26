---
title       : The Grim Reaper App
subtitle    : Find out how long you have left...
author      : Luke Remy 
job         : https://lukeremy.shinyapps.io/GrimReaper
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : standalone # {standalone, draft}
knit        : slidify::knit2slides

--- 

## Why does this matter?


We all know we're going to die some day, doesn't it take the fun out of life knowing exactly which day you'll die on?!

It turns out, as it were, in a certain manner of speaking, that indeed, the actual answer is no -- this is not the case at all!

If you know which day you will die on, perhaps you can plan ahead.  Knowing when you will die ahead of time will allow you to do any of the following with time to spare:
* repair damaged relations with family members
* take that last trip you always wanted to take
* have breakfast for dinner, just 'cuz
* spend your every last dollar, just to spite the aforementioned family members 
* anything else on your bucket list!

Now doesn't all that sound fun?!

--- .class #id 

## What sorcery is this?
### How do you actually know when I'll die?

As this is but a simple application, the prediction is based on the average life expectancy worldwide for the period 2010-2013, according to The World Factbook.

This application uses the following average lifespans:
* females = 73.5 years
* males = 68.5 years

See [Wikipedia](http://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy) for source.

--- .class #id 

## Fine. I'm dying. 
### But how does this app calculate the date?s

While this application is neither sophisticated, elegant, nor well-conceived, it is, perhaps, parsimonious.  This is owed to the fact that it requires but two inputs, namely, birthdate and gender.


Below, I have selected as inputs for my function the demographic information corresponding with one Wardell Stephen Curry III, also known as _Threesus_, and soon-to-be 2015 NBA MVP.

```r
death("1988-03-14","Male")
```

```
## [[1]]
## [1] "Thurs"
## 
## [[2]]
## [1] "2056-09-14 PDT"
```

As we can see, Steph will die on a Thursday - September 14, 2056, to be precise.


--- .class #id 

## But... Steph's never gonna die!
### And if he does, won't he at least live longer?



If you're still struggling to cope with Steph's imminent demise, don't fear!  He has plenty of years left to accumulate accolades and rings.  




Maybe you'll be inspired to improve upon this application by adding more inputs for country of origin, how often you floss, whether or not you look both ways before crossing the street, etc.



If you're feeling completely dismayed, I sincerely apologize - 'twas ne'er my intent.  Maybe [this](http://www.wikihow.com/Live-a-Long-Life) will cheer you up.

If that didn't work, I'm sure [this](http://l.yimg.com/bt/api/res/1.2/q2JHX2SeaJim1uJ0m0jfxw--/YXBwaWQ9eW5ld3M7aWw9cGxhbmU7cT03NTt3PTYwMA--/http://media.zenfs.com/en/person/Ysports/stephen-curry-basketball-headshot-photo.jpg) will do the trick.





