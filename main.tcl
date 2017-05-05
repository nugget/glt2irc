#!/usr/bin/env tclsh

package require irc
package require tls
package require Syslog

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
	logmsg "Connecting to IRC"
	::irc::config logger 0
	::irc::config debug 0
	set cn [::irc::connection]
	$cn connect $::config(hostname) $::config(port)
	::tls::import [$cn socket]
	logmsg "Converted socket [$cn socket] to SSL"
	$cn send "PASS $::config(password)"
	$cn user $::config(nick) localhost domain "macnugget.org"
	$cn nick $::config(nick)
	after 10000 "$cn privmsg $channel \"$msg\""
}

proc logmsg {buf} {
	syslog -ident glt2irc notice $buf
	puts $buf
}

proc alldone {} {
	logmsg "All Done"
	exit 0
}

proc main {} {
	logmsg "glt2irc starting"
	set msg [read_email]
	set url [find_url $msg]
	if {$url eq ""} {
		logmsg "No URL found in message body"
		exit 0
	}

	logmsg "Informing the world about $url"

	sendmsg "The Vancouver BMO Marathon has started!  You should be able to stalk my progress at $url" $::config(target)
	after 30000 alldone
	vwait die
}

if !$tcl_interactive main
