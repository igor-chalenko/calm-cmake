project(calm-cmake-test VERSION 0.1)

include(../cmake/GetCPM.cmake)

CPMAddPackage("gh:igor-chalenko/cmake-utilities#master")
list(APPEND CMAKE_MODULE_PATH "${cmake-utilities_SOURCE_DIR}/cmake")

include(Logging)
include(GlobalMap)
include(Testing)
include(DynamicFunctions)
include(Dependency)

include(../cmake/core/DependencyManagement.cmake)
include(../cmake/core/Plugin.cmake)

function(dependency_test)
    calm_project_dependencies(
            MAIN Boost:boost-1.77.0
            TEST Catch2::Catch2WithMain:devel
    )
    _calm_get_managed_version(Boost _version)
    assert_same(${_version} "boost-1.77.0")
    _calm_get_managed_version(Catch2::Catch2WithMain _version)
    assert_same(${_version} "devel")

    calm_test_dependencies(Boost::filesystem)
    _calm_get_test_dependencies(_deps)
    assert_same(${_deps} "Boost::filesystem")

    _calm_set_managed_version(Boost boost-1.78.0)
    _calm_get_managed_version(Boost _version)
    assert_same(${_version} "boost-1.78.0")

    _calm_set_cpm_arguments(package_name arg1 arg2)
    _calm_get_cpm_arguments(package_name _args)
    assert_same("${_args}" "arg1;arg2")
endfunction()

function(calm_add_executable _target)
    cmake_parse_arguments(ARG "TEST" "" "DEPENDENCIES;INCLUDES;SOURCES" ${ARGN})
    add_executable(${_target} ${ARG_SOURCES})
endfunction()

function(plugin_test)
    log_level(test DEBUG)
    log_level(calm.cmake DEBUG)
    log_level(calm.plugins DEBUG)

    set(_test_plugins concepts so_version debug_postfix examples catch2 coverage)
    calm_plugins(${_test_plugins})

    calm_project_dependencies(
            TEST Catch2::Catch2WithMain:devel
    )
    obtain(Catch2::Catch2WithMain)

    calm_optional_plugin(doxygen_cmake)
    #calm_optional_plugin(sanitizers ENABLED_WHEN "${CMAKE_CXX_COMPILER} STREQUAL GNU")
    calm_optional_plugin(coverage ENABLED_BY I18N_COVERAGE)

    _calm_get_plugins(_plugins)
    assert_same("${_plugins}" "${_test_plugins}")
    global_get(calm.cmake "optional.plugins" _optional_plugins)
    assert_same("${_optional_plugins}" "doxygen_cmake;coverage")

    set(ARG_SO_VERSION ON)
    set(ARG_CATCH2 ON)
    set(ARG_DEBUG_POSTFIX ON)
    set(ARG_COVERAGE ON)
    set(ARG_EXAMPLE_PATH ${PROJECT_SOURCE_DIR}/example)
    _calm_apply_plugins(test_lib main)

    get_target_property(_version test_lib SOVERSION)
    assert_same(${_version} ${PROJECT_VERSION})
    get_target_property(_postfix test_lib DEBUG_POSTFIX)
    assert_same(${_postfix} "d")
    if (NOT TARGET test_lib.example.example1)
        assert_fail("Expected example target was not created")
    endif()
endfunction()

add_library(test_lib ../i18n/src/fun.cc)
target_include_directories(test_lib PUBLIC ../i18n/include)

#dependency_test()
plugin_test()

include(../cmake/core/AddTarget.cmake)
calm_add_library(test_lib_2 SOURCES ../i18n/src/fun.cc
        SO_VERSION
        )