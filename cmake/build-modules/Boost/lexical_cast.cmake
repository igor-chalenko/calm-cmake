get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_lexical_cast)
    add_library(boost_lexical_cast INTERFACE)

    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/container.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/math.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    project(boost_lexical_cast VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS lexical_cast)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::config Boost::array Boost::assert Boost::container Boost::core Boost::detail
            Boost::integer Boost::math Boost::numeric_conversion Boost::range Boost::static_assert
            Boost::throw_exception Boost::type_traits
            NAMESPACE Boost
            EXPORT_NAME lexical_cast
            )

    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::lexical_cast ALIAS boost_lexical_cast)
    #set_property(TARGET boost_lexical_cast PROPERTY EXPORT_NAME lexical_cast)

    #target_link_libraries(boost_lexical_cast INTERFACE Boost::config)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::array)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::assert)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::container)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::core)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::detail)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::integer)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::math)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::numeric_conversion)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::range)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::static_assert)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_lexical_cast INTERFACE Boost::type_traits)
    #bcm_deploy(TARGETS boost_lexical_cast INCLUDE ${boost_lexical_cast_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
