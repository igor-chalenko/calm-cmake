get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_regex)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_regex VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS regex)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::config Boost::assert Boost::container_hash Boost::integer
            Boost::iterator Boost::mpl Boost::predef Boost::smart_ptr Boost::static_assert
            Boost::throw_exception Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME regex
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_regex INTERFACE)
    #add_library(Boost::regex ALIAS boost_regex)
    #set_property(TARGET boost_regex PROPERTY EXPORT_NAME regex)
    #target_link_libraries(boost_regex INTERFACE Boost::config)
    #target_link_libraries(boost_regex INTERFACE Boost::assert)
    #target_link_libraries(boost_regex INTERFACE Boost::concept_check)
    #target_link_libraries(boost_regex INTERFACE Boost::container_hash)
    #target_link_libraries(boost_regex INTERFACE Boost::core)
    #target_link_libraries(boost_regex INTERFACE Boost::integer)
    #target_link_libraries(boost_regex INTERFACE Boost::iterator)
    #target_link_libraries(boost_regex INTERFACE Boost::mpl)
    #target_link_libraries(boost_regex INTERFACE Boost::predef)
    #target_link_libraries(boost_regex INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_regex INTERFACE Boost::static_assert)
    #target_link_libraries(boost_regex INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_regex INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_regex INCLUDE ${boost_regex_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
