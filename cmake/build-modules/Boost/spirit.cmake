get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET boost_spirit)
    add_library(boost_spirit INTERFACE)

    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/locale.cmake)
    include(${_current_dir}/build-modules/Boost/tti.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/io.cmake)
    include(${_current_dir}/build-modules/Boost/serialization.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/unordered.cmake)
    include(${_current_dir}/build-modules/Boost/iostreams.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/regex.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/proto.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/config.cmake)
    #include(${_current_dir}/build-modules/Boost/math.cmake)
    include(${_current_dir}/build-modules/Boost/foreach.cmake)
    include(${_current_dir}/build-modules/Boost/function.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/phoenix.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/filesystem.cmake)
    include(${_current_dir}/build-modules/Boost/variant.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/integer.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)
    include(${_current_dir}/build-modules/Boost/pool.cmake)
    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/thread.cmake)
    include(${_current_dir}/build-modules/Boost/algorithm.cmake)
    include(${_current_dir}/build-modules/Boost/range.cmake)
    include(${_current_dir}/build-modules/Boost/typeof.cmake)
    include(${_current_dir}/build-modules/Boost/endian.cmake)
    #include(${_current_dir}/build-modules/Boost/lexical_cast.cmake)
    include(${_current_dir}/build-modules/Boost/throw_exception.cmake)

    project(boost_spirit VERSION 1.74.0)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS spirit)
    else()
        find_package(Boost REQUIRED COMPONENTS headers)
    endif()

    calm_add_library(${PROJECT_NAME} INTERFACE
            INCLUDES $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
            DEPENDENCIES Boost::predef Boost::locale Boost::tti Boost::concept_check
            Boost::io Boost::serialization Boost::array Boost::unordered
            Boost::iostreams Boost::utility Boost::regex Boost::static_assert
            Boost::iterator Boost::proto Boost::type_traits Boost::smart_ptr Boost::config
            Boost::foreach Boost::function Boost::core Boost::phoenix
            Boost::mpl Boost::filesystem Boost::throw_exception
            Boost::assert Boost::fusion Boost::integer Boost::preprocessor
            Boost::optional Boost::pool Boost::function_types Boost::thread
            Boost::algorithm Boost::range Boost::typeof Boost::endian
            #Boost::headers
            #Boost::lexical_cast Boost::math Boost::variant

            Boost::throw_exception
            NAMESPACE Boost
            EXPORT_NAME spirit
            )

    #bcm_setup_version(VERSION 1.74.0)

    #add_library(Boost::spirit ALIAS boost_spirit)
    #set_property(TARGET boost_spirit PROPERTY EXPORT_NAME spirit)

    #target_link_libraries(boost_spirit INTERFACE Boost::predef)
    #target_link_libraries(boost_spirit INTERFACE Boost::locale)
    #target_link_libraries(boost_spirit INTERFACE Boost::tti)
    #target_link_libraries(boost_spirit INTERFACE Boost::concept_check)
    #target_link_libraries(boost_spirit INTERFACE Boost::io)
    #target_link_libraries(boost_spirit INTERFACE Boost::serialization)
    #target_link_libraries(boost_spirit INTERFACE Boost::array)
    #target_link_libraries(boost_spirit INTERFACE Boost::unordered)
    #target_link_libraries(boost_spirit INTERFACE Boost::iostreams)
    #target_link_libraries(boost_spirit INTERFACE Boost::utility)
    #target_link_libraries(boost_spirit INTERFACE Boost::regex)
    #target_link_libraries(boost_spirit INTERFACE Boost::static_assert)
    #target_link_libraries(boost_spirit INTERFACE Boost::iterator)
    #target_link_libraries(boost_spirit INTERFACE Boost::proto)
    #target_link_libraries(boost_spirit INTERFACE Boost::type_traits)
    #target_link_libraries(boost_spirit INTERFACE Boost::smart_ptr)
    #target_link_libraries(boost_spirit INTERFACE Boost::config)
    #target_link_libraries(boost_spirit INTERFACE Boost::math)
    #target_link_libraries(boost_spirit INTERFACE Boost::foreach)
    #target_link_libraries(boost_spirit INTERFACE Boost::function)
    #target_link_libraries(boost_spirit INTERFACE Boost::core)
    #target_link_libraries(boost_spirit INTERFACE Boost::phoenix)
    #target_link_libraries(boost_spirit INTERFACE Boost::mpl)
    #target_link_libraries(boost_spirit INTERFACE Boost::filesystem)
    #target_link_libraries(boost_spirit INTERFACE Boost::variant)
    #target_link_libraries(boost_spirit INTERFACE Boost::assert)
    #target_link_libraries(boost_spirit INTERFACE Boost::fusion)
    #target_link_libraries(boost_spirit INTERFACE Boost::preprocessor)
    #target_link_libraries(boost_spirit INTERFACE Boost::integer)
    #target_link_libraries(boost_spirit INTERFACE Boost::optional)
    #target_link_libraries(boost_spirit INTERFACE Boost::pool)
    #target_link_libraries(boost_spirit INTERFACE Boost::function_types)
    #target_link_libraries(boost_spirit INTERFACE Boost::thread)
    #target_link_libraries(boost_spirit INTERFACE Boost::algorithm)
    #target_link_libraries(boost_spirit INTERFACE Boost::range)
    #target_link_libraries(boost_spirit INTERFACE Boost::typeof)
    #target_link_libraries(boost_spirit INTERFACE Boost::endian)
    #target_link_libraries(boost_spirit INTERFACE Boost::lexical_cast)
    #target_link_libraries(boost_spirit INTERFACE Boost::throw_exception)
    #bcm_deploy(TARGETS boost_spirit INCLUDE ${boost_spirit_SOURCE_DIR}/include NAMESPACE Boost::)
endif()
