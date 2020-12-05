get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_unordered)
    add_library(boost_unordered INTERFACE)

    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/container.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/functional.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)

    project(boost_unordered VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS unordered)
    else()
        find_package(Boost REQUIRED)
    endif()

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::container Boost::iterator Boost::tuple Boost::move
            Boost::functional Boost::detail Boost::assert Boost::throw_exception Boost::preprocessor
            Boost::type_traits Boost::config Boost::smart_ptr
            NAMESPACE Boost
            EXPORT_NAME unordered
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::unordered ALIAS boost_unordered)

    #target_include_directories(boost_unordered INTERFACE ${boost_unordered_SOURCE_DIR}/include)
    #set_property(TARGET boost_unordered PROPERTY EXPORT_NAME unordered)

    #target_link_libraries(boost_unordered INTERFACE Boost::core)
    #target_link_libraries(boost_unordered INTERFACE Boost::container)
    #target_link_libraries(boost_unordered INTERFACE Boost::iterator)
    #target_link_libraries(boost_unordered INTERFACE Boost::tuple)
    #target_link_libraries(boost_unordered INTERFACE Boost::move)
    #target_link_libraries(boost_unordered INTERFACE Boost::functional)
    #target_link_libraries(boost_unordered INTERFACE Boost::detail)
    #target_link_libraries(boost_unordered INTERFACE Boost::assert)
    #target_link_libraries(boost_unordered INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_unordered INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_unordered INTERFACE Boost::type_traits)
    #target_link_libraries(boost_unordered INTERFACE Boost::config)
    #target_link_libraries(boost_unordered INTERFACE Boost::smart_ptr)
    #bcm_deploy(TARGETS boost_unordered INCLUDE ${boost_unordered_SOURCE_DIR}/include NAMESPACE Boost::)
endif()