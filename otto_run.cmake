## Assuming source code is divided into src and include directories
include_directories(include)

## Include misc functions that otto needs
include(otto_create_version)

## create version.h file
otto_create_version()

## If binary is required, add target
if (APP_NAME)
    add_executable(${APP_NAME} ${APP_OBJS})
endif()

## If shared library is required, add target
if (LIB_NAME)
    add_library(${LIB_NAME} SHARED ${LIB_OBJS})

    ## If shared library and binary are required, link binary
    if (APP_NAME)
        target_link_libraries(${APP_NAME} ${LIB_NAME})
    endif()
endif()