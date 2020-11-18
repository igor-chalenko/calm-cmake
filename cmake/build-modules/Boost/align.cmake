get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_align)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_align VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS align)

    #bcm_setup_version(VERSION 1.74.0)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            NAMESPACE Boost
            DEPENDENCIES Boost::config Boost::assert Boost::type_traits
            EXPORT_NAME align
            )
    #add_library(Boost::align ALIAS boost_align)
    #set_property(TARGET boost_align PROPERTY EXPORT_NAME align)
    #target_link_libraries(boost_align INTERFACE Boost::config)
    #target_link_libraries(boost_align INTERFACE Boost::assert)
    #target_link_libraries(boost_align INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_align INCLUDE ${boost_align_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
