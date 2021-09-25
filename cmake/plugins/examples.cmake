function(_plugin_examples_manifest)
    _calm_plugin_manifest(examples
            TARGET_TYPES main
            PARAMETERS EXAMPLE_PATH
            OPTIONS EXAMPLES
            DESCRIPTION [=[
This plugin scans files in the subdirectories `example`, `examples` of the current project
and creates an executable target for each found file under a root target `examples`. 
]=])
endfunction()

function(_plugin_examples_init)
endfunction()

function(_plugin_examples_apply _target)
    if (${ARGV1})
        set(_test_sources "${ARGV1}")
    endif()
    TPA_get("target.args.${_target}" _args)
    if (_test_sources)
        _calm_examples(${_target} "test/*.cc" ${_args})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/example")
        _calm_examples(${_target} "example/*.cc" ${_args})
    elseif (IS_DIRECTORY "${PROJECT_SOURCE_DIR}/examples")
        _calm_examples(${_target} "examples/*.cc" ${_args})
    else()
        message(STATUS [[
No `example` or `examples` directories found, `examples` target was not created. Use
`EXAMPLE_PATH <directory>` to specify a non-default directory.
]])
    endif()
endfunction()

function(_calm_examples _for_target _sources)
    set(_target_prefix "${_for_target}.")
    set(_test_file_pattern ${CMAKE_CURRENT_SOURCE_DIR}/${_sources})
    # list the test files
    file(GLOB_RECURSE TESTS LIST_DIRECTORIES false ${_test_file_pattern})
    get_target_property(_type ${_for_target} TYPE)
    if (_type STREQUAL INTERFACE_LIBRARY)
        get_target_property(_includes ${_for_target} INTERFACE_INCLUDE_DIRECTORIES)
    else()
        get_target_property(_includes ${_for_target} INCLUDE_DIRECTORIES)
    endif()

    foreach (_file IN LISTS TESTS)
        _calm_example_name_for_file(${_file} ${_target_prefix} _target)
        calm_add_executable(${_target}
                INCLUDES "${_includes}"
                SOURCES "${_file}"
                TEST
                DEPENDENCIES ${_test_dependencies}
                ${ARGN})
        target_link_libraries(${_target} PRIVATE ${_for_target})

        add_test(${_target} ${_target})
    endforeach()
endfunction()

# ===========================================================================
# as_target_name(<output variable> <source file> [ext])
# ============================================================================
# Return the target name associated to a source file. If the path of the
# source file relative from the source directory is `path/to/source/file.ext`,
# the target name associated to it will be `path.to.source.file`.
function(_calm_example_name_for_file _file _prefix _out_var)
    file(RELATIVE_PATH _relative ${CMAKE_CURRENT_SOURCE_DIR} ${_file})
    string(REGEX REPLACE "^(.*)\\.(.*)$" "\\1" _name ${_relative})
    string(REGEX REPLACE "/" "." _name ${_name})
    #string(SUBSTRING ${_name} 5 -1 _name)
    set(${_out_var} "${_prefix}${_name}" PARENT_SCOPE)
endfunction()
