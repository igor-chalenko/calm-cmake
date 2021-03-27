function(_plugin_debug_postfix_init)
endfunction()

function(_plugin_debug_postfix_manifest)
    _calm_plugin_manifest(debug_postfix
            TARGET_TYPES main
            REQUIRED
            DESCRIPTION [=[
Plugin `debug_postfix` enables `DEBUG_POSTFIX` property for the given targets.
]=]
            )
endfunction()

function(_plugin_debug_postfix_apply _target)
    get_target_property(_type ${_target} TYPE)
    if (NOT ${_type} STREQUAL INTERFACE_LIBRARY)
        set_target_properties(${_target} PROPERTIES DEBUG_POSTFIX "d")
    endif ()
endfunction()