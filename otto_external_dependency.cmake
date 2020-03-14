foreach(externalProject IN LISTS OTTO_DEPENDENCY_ON)
        string(REPLACE ":" ";" packageInfo ${externalProject})
        list(LENGTH packageInfo packageElements)
        if (NOT ${packageElements} EQUAL 2)
            message(FATAL_ERROR "
                OTTO_DEPENDENCY_ON requires <projectName>:<projectVersion> for each dependency.
                Offending value is <${externalProject}>
            ")
        endif()

        list(GET packageInfo 0 packageName)
        list(GET packageInfo 1 packageVersion)

        if ("${packageName}" STREQUAL "" OR "${packageVersion}" STREQUAL "")
            message(FATAL_ERROR "
                OTTO_DEPENDENCY_ON requires <projectName>:<projectVersion> for each dependency.
                Offending value is <${externalProject}>
            ")
        endif()
        message(STATUS "External dependencies on ${packageName} version ${packageVersion}")

        find_package(${packageName} ${packageVersion} REQUIRED)
        target_link_libraries(${APP_NAME}-bin ${packageName}::${packageName})
endforeach()