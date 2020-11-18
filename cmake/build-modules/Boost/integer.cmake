get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_integer)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    project(boost_integer VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS integer)

    #bcm_setup_version(VERSION 1.74.0)
    add_library(boost_integer INTERFACE)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::integer Boost::static_assert Boost::core Boost::throw_exception
            NAMESPACE Boost
            EXPORT_NAME integer
            )

    #add_library(Boost::integer ALIAS boost_integer)
    #set_property(TARGET boost_integer PROPERTY EXPORT_NAME integer)
    #target_link_libraries(boost_integer INTERFACE Boost::core)
    #target_link_libraries(boost_integer INTERFACE Boost::static_assert)
    #target_link_libraries(boost_integer INTERFACE Boost::throw_exception)
    #bcm_deploy(TARGETS boost_integer INCLUDE ${boost_integer_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
