if (NOT TARGET boost_date_time)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(date_time algorithm
            assert
            config
            core
            io
            lexical_cast
            numeric_conversion
            range
            smart_ptr
            static_assert
            throw_exception
            tokenizer
            type_traits
            utility
            winapi)
endif()
