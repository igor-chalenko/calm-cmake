if (NOT TARGET boost_config)
    project(boost_config VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS config)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_config INTERFACE)
    add_library(Boost::config ALIAS boost_config)
    set_property(TARGET boost_config PROPERTY EXPORT_NAME config)
    bcm_deploy(TARGETS boost_config INCLUDE include NAMESPACE Boost::)
endif()