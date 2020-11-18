get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_serialization)
    add_library(boost_serialization INTERFACE)

    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/move.cmake)
    include(${_current_dir}/build-modules/Boost/io.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/unordered.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/variant.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)
    include(${_current_dir}/build-modules/Boost/spirit.cmake)
    
    project(boost_serialization VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS serialization)

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::predef Boost::move Boost::io Boost::array Boost::unordered Boost::utility
            Boost::static_assert Boost::iterator Boost::detail Boost::type_traits Boost::smart_ptr
            Boost::config Boost::function Boost::core Boost::mpl Boost::variant
            Boost::assert Boost::preprocessor Boost::integer Boost::optional Boost::spirit
            NAMESPACE Boost
            EXPORT_NAME serialization
            )

    #bcm_setup_version(VERSION 1.74.0)
    #add_library(Boost::serialization ALIAS boost_serialization)
    #set_property(TARGET boost_serialization PROPERTY EXPORT_NAME serialization)

    #target_link_libraries(boost_serialization INTERFACE Boost::predef)
    #target_link_libraries(boost_serialization INTERFACE Boost::move)
    #target_link_libraries(boost_serialization INTERFACE Boost::io)
    #target_link_libraries(boost_serialization INTERFACE Boost::array)
    #target_link_libraries(boost_serialization INTERFACE Boost::unordered)
    #target_link_libraries(boost_serialization INTERFACE Boost::utility)
    #target_link_libraries(boost_serialization INTERFACE Boost::static_assert)
    #target_link_libraries(boost_serialization INTERFACE Boost::iterator)
    #target_link_libraries(boost_serialization INTERFACE Boost::detail)
    #target_link_libraries(boost_serialization INTERFACE Boost::type_traits)
    #target_link_libraries(boost_serialization INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_serialization INTERFACE Boost::config)
    #target_link_libraries(boost_serialization INTERFACE Boost::function)
    #target_link_libraries(boost_serialization INTERFACE Boost::core)
    #target_link_libraries(boost_serialization INTERFACE Boost::mpl)
    #target_link_libraries(boost_serialization INTERFACE Boost::variant)
    #target_link_libraries(boost_serialization INTERFACE Boost::assert)
    #target_link_libraries(boost_serialization INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_serialization INTERFACE Boost::integer)
    #target_link_libraries(boost_serialization INTERFACE Boost::optional)
    #target_link_libraries(boost_serialization INTERFACE Boost::spirit)
    #bcm_deploy(TARGETS boost_serialization INCLUDE ${boost_serialization_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
