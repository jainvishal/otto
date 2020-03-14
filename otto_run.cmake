## Assuming source code is divided into src and include directories
include_directories(include)

## Include misc functions that otto needs
include(otto_create_version)

## create version.h file
otto_create_version()

## If binary is required, add target
if (APP_NAME)
    add_executable(${APP_NAME}-bin ${APP_OBJS})
    set_target_properties(${APP_NAME}-bin
        PROPERTIES
            OUTPUT_NAME ${APP_NAME}
    )
endif()

## If shared library is required, add target
if (LIB_NAME)
    add_library(${LIB_NAME} SHARED ${LIB_OBJS})
    set_target_properties(${LIB_NAME}
        PROPERTIES
            VERSION ${PROJECT_VERSION}
            SOVERSION ${PROJECT_VERSION_MAJOR}
    )
    if (LIB_HEADERS)
        set_target_properties(${LIB_NAME}
            PROPERTIES
                PUBLIC_HEADER ${LIB_HEADERS}
        )
    endif()

    ## If shared library and binary are required, link binary
    if (APP_NAME)
        target_link_libraries(${APP_NAME}-bin ${LIB_NAME})
    endif()
endif()

include(otto_install)
