get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_foreach)
    add_library(boost_foreach INTERFACE)

    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_foreach VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS foreach)
    bcm_setup_version(VERSION 1.74.0)

    add_library(Boost::foreach ALIAS boost_foreach)
    set_property(TARGET boost_foreach PROPERTY EXPORT_NAME foreach)
    
    target_link_libraries(boost_foreach INTERFACE Boost::core)
    target_link_libraries(boost_foreach INTERFACE Boost::iterator)
    target_link_libraries(boost_foreach INTERFACE Boost::mpl)
    target_link_libraries(boost_foreach INTERFACE Boost::range)
    target_link_libraries(boost_foreach INTERFACE Boost::type_traits)
    target_link_libraries(boost_foreach INTERFACE Boost::config)
    bcm_deploy(TARGETS boost_foreach INCLUDE ${boost_foreach_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
