## Assuming source code is divided into src and include directories
include_directories(include)

## Create Version.h
include(otto_create_version)

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
                PUBLIC_HEADER "${LIB_HEADERS}"
        )
        target_include_directories(${LIB_NAME}
            INTERFACE $<INSTALL_INTERFACE:${OTTO_PROJECT_INSTALL_PREFIX}/include>
        )
    endif()
endif()

## If binary is required, add target
if (APP_NAME)
    add_executable(${APP_NAME}-bin ${APP_OBJS})
    set_target_properties(${APP_NAME}-bin
        PROPERTIES
            OUTPUT_NAME ${APP_NAME}
    )

    ## Link executable if shared object is also produced
    if (LIB_NAME)
        target_link_libraries(${APP_NAME}-bin ${LIB_NAME})
    endif()

    ## Fulfill any external dependencies (find_package)
    include(otto_external_dependency)
endif()

include(otto_install)
