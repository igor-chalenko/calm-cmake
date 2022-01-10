function(_calm_include_catch)
    message(STATUS "Catch2_SOURCE_DIR = ${Catch2_SOURCE_DIR}")
    if (Catch2_SOURCE_DIR)
        list(PREPEND CMAKE_MODULE_PATH "${Catch2_SOURCE_DIR}/extras")
    else()
        find_package(Catch2 REQUIRED)
        list(PREPEND CMAKE_MODULE_PATH "${Catch2_DIR}")
    endif()
    include(Catch)
    include(ParseAndAddCatchTests)
endfunction()

function(_calm_catch_discover_tests _target _cmd_line)
    catch_discover_tests(${_target} "${_cmd_line}")
endfunction()

_calm_include_catch()
get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)
if (Catch2_SOURCE_DIR)
    if (NOT DEFINED _CATCH_DISCOVER_TESTS_SCRIPT)
        set(_CATCH_DISCOVER_TESTS_SCRIPT
                ${Catch2_SOURCE_DIR}/extras/CatchAddTests.cmake
                )
    endif()
else()
    if (NOT DEFINED _CATCH_DISCOVER_TESTS_SCRIPT)
        set(_CATCH_DISCOVER_TESTS_SCRIPT
                ${Catch2_DIR}/CatchAddTests.cmake
                )
    endif()
endif()
