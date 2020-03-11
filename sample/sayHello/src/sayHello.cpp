#include <iostream>
#include "sayHello_version.h"

int sayHello(void) {
    std::cout << "Hello World!\n"; 
    std::cout << "sayHello Version " << sayHello_VERSION << " built using " << sayHello_BUILD_TYPE << " build configuration.\n";
    return 0;
}
