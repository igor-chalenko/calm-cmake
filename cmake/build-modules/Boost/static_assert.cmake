get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_static_assert)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_static_assert VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS static_assert)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_static_assert INTERFACE)
    add_library(Boost::static_assert ALIAS boost_static_assert)
    set_property(TARGET boost_static_assert PROPERTY EXPORT_NAME static_assert)
    target_link_libraries(boost_static_assert INTERFACE Boost::config)
    bcm_deploy(TARGETS boost_static_assert INCLUDE include NAMESPACE Boost::)
endif()

