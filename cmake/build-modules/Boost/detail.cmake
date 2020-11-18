get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_detail)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_detail VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS detail)

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_detail INTERFACE)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::preprocessor Boost::static_assert Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME detail
            )
    #add_library(Boost::detail ALIAS boost_detail)
    #set_property(TARGET boost_detail PROPERTY EXPORT_NAME detail)
    #target_link_libraries(boost_detail INTERFACE Boost::core)
    #target_link_libraries(boost_detail INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_detail INTERFACE Boost::static_assert)
    #target_link_libraries(boost_detail INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_detail INCLUDE ${boost_detail_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
