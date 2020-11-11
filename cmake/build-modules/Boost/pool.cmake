get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_pool)
    include(${_current_dir}/build-modules/Boost/thread.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)

    project(boost_pool VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS pool)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_pool INTERFACE)
    add_library(Boost::pool ALIAS boost_pool)

    set_property(TARGET boost_pool PROPERTY EXPORT_NAME pool)
    target_link_libraries(boost_pool INTERFACE Boost::thread)
    target_link_libraries(boost_pool INTERFACE Boost::assert)
    target_link_libraries(boost_pool INTERFACE Boost::type_traits)
    target_link_libraries(boost_pool INTERFACE Boost::integer)
    target_link_libraries(boost_pool INTERFACE Boost::config)
    target_link_libraries(boost_pool INTERFACE Boost::throw_exception)

    bcm_deploy(TARGETS boost_pool INCLUDE ${boost_pool_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

