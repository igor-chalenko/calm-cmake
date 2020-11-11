get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_type_traits)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)

    project(boost_type_traits VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS type_traits)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_type_traits INTERFACE)
    add_library(Boost::type_traits ALIAS boost_type_traits)

    set_property(TARGET boost_type_traits PROPERTY EXPORT_NAME type_traits)
    target_link_libraries(boost_type_traits INTERFACE Boost::config)
    target_link_libraries(boost_type_traits INTERFACE Boost::static_assert)
    target_link_libraries(boost_type_traits INTERFACE Boost::core)
    bcm_deploy(TARGETS boost_type_traits INCLUDE ${boost_type_traits_SOURCE_DIR}/include NAMESPACE Boost::)
endif()