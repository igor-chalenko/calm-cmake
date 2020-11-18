get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_bind)
    include(${_current_dir}/build-modules/Boost/core.cmake)

    project(boost_bind VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS bind)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core
            NAMESPACE Boost
            EXPORT_NAME bind
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_bind INTERFACE)
    #add_library(Boost::bind ALIAS boost_bind)
    #set_property(TARGET boost_bind PROPERTY EXPORT_NAME bind)
    #target_link_libraries(boost_bind INTERFACE Boost::core)
    #bcm_deploy(TARGETS boost_bind INCLUDE ${boost_bind_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
