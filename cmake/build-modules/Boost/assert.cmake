get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_assert)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_assert VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS assert)

    #bcm_setup_version(VERSION 1.74.0)
    #calm_add_library(${PROJECT_NAME} INTERFACE
    #        INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
    #        INSTALL
    #        )
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            DEPENDENCIES Boost::config
            EXPORT_NAME assert
            )
    #add_library(Boost::assert ALIAS boost_assert)

    #set_property(TARGET boost_assert PROPERTY EXPORT_NAME assert)
    #target_link_libraries(boost_assert INTERFACE Boost::config)
    #bcm_deploy(TARGETS boost_assert INCLUDE ${boost_assert_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

