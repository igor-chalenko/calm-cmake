get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_tuple)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_tuple VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS tuple)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::static_assert Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME tuple
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_tuple INTERFACE)
    #add_library(Boost::tuple ALIAS boost_tuple)
    #set_property(TARGET boost_tuple PROPERTY EXPORT_NAME tuple)
    #target_link_libraries(boost_tuple INTERFACE Boost::core)
    #target_link_libraries(boost_tuple INTERFACE Boost::static_assert)
    #target_link_libraries(boost_tuple INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_tuple INCLUDE ${boost_tuple_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

