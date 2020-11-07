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
#    calm_dependency_management(<dependency>:<version> ...)
#
# .. note::
#    Dependency names should be consistent between the calls to this function
#    and target creation functions :cmake:command:`calm_add_library` and
#    :cmake:command:`calm_add_executable`.
###############################################################################
function(calm_dependency_management)
    foreach(_dependency ${ARGN})
        string(FIND ${_dependency} ":" _colon_ind REVERSE)
        if (_colon_ind GREATER -1)
            string(SUBSTRING ${_dependency} 0 ${_colon_ind} _package)
            math(EXPR _colon_ind "${_colon_ind} + 1")
            string(SUBSTRING ${_dependency} ${_colon_ind} -1 _version)
            _calm_set_managed_version(${_package} ${_version})
        else()
            message(FATAL_ERROR
"Change the specification string `${_dependency}` to follow the format
    <dependency>:<version>")
        endif()
    endforeach()
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
    TPA_get(dependencies.management.${_dependency} _version)
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
    TPA_set(dependencies.management.${_dependency} ${_version})
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
    TPA_append(dependencies.test "${ARGN}")
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
    TPA_get(dependencies.test _dependencies)
    set(${_out_var} "${_dependencies}" PARENT_SCOPE)
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
    TPA_set(dependencies.cpm.arguments.${_package} "${ARGN}")
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
    TPA_get(dependencies.cpm.arguments.${_package} _arguments)
    set(${_out_var} "${_arguments}" PARENT_SCOPE)
endfunction()
