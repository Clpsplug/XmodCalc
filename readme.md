# Xmod Calculator

Calculate optimal "Xmod" for rhythm games, right on your wrist.

## What is this app for?

* This app runs on Apple Watch (current target OS is 9.5.)
* This app calculates the optimal "Xmod" for your gameplay.
* This app is primarily targeted for arcade rhythm games, where access to calculator may be limited, if not impossible.

## What is Xmod?

Xmod refers to a gameplay system in rhythm games where you can modify the scroll speed of the chart.  
Xmod multiplies the scroll speed of the chart (hence the name **X**mod,) and some rhythm games offers fine-tuned modification rate (sometimes down to 2nd decimal place.)  

If you play rhythm games whose chart scroll speed is tied to the BPM (=tempo) of the song, you may run into some issues.  
When you play rhythm games, you would probably have an optimal scroll speed for your sightreading;  
in rhythm games where the scroll speed is tied to BPM, your scroll speed can also be represented by BPM value:

> **Note**  
> For example:
> If you play a chart with BPM of 160 and you're most comfortable using Xmod of x3.0,
> your optimal reading BPM is 480.

Unless the game offers such feature, you probably have to work it out in your head, which can lead to a mistake and your unfortunate demise.

This app calculates optimal Xmod (i.e., Xmod that does not make the scroll speed exceed your optimal speed)
from your optimal reading BPM.  
Just set your BPM of preference in the settings, and set the BPM of the song in the main screen!


## How to use

1. Visit the settings screen by clicking the gear icon
2. Set "your preferred BPM" using the Digital Crown etc. [^1]
  * If you're playing on premium mode, toggle that switch on.
3. Go back to the main screen and turn the Digital Crown [^1] until the value on screen matches the BPM of the song.

[^1]: In addition to using the DC, you can swipe the value for big change, and chevrons (\< \>) to change the value by 5.

## Limitation

* This app does not support optimization for BPM *changes* (i.e., so-called *"sof-lan"* songs.)
  * This is because either:
  	1. it is hard for you to change Xmod mid-game in the first place, or
  	2. the ways to change Xmod mid-game are too diverse to be supported in a simple-enough UI.
  * Workarounds:
  	1. Optimize for maximum or minimum BPM in the songs (depending on your strat)
  	2. View optimal Xmods for both BPM limits and remember them
* BPM over 999 is not supported.
  * This is because when such ridiculously-high BPM is used, it is most likely for visual effect 
    and the game doesn't really expect you to read at such high speed.  
    If it is the case, just half the BPM in question for calculation and half whatever Xmod value the app shows.
