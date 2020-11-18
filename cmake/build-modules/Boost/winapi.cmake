get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_winapi)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)

    project(boost_winapi VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS winapi)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::predef
            NAMESPACE Boost
            EXPORT_NAME winapi
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_winapi INTERFACE)
    #add_library(Boost::winapi ALIAS boost_winapi)
    #set_property(TARGET boost_winapi PROPERTY EXPORT_NAME winapi)
    #target_link_libraries(boost_winapi INTERFACE Boost::config)
    #target_link_libraries(boost_winapi INTERFACE Boost::predef)
    #bcm_deploy(TARGETS boost_winapi INCLUDE ${boost_winapi_SOURCE_DIR}/include NAMESPACE Boost::)
endif()