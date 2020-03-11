# Create version.h file in build directory
function(otto_create_version)
    include_directories(${CMAKE_BINARY_DIR})
    set(VERSION_TEMPLATE ${OTTO_TEMPLATE_DIR}/version.h.in)
    set(VERSION_HEADER ${CMAKE_BINARY_DIR}/${PROJECT_NAME}_version.h)

    message(STATUS "Generating ${VERSION_HEADER} for ${PROJECT_VERSION}...")
    configure_file(${VERSION_TEMPLATE} ${VERSION_HEADER})    
endfunction(otto_create_version)