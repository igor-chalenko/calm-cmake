get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_throw_exception)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_throw_exception VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS throw_exception)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_throw_exception INTERFACE)
    add_library(Boost::throw_exception ALIAS boost_throw_exception)

    set_property(TARGET boost_throw_exception PROPERTY EXPORT_NAME throw_exception)
    target_link_libraries(boost_throw_exception INTERFACE Boost::assert)
    target_link_libraries(boost_throw_exception INTERFACE Boost::config)
    bcm_deploy(TARGETS boost_throw_exception INCLUDE ${boost_throw_exception_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

