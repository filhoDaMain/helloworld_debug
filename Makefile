# Output binary
TARGET = bin/helloworld

# Sources
SRC = main.c greet.c

# Move object files to build/
OBJ = $(patsubst %.c,build/%.o,$(SRC))

# BUILD configuration: release or debug
STRIP = true
BUILD ?= release
ifeq ($(BUILD),debug)
    CFLAGS = -ggdb -O0 -U_FORTIFY_SOURCE
	STRIP = false
else ifeq ($(BUILD),release)
    CFLAGS = -Wall -Wextra -O2
else
    $(error Invalid BUILD type. Use 'debug' or 'release')
endif


all: $(TARGET)

$(TARGET): $(OBJ)
	mkdir -p bin
	$(CC) $(CFLAGS) -o $@ $(OBJ)
ifeq ($(STRIP),true)
	strip $@
endif

build/%.o: %.c
	mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf build bin

.PHONY: all clean
