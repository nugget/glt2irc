glt2irc - Garmin Live Track to IRC
==================================

Ingests emails from Garmin LiveTrack and emits the URL to IRC (or Slack via
IRC gateway)

Requires Tcl, tcllib, and tclsyslog.

Do a `sudo make install`

Put this in `/etc/aliases`:
    mylivetrackemail: "| /usr/local/bin/glt2irc"
