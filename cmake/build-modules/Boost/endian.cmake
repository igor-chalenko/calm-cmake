get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_endian)
    add_library(boost_endian INTERFACE)

    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/system.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_endian VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS endian)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::predef Boost::system Boost::config Boost::type_traits Boost::utility
            NAMESPACE Boost
            EXPORT_NAME endian
            )
    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::endian ALIAS boost_endian)

    #set_property(TARGET boost_endian PROPERTY EXPORT_NAME endian)
    #target_link_libraries(boost_endian INTERFACE Boost::core)
    #target_link_libraries(boost_endian INTERFACE Boost::predef)
    #target_link_libraries(boost_endian INTERFACE Boost::system)
    #target_link_libraries(boost_endian INTERFACE Boost::type_traits)
    #target_link_libraries(boost_endian INTERFACE Boost::config)
    #target_link_libraries(boost_endian INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_endian INCLUDE ${boost_endian_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

