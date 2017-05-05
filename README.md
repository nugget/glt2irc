glt2irc - Garmin Live Track to IRC
==================================

This program will parse the body of a Garmin LiveTrack email notification and
post the URL to an IRC or Slack channel.  In order to function you will need to
set up a mail server to receive the email from Garmin Connect and then pipe it
into this program for processing.

Requires Tcl, tcllib, and tclsyslog, and tcllauncher.

Absolutely no guarantees or warranties.  I wrote this in an hour to handle just
a single event.  In fact, the name of that race is hard-coded in `main.tcl`
which you'll probably want to change to something less specific.

[Good luck everybody else!](https://www.youtube.com/watch?v=LLuaPZWkvZ0)

Installation
============

- Copy `config.tcl.example` to `config.tcl` and edit to taste.
- Do a `sudo make install`

Mailserver Configuration
========================

For UNIXy stuff like Sendmail or Postfix, put this in `/etc/aliases`:

    mylivetrackemail: "| /usr/local/bin/glt2irc"

You may need to run something like `newaliases` depending on your system.
