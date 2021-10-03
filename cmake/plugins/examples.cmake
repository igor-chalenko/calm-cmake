function(_plugin_examples_manifest)
    _calm_plugin_manifest(examples
            TARGET_TYPES main
            OPTIONS EXAMPLES
            PARAMETERS EXAMPLES_PATH
            DESCRIPTION [=[
This plugin scans files in the subdirectories `example`, `examples` of the current project
and creates an executable target for each found file under a root target `examples`. 
]=])
endfunction()

function(_plugin_examples_init)
endfunction()

if(NOT WIN32)
    string(ASCII 27 Esc)
    set(ColourReset "${Esc}[m")
    set(ColourBold  "${Esc}[1m")
    set(Red         "${Esc}[31m")
    set(Green       "${Esc}[32m")
    set(Yellow      "${Esc}[33m")
    set(Blue        "${Esc}[34m")
    set(Magenta     "${Esc}[35m")
    set(Cyan        "${Esc}[36m")
    set(White       "${Esc}[37m")
    set(BoldRed     "${Esc}[1;31m")
    set(BoldGreen   "${Esc}[1;32m")
    set(BoldYellow  "${Esc}[1;33m")
    set(BoldBlue    "${Esc}[1;34m")
    set(BoldMagenta "${Esc}[1;35m")
    set(BoldCyan    "${Esc}[1;36m")
    set(BoldWhite   "${Esc}[1;37m")
endif()

function(_plugin_examples_apply _target)
    cmake_parse_arguments(ARG "" "EXAMPLE_PATH" "")
    set(_args ${ARGN})
    TPA_get("target.args.${_target}" _args)
    if (ARG_EXAMPLES_PATH)
        if (NOT IS_ABSOLUTE ${ARG_EXAMPLES_PATH})
            set(ARG_EXAMPLES_PATH "${PROJECT_SOURCE_DIR}/${ARG_EXAMPLES_PATH}")
        endif()
        message(STATUS "Searching example sources in ${Green}${ARG_EXAMPLES_PATH}${ColourReset}")
        _calm_examples(${_target} "${ARG_EXAMPLES_PATH}/*.cc" ${_args})
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
    set(_test_file_pattern ${_sources})
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
        message(STATUS "[examples] adding example ${_target}")
        calm_add_executable(${_target}
                INCLUDES "${_includes}"
                SOURCES "${_file}"
                TEST
                DEPENDENCIES ${_test_dependencies}
                ${ARGN})
        target_link_libraries(${_target} PRIVATE ${_for_target})

        #add_test(${_target} ${_target})
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
