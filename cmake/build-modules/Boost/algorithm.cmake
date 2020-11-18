get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_algorithm)
    include(${_current_dir}/build-modules/Boost/regex.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/exception.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/unordered.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)

    project(boost_algorithm VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS algorithm)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::regex Boost::exception Boost::iterator Boost::tuple
            Boost::function Boost::bind Boost::mpl Boost::static_assert Boost::unordered
            Boost::assert Boost::range Boost::type_traits Boost::concept_check Boost::array
            Boost::config Boost::throw_exception
            NAMESPACE Boost
            EXPORT_NAME algorithm
            )
    #bcm_setup_version(VERSION 1.74.0)

    #add_library(boost_algorithm INTERFACE)
    #add_library(Boost::algorithm ALIAS boost_algorithm)
    #set_property(TARGET boost_algorithm PROPERTY EXPORT_NAME algorithm)

    #target_include_directories(boost_algorithm INTERFACE ${boost_algorithm_SOURCE_DIR}/include)
    #target_link_libraries(boost_algorithm INTERFACE Boost::regex)
    #target_link_libraries(boost_algorithm INTERFACE Boost::core)
    #target_link_libraries(boost_algorithm INTERFACE Boost::exception)
    #target_link_libraries(boost_algorithm INTERFACE Boost::iterator)
    #target_link_libraries(boost_algorithm INTERFACE Boost::tuple)
    #target_link_libraries(boost_algorithm INTERFACE Boost::function)
    #target_link_libraries(boost_algorithm INTERFACE Boost::bind)
    #target_link_libraries(boost_algorithm INTERFACE Boost::mpl)
    #target_link_libraries(boost_algorithm INTERFACE Boost::static_assert)
    #target_link_libraries(boost_algorithm INTERFACE Boost::unordered)
    #target_link_libraries(boost_algorithm INTERFACE Boost::assert)
    #target_link_libraries(boost_algorithm INTERFACE Boost::range)
    #target_link_libraries(boost_algorithm INTERFACE Boost::type_traits)
    #target_link_libraries(boost_algorithm INTERFACE Boost::concept_check)
    #target_link_libraries(boost_algorithm INTERFACE Boost::array)
    #target_link_libraries(boost_algorithm INTERFACE Boost::config)
    #target_link_libraries(boost_algorithm INTERFACE Boost::throw_exception)
    #bcm_deploy(TARGETS boost_algorithm INCLUDE ${boost_algorithm_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
