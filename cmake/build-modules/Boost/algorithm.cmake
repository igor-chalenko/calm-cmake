if (NOT TARGET boost_algorithm)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(algorithm headers regex core exception iterator tuple
            function bind mpl static_assert unordered assert range type_traits
            concept_check array
            config throw_exception)
endif()
