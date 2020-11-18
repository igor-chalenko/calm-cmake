get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_chrono)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/ratio.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/system.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_chrono VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS chrono)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::config Boost::integer Boost::move Boost::mpl
            Boost::predef Boost::ratio Boost::static_assert Boost::system Boost::throw_exception
            Boost::type_traits Boost::typeof Boost::utility
            NAMESPACE Boost
            EXPORT_NAME chrono
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_chrono INTERFACE)
    #add_library(Boost::chrono ALIAS boost_chrono)
    #set_property(TARGET boost_chrono PROPERTY EXPORT_NAME chrono)
    #target_link_libraries(boost_chrono INTERFACE Boost::config)
    #target_link_libraries(boost_chrono INTERFACE Boost::core)
    #target_link_libraries(boost_chrono INTERFACE Boost::integer)
    #target_link_libraries(boost_chrono INTERFACE Boost::move)
    #target_link_libraries(boost_chrono INTERFACE Boost::mpl)
    #target_link_libraries(boost_chrono INTERFACE Boost::predef)
    #target_link_libraries(boost_chrono INTERFACE Boost::ratio)
    #target_link_libraries(boost_chrono INTERFACE Boost::static_assert)
    #target_link_libraries(boost_chrono INTERFACE Boost::system)
    #target_link_libraries(boost_chrono INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_chrono INTERFACE Boost::type_traits)
    #target_link_libraries(boost_chrono INTERFACE Boost::typeof)
    #target_link_libraries(boost_chrono INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_chrono INCLUDE ${boost_chrono_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
