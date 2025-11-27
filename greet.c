#include "greet.h"
#include <stdio.h>

int greet(const char* msg, int n_arg, char **arg)
{
    static int i = 0;
    printf("%i: A very grungy way of saying %s to\n", i, msg);

    for (int n = 0; n < n_arg; n++)
    {
        printf("   - %s\n", arg[n]);
    }
    printf("\n");

    return (i++);
}