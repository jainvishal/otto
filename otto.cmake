set(OTTO_VERSION 0.0.1)
set(OTTO_TEMPLATE_DIR ${CMAKE_CURRENT_LIST_DIR}/templates)

### Following can be tuned as needed
set(CMAKE_INSTALL_PREFIX /home/vishalj/release)
set(OTTO_PROJECT_INSTALL_PREFIX ${PROJECT_NAME}/${PROJECT_VERSION})
set(OTTO_BIN_OUTPUT_DIR bin)
set(OTTO_LIB_OUTPUT_DIR lib)
set(OTTO_DEBUG_POSTFIX _debug)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OTTO_LIB_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OTTO_BIN_OUTPUT_DIR}$<$<CONFIG:Debug>:${OTTO_DEBUG_POSTFIX}>)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
