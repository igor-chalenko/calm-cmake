get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
if (NOT TARGET boost_mpl)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/predef.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    set(_lib_name mpl)
    set(_lib_alt_name headers)
    set(_dependencies
            core predef preprocessor static_assert type_traits utility)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()

