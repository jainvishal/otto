# Create version.h file in build directory
set(VERSION_TEMPLATE ${OTTO_TEMPLATE_DIR}/version.h.in)
set(VERSION_HEADER ${PROJECT_BINARY_DIR}/${OTTO_TOOLCHAIN}/${PROJECT_NAME}_version.h)

message(STATUS "Generating ${VERSION_HEADER} for ${PROJECT_VERSION}...")
configure_file(${VERSION_TEMPLATE} ${VERSION_HEADER})
