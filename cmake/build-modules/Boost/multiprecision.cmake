if (NOT TARGET boost_multiprecision)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(multiprecision headers core static_assert predef mpl
            random functional assert type_traits smart_ptr rational integer
            array config throw_exception)
endif()
