get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_exception)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_exception VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS exception)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::smart_ptr Boost::throw_exception Boost::preprocessor Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME exception
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_exception INTERFACE)
    #add_library(Boost::exception ALIAS boost_exception)
    #set_property(TARGET boost_exception PROPERTY EXPORT_NAME exception)
    #target_link_libraries(boost_exception INTERFACE Boost::core)
    #target_link_libraries(boost_exception INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_exception INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_exception INTERFACE Boost::tuple)
    #target_link_libraries(boost_exception INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_exception INCLUDE ${boost_exception_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
