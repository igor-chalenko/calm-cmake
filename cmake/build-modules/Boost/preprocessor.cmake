if (NOT TARGET boost_preprocessor)
    project(boost_preprocessor VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS preprocessor)

    #bcm_setup_version(VERSION 1.74.0)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            EXPORT_NAME preprocessor
            )
    #add_library(Boost::preprocessor ALIAS boost_preprocessor)
    #set_property(TARGET boost_preprocessor PROPERTY EXPORT_NAME preprocessor)
    #bcm_deploy(TARGETS boost_preprocessor INCLUDE ${boost_preprocessor_SOURCE_DIR}/include NAMESPACE Boost::)
endif()