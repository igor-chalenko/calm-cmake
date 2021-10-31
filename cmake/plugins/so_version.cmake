function(_plugin_so_version_manifest)
    _calm_plugin_manifest(so_version
            TARGET_TYPES main
            OPTIONS SO_VERSION
            DESCRIPTION [=[
This plugin sets version and SO_VERSION properties from `${PROJECT_VERSION}`.
]=])
endfunction()

function(_plugin_so_version_init)
endfunction()

function(_plugin_so_version_apply _target)
    # todo better versions!
    _calm_get_target_property(_type ${_target} TYPE)
    if (_type MATCHES "(.*)_LIBRARY")
        if (_type STREQUAL INTERFACE_LIBRARY)
            _calm_set_target_properties(${_target} PROPERTIES
                        INTERFACE_VERSION ${PROJECT_VERSION}
                        INTERFACE_SOVERSION ${PROJECT_VERSION})
        else()
            _calm_set_target_properties(${_target} PROPERTIES
                    VERSION ${PROJECT_VERSION}
                    SOVERSION ${PROJECT_VERSION})
        endif()
        log_info(calm.plugins.so_version "${_target}::SOVERSION = ${PROJECT_VERSION}")
    endif()
endfunction()