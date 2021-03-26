get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_iterator)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/smart_ptr.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/function_types.cmake)
    include(${_current_dir}/build-modules/Boost/fusion.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)

    set(_lib_name iterator)
    set(_lib_alt_name headers)
    set(_dependencies concept_check numeric_conversion utility type_traits
            smart_ptr static_assert detail function_types fusion
            mpl optional)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
