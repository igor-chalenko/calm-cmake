if (NOT TARGET boost_config)
    project(boost_config VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS config)

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(${PROJECT_NAME} INTERFACE)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            EXPORT_NAME config
            )
    #add_library(Boost::config ALIAS ${PROJECT_NAME})
    #set_property(TARGET ${PROJECT_NAME} PROPERTY EXPORT_NAME config)
    #bcm_deploy(TARGETS boost_config INCLUDE ${boost_config_SOURCE_DIR}/include NAMESPACE Boost::)
endif()