get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_type_index)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_type_index VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS type_index)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::container_hash Boost::smart_ptr Boost::preprocessor Boost::type_traits Boost::throw_exception Boost::static_assert
            NAMESPACE Boost
            EXPORT_NAME type_index
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_type_index INTERFACE)
    #add_library(Boost::type_index ALIAS boost_type_index)
    #set_property(TARGET boost_type_index PROPERTY EXPORT_NAME type_index)
    #target_link_libraries(boost_type_index INTERFACE Boost::container_hash)
    #target_link_libraries(boost_type_index INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_type_index INTERFACE Boost::core)
    #target_link_libraries(boost_type_index INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_type_index INTERFACE Boost::static_assert)
    #target_link_libraries(boost_type_index INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_type_index INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_type_index INCLUDE ${boost_type_index_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
