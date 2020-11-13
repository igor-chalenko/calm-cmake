foreach(_component ${ARG_COMPONENTS})
    CPMFindPackage(NAME boost_${_component} ${_args}
            DOWNLOAD_ONLY TRUE
            GITHUB_REPOSITORY boostorg/${_component}
            GIT_TAG ${_git_tag})
endforeach()

get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
set(_package_dir "${_current_dir}/3rd-party/BCM")
if (IS_DIRECTORY "${_package_dir}")
    if (NOT ${_package_dir}/share/bcm/cmake IN_LIST CMAKE_PREFIX_PATH)
        message(STATUS "Adding ${_package_dir}/share/bcm/cmake to search path.")
        list(PREPEND CMAKE_PREFIX_PATH "${_package_dir}/share/bcm/cmake")
    endif()
endif()
_calm_find_package(BCM master)
#find_package(BCM REQUIRED)
include(BCMFuture)
include(BCMDeploy)
include(BCMSetupVersion)
#endif()

