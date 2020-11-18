if (NOT TARGET boost_predef)
    project(boost_predef VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS predef)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            EXPORT_NAME predef
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_predef INTERFACE)
    #add_library(Boost::predef ALIAS boost_predef)
    #set_property(TARGET boost_predef PROPERTY EXPORT_NAME predef)
    #bcm_deploy(TARGETS boost_predef INCLUDE ${boost_predef_SOURCE_DIR}/include NAMESPACE Boost::)
endif()