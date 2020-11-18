get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_numeric_conversion)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)

    project(boost_numeric_conversion VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS numeric_conversion)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::smart_ptr Boost::throw_exception Boost::typeof Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME numeric_conversion
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_numeric_conversion INTERFACE)
    #add_library(Boost::numeric_conversion ALIAS boost_numeric_conversion)
    #set_property(TARGET boost_numeric_conversion PROPERTY EXPORT_NAME numeric_conversion)
    #target_link_libraries(boost_numeric_conversion INTERFACE Boost::core)
    #target_link_libraries(boost_numeric_conversion INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_numeric_conversion INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_numeric_conversion INTERFACE Boost::type_traits)
    #target_link_libraries(boost_numeric_conversion INTERFACE Boost::typeof)
    #bcm_deploy(TARGETS boost_numeric_conversion INCLUDE ${boost_numeric_conversion_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
