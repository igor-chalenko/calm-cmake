cmake_minimum_required(VERSION 3.14)
project(calm-cmake LANGUAGES CXX VERSION 1.0
        DESCRIPTION "CMake project template for calm development")

include(cmake/Bootstrap.cmake)

message(STATUS "Project name is ${PROJECT_NAME}")
message(STATUS "CMake project name is ${CMAKE_PROJECT_NAME}")
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(cmake/3rd-party/ycm/modules/InstallBasicPackageFiles.cmake)

    add_subdirectory(i18n)

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