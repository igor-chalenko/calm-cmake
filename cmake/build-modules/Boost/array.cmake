get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
include(${_current_dir}/build-modules/Boost/config.cmake)
include(${_current_dir}/build-modules/Boost/assert.cmake)
include(${_current_dir}/build-modules/Boost/core.cmake)
include(${_current_dir}/build-modules/Boost/static_assert.cmake)
include(${_current_dir}/build-modules/Boost/throw_exception.cmake)

if (NOT TARGET boost_array)
    project(boost_array VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS array)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            DEPENDENCIES Boost::config Boost::assert Boost::core Boost::static_assert Boost::throw_exception
            EXPORT_NAME array
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_array INTERFACE)
    #add_library(Boost::array ALIAS boost_array)
    #set_property(TARGET boost_array PROPERTY EXPORT_NAME array)
    #target_link_libraries(boost_array INTERFACE Boost::config)
    #target_link_libraries(boost_array INTERFACE Boost::assert)
    #target_link_libraries(boost_array INTERFACE Boost::core)
    #target_link_libraries(boost_array INTERFACE Boost::static_assert)
    #target_link_libraries(boost_array INTERFACE Boost::throw_exception)
    #bcm_deploy(TARGETS boost_array INCLUDE ${boost_array_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
