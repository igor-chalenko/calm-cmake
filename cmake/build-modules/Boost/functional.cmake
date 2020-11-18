get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_functional)
    add_library(boost_functional INTERFACE)

    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_functional VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS functional)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::config Boost::function Boost::static_assert Boost::iterator
            Boost::typeof Boost::optional Boost::mpl Boost::function_types Boost::detail
            Boost::assert Boost::preprocessor Boost::integer Boost::utility
            NAMESPACE Boost
            EXPORT_NAME functional
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::functional ALIAS boost_functional)
    #set_property(TARGET boost_functional PROPERTY EXPORT_NAME functional)
    #target_link_libraries(boost_functional INTERFACE Boost::config)
    #target_link_libraries(boost_functional INTERFACE Boost::function)
    #target_link_libraries(boost_functional INTERFACE Boost::core)
    #target_link_libraries(boost_functional INTERFACE Boost::static_assert)
    #target_link_libraries(boost_functional INTERFACE Boost::iterator)
    #target_link_libraries(boost_functional INTERFACE Boost::typeof)
    #target_link_libraries(boost_functional INTERFACE Boost::optional)
    #target_link_libraries(boost_functional INTERFACE Boost::mpl)
    #target_link_libraries(boost_functional INTERFACE Boost::function_types)
    #target_link_libraries(boost_functional INTERFACE Boost::detail)
    #target_link_libraries(boost_functional INTERFACE Boost::assert)
    #target_link_libraries(boost_functional INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_functional INTERFACE Boost::integer)
    #target_link_libraries(boost_functional INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_functional INCLUDE ${boost_functional_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
