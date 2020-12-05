get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_ratio)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/rational.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_ratio VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS ratio)
    else()
        find_package(Boost REQUIRED)
    endif()

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::assert Boost::core Boost::integer Boost::static_assert
            Boost::throw_exception Boost::type_traits Boost::utility
            NAMESPACE Boost
            EXPORT_NAME ratio
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_ratio INTERFACE)
    #add_library(Boost::ratio ALIAS boost_ratio)
    #set_property(TARGET boost_ratio PROPERTY EXPORT_NAME ratio)
    #target_link_libraries(boost_ratio INTERFACE Boost::config)
    #target_link_libraries(boost_ratio INTERFACE Boost::assert)
    #target_link_libraries(boost_ratio INTERFACE Boost::core)
    #target_link_libraries(boost_ratio INTERFACE Boost::integer)
    #target_link_libraries(boost_ratio INTERFACE Boost::static_assert)
    #target_link_libraries(boost_ratio INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_ratio INTERFACE Boost::type_traits)
    #target_link_libraries(boost_ratio INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_ratio INCLUDE ${boost_ratio_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
