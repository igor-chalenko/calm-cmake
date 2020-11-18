get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_function)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_index.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)

    project(boost_function VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS function)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::bind Boost::integer Boost::preprocessor Boost::throw_exception Boost::typeof Boost::type_index
            NAMESPACE Boost
            EXPORT_NAME function
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_function INTERFACE)
    #add_library(Boost::function ALIAS boost_function)
    #set_property(TARGET boost_function PROPERTY EXPORT_NAME function)
    #target_link_libraries(boost_function INTERFACE Boost::bind)
    #target_link_libraries(boost_function INTERFACE Boost::core)
    #target_link_libraries(boost_function INTERFACE Boost::integer)
    #target_link_libraries(boost_function INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_function INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_function INTERFACE Boost::type_index)
    #target_link_libraries(boost_function INTERFACE Boost::typeof)
    #bcm_deploy(TARGETS boost_function INCLUDE ${boost_function_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
