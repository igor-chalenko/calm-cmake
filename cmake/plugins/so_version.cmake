function(_plugin_so_version_manifest)
    _calm_plugin_manifest(so_version
            TARGET_TYPES main
            REQUIRED
            DESCRIPTION [=[
This plugin sets version and SO_VERSION properties from `${PROJECT_VERSION}`.
]=])
endfunction()

function(_plugin_so_version_init)
endfunction()

function(_plugin_so_version_apply _target)
    # todo better versions!
    if (BUILD_SHARED_LIBS)
        set_target_properties(${_target} PROPERTIES
                    VERSION ${PROJECT_VERSION}
                    SOVERSION ${PROJECT_VERSION})
    endif()
endfunction()