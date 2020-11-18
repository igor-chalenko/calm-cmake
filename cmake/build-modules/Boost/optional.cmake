get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_optional)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_optional VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS optional)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::detail Boost::mpl Boost::preprocessor Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME optional
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_optional INTERFACE)
    #add_library(Boost::optional ALIAS boost_optional)
    #set_property(TARGET boost_optional PROPERTY EXPORT_NAME optional)
    #target_link_libraries(boost_optional INTERFACE Boost::core)
    #target_link_libraries(boost_optional INTERFACE Boost::static_assert)
    #target_link_libraries(boost_optional INTERFACE Boost::detail)
    #target_link_libraries(boost_optional INTERFACE Boost::move)
    #target_link_libraries(boost_optional INTERFACE Boost::predef)
    #target_link_libraries(boost_optional INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_optional INTERFACE Boost::type_traits)
    #target_link_libraries(boost_optional INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_optional INCLUDE ${boost_optional_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
