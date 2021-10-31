function(_calm_get_target_property _out_var _target _property)
    get_target_property(_var ${_target} ${_property})
    set(${_out_var} "${_var}" PARENT_SCOPE)
endfunction()

function(_calm_set_target_properties _target)
    set_target_properties(${_target} ${ARGN})
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
