get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_typeof)
    add_library(boost_typeof INTERFACE)

    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)

    project(boost_typeof VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS typeof)

    bcm_setup_version(VERSION 1.74.0)
    add_library(Boost::typeof ALIAS boost_typeof)
    set_property(TARGET boost_typeof PROPERTY EXPORT_NAME typeof)
    target_link_libraries(boost_typeof INTERFACE Boost::type_traits)
    target_link_libraries(boost_typeof INTERFACE Boost::preprocessor)
    bcm_deploy(TARGETS boost_typeof INCLUDE include NAMESPACE Boost::)
endif()
