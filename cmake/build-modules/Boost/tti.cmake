get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_tti)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS tti)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_tti INTERFACE)


    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)

    project(boost_tti VERSION 1.74.0)
    add_library(Boost::tti ALIAS boost_tti)
    set_property(TARGET boost_tti PROPERTY EXPORT_NAME tti)

    target_link_libraries(boost_tti INTERFACE Boost::function_types)
    target_link_libraries(boost_tti INTERFACE Boost::mpl)
    target_link_libraries(boost_tti INTERFACE Boost::type_traits)
    target_link_libraries(boost_tti INTERFACE Boost::preprocessor)
    target_link_libraries(boost_tti INTERFACE Boost::config)
    
    bcm_deploy(TARGETS boost_tti INCLUDE include NAMESPACE Boost::)
endif()
