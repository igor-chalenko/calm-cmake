get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_container_hash)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_container_hash VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS container_hash)

    #bcm_setup_version(VERSION 1.74.0)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::integer Boost::static_assert Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME container_hash
            )
    #add_library(boost_container_hash INTERFACE)
    #add_library(Boost::container_hash ALIAS boost_container_hash)
    #set_property(TARGET boost_container_hash PROPERTY EXPORT_NAME container_hash)

    #target_link_libraries(boost_container_hash INTERFACE Boost::integer)
    #target_link_libraries(boost_container_hash INTERFACE Boost::static_assert)
    #target_link_libraries(boost_container_hash INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_container_hash INCLUDE ${boost_container_hash_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
