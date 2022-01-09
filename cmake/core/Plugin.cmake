
##############################################################################
#.rst:
#
# .. cmake:command:: calm_plugins
#
# Enables the given plugins. More specifically, searches known locations of
# the plugin file for each given plugin. If the plugin file is found, calls
# ``_init()`` from it; error is raised otherwise. Afterward, stores the provided
# list of plugin names into the current TPA scope.
#
# Once a plugin is enabled, the parameters it publishes may be used in the
# calls to :cmake:command:`calm_add_library` and
# :cmake:command:`calm_add_executable`. A plugin publishes its parameters
# by calling :cmake:command:`_calm_plugin_manifest`.
#
# .. code-block:: cmake
#
#    calm_plugins(<plugin name> ...)
#
##############################################################################
macro(calm_plugins)
    foreach (_plugin ${ARGN})
        _calm_plugin(${_plugin})
    endforeach ()
    _calm_set_plugins(${ARGN})
endmacro()

macro(_calm_plugin _plugin)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    set(_suffix "plugins/${_plugin}.cmake")
    set(_include_file ${PROJECT_SOURCE_DIR}/cmake/${_suffix})
    if (NOT EXISTS ${_include_file})
        set(_include_file ${CMAKE_SOURCE_DIR}/cmake/${_suffix})
    endif ()
    if (NOT EXISTS ${_include_file})
        set(_include_file ${_current_dir}/${_suffix})
    endif ()
    if (NOT EXISTS ${_include_file})
        set(_locations "
Searched in:
1) ${PROJECT_SOURCE_DIR}/cmake/plugins
2) ${CMAKE_SOURCE_DIR}/cmake/plugins
3) ${_current_dir}
"
                )
        message(FATAL_ERROR "Plugin `${_plugin}` not found.\n${_locations}")
    endif ()
    include(${_include_file})
    dynamic_call(_plugin_${_plugin}_init)
    log_info(calm.plugins "The plugin `${_plugin}` initialized")
endmacro()

function(calm_optional_plugin _name)
    set(_params ENABLED_BY ENABLED_WHEN)
    cmake_parse_arguments(ARG "" "${_params}" "" ${ARGN})
    global_append(calm.cmake "plugins" ${_name})
    if (ARG_ENABLED_BY)
        global_set(calm.cmake plugin.${_name}.enabled.by "${ARG_ENABLED_BY}")
    endif()
    if (ARG_ENABLED_WHEN)
        global_set(calm.cmake plugin.${_name}.enabled.when "${ARG_ENABLED_WHEN}")
    endif()
    _calm_plugin(${_name})
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_plugin_manifest
#
# Stores information provided by the given plugin for later use.
#
# .. code-block:: cmake
#
#    _calm_plugin_manifest(<plugin name>
#                              [TARGET_TYPES [main|test]...]
#                              [PARAMETERS <parameter names> ...]
#                              [OPTIONS <option names> ...]
#                              [CPM_ARGUMENTS <argument> ...]
#                              [DESCRIPTION <text>]
#                              [REQUIRED])
#
###############################################################################
function(_calm_plugin_manifest _plugin)
    set(_options PROJECT_WIDE)
    set(_one_value_args DESCRIPTION)
    set(_multi_value_args TARGET_TYPES PARAMETERS OPTIONS)

    unset(ARG_TARGET_TYPES)
    unset(ARG_PARAMETERS)
    unset(ARG_OPTIONS)
    cmake_parse_arguments(ARG
            "${_options}" "${_one_value_args}" "${_multi_value_args}" ${ARGN})

    _calm_set_plugin_target_types(${_plugin} ${ARG_TARGET_TYPES})
    _calm_set_plugin_description(${_plugin} "${ARG_DESCRIPTION}")
    _calm_set_plugin_parameters(${_plugin} "${ARG_PARAMETERS}")
    _calm_set_plugin_options(${_plugin} "${ARG_OPTIONS}")
    _calm_set_plugin_project_wide(${_plugin} "${ARG_PROJECT_WIDE}")

    _calm_get_plugin_parameters(${_plugin} _parameters)
    _calm_get_plugin_options(${_plugin} _options)
    if (_options)
        list(APPEND _all_options ${_options})
    endif ()
    if (_parameters)
        list(APPEND _all_parameters ${_parameters})
    endif ()

    global_append(calm.cmake "plugins.parameters" "${ARG_PARAMETERS}")
    global_append(calm.cmake "plugins.options" "${ARG_OPTIONS}")
endfunction()

