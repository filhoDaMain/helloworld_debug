#include "message.h"
#include <string.h>

const char* get_message(void)
{
    static char* msg = "hello";
    size_t ptr_sz = sizeof(msg);
    size_t char_sz = sizeof(*msg);
    size_t len = strlen(msg);
    return msg;
}