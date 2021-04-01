get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (_cpm_initialized)
    message(STATUS "_calm_set_cpm_arguments: ${_git_tag}")
    _calm_set_cpm_arguments(Catch2
            GITHUB_REPOSITORY catchorg/Catch2
            GIT_TAG ${_git_tag})
endif()

if (NOT TARGET Catch2::Catch2)
    message(STATUS "_calm_find_package: ${_git_tag}")
    _calm_find_package(Catch2 ${_git_tag})
else()
    message(STATUS "!!! catch2 was already loaded !!!")
endif()