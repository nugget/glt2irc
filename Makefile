LIB?=	/usr/local/lib
BIN?=	/usr/local/bin
TCLSH?=	tclsh8.6

INSTALL_FILES=main.tcl config.tcl
PROGNAME=glt2irc

all:

install:
	@echo Installing glt2irc
	install -o root -g wheel -m 0755 $(BIN)/tcllauncher $(BIN)/$(PROGNAME)
	install -o root -g wheel -m 0755 -d $(LIB)/$(PROGNAME)
	install -o root -g wheel -m 0644 $(INSTALL_FILES) $(LIB)/$(PROGNAME)
