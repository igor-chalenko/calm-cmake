#get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_core)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_core VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS core)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_core INTERFACE)
    add_library(Boost::core ALIAS boost_core)

    set_property(TARGET boost_core PROPERTY EXPORT_NAME core)
    target_link_libraries(boost_core INTERFACE Boost::config)
    target_link_libraries(boost_core INTERFACE Boost::assert)
    bcm_deploy(TARGETS boost_core INCLUDE include NAMESPACE Boost::)
endif()

