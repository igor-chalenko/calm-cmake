function(_plugin_debug_postfix_init)
endfunction()

function(_plugin_debug_postfix_manifest)
    _calm_plugin_manifest(debug_postfix
            TARGET_TYPES main
            OPTIONS DEBUG_POSTFIX
            DESCRIPTION [=[
Plugin `debug_postfix` enables `DEBUG_POSTFIX` property for the given targets.
]=]
            )
endfunction()

function(_plugin_debug_postfix_apply _target)
    get_target_property(_type ${_target} TYPE)
    log_debug(calm.plugins.debug_postfix "${_target}::TYPE is ${_type}")
    if (NOT ${_type} STREQUAL INTERFACE_LIBRARY)
        set_target_properties(${_target} PROPERTIES DEBUG_POSTFIX "d")
        log_info(calm.plugins.debug_postfix "${_target}::DEBUG_POSTFIX = \"d\"")
    endif ()
endfunction()