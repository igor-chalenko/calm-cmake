get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_phoenix)
    add_library(boost_phoenix INTERFACE)

    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/proto.cmake)
    include(${_current_dir}/build-modules/Boost/bind.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_phoenix VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS phoenix)
    else()
        find_package(Boost REQUIRED COMPONENTS headers)
    endif()
    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::function Boost::core Boost::predef Boost::proto Boost::bind Boost::mpl
            Boost::range Boost::detail Boost::assert Boost::smart_ptr Boost::fusion Boost::type_traits
            Boost::preprocessor Boost::config Boost::utility
            NAMESPACE Boost
            EXPORT_NAME phoenix
            )
    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::phoenix ALIAS boost_phoenix)
    #set_property(TARGET boost_phoenix PROPERTY EXPORT_NAME phoenix)

    #target_link_libraries(boost_phoenix INTERFACE Boost::function)
    #target_link_libraries(boost_phoenix INTERFACE Boost::core)
    #target_link_libraries(boost_phoenix INTERFACE Boost::predef)
    #target_link_libraries(boost_phoenix INTERFACE Boost::proto)
    #target_link_libraries(boost_phoenix INTERFACE Boost::bind)
    #target_link_libraries(boost_phoenix INTERFACE Boost::mpl)
    #target_link_libraries(boost_phoenix INTERFACE Boost::range)
    #target_link_libraries(boost_phoenix INTERFACE Boost::detail)
    #target_link_libraries(boost_phoenix INTERFACE Boost::assert)
    #target_link_libraries(boost_phoenix INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_phoenix INTERFACE Boost::fusion)
    #target_link_libraries(boost_phoenix INTERFACE Boost::type_traits)
    #target_link_libraries(boost_phoenix INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_phoenix INTERFACE Boost::config)
    #target_link_libraries(boost_phoenix INTERFACE Boost::utility)
    #bcm_deploy(TARGETS boost_phoenix INCLUDE ${boost_phoenix_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
