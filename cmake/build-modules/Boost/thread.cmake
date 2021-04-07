function(_calm_init_thread)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS thread)

        if (DEFINED boost_thread_SOURCE_DIR)
            foreach (_dep ${ARGN})
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
            calm_add_library(${_lib_name}
                    INCLUDES $<BUILD_INTERFACE:${boost_thread_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                    SOURCES ${_sources}
                    DEPENDENCIES ${_deps}
                    NAMESPACE Boost
                    EXPORT_NAME thread
                    )
            find_package(Threads)
            target_link_libraries(boost_thread PUBLIC Threads::Threads)
        else()
            find_package(Boost REQUIRED COMPONENTS thread)
        endif()
    else()
        find_package(Boost REQUIRED COMPONENTS thread)
    endif()
endfunction()

if (NOT TARGET Boost::thread)
    _calm_init_thread(config predef move functional concept_check atomic io
            utility static_assert container system type_traits smart_ptr
            intrusive function core tuple winapi mpl preprocessor optional
            date_time exception algorithm chrono bind lexical_cast
            throw_exception)
endif()
