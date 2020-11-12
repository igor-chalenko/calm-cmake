foreach(_component ${ARG_COMPONENTS})
    CPMFindPackage(NAME boost_${_component} ${_args}
            DOWNLOAD_ONLY TRUE
            GITHUB_REPOSITORY boostorg/${_component}
            GIT_TAG ${_git_tag})
endforeach()

get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
set(_package_dir "${_current_dir}/3rd-party/BCM")
if (IS_DIRECTORY "${_package_dir}")
    list(PREPEND CMAKE_MODULE_PATH "${_package_dir}/share/bcm/cmake")
endif()
_calm_find_package(BCM master)
#find_package(BCM REQUIRED)
include(BCMFuture)
include(BCMDeploy)
include(BCMSetupVersion)
#endif()

