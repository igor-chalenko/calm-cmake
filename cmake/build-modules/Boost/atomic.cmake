get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_atomic)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/align.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)

    project(boost_atomic VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS atomic)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::assert Boost::static_assert Boost::predef Boost::type_traits Boost::align Boost::preprocessor
            NAMESPACE Boost
            EXPORT_NAME atomic
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_atomic INTERFACE)
    #add_library(Boost::atomic ALIAS boost_atomic)
    #set_property(TARGET boost_atomic PROPERTY EXPORT_NAME atomic)
    #target_link_libraries(boost_atomic INTERFACE Boost::config)
    #target_link_libraries(boost_atomic INTERFACE Boost::assert)
    #target_link_libraries(boost_atomic INTERFACE Boost::static_assert)
    #target_link_libraries(boost_atomic INTERFACE Boost::type_traits)
    #target_link_libraries(boost_atomic INTERFACE Boost::predef)
    #target_link_libraries(boost_atomic INTERFACE Boost::align)
    #target_link_libraries(boost_atomic INTERFACE Boost::preprocessor)
    #bcm_deploy(TARGETS boost_atomic INCLUDE ${boost_atomic_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
