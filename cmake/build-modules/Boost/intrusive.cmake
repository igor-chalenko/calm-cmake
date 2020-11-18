get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_intrusive)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)

    project(boost_intrusive VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS intrusive)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::assert Boost::move Boost::container_hash Boost::static_assert
            NAMESPACE Boost
            EXPORT_NAME intrusive
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_intrusive INTERFACE)
    #add_library(Boost::intrusive ALIAS boost_intrusive)
    #set_property(TARGET boost_intrusive PROPERTY EXPORT_NAME intrusive)
    #target_link_libraries(boost_intrusive INTERFACE Boost::config)
    #target_link_libraries(boost_intrusive INTERFACE Boost::assert)
    #target_link_libraries(boost_intrusive INTERFACE Boost::move)
    #target_link_libraries(boost_intrusive INTERFACE Boost::container_hash)
    #target_link_libraries(boost_intrusive INTERFACE Boost::static_assert)
    #bcm_deploy(TARGETS boost_intrusive INCLUDE ${boost_intrusive_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
