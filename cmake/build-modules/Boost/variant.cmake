if (NOT TARGET boost_variant)
    set(_dependencies core static_assert bind mpl move detail functional assert
            type_traits type_index preprocessor config throw_exception math
            utility)

    set(_lib_name variant)
    set(_lib_alt_name headers)

    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
