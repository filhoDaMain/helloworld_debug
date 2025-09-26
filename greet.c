#include "greet.h"
#include <stdio.h>

int greetings(const char* str, int val)
{
    // Try a breakpoint here
    printf("%i: Greetings fellow %s\n", val, str);

    return val;
}