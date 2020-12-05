get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_proto)
    add_library(boost_proto INTERFACE)

    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)

    project(boost_proto VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS proto)
    else()
        find_package(Boost REQUIRED COMPONENTS headers)
    endif()

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::core Boost::static_assert Boost::mpl Boost::range Boost::fusion Boost::type_traits
            Boost::preprocessor Boost::utility Boost::config Boost::typeof
            NAMESPACE Boost
            EXPORT_NAME proto
            )
    #bcm_setup_version(VERSION 1.74.0)
    #set_property(TARGET boost_proto PROPERTY EXPORT_NAME proto)

    #target_link_libraries(boost_proto INTERFACE Boost::core)
    #target_link_libraries(boost_proto INTERFACE Boost::static_assert)
    #target_link_libraries(boost_proto INTERFACE Boost::mpl)
    #target_link_libraries(boost_proto INTERFACE Boost::range)
    #target_link_libraries(boost_proto INTERFACE Boost::fusion)
    #target_link_libraries(boost_proto INTERFACE Boost::type_traits)
    #target_link_libraries(boost_proto INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_proto INTERFACE Boost::utility)
    #target_link_libraries(boost_proto INTERFACE Boost::config)
    #target_link_libraries(boost_proto INTERFACE Boost::typeof)
    #bcm_deploy(TARGETS boost_proto INCLUDE ${boost_proto_SOURCE_DIR}/include NAMESPACE Boost::)
endif()