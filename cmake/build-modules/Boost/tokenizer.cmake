if (NOT TARGET boost_tokenizer)
    include(${_current_dir}/build-modules/Boost/internal.cmake)
    _calm_init_library(tokenizer headers)
endif()
