get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_bind)
    include(${_current_dir}/build-modules/Boost/core.cmake)

    project(boost_bind VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS bind)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_bind INTERFACE)
    add_library(Boost::bind ALIAS boost_bind)
    set_property(TARGET boost_bind PROPERTY EXPORT_NAME bind)
    target_link_libraries(boost_bind INTERFACE Boost::core)
    bcm_deploy(TARGETS boost_bind INCLUDE include NAMESPACE Boost::)
endif()
