#include "greet.h"
#include "message.h"

int main(int argc, char **argv)
{
    int i;
    for (i = 0; i < 5; i++)
    {
        (void) greet( get_message(), (argc-1), (argv+1) );
    }
    return 0;
}
