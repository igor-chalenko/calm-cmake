if (NOT TARGET boost_filesystem)
    set(_dependencies core static_assert functional iterator system detail
            assert range type_traits smart_ptr io config)
    set(_lib_name filesystem)
    set(_lib_alt_name filesystem)

    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${_dependencies})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${_dependencies})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})
        set(_sources
                "${boost_filesystem_SOURCE_DIR}/src/directory.cpp;${boost_filesystem_SOURCE_DIR}/src/exception.cpp;${boost_filesystem_SOURCE_DIR}/src/path_traits.cpp;${boost_filesystem_SOURCE_DIR}/src/portability.cpp;${boost_filesystem_SOURCE_DIR}/src/unique_path.cpp;${boost_filesystem_SOURCE_DIR}/src/path.cpp;${boost_filesystem_SOURCE_DIR}/src/windows_file_codecvt.cpp;${boost_filesystem_SOURCE_DIR}/src/operations.cpp;${boost_filesystem_SOURCE_DIR}/src/codecvt_error_category.cpp;${boost_filesystem_SOURCE_DIR}/src/utf8_codecvt_facet.cpp"
                )

        calm_add_library(${_lib_name} INTERFACE
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                SOURCES ${_sources}
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
    else()
        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})
    endif()

endif()
