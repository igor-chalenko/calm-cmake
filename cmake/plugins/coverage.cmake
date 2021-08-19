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
    message(STATUS "Enable Coverage for target ${_target}...")
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "(.*)CLang")
        target_link_libraries(${_target} PRIVATE gcov)
        target_compile_options(${_target} PRIVATE --coverage)
    endif()
endfunction()