if (NOT TARGET Boost::thread)
    set(_lib_name thread)
    set(_lib_alt_name thread)
    set(_dependencies config predef move functional concept_check atomic io
            utility static_assert container system type_traits smart_ptr
            intrusive function core tuple winapi mpl preprocessor optional
            date_time exception algorithm chrono bind lexical_cast
            throw_exception)

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

        set(_sources
                "${boost_thread_SOURCE_DIR}/src/future.cpp;${boost_thread_SOURCE_DIR}/src/tss_null.cpp"
                )
        if(WIN32)
            list(APPEND _sources
                    "${boost_thread_SOURCE_DIR}/src/win32/thread.cpp;${boost_thread_SOURCE_DIR}/src/win32/tss_dll.cpp;${boost_thread_SOURCE_DIR}/src/win32/tss_pe.cpp")
        else()
            LIST(APPEND _sources
                    "${boost_thread_SOURCE_DIR}/src/pthread/thread.cpp;${boost_thread_SOURCE_DIR}/src/pthread/once.cpp"
                    )
        endif()
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ${_lib_name})

        calm_add_library(${_lib_name}
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                SOURCES ${_sources}
                DEPENDENCIES ${_deps}
                NAMESPACE Boost
                EXPORT_NAME ${_lib_name}
                )
    else()
        find_package(Boost REQUIRED COMPONENTS ${_lib_alt_name})
    endif()

    find_package(Threads)
endif()
