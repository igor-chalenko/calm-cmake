get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_tti)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS tti)
    else()
        find_package(Boost REQUIRED)
    endif()

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_tti INTERFACE)

    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_tti VERSION 1.74.0)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::function_types Boost::mpl Boost::type_traits Boost::preprocessor Boost::config
            NAMESPACE Boost
            EXPORT_NAME tti
            )
    #add_library(Boost::tti ALIAS boost_tti)
    #set_property(TARGET boost_tti PROPERTY EXPORT_NAME tti)

    #target_link_libraries(boost_tti INTERFACE Boost::function_types)
    #target_link_libraries(boost_tti INTERFACE Boost::mpl)
    #target_link_libraries(boost_tti INTERFACE Boost::type_traits)
    #target_link_libraries(boost_tti INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_tti INTERFACE Boost::config)
    
    #bcm_deploy(TARGETS boost_tti INCLUDE ${boost_tti_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
