get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_concept_check)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)

    project(boost_concept_check VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS concept_check)

    bcm_setup_version(VERSION 1.74.0)
    add_library(boost_concept_check INTERFACE)
    add_library(Boost::concept_check ALIAS boost_concept_check)
    set_property(TARGET boost_concept_check PROPERTY EXPORT_NAME concept_check)
    target_link_libraries(boost_concept_check INTERFACE Boost::type_traits)
    target_link_libraries(boost_concept_check INTERFACE Boost::static_assert)
    target_link_libraries(boost_concept_check INTERFACE Boost::preprocessor)
    bcm_deploy(TARGETS boost_concept_check INCLUDE include NAMESPACE Boost::)
endif()

