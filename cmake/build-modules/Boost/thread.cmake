get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

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
    add_library(boost_thread
            ${boost_thread_SOURCE_DIR}/src/future.cpp
            ${boost_thread_SOURCE_DIR}/src/tss_null.cpp
            )
    if(WIN32)
        target_sources(boost_thread PRIVATE
                ${boost_thread_SOURCE_DIR}/src/win32/thread.cpp
                ${boost_thread_SOURCE_DIR}/src/win32/tss_dll.cpp
                ${boost_thread_SOURCE_DIR}/src/win32/tss_pe.cpp
                )
    else()
        target_sources(boost_thread PRIVATE
                ${boost_thread_SOURCE_DIR}/src/pthread/thread.cpp
                ${boost_thread_SOURCE_DIR}/src/pthread/once.cpp
                )
    endif()

    calm_add_library(${PROJECT_NAME}
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
    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::thread ALIAS boost_thread)
    #target_include_directories(boost_thread INTERFACE ${boost_thread_SOURCE_DIR}/include)

    #target_link_libraries(boost_thread PUBLIC Boost::predef)
    #target_link_libraries(boost_thread PUBLIC Boost::move)
    #target_link_libraries(boost_thread PUBLIC Boost::functional)
    #target_link_libraries(boost_thread PUBLIC Boost::concept_check)
    #target_link_libraries(boost_thread PUBLIC Boost::atomic)
    #target_link_libraries(boost_thread PUBLIC Boost::io)
    #target_link_libraries(boost_thread PUBLIC Boost::utility)
    #target_link_libraries(boost_thread PUBLIC Boost::static_assert)
    #target_link_libraries(boost_thread PUBLIC Boost::container)
    #target_link_libraries(boost_thread PUBLIC Boost::system)
    #target_link_libraries(boost_thread PUBLIC Boost::type_traits)
    #target_link_libraries(boost_thread PUBLIC Boost::smart_ptr)
    #target_link_libraries(boost_thread PUBLIC Boost::intrusive)
    #target_link_libraries(boost_thread PUBLIC Boost::config)
    #target_link_libraries(boost_thread PUBLIC Boost::function)
    #target_link_libraries(boost_thread PUBLIC Boost::core)
    #target_link_libraries(boost_thread PUBLIC Boost::tuple)
    #target_link_libraries(boost_thread PUBLIC Boost::winapi)
    #target_link_libraries(boost_thread PUBLIC Boost::mpl)
    #target_link_libraries(boost_thread PUBLIC Boost::assert)
    #target_link_libraries(boost_thread PUBLIC Boost::preprocessor)
    #target_link_libraries(boost_thread PUBLIC Boost::optional)
    #target_link_libraries(boost_thread PUBLIC Boost::date_time)
    #target_link_libraries(boost_thread PUBLIC Boost::exception)
    #target_link_libraries(boost_thread PUBLIC Boost::algorithm)
    #target_link_libraries(boost_thread PUBLIC Boost::chrono)
    #target_link_libraries(boost_thread PUBLIC Boost::bind)
    #target_link_libraries(boost_thread PUBLIC Boost::lexical_cast)
    #target_link_libraries(boost_thread PUBLIC Boost::throw_exception)

    find_package(Threads)
    #target_link_libraries(boost_thread PRIVATE Threads::Threads)
    #target_include_directories(boost_thread PRIVATE ${boost_thread_SOURCE_DIR}/include)
    #bcm_deploy(TARGETS boost_thread INCLUDE ${boost_thread_SOURCE_DIR}/include NAMESPACE Boost::)
endif()