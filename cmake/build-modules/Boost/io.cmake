get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_io)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_io VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS io)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config
            NAMESPACE Boost
            EXPORT_NAME io
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_io INTERFACE)
    #add_library(Boost::io ALIAS boost_io)
    #set_property(TARGET boost_io PROPERTY EXPORT_NAME io)
    #target_link_libraries(boost_io INTERFACE Boost::config)
    #bcm_deploy(TARGETS boost_io INCLUDE ${boost_io_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
