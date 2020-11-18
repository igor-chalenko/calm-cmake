get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_rational)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_rational VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS rational)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::assert Boost::core Boost::integer Boost::static_assert Boost::throw_exception Boost::type_traits Boost::utility
            NAMESPACE Boost
            EXPORT_NAME rational
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_rational INTERFACE)
    #add_library(Boost::rational ALIAS boost_rational)
    #set_property(TARGET boost_rational PROPERTY EXPORT_NAME rational)
    #target_link_libraries(boost_rational INTERFACE Boost::config)
    #target_link_libraries(boost_rational INTERFACE Boost::assert)
    #target_link_libraries(boost_rational INTERFACE Boost::core)
    #target_link_libraries(boost_rational INTERFACE Boost::integer)
    #target_link_libraries(boost_rational INTERFACE Boost::static_assert)
    #target_link_libraries(boost_rational INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_rational INTERFACE Boost::type_traits)
    #target_link_libraries(boost_rational INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_rational INCLUDE ${boost_rational_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
