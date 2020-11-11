get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_smart_ptr)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    project(boost_smart_ptr VERSION 1.74.0)

    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS smart_ptr)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_smart_ptr INTERFACE)
    add_library(Boost::smart_ptr ALIAS boost_smart_ptr)

    set_property(TARGET boost_smart_ptr PROPERTY EXPORT_NAME smart_ptr)
    target_link_libraries(boost_smart_ptr INTERFACE Boost::core)
    target_link_libraries(boost_smart_ptr INTERFACE Boost::move)
    target_link_libraries(boost_smart_ptr INTERFACE Boost::static_assert)
    target_link_libraries(boost_smart_ptr INTERFACE Boost::throw_exception)
    target_link_libraries(boost_smart_ptr INTERFACE Boost::type_traits)
    bcm_deploy(TARGETS boost_smart_ptr INCLUDE ${boost_smart_ptr_SOURCE_DIR}/include NAMESPACE Boost::)
endif()