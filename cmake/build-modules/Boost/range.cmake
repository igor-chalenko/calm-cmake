get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_range)
    add_library(boost_range INTERFACE)

    include(${_current_dir}/build-modules/Boost/regex.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/functional.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_range VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS range)
    #bcm_setup_version(VERSION 1.74.0)

    #target_include_directories(boost_range INTERFACE ${boost_range_SOURCE_DIR}/include)
    #add_library(Boost::range ALIAS boost_range)
    #set_property(TARGET boost_range PROPERTY EXPORT_NAME range)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES
                Boost::core
                Boost::regex
                Boost::static_assert
                Boost::iterator
                Boost::functional
                Boost::assert
                Boost::tuple
                Boost::optional
                Boost::mpl
                Boost::detail
                Boost::type_traits
                Boost::concept_check
                Boost::preprocessor
                Boost::config
                Boost::array
                Boost::numeric_conversion
                Boost::utility
            NAMESPACE Boost
            EXPORT_NAME range
            )

    #target_link_libraries(boost_range INTERFACE Boost::regex)
    #target_link_libraries(boost_range INTERFACE Boost::core)
    #target_link_libraries(boost_range INTERFACE Boost::static_assert)
    #target_link_libraries(boost_range INTERFACE Boost::iterator)
    #target_link_libraries(boost_range INTERFACE Boost::tuple)
    #target_link_libraries(boost_range INTERFACE Boost::optional)
    #target_link_libraries(boost_range INTERFACE Boost::mpl)
    #target_link_libraries(boost_range INTERFACE Boost::functional)
    #target_link_libraries(boost_range INTERFACE Boost::detail)
    #target_link_libraries(boost_range INTERFACE Boost::assert)
    #target_link_libraries(boost_range INTERFACE Boost::type_traits)
    #target_link_libraries(boost_range INTERFACE Boost::concept_check)
    #target_link_libraries(boost_range INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_range INTERFACE Boost::array)
    #target_link_libraries(boost_range INTERFACE Boost::config)
    #target_link_libraries(boost_range INTERFACE Boost::numeric_conversion)
    #target_link_libraries(boost_range INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_range INCLUDE ${boost_range_SOURCE_DIR}/include NAMESPACE Boost::)
endif()

