foreach(_component ${ARG_COMPONENTS})
    CPMFindPackage(NAME boost_${_component} ${_args}
            DOWNLOAD_ONLY TRUE
            GITHUB_REPOSITORY boostorg/${_component}
            GIT_TAG ${_git_tag})
endforeach()

CPMFindPackage(NAME BCM
        DOWNLOAD_ONLY
        GITHUB_REPOSITORY boost-cmake/bcm
        GIT_TAG master)
list(PREPEND CMAKE_MODULE_PATH "${BCM_SOURCE_DIR}/share/bcm/cmake")
find_package(BCM REQUIRED)
include(BCMFuture)
include(BCMDeploy)
include(BCMSetupVersion)
