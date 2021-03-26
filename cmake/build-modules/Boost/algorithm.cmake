if (NOT TARGET boost_algorithm)
    set(_dependencies regex core exception iterator tuple function bind mpl
            static_assert unordered assert range type_traits concept_check array
            config throw_exception)
    set(_lib_name algorithm)
    set(_lib_alt_name headers)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
endif()
