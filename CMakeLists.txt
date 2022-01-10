cmake_minimum_required(VERSION 3.17)
project(CalmCMake LANGUAGES CXX VERSION 1.0
        DESCRIPTION "CMake project template for calm development")

include(CMakeDependentOption)
include(cmake/GetCPM.cmake)

if (NOT DEFINED PROJECT_IS_TOP_LEVEL)
    get_directory_property(is_subproject PARENT_DIRECTORY)
    if (is_subproject)
        set(PROJECT_IS_TOP_LEVEL OFF)
    else()
        set(PROJECT_IS_TOP_LEVEL ON)
    endif()
endif()

option(CALM_CMAKE_BUILD_TESTS "Build tests" ${PROJECT_IS_TOP_LEVEL})
option(CPM_DOWNLOAD_ALL "Download all dependencies using CPM" ${PROJECT_IS_TOP_LEVEL})
enable_testing()

if(PROJECT_IS_TOP_LEVEL)
    CPMAddPackage("gh:igor-chalenko/cmake-utilities#master")
    list(APPEND CMAKE_MODULE_PATH "${cmake-utilities_SOURCE_DIR}/cmake")

    include(Logging)
    include(GlobalMap)
    include(Testing)
    include(DynamicFunctions)
    include(Dependency)

    include(cmake/Bootstrap.cmake)
    include(cmake/3rd-party/ycm/modules/InstallBasicPackageFiles.cmake)

    add_subdirectory(test)
    add_subdirectory(i18n)
    #if (CALM_CMAKE_BUILD_TESTS)
    #endif()

    if (NOT DEFINED CMAKE_INSTALL_DATADIR)
        unset(CMAKE_INSTALL_DATADIR)
        include(GNUInstallDirs)
    endif()
    set(_DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME})
    install_basic_package_files(${PROJECT_NAME}
            VERSION ${PROJECT_VERSION}
            COMPATIBILITY AnyNewerVersion
            ARCH_INDEPENDENT
            NO_EXPORT
            EXTRA_PATH_VARS_SUFFIX MODULE_DIR
            NO_CHECK_REQUIRED_COMPONENTS_MACRO)

    # slash at the end remove `cmake` from the directory structure
    install(DIRECTORY "cmake/" DESTINATION ${_DESTINATION})
endif()