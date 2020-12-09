get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)

    if (NOT TARGET Boost::thread)
        include(${_current_dir}/build-modules/Boost/config.cmake)
        include(${_current_dir}/build-modules/Boost/predef.cmake)
        include(${_current_dir}/build-modules/Boost/move.cmake)
        include(${_current_dir}/build-modules/Boost/functional.cmake)
        include(${_current_dir}/build-modules/Boost/concept_check.cmake)
        include(${_current_dir}/build-modules/Boost/atomic.cmake)
        include(${_current_dir}/build-modules/Boost/io.cmake)
        include(${_current_dir}/build-modules/Boost/utility.cmake)
        include(${_current_dir}/build-modules/Boost/static_assert.cmake)
        include(${_current_dir}/build-modules/Boost/container.cmake)
        include(${_current_dir}/build-modules/Boost/system.cmake)
        include(${_current_dir}/build-modules/Boost/type_traits.cmake)
        include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
        include(${_current_dir}/build-modules/Boost/intrusive.cmake)
        include(${_current_dir}/build-modules/Boost/function.cmake)
        include(${_current_dir}/build-modules/Boost/core.cmake)
        include(${_current_dir}/build-modules/Boost/tuple.cmake)
        include(${_current_dir}/build-modules/Boost/winapi.cmake)
        include(${_current_dir}/build-modules/Boost/mpl.cmake)
        include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
        include(${_current_dir}/build-modules/Boost/optional.cmake)
        include(${_current_dir}/build-modules/Boost/date_time.cmake)
        include(${_current_dir}/build-modules/Boost/exception.cmake)
        include(${_current_dir}/build-modules/Boost/algorithm.cmake)
        include(${_current_dir}/build-modules/Boost/chrono.cmake)
        include(${_current_dir}/build-modules/Boost/bind.cmake)
        include(${_current_dir}/build-modules/Boost/lexical_cast.cmake)
        include(${_current_dir}/build-modules/Boost/throw_exception.cmake)

        project(boost_thread VERSION 1.74.0)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS thread)
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

        calm_add_library(${PROJECT_NAME}
                SOURCES ${_sources}
                INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                DEPENDENCIES Boost::predef Boost::move Boost::functional Boost::concept_check Boost::atomic
                Boost::io Boost::utility Boost::static_assert Boost::container Boost::system
                Boost::type_traits Boost::smart_ptr Boost::intrusive Boost::config Boost::function
                Boost::core Boost::tuple Boost::winapi Boost::mpl Boost::assert
                Boost::preprocessor Boost::optional Boost::date_time Boost::exception Boost::algorithm
                Boost::chrono Boost::bind Boost::lexical_cast Boost::throw_exception
                NAMESPACE Boost
                EXPORT_NAME thread
                )

        find_package(Threads)
    endif()

else()
    find_package(Boost REQUIRED COMPONENTS thread)
endif()
