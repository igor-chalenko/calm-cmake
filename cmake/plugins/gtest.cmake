function(_plugin_gtest_manifest)
    _calm_plugin_manifest(gtest
            TARGET_TYPES main
            PARAMETERS GTEST_TEST_PATH
            OPTIONS GTEST
            DESCRIPTION [=[
This plugin scans files in the subdirectory `test` of the current project
and creates an executable target for each found file. The target is then used
as a basis for the `CTest` tests created by `gtest_discover_tests`.
]=])
endfunction()

function(_plugin_gtest_init)
endfunction()

function(_plugin_gtest_apply _target)
    cmake_parse_arguments(ARG "" "GTEST_TEST_PATH" "" ${ARGN})
    if (ARG_GTEST_TEST_PATH)
        if (NOT IS_ABSOLUTE ${ARG_GTEST_TEST_PATH})
            set(ARG_GTEST_TEST_PATH "${PROJECT_SOURCE_DIR}/${ARG_GTEST_TEST_PATH}")
        endif()
        _calm_gtest_tests(${_target} "${ARG_GTEST_TEST_PATH}" "*" ${ARGN})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/test")
        _calm_gtest_tests(${_target} "${PROJECT_SOURCE_DIR}/test" "*" ${ARGN})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/tests")
        _calm_gtest_tests(${_target} "${PROJECT_SOURCE_DIR}/tests" "*" ${ARGN})
    else()
        message(WARNING [[
No `test` or `tests` directories found, auto-tests not created. Use
`TEST_SOURCES <directory>` to specify a non-default directory.
]])
    endif()
endfunction()

function(_calm_gtest_tests _for_target _sources)
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
                DEPENDENCIES ${_test_dependencies}
                ${ARGN})
        target_link_libraries(${_target} PRIVATE ${_for_target})
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
