get_filename_component(_current_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

function(_plugin_sanitizers_manifest)
    _calm_plugin_manifest(sanitizers
            TARGET_TYPES main test
            OPTIONS
                SANITIZE_ADDRESS
                SANITIZE_MEMORY
                SANITIZE_THREAD
                SANITIZE_UNDEFINED
            CPM_ARGUMENTS
                GITHUB_REPOSITORY arsenm/sanitizers-cmake
                GIT_TAG master
                DOWNLOAD_ONLY TRUE
            DESCRIPTION [=[
Plugin `Sanitizers` enables sanitizers for the requested targets. The following
parameters are injected into _calm_add_(library|executable):
 p1) `SANITIZE_ADDRESS` - enables ASan for the given target
 p2) `SANITIZE_MEMORY` - enables MSan
 p3) `SANITIZE_THREAD` - enables TSan
 p4) `SANITIZE_UNDEFINED` - enables UBSan

By default, no action is performed by the plugin. Corresponding sanitizers
must first be enabled:
 o1) `-DSANITIZE_ADDRESS=ON` for ASan
 o2) `-DSANITIZE_MEMORY=ON` for MSan
 o2) `-DSANITIZE_UNDEFINED=ON` for UBSan
 o4) `-DSANITIZE_THREAD=ON` for TSan

So, in order to enable a sanitizer `n` for a target, `o<N>` must be enabled (for
instance, via `-D`) and `p<N>` must be specified in the call to
`calm_add_[library|executable]`.

Note that sanitizers need ptrace permissions, which might be disabled under
Docker. In such a case, just disable the options `o1` - `o4`.
]=]
    )
endfunction()

function(_plugin_sanitizers_init)
    set(SANITIZE_ADDRESS ON)
    #_calm_find_package(Sanitizers)

    #_package_directory(_current_dir)
    message(STATUS "??? _current_dir = ${_current_dir}")
    set(_package_dir "${_current_dir}/../3rd-party/Sanitizers")
    if (IS_DIRECTORY "${_package_dir}")
        list(PREPEND CMAKE_MODULE_PATH "${_package_dir}/cmake")
    endif()

    list(PREPEND CMAKE_MODULE_PATH "${Sanitizers_SOURCE_DIR}/cmake")
    find_package(Sanitizers REQUIRED)
endfunction()

function(_plugin_sanitizers_apply _target _options)
    get_target_property(_type ${_target} TYPE)
    if (NOT _type STREQUAL INTERFACE_LIBRARY)
        foreach(_option ${_options})
            set(${_option}_backup ${${_option}})
            set(${_option} ON)
        endforeach()
        add_sanitizers(${_target})
        foreach(_option ${_options})
            set(${_option} ${${_option}_backup})
        endforeach()
    endif()
endfunction()
