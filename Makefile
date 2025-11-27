# Source files
PROG_SOURCES 		:= helloworld.c
LIB_GREET_SOURCES	:= greet.c
LIB_MESSAGE_SOURCES	:= message.c

LDFLAGS 	:= -shared
BUILDDIR  	=
LIBDIR    	=
BINDIR		=


STRIP = true
BUILD ?= release
ifeq ($(BUILD),debug)
    CFLAGS = -ggdb -O0 -U_FORTIFY_SOURCE
	STRIP = false
	BUILDDIR 	= build/debug
	LIBDIR    	= out/debug/lib
	BINDIR		= out/debug/bin
else ifeq ($(BUILD),release)
    CFLAGS = -Wall -Wextra -O2
	BUILDDIR 	= build/rel
	LIBDIR    	= out/rel/lib
	BINDIR		= out/rel/bin
else
    $(error Invalid BUILD type. Use 'debug' or 'release')
endif

# Object files
PROG_OBJECTS := $(PROG_SOURCES:%.c=$(BUILDDIR)/%.o)
LIB_GREET_OBJECTS  := $(LIB_GREET_SOURCES:%.c=$(BUILDDIR)/%.o)
LIB_MESSAGE_OBJECTS  := $(LIB_MESSAGE_SOURCES:%.c=$(BUILDDIR)/%.o)

# Compile shared libs with -fPIC
$(LIB_GREET_OBJECTS): CFLAGS += -fPIC
$(LIB_MESSAGE_OBJECTS): CFLAGS += -fPIC


all: greet message helloworld
greet: $(LIBDIR)/libgreet.so
message: $(LIBDIR)/libmessage.so
helloworld: greet message $(BINDIR)/helloworld

# Create output dirs
$(BUILDDIR) $(LIBDIR) $(BINDIR):
	mkdir -p $@

# Rule for all .c files
$(BUILDDIR)/%.o: %.c | $(BUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# libgreet.so
$(LIBDIR)/libgreet.so: $(LIB_GREET_OBJECTS) | $(LIBDIR)
	$(CC) $(LDFLAGS) -o $@ $^
ifeq ($(STRIP),true)
	strip $@
endif

# libmessage.so
$(LIBDIR)/libmessage.so: $(LIB_MESSAGE_OBJECTS) | $(LIBDIR)
	$(CC) $(LDFLAGS) -o $@ $^
ifeq ($(STRIP),true)
	strip $@
endif

# helloworld
# -rpath,'$$ORIGIN/../lib' sets a hardcoded rpath relative to where helloworld is installed
$(BINDIR)/helloworld: $(PROG_OBJECTS) | $(BINDIR)
	$(CC) -o $@ $^ -L$(LIBDIR) -lgreet -lmessage -Wl,-rpath,'$$ORIGIN/../lib'
ifeq ($(STRIP),true)
	strip $@
endif

clean:
	rm -rf $(BUILDDIR) $(BINDIR) $(LIBDIR)

.PHONY: all clean greet message helloworld
