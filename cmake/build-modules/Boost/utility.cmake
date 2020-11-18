get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_utility)
    add_library(boost_utility INTERFACE)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/io.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_utility VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS utility)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::container_hash Boost::io Boost::preprocessor Boost::type_traits Boost::throw_exception
            NAMESPACE Boost
            EXPORT_NAME utility
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::utility ALIAS boost_utility)
    #set_property(TARGET boost_utility PROPERTY EXPORT_NAME utility)
    #target_link_libraries(boost_utility INTERFACE Boost::core)
    #target_link_libraries(boost_utility INTERFACE Boost::container_hash)
    #target_link_libraries(boost_utility INTERFACE Boost::io)
    #target_link_libraries(boost_utility INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_utility INTERFACE Boost::static_assert)
    #target_link_libraries(boost_utility INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_utility INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_utility INCLUDE ${boost_utility_SOURCE_DIR}/include NAMESPACE Boost::)
endif()


