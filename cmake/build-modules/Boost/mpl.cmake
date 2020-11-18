get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_mpl)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_mpl VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS mpl)

    #bcm_setup_version(VERSION 1.74.0)
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::predef Boost::static_assert Boost::preprocessor Boost::type_traits Boost::utility
            NAMESPACE Boost
            EXPORT_NAME mpl
            )
    #add_library(Boost::mpl ALIAS boost_mpl)
    #set_property(TARGET boost_mpl PROPERTY EXPORT_NAME mpl)
    #target_link_libraries(boost_mpl INTERFACE Boost::core)
    #target_link_libraries(boost_mpl INTERFACE Boost::predef)
    #target_link_libraries(boost_mpl INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_mpl INTERFACE Boost::static_assert)
    #target_link_libraries(boost_mpl INTERFACE Boost::type_traits)
    #target_link_libraries(boost_mpl INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_mpl INCLUDE ${boost_mpl_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

