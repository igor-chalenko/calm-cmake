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
    _package_directory(_current_dir)
    foreach (_plugin ${ARGN})
        set(_suffix "plugins/${_plugin}.cmake")
        set(_include_file ${PROJECT_SOURCE_DIR}/cmake/${_suffix})
        if (NOT EXISTS ${_include_file})
            set(_include_file ${CMAKE_SOURCE_DIR}/cmake/${_suffix})
        endif ()
        if (NOT EXISTS ${_include_file})
            set(_include_file ${_current_dir}/${_suffix})
        endif ()
        if (NOT EXISTS ${_include_file})
            set(_locations [[
Searched in:
1) ${PROJECT_SOURCE_DIR}/cmake/plugins
2) ${CMAKE_SOURCE_DIR}/cmake/plugins
3) ${_current_cmake_dir}/plugins
]]
                    )
            message(SEND_ERROR "Plugin `${_plugin}` not found.\n${_locations}")
        endif ()
        include(${_include_file})
        _calm_call(_plugin_${_plugin}_init)
    endforeach ()
    _calm_set_plugins(${ARGN})
endmacro()

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
    set(_options REQUIRED)
    set(_one_value_args DESCRIPTION)
    set(_multi_value_args TARGET_TYPES PARAMETERS OPTIONS CPM_ARGUMENTS)

    unset(ARG_TARGET_TYPES)
    unset(ARG_REQUIRED)
    unset(ARG_PARAMETERS)
    unset(ARG_OPTIONS)
    unset(ARG_CPM_ARGUMENTS)
    cmake_parse_arguments(ARG
            "${_options}" "${_one_value_args}" "${_multi_value_args}" ${ARGN})

    _calm_set_plugin_required(${_plugin} ${ARG_REQUIRED})
    _calm_set_plugin_target_types(${_plugin} ${ARG_TARGET_TYPES})
    _calm_set_plugin_description(${_plugin} "${ARG_DESCRIPTION}")
    _calm_set_plugin_parameters(${_plugin} "${ARG_PARAMETERS}")
    _calm_set_plugin_options(${_plugin} "${ARG_OPTIONS}")
    if (ARG_CPM_ARGUMENTS)
        _calm_set_cpm_arguments(${_plugin} "${ARG_CPM_ARGUMENTS}")
    endif ()

    _calm_get_plugin_parameters(${_plugin} _parameters)
    _calm_get_plugin_options(${_plugin} _options)
    if (_options)
        list(APPEND _all_options ${_options})
    endif ()
    if (_parameters)
        list(APPEND _all_parameters ${_parameters})
    endif ()

    TPA_append("plugins.parameters" "${ARG_PARAMETERS}")
    TPA_append("plugins.options" "${ARG_OPTIONS}")
endfunction()

function(_calm_apply_plugins _target _target_type)
    _calm_get_plugins(_plugins)
    foreach (_plugin ${_plugins})
        _calm_get_plugin_parameters(${_plugin} _parameters)
        _calm_get_plugin_options(${_plugin} _options)
        _calm_get_target_types(${_plugin} _plugin_phase)
        _calm_is_plugin_required(${_plugin} _required)
        if (${_target_type} IN_LIST _plugin_phase)
            set(_extra_args "")
            foreach (_parameter ${_parameters})
                if (ARG_${_parameter})
                    list(APPEND _extra_args ${ARG_${_parameter}})
                endif ()
            endforeach ()
            foreach (_option ${_options})
                if (ARG_${_option})
                    list(APPEND _extra_args ${_option})
                endif ()
            endforeach ()

            if (${_required} OR _extra_args)
                _calm_call(_plugin_${_plugin}_apply ${_target} ${_extra_args})
                TPA_append("target.args.${_target}" "${_extra_args}")
            endif ()
        endif ()
    endforeach ()
endfunction()

##############################################################################
#.rst:
#
# .. cmake:command:: _calm_call
#
# .. code-block:: cmake
#
#    _calm_call(_id _arg1)
#
# Calls a function or a macro given its name ``_id``. Writes actual call code
# into a temporary file, which is then included. ``ARGN`` is also passed.
##############################################################################
function(_calm_call _id)
    if (NOT COMMAND ${_id})
        message(FATAL_ERROR "Unsupported function/macro \"${_id}\"")
    else ()
        set(_helper "${CMAKE_CURRENT_BINARY_DIR}/helpers/macro_helper_${_id}.cmake")
        if (NOT EXISTS ${_helper})
            set(_args [[(${ARGN})]])
            file(WRITE "${_helper}" "${_id}${_args}\n")
        endif ()
        include("${_helper}")
    endif ()
endfunction()

function(_calm_get_plugins _out_var)
    TPA_get("plugins" _plugins)
    set(${_out_var} "${_plugins}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugins)
    TPA_set("plugins" "${ARGN}")
endfunction()

function(_calm_get_plugin_options _plugin _out_var)
    TPA_get(plugins.options.${_plugin} _options)
    set(${_out_var} "${_options}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_options _plugin _options)
    TPA_set(plugins.options.${_plugin} "${_options}")
endfunction()

function(_calm_get_plugin_parameters _plugin _out_var)
    TPA_get(plugins.parameters.${_plugin} _parameters)
    set(${_out_var} "${_parameters}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_parameters _plugin)
    TPA_set(plugins.parameters.${_plugin} "${ARGN}")
endfunction()

function(_calm_set_plugin_target_types _plugin)
    TPA_set("plugin.target.types.${_plugin}" "${ARGN}")
endfunction()

function(_calm_get_target_types _plugin _out_var)
    TPA_get("plugin.target.types.${_plugin}" _phase)
    set(${_out_var} "${_phase}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_description _plugin _description)
    TPA_set("plugin.description.${_plugin}" "${_description}")
endfunction()

function(_calm_get_plugin_description _plugin _out_var)
    TPA_get("plugin.description.${_plugin}" _description)
    set(${_out_var} "${_description}" PARENT_SCOPE)
endfunction()

function(_calm_set_plugin_required _plugin _required)
    TPA_set("plugin.${_plugin}.required" ${_required})
endfunction()

function(_calm_is_plugin_required _plugin _out_var)
    TPA_get("plugin.${_plugin}.required" _required)
    set(${_out_var} ${_required} PARENT_SCOPE)
endfunction()

_package_directory(_dir)
foreach (_plugin_dir IN_LIST
        "${_dir}" "${PROJECT_SOURCE_DIR}" "${CMAKE_SOURCE_DIR}")
    file(GLOB_RECURSE _files ${_plugin_dir}/plugins/*.cmake)
    foreach (_file ${_files})
        include(${_file})
        get_filename_component(_name ${_file} NAME_WLE)
        _calm_call(_plugin_${_name}_manifest)
        if (CALM_LIST_PLUGINS)
            _calm_get_plugin_description(${_name} _description)
            message("---------------------------")
            message("${_name}")
            message("---------------------------")
            message("${_description}")
        endif ()
    endforeach ()
endforeach ()