function(_calm_apply_plugins _target _target_type)
    unset(target.args.${_target})
    _calm_get_plugins(_plugins)
    foreach (_plugin ${_plugins})
        _calm_get_plugin_parameters(${_plugin} _parameters)
        _calm_get_plugin_options(${_plugin} _options)
        _calm_get_target_types(${_plugin} _plugin_target_types)
        if (${_target_type} IN_LIST _plugin_target_types)
            set(_extra_args "")
            foreach (_parameter ${_parameters})
                if (ARG_${_parameter})
                    #message(STATUS "[${_plugin}] appending to _extra_args: ${_parameter} = ${ARG_${_parameter}}")
                    list(APPEND _extra_args ${_parameter} ${ARG_${_parameter}})
                endif ()
            endforeach ()
            foreach (_option ${_options})
                if (ARG_${_option})
                    #message(STATUS "[${_plugin}] appending to _extra_args: ${_option} = ${ARG_${_option}}")
                    list(APPEND _extra_args ${_option})
                endif ()
            endforeach ()

            if (_extra_args)
                set(${_plugin}_given_args true)
                foreach (_arg ${_extra_args})
                    list(APPEND target.args.${_target} "${_arg}")
                endforeach()
            else()
                set(${_plugin}_given_args false)
            endif ()
        endif ()
    endforeach ()
    foreach (_plugin ${_plugins})
        _calm_get_target_types(${_plugin} _plugin_target_types)
        if (${_target_type} IN_LIST _plugin_target_types)
            _calm_get_plugin_project_wide(${_plugin} _project_wide)
            if (${_plugin}_given_args OR _project_wide)
                log_debug(calm.cmake "apply_plugin_${_plugin}(${_target} ${target.args.${_target}})")
                dynamic_call(_plugin_${_plugin}_apply ${_target} ${target.args.${_target}})
            endif()
        endif()
    endforeach()
endfunction()

function(_calm_get_plugins _out_var)
    global_get(calm.cmake "plugins" _plugins)
    set(${_out_var} "${_plugins}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugins)
    global_set(calm.cmake "plugins" "${ARGN}")
endfunction()

function(_calm_get_plugin_options _plugin _out_var)
    global_get(calm.cmake plugins.options.${_plugin} _options)
    set(${_out_var} "${_options}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_options _plugin _options)
    global_set(calm.cmake plugins.options.${_plugin} "${_options}")
endfunction()

function(_calm_get_plugin_parameters _plugin _out_var)
    global_get(calm.cmake plugins.parameters.${_plugin} _parameters)
    set(${_out_var} "${_parameters}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_parameters _plugin)
    global_set(calm.cmake plugins.parameters.${_plugin} "${ARGN}")
endfunction()

function(_calm_set_plugin_target_types _plugin)
    global_set(calm.cmake "plugin.target.types.${_plugin}" "${ARGN}")
endfunction()

function(_calm_set_plugin_project_wide _plugin)
    global_set(calm.cmake "plugin.project_wide.${_plugin}" "${ARGN}")
endfunction()

function(_calm_get_target_types _plugin _out_var)
    global_get(calm.cmake "plugin.target.types.${_plugin}" _phase)
    set(${_out_var} "${_phase}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_description _plugin _description)
    global_set(calm.cmake "plugin.description.${_plugin}" "${_description}")
endfunction()

function(_calm_get_plugin_description _plugin _out_var)
    global_get(calm.cmake "plugin.description.${_plugin}" _description)
    set(${_out_var} "${_description}" PARENT_SCOPE)
endfunction()

function(_calm_get_plugin_project_wide _plugin _out_var)
    global_get(calm.cmake "plugin.project_wide.${_plugin}" _project_wide)
    set(${_out_var} "${_project_wide}" PARENT_SCOPE)
endfunction()

get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

foreach (_plugin_dir "${_current_dir}" "${PROJECT_SOURCE_DIR}" "${CMAKE_SOURCE_DIR}")
    file(GLOB_RECURSE _files ${_plugin_dir}/../plugins/*.cmake)
    foreach (_file ${_files})
        include(${_file})
        get_filename_component(_name ${_file} NAME_WLE)
        dynamic_call(_plugin_${_name}_manifest)
        _calm_get_plugin_project_wide(${_name} _project_wide)
        if (CALM_LIST_PLUGINS)
            _calm_get_plugin_description(${_name} _description)
            message("---------------------------")
            message("${_name}")
            message("---------------------------")
            message("${_description}")
        endif ()
    endforeach ()
endforeach ()

