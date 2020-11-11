get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_variant)
    add_library(boost_variant INTERFACE)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/functional.cmake)
    include(${_current_dir}/build-modules/Boost/variant.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/type_index.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/math.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_variant VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS variant)

    bcm_setup_version(VERSION 1.74.0)
    add_library(Boost::variant ALIAS boost_variant)

    set_property(TARGET boost_variant PROPERTY EXPORT_NAME variant)
    target_link_libraries(boost_variant INTERFACE Boost::core)
    target_link_libraries(boost_variant INTERFACE Boost::static_assert)
    target_link_libraries(boost_variant INTERFACE Boost::bind)
    target_link_libraries(boost_variant INTERFACE Boost::mpl)
    target_link_libraries(boost_variant INTERFACE Boost::move)
    target_link_libraries(boost_variant INTERFACE Boost::detail)
    target_link_libraries(boost_variant INTERFACE Boost::functional)
    target_link_libraries(boost_variant INTERFACE Boost::assert)
    target_link_libraries(boost_variant INTERFACE Boost::type_traits)
    target_link_libraries(boost_variant INTERFACE Boost::type_index)
    target_link_libraries(boost_variant INTERFACE Boost::preprocessor)
    target_link_libraries(boost_variant INTERFACE Boost::config)
    target_link_libraries(boost_variant INTERFACE Boost::throw_exception)
    target_link_libraries(boost_variant INTERFACE Boost::math)
    target_link_libraries(boost_variant INTERFACE Boost::utility)
    
    bcm_deploy(TARGETS boost_variant INCLUDE ${boost_variant_SOURCE_DIR}/include NAMESPACE Boost::)
endif()