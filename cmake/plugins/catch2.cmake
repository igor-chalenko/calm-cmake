function(_plugin_catch2_manifest)
    _calm_plugin_manifest(catch2
            TARGET_TYPES main
            PARAMETERS CATCH2_TEST_PATH
            OPTIONS CATCH2
            DESCRIPTION [=[
This plugin globs files in the subdirectories `${CATCH2_TEST_PATH}`, `test`,
and `tests` (whichever is found first) of the current project and creates
an executable target for each found file. The target is then used as a basis
for the `CTest` tests created by `catch_discover_tests`.
]=])
endfunction()

function(_plugin_catch2_init)
endfunction()

function(_plugin_catch2_apply _target)
    cmake_parse_arguments(ARG "" "CATCH2_TEST_PATH" "" ${ARGN})
    if (ARG_CATCH2_TEST_PATH)
        if (NOT IS_ABSOLUTE ${ARG_CATCH2_TEST_PATH})
            set(ARG_CATCH2_TEST_PATH "${PROJECT_SOURCE_DIR}/${ARG_CATCH2_TEST_PATH}")
        endif()
        _calm_catch2_tests(${_target} "${ARG_CATCH2_TEST_PATH}" "*" ${ARGN})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/test")
        _calm_catch2_tests(${_target} "${PROJECT_SOURCE_DIR}/test" "*" ${ARGN})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/tests")
        _calm_catch2_tests(${_target} "${PROJECT_SOURCE_DIR}/tests" "*" ${ARGN})
    else()
        message(WARNING [[
No `test` or `tests` directories found, auto-tests not created. Use
`CATCH2_TEST_PATH <directory>` to specify a non-default directory.
]])
    endif()
endfunction()

function(_calm_include_catch)
    if (Catch2_SOURCE_DIR)
        list(PREPEND CMAKE_MODULE_PATH "${Catch2_SOURCE_DIR}/extras")
    else()
        find_package(Catch2 REQUIRED)
        list(PREPEND CMAKE_MODULE_PATH "${Catch2_DIR}")
    endif()
    include(Catch)
    include(ParseAndAddCatchTests)
endfunction()

function(_calm_catch2_tests _for_target _sources _mask)
    #_calm_find_package(Catch2 REQUIRED)
    #include(GoogleTest)
    if (NOT TARGET ${_for_target}.test)
        add_custom_target(${_for_target}.test
                COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                COMMENT "Build and run all the tests.")
        #add_dependencies("all_tests" ${_for_target}.test)
    endif()

    set(_target_prefix "${_for_target}.")
    set(_test_file_pattern ${_sources})
    # list the test files
    file(GLOB_RECURSE TESTS LIST_DIRECTORIES false ${_test_file_pattern}/${_mask})
    get_target_property(_type ${_for_target} TYPE)
    if (_type STREQUAL INTERFACE_LIBRARY)
        get_target_property(_includes ${_for_target} INTERFACE_INCLUDE_DIRECTORIES)
    else()
        get_target_property(_includes ${_for_target} INCLUDE_DIRECTORIES)
    endif()

    # each found file is a separate test
    _calm_get_test_dependencies(_test_dependencies)

    foreach (_file IN LISTS TESTS)
        _calm_test_name_for_file(${_file} ${_target_prefix} _target)
        log_debug(calm.plugins.catch2 "Add test ${_target}")
        calm_add_executable(${_target}
                INCLUDES "${_includes}"
                SOURCES "${_file}"
                TEST
                DEPENDENCIES ${_test_dependencies}
                ${ARGN})
        target_link_libraries(${_target} PRIVATE ${_for_target})

        add_dependencies(${_for_target}.test ${_target})
    endforeach()
    _calm_include_catch()
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
    if (_cpm_initialized)
        if (NOT DEFINED _CATCH_DISCOVER_TESTS_SCRIPT)
            set(_CATCH_DISCOVER_TESTS_SCRIPT
                    ${Catch2_SOURCE_DIR}/extras/CatchAddTests.cmake
                    )
        endif()
    else()
        if (NOT DEFINED _CATCH_DISCOVER_TESTS_SCRIPT)
            set(_CATCH_DISCOVER_TESTS_SCRIPT
                    ${Catch2_DIR}/CatchAddTests.cmake
                    )
        endif()
    endif()
    foreach (_file IN LISTS TESTS)
        _calm_test_name_for_file(${_file} ${_target_prefix} _target)
        catch_discover_tests(${_target}) # REPORTER sonarqube OUTPUT_DIR bed)
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
