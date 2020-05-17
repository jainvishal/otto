if (LIB_NAME)
    install(TARGETS ${LIB_NAME} EXPORT ${PROJECT_NAME}Targets
        LIBRARY DESTINATION ${OTTO_PROJECT_INSTALL_PREFIX}/lib$<$<CONFIG:Debug>:_debug>
        PUBLIC_HEADER DESTINATION ${OTTO_PROJECT_INSTALL_PREFIX}/include
    )
    # create any necessary find package targets for others to use
    include(otto_find)
endif()
if (APP_NAME)
    install(TARGETS ${APP_NAME}-bin EXPORT ${PROJECT_NAME}Targets
        RUNTIME DESTINATION ${OTTO_PROJECT_INSTALL_PREFIX}/bin$<$<CONFIG:Debug>:_debug>
    )
endif()
