if (NOT TARGET boost_dynamic_bitset)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(dynamic_bitset headers assert
            config
            core
            integer
            move
            static_assert
            throw_exception)
endif()
