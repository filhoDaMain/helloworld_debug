#include "greet.h"

int main(void)
{
    int i;
    for (i = 0; i < 5; i++)
    {
        (void) greetings("Andre", i);
    }
    return 0;
}