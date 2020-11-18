get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_system)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/winapi.cmake)

    project(boost_system VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS system)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::winapi
            NAMESPACE Boost
            EXPORT_NAME system
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_system INTERFACE)
    #add_library(Boost::system ALIAS boost_system)
    #set_property(TARGET boost_system PROPERTY EXPORT_NAME system)
    #target_link_libraries(boost_system INTERFACE Boost::config)
    #target_link_libraries(boost_system INTERFACE Boost::winapi)
    #bcm_deploy(TARGETS boost_system INCLUDE ${boost_system_SOURCE_DIR}/include NAMESPACE Boost::)
endif()