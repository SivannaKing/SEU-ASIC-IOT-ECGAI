/* See LICENSE of license details. */
#include "hbird_sdk_soc.h"
#include <unistd.h>

__WEAK int _isatty(int fd)
{
    return 1;
}
