HereThings Plan
===============

Overview
--------

**Goal:** HereThings - Give people a super simple way to share sketches, speech recordings, cam snaps, sketchcasts and more in comments, email, text messages and such. Improve global communication & progress with it.

**Uniqueness:** Much simpler, quicker, and more uncluttered than related tools. Integrated "HereX" strategy that's easy to remember (if one tool takes off, it can help carry the others). Each Thing is bubbled up as its own domain and can thus be predictably clicked, e.g. you will know heresnap.com never makes sounds. Ephemeral storage for better privacy comfort.

**Project approach:** Keep it simple, start with base set of features, work on desktop web version first, see if people at especially Reddit like it. Further plan based on that feedback.

**Revenues:** Once we hit a comfortable interest threshold, add AdSense below displayed things.

**Potential future direction if big interest:** Add one mobile app wrapper per HereThing, release to iOS and Android. Also, throttle to say 250 created objects per day per IP. (Far future: We could add more object types, and got herepic.com, heretune.com, herewords.com, herechan.com and others reserved. The less simple the object, the less people will benefit from the super minimal UI + ephemeralness though, and may fare better with competing suites. HereThings should focus on simple, casual, ad hoc communication. We won't completely rule out a future 'log-in to make permanent' though.)

**Technology:** HTML5/ JS/ Canvas/ Web technologies/ Node/ perhaps Nginx or another storage/ saving to file system/ Linode/ MaxCDN/ and whatever makes sense. All things are fully static and cacheable, and disappear after 3 days. We'll keep it simple and first see if people like it, but will prepare scaling so that a link can climb to the Reddit frontpage.

Scott, Yousef and Philipp co-own HereThings, and split all profits, at 33.33% each.

---

Upcoming steps
--------------

- [X] Philipp updating design to make it more fresh, simpler, minimal
- [X] Philipp handing over of files to Amar
- [X] Amar programming a workable first version, client and server.
  - [X] Implement services
    - [X] HereSketch
    - [X] HereSnap
      - [ ] Countdown?
    - [X] HereClip
    - [X] HereVoice
    - [X] HereShown
  - [ ] Fix bugs
    - [ ] Fix Firefox client bugs
    - [ ] Create 404 page for bad links
    - [ ] Fix HereShown playback seek timing bugs
    - [ ] disable done button
  - [ ] Clean up, restructure, refactor
  - [ ] Prepare scaling (content distribution network, file storage)
  - [ ] Make sure info@herethings.com goes somewhere
- [ ] Go live and submission to reddit.com/r/internetisbeautiful, possibly others
    [ ] "We've made a set of tools for you to quickly add sketches, webcam snaps, voice recordings and more in Reddit comments" - herethings.com
- [ ] See if people like it.
