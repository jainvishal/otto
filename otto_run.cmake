### Following can be tuned as needed
set(CMAKE_INSTALL_PREFIX /home/vishalj/release)
# Lets say we perform installs in /opt (used for finding shared libraries on installed systems)
set(OTTO_INSTALL_RPATH_PREFIX /opt)
# Where to find installed cmake files for other projects
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_INSTALL_PREFIX})

set(OTTO_BIN_OUTPUT_DIR bin)
set(OTTO_LIB_OUTPUT_DIR lib)
set(OTTO_DEBUG_POSTFIX _debug)

set(OTTO_PROJECT_INSTALL_PREFIX ${PROJECT_NAME}/${PROJECT_VERSION}/${OTTO_TOOLCHAIN})
set(OTTO_INTERFACE_INSTALL_PREFIX ${PROJECT_NAME}/${PROJECT_VERSION})

# Following will control where to find shared libraries after installation
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH True)
set(CMAKE_INSTALL_RPATH ${OTTO_INSTALL_RPATH_PREFIX}/${OTTO_LIB_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OTTO_LIB_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>/${OTTO_TOOLCHAIN})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OTTO_BIN_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>/${OTTO_TOOLCHAIN})


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
    ## Assuming source code is divided into src and include directories
    target_include_directories(${LIB_NAME}
        PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
        PRIVATE $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/${OTTO_TOOLCHAIN}>
    )
    if (LIB_HEADERS)
        set_target_properties(${LIB_NAME}
            PROPERTIES
                PUBLIC_HEADER "${LIB_HEADERS}"
        )
        target_include_directories(${LIB_NAME}
            INTERFACE $<INSTALL_INTERFACE:${OTTO_INTERFACE_INSTALL_PREFIX}/include>
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
    ## Assuming source code is divided into src and include directories
    target_include_directories(${APP_NAME}-bin
        PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
        PRIVATE $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/${OTTO_TOOLCHAIN}>
    )

    ## Link executable if shared object is also produced
    if (LIB_NAME)
        target_link_libraries(${APP_NAME}-bin ${LIB_NAME})
    endif()

endif()

## Fulfill any external dependencies (find_package)
include(otto_external_dependency)

include(otto_install)
