get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)
    _calm_set_cpm_arguments(Catch2
            GITHUB_REPOSITORY catchorg/Catch2
            GIT_TAG ${_git_tag})
endif()

_calm_find_package(Catch2 ${_git_tag})