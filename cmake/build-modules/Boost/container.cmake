get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_container)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/intrusive.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_container VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS container)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::config Boost::assert Boost::container_hash Boost::intrusive
            Boost::move Boost::static_assert Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME container
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_container INTERFACE)
    #add_library(Boost::container ALIAS boost_container)
    #set_property(TARGET boost_container PROPERTY EXPORT_NAME container)
    #target_link_libraries(boost_container INTERFACE Boost::config)
    #target_link_libraries(boost_container INTERFACE Boost::assert)
    #target_link_libraries(boost_container INTERFACE Boost::container_hash)
    #target_link_libraries(boost_container INTERFACE Boost::core)
    #target_link_libraries(boost_container INTERFACE Boost::intrusive)
    #target_link_libraries(boost_container INTERFACE Boost::move)
    #target_link_libraries(boost_container INTERFACE Boost::static_assert)
    #target_link_libraries(boost_container INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_container INCLUDE ${boost_container_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
