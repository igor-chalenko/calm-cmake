get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_iterator)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)

    project(boost_iterator VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS iterator)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::concept_check Boost::numeric_conversion Boost::utility Boost::smart_ptr Boost::type_traits
            Boost::static_assert Boost::detail Boost::function_types Boost::fusion Boost::mpl Boost::optional
            NAMESPACE Boost
            EXPORT_NAME iterator
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(boost_iterator INTERFACE)
    #add_library(Boost::iterator ALIAS boost_iterator)
    #set_property(TARGET boost_iterator PROPERTY EXPORT_NAME iterator)
    #target_link_libraries(boost_iterator INTERFACE Boost::concept_check)
    #target_link_libraries(boost_iterator INTERFACE Boost::numeric_conversion)
    #target_link_libraries(boost_iterator INTERFACE Boost::utility)
    #target_link_libraries(boost_iterator INTERFACE Boost::type_traits)
    #target_link_libraries(boost_iterator INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_iterator INTERFACE Boost::static_assert)
    #target_link_libraries(boost_iterator INTERFACE Boost::detail)
    #target_link_libraries(boost_iterator INTERFACE Boost::function_types)
    #target_link_libraries(boost_iterator INTERFACE Boost::fusion)
    #target_link_libraries(boost_iterator INTERFACE Boost::mpl)
    #target_link_libraries(boost_iterator INTERFACE Boost::optional)
    #bcm_deploy(TARGETS boost_iterator INCLUDE ${boost_iterator_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
