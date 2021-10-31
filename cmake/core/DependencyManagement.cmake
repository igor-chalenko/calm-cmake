###############################################################################
#.rst:
#
# .. cmake:command:: calm_dependency_management
#
# Stores provided `dependency`:`version` pairs for later use by
# :cmake:command:`_calm_add_target`. Doesn't configure or load any dependencies
# itself.
#
# .. code-block:: cmake
#
#    calm_dependency_management(
#                               [MAIN <dependency>:<version>... ]
#                               [TEST <dependency>:<version>... ]
#    )
#
# .. note::
#    Dependency names should be consistent between the calls to this function
#    and target creation functions :cmake:command:`calm_add_library` and
#    :cmake:command:`calm_add_executable`.
###############################################################################
function(calm_project_dependencies)
    set(_multi_value_args MAIN TEST)
    cmake_parse_arguments(ARG "" "" "${_multi_value_args}" ${ARGN})
    if (ARG_MAIN)
        foreach(_dependency IN LISTS ARG_MAIN)
            _calm_project_dependency(${_dependency})
        endforeach()
    endif()
    # MAIN == TEST for now
    if (ARG_TEST)
        foreach(_dependency IN LISTS ARG_TEST)
            _calm_project_dependency(${_dependency})
        endforeach()
    endif()
endfunction()

function(_calm_project_dependency _dependency)
    if (_dependency MATCHES "([-_A-Za-z0-9\\.]+)::([-_A-Za-z_0-9\\.]+):([-_A-Za-z0-9\\.]+)")
        set(_package ${CMAKE_MATCH_1}::${CMAKE_MATCH_2})
        set(_version ${CMAKE_MATCH_3})
        log_debug(calm.cmake "The package ${_package} is fixed to the version ${_version}")
        _calm_set_managed_version(${_package} ${_version})
    elseif (_dependency MATCHES "([-_A-Za-z0-9\\.]+):([-_A-Za-z0-9\\.]+)")
        set(_package ${CMAKE_MATCH_1})
        set(_version ${CMAKE_MATCH_2})
        log_debug(calm.cmake "The package ${_package} is fixed to the version ${_version}")
        _calm_set_managed_version(${_package} ${_version})
    else()
        message(FATAL_ERROR
                "Change the specification string `${_dependency}` to follow the format <dependency>:<version>")
    endif()
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_get_managed_version
#
# A helper function to retrieve a `dependency`:`version` pair from the current
# TPA scope.
#
# .. code-block:: cmake
#
#    _calm_get_managed_version(<dependency name> <output variable>)
#
###############################################################################
function(_calm_get_managed_version _dependency _out_var)
    global_get(calm.cmake dependencies.management.${_dependency} _version)
    set(${_out_var} "${_version}" PARENT_SCOPE)
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_set_managed_version
#
# A helper function to store a `dependency`:`version` pair in the current TPA
# scope.
#
# .. code-block:: cmake
#
#    _calm_set_managed_version(<dependency name> <version>)
#
###############################################################################
function(_calm_set_managed_version _dependency _version)
    global_set(calm.cmake dependencies.management.${_dependency} ${_version})
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_set_cpm_arguments
#
# A helper function to store CPM arguments of a given downloadable package in
# the current TPA scope.
#
# .. code-block:: cmake
#
#    _calm_set_cpm_arguments(<package name> <ARGN>)
#
###############################################################################
function(_calm_set_cpm_arguments _package)
    #log_info(calm.cmake "set CPM arguments to ${ARGN} for ${_package}")
    global_set(calm.cmake dependencies.cpm.arguments.${_package} "${ARGN}")
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_get_cpm_arguments
#
# A helper function to retrieve CPM arguments of a given downloadable package
# from the current TPA scope.
#
# .. code-block:: cmake
#
#    _calm_get_cpm_arguments(<package name> <output variable>)
#
###############################################################################
function(_calm_get_cpm_arguments _package _out_var)
    global_get(calm.cmake dependencies.cpm.arguments.${_package} _arguments)
    set(${_out_var} "${_arguments}" PARENT_SCOPE)
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: calm_test_dependencies
#
# A helper function to store test dependencies in the current TPA scope.
# Doesn't configure or load any dependencies itself.
#
# .. code-block:: cmake
#
#    calm_test_dependencies(<package name> ...)
#
###############################################################################
function(calm_test_dependencies)
    global_append(calm.cmake dependencies.test "${ARGN}")
endfunction()

###############################################################################
#.rst:
#
# .. cmake:command:: _calm_get_test_dependencies
#
# A helper function to retrieve test dependencies from the current TPA scope.
#
# .. code-block:: cmake
#
#    _calm_get_test_dependencies(<output variable>)
#
###############################################################################
function(_calm_get_test_dependencies _out_var)
    global_get(calm.cmake dependencies.test _dependencies)
    set(${_out_var} "${_dependencies}" PARENT_SCOPE)
endfunction()
