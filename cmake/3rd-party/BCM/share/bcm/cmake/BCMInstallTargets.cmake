include(GNUInstallDirs)

function(bcm_install_targets)
    set(options)
    set(oneValueArgs EXPORT)
    set(multiValueArgs TARGETS INCLUDE)

    cmake_parse_arguments(PARSE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    string(TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWER)
    set(EXPORT_FILE ${PROJECT_NAME_LOWER}-targets)
    if(PARSE_EXPORT)
        set(EXPORT_FILE ${PARSE_EXPORT})
    endif()

    set(BIN_INSTALL_DIR ${CMAKE_INSTALL_BINDIR})
    set(LIB_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR})
    set(INCLUDE_INSTALL_DIR ${CMAKE_INSTALL_INCLUDEDIR})

    foreach(TARGET ${PARSE_TARGETS})
        get_target_property(_type ${TARGET} TYPE)
        foreach(INCLUDE ${PARSE_INCLUDE})
            get_filename_component(INCLUDE_PATH ${INCLUDE} ABSOLUTE)
            if (_type STREQUAL INTERFACE_LIBRARY)
                target_include_directories(${TARGET} INTERFACE $<BUILD_INTERFACE:${INCLUDE_PATH}>)
            else()
                target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${INCLUDE_PATH}>)
            endif()
        endforeach()
        if (_type STREQUAL INTERFACE_LIBRARY)
            target_include_directories(${TARGET} INTERFACE $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>)
        else()
            target_include_directories(${TARGET} PUBLIC $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>)
        endif()
    endforeach()

    foreach(INCLUDE ${PARSE_INCLUDE})
        install(DIRECTORY ${INCLUDE}/ DESTINATION ${INCLUDE_INSTALL_DIR})
    endforeach()

    install(TARGETS ${PARSE_TARGETS} 
        EXPORT ${EXPORT_FILE}
        RUNTIME DESTINATION ${BIN_INSTALL_DIR}
        LIBRARY DESTINATION ${LIB_INSTALL_DIR}
        ARCHIVE DESTINATION ${LIB_INSTALL_DIR})

endfunction()

