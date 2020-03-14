set(OTTO_VERSION 0.0.1)
set(OTTO_TEMPLATE_DIR ${CMAKE_CURRENT_LIST_DIR}/templates)

### Following can be tuned as needed
set(CMAKE_INSTALL_PREFIX /home/vishalj/release)
# Lets say we perform installs in /opt
set(OTTO_INSTALL_RPATH_PREFIX /opt)
# Where to find installed cmake files for other projects
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_INSTALL_PREFIX})

set(OTTO_PROJECT_INSTALL_PREFIX ${PROJECT_NAME}/${PROJECT_VERSION})
set(OTTO_BIN_OUTPUT_DIR bin)
set(OTTO_LIB_OUTPUT_DIR lib)
set(OTTO_DEBUG_POSTFIX _debug)

# Following will control where to find shared libraries after installation
set(CMAKE_INSTALL_RPATH ${OTTO_INSTALL_RPATH_PREFIX}/${OTTO_LIB_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OTTO_LIB_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OTTO_BIN_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
