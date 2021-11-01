function(_calm_get_target_property _out_var _target _property)
    get_target_property(_var ${_target} ${_property})
    set(${_out_var} "${_var}" PARENT_SCOPE)
endfunction()

function(_calm_set_target_properties _target)
    message(STATUS "_calm_set_target_properties(${_target} ${ARGN}")
    message(STATUS "ARGV1 = ${ARGV1}")
    message(STATUS "ARGV2 = ${ARGV2}")
    message(STATUS "ARGV3 = ${ARGV3}")
    message(STATUS "ARGV4 = ${ARGV4}")
    set(_ind 3)
    unset(_args)
    while(_ind LESS ARGC)
        list(APPEND _args \"${ARGV${_ind}}\")
        math(EXPR _ind "${_ind} + 2")
    endwhile()
    message(STATUS "set_target_properties(${_target} ${ARGV1} ${ARGV2} ${_args})")
    set_target_properties(${_target} ${ARGV1} ${ARGV2} "${_args}")
endfunction()

function(_calm_target_include_directories _target _visibility)
    target_include_directories(${_target} ${_visibility} ${ARGN})
endfunction()

function(_calm_target_link_libraries _target _visibility)
    target_link_libraries(${_target} ${_visibility} ${ARGN})
endfunction()

function(_calm_target_compile_options _target _visibility)
    target_compile_options(${_target} ${_visibility} ${ARGN})
endfunction()

function(_calm_target_link_options  _target _visibility)
    target_link_options(${_target} ${_visibility} ${ARGN})
endfunction()

function(_calm_add_custom_target _target)
    add_custom_target(${_target} ${ARGN})
endfunction()

function(_calm_add_dependencies _target)
    add_dependencies(${_target} ${ARGN})
endfunction()

function(_calm_add_library _target)
    add_library(${_target} ${ARGN})
endfunction()

function(_calm_target_sources _target)
    target_sources(${_target} ${ARGN})
endfunction()

function(_calm_add_executable _target)
    add_executable(${_target} ${ARGN})
endfunction()
