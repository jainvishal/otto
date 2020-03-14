# Create version.h file in build directory
include_directories(${PROJECT_BINARY_DIR})
set(VERSION_TEMPLATE ${OTTO_TEMPLATE_DIR}/version.h.in)
set(VERSION_HEADER ${PROJECT_BINARY_DIR}/${PROJECT_NAME}_version.h)

message(STATUS "Generating ${VERSION_HEADER} for ${PROJECT_VERSION}...")
configure_file(${VERSION_TEMPLATE} ${VERSION_HEADER})
