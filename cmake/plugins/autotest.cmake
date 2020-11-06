set(calm_ROOT_TEST_TARGET "all_tests"
            CACHE STRING "Name of the root test target")

function(_plugin_autotest_manifest)
    _calm_plugin_manifest(autotest
            TARGET_TYPES main
            PARAMETERS TEST_SOURCES
            REQUIRED
            DESCRIPTION [=[
This plugin scans files in the subdirectory `test` of the current project
and creates an executable target for each found file. The target is then used
as a basis for the `CTest` tests created by `gtest_discover_tests`.
]=])
endfunction()

function(_plugin_autotest_init)
    add_custom_target(${calm_ROOT_TEST_TARGET}
            COMMENT "Build and run all the tests.")
endfunction()

function(_plugin_autotest_apply _target _test_sources)
    TPA_get("target.args.${_target}" _args)
    message(STATUS "Configure ${_target}.test same as ${_target}: ${_args}")
    if (_test_sources)
        _calm_tests(${_target} "test/*.cc" ${_args})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/test")
        _calm_tests(${_target} "test/*.cc" ${_args})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/tests")
        _calm_tests(${_target} "tests/*.cc" ${_args})
    else()
        message(WARNING [[
No `test` or `tests` directories found, auto-tests not created. Use
`TEST_SOURCES <directory>` to specify a non-default directory.
]])
    endif()
endfunction()

function(_calm_tests _for_target _sources)
    include(GoogleTest)

    add_custom_target(${_for_target}.test
            COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            COMMENT "Build and run all the tests.")
    add_dependencies(${calm_ROOT_TEST_TARGET} ${_for_target}.test)

    set(_target_prefix "${_for_target}.")
    set(_test_file_pattern ${CMAKE_CURRENT_SOURCE_DIR}/${_sources})
    # list the test files
    file(GLOB_RECURSE TESTS LIST_DIRECTORIES false ${_test_file_pattern})
    get_target_property(_includes ${_for_target} INTERFACE_INCLUDE_DIRECTORIES)

    # each found file is a separate test
    _calm_get_test_dependencies(_test_dependencies)

    foreach (_file IN LISTS TESTS)
        _calm_test_name_for_file(${_file} ${_target_prefix} _target)
        calm_add_executable(${_target}
                INCLUDES "${_includes}"
                SOURCES "${_file}"
                TEST
                DEPENDENCIES ${_test_dependencies} ${_for_target}
                ${ARGN})
        if (CMAKE_VERSION VERSION_GREATER_EQUAL 3.18)
            gtest_discover_tests(${_target} XML_OUTPUT_DIR "test-reports")
        else()
            gtest_discover_tests(${_target})
        endif()

        add_dependencies(${_for_target}.test ${_target})
    endforeach()
endfunction()

# ===========================================================================
# as_target_name(<output variable> <source file> [ext])
# ============================================================================
# Return the target name associated to a source file. If the path of the
# source file relative from the source directory is `path/to/source/file.ext`,
# the target name associated to it will be `path.to.source.file`.
function(_calm_test_name_for_file _file _prefix _out_var)
    file(RELATIVE_PATH _relative ${CMAKE_CURRENT_SOURCE_DIR} ${_file})
    string(REGEX REPLACE "^(.*)\\.(.*)$" "\\1" _name ${_relative})
    string(REGEX REPLACE "/" "." _name ${_name})
    #string(SUBSTRING ${_name} 5 -1 _name)
    set(${_out_var} "${_prefix}${_name}" PARENT_SCOPE)
endfunction()
