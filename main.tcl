#!/usr/bin/env tclsh

package require irc
package require tls

source [file join [file dirname [info script]] "config.tcl"]

proc read_email {} {
	set fh [open /dev/stdin r]
	fconfigure $fh -blocking 0
	if [eof $fh] {
		close $fh
		return ""
	}
	set msg [read $fh]
	close $fh

	return $msg
}

proc find_url {msg} {
	if {[regexp {(http://livetrack.garmin.com/session/[^\"]*)} $msg url]} {
		return $url
	} else {
		return
	}
}

proc sendmsg {msg channel} {
	::irc::config logger 1
	::irc::config debug 1
	set cn [::irc::connection]
	$cn connect $::config(hostname) $::config(port)
	::tls::import [$cn socket]
	$cn send "PASS $::config(password)"
	$cn user $::config(nick) localhost domain "macnugget.org"
	$cn nick $::config(nick)
	after 10000 "$cn privmsg $channel \"$msg\""
}

proc main {} {
	set msg [read_email]
	set url [find_url $msg]
	puts $url
	sendmsg "The Vancouver BMO Marathon has started!  You should be able to stalk my progress at $url" slackbot
	after 30000 exit
	vwait die
}

if !$tcl_interactive main
