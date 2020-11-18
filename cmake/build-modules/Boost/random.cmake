get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_random)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/system.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/math.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_random VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS random)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::static_assert Boost::mpl Boost::system Boost::assert Boost::range
            Boost::type_traits Boost::integer Boost::throw_exception Boost::math Boost::utility
            NAMESPACE Boost
            EXPORT_NAME random
            )

    #bcm_setup_version(VERSION 1.74.0)

    #add_library(boost_random INTERFACE)
    #add_library(Boost::random ALIAS boost_random)
    #set_property(TARGET boost_random PROPERTY EXPORT_NAME random)

    #target_include_directories(boost_random INTERFACE ${boost_random_SOURCE_DIR}/include)
    #target_link_libraries(boost_random INTERFACE Boost::core)
    #target_link_libraries(boost_random INTERFACE Boost::static_assert)
    #target_link_libraries(boost_random INTERFACE Boost::mpl)
    #target_link_libraries(boost_random INTERFACE Boost::system)
    #target_link_libraries(boost_random INTERFACE Boost::assert)
    #target_link_libraries(boost_random INTERFACE Boost::range)
    #target_link_libraries(boost_random INTERFACE Boost::type_traits)
    #target_link_libraries(boost_random INTERFACE Boost::integer)
    #target_link_libraries(boost_random INTERFACE Boost::config)
    #target_link_libraries(boost_random INTERFACE Boost::throw_exception)
    #target_link_libraries(boost_random INTERFACE Boost::math)
    #target_link_libraries(boost_random INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_random INCLUDE ${boost_random_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
