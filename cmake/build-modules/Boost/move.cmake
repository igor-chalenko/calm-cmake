get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_move)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_move VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS move)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::assert Boost::core Boost::static_assert
            NAMESPACE Boost
            EXPORT_NAME move
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_move INTERFACE)
    #add_library(Boost::move ALIAS boost_move)
    #set_property(TARGET boost_move PROPERTY EXPORT_NAME move)
    #target_link_libraries(boost_move INTERFACE Boost::config)
    #target_link_libraries(boost_move INTERFACE Boost::assert)
    #target_link_libraries(boost_move INTERFACE Boost::core)
    #target_link_libraries(boost_move INTERFACE Boost::static_assert)
    #bcm_deploy(TARGETS boost_move INCLUDE ${boost_move_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
