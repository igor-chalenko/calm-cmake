get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_date_time)
    add_library(boost_date_time INTERFACE)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)

    project(boost_date_time VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS date_time)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::detail Boost::move Boost::predef Boost::static_assert
            Boost::throw_exception Boost::type_traits Boost::utility Boost::numeric_conversion
            NAMESPACE Boost
            EXPORT_NAME date_time
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::date_time ALIAS boost_date_time)
    #set_property(TARGET boost_date_time PROPERTY EXPORT_NAME date_time)
    #target_link_libraries(boost_date_time INTERFACE Boost::core)
    #target_link_libraries(boost_date_time INTERFACE Boost::detail)
    #target_link_libraries(boost_date_time INTERFACE Boost::move)
    #target_link_libraries(boost_date_time INTERFACE Boost::predef)
    #target_link_libraries(boost_date_time INTERFACE Boost::static_assert)
    #target_link_libraries(boost_date_time INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_date_time INTERFACE Boost::type_traits)
    #target_link_libraries(boost_date_time INTERFACE Boost::utility)
    #target_link_libraries(boost_date_time INTERFACE Boost::numeric_conversion)
    #bcm_deploy(TARGETS boost_date_time INCLUDE ${boost_date_time_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
