get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_fusion)
    add_library(boost_fusion INTERFACE)

    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/container_hash.cmake)
    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_fusion VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS fusion)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::container_hash Boost::function_types Boost::mpl Boost::preprocessor
                         Boost::static_assert Boost::tuple Boost::type_traits Boost::typeof Boost::utility
            NAMESPACE Boost
            EXPORT_NAME fusion
            )
    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::fusion ALIAS boost_fusion)
    #set_property(TARGET boost_fusion PROPERTY EXPORT_NAME fusion)
    #target_link_libraries(boost_fusion INTERFACE Boost::core)
    #target_link_libraries(boost_fusion INTERFACE Boost::container_hash)
    #target_link_libraries(boost_fusion INTERFACE Boost::function_types)
    #target_link_libraries(boost_fusion INTERFACE Boost::mpl)
    #target_link_libraries(boost_fusion INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_fusion INTERFACE Boost::static_assert)
    #target_link_libraries(boost_fusion INTERFACE Boost::tuple)
    #target_link_libraries(boost_fusion INTERFACE Boost::type_traits)
    #target_link_libraries(boost_fusion INTERFACE Boost::typeof)
    #target_link_libraries(boost_fusion INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_fusion INCLUDE ${boost_fusion_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
