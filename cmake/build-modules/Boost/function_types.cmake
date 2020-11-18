get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_function_types)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_function_types VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS function_types)

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_function_types INTERFACE)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::detail Boost::mpl Boost::preprocessor Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME function_types
            )
    #add_library(Boost::function_types ALIAS boost_function_types)
    #set_property(TARGET boost_function_types PROPERTY EXPORT_NAME function_types)
    #target_link_libraries(boost_function_types INTERFACE Boost::core)
    #target_link_libraries(boost_function_types INTERFACE Boost::detail)
    #target_link_libraries(boost_function_types INTERFACE Boost::mpl)
    #target_link_libraries(boost_function_types INTERFACE Boost::mpl)
    #target_link_libraries(boost_function_types INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_function_types INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_function_types INCLUDE ${boost_function_types_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
