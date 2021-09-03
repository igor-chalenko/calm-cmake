if (NOT TARGET boost_random)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(random
            headers
            config
            core
            dynamic_bitset
            integer
            io
            range
            static_assert
            system
            throw_exception
            type_traits
            utility)
endif()
