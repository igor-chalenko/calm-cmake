function(_plugin_coverage_manifest)
    _calm_plugin_manifest(coverage
            TARGET_TYPES main test
            OPTIONS COVERAGE
            DESCRIPTION [=[
Plugin `coverage` enables code coverage on the requested targets. Neither
gcov nor lcov are invoked directly. Instead, CLion coverage plugin is used
to get actual coverage reports.]=]
            )
endfunction()

function(_plugin_coverage_init)
    if(NOT CMAKE_BUILD_TYPE MATCHES "(.*)Debug(.*)")
        message(WARNING "Code coverage results with a non-debug build can be misleading")
    endif()
endfunction()

function(_plugin_coverage_apply _target)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "(.*)Clang")
        _calm_get_target_property(_type ${_target} TYPE)
        if (_type STREQUAL INTERFACE_LIBRARY)
            _calm_target_link_libraries(${_target} INTERFACE gcov)
            _calm_target_compile_options(${_target} INTERFACE --coverage)
        else()
            _calm_target_link_libraries(${_target} PRIVATE gcov)
            _calm_target_compile_options(${_target} PRIVATE --coverage)
        endif()
        log_info(calm.plugins.coverage "Coverage enabled for ${_target} via `--coverage`")
    else()
        log_info(calm.plugins.coverage "Coverage was not enabled for ${_target} - unsupported compiler `${CMAKE_CXX_COMPILER_ID}`")
    endif()
endfunction()