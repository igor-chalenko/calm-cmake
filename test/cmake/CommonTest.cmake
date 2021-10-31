include(${_current_test_dir}/ImportCmakeUtilities.cmake)
include(${_current_test_dir}/../../cmake/core/Bootstrap.cmake)

function(mock_add_library _target _type _sources)
    global_set(add.target.${_target} TYPE ${_type})
    global_set(add.target.${_target} SOURCES "${_sources}")
    global_set(add.target.${_target} EXCLUDE_FROM_ALL 1)
endfunction()

function(_calm_target_link_libraries _target _visibility)
    global_get(add.target.${_target} TYPE _type)
    if(_type STREQUAL INTERFACE_LIBRARY)
        global_set(add.target.${_target} INTERFACE_LINK_LIBRARIES ${ARGN})
    else()
        global_set(add.target.${_target} LINK_LIBRARIES ${ARGN})
    endif()
endfunction()

function(_calm_target_include_directories _target _visibility)
    global_get(add.target.${_target} TYPE _type)
    if(_type STREQUAL INTERFACE_LIBRARY)
        message(STATUS "[${_target}] set INTERFACE_INCLUDE_DIRECTORIES to ${ARGN}")
        global_set(add.target.${_target} INTERFACE_INCLUDE_DIRECTORIES "${ARGN}")
    else()
        message(STATUS "[${_target}] set INCLUDE_DIRECTORIES to ${ARGN}")
        global_set(add.target.${_target} INCLUDE_DIRECTORIES "${ARGN}")
    endif()
endfunction()

function(_calm_target_compile_options _target _visibility)
    global_set(add.target.${_target} compile.options ${ARGN})
endfunction()

function(_calm_get_target_property _out_var _target _property)
    message(STATUS "getting add.target.${_target} ${_property}")
    global_get(add.target.${_target} ${_property} _value)
    set(${_out_var} "${_value}" PARENT_SCOPE)
endfunction()

function(_calm_set_target_properties _target)
    cmake_parse_arguments(ARG "" "" "PROPERTIES" ${ARGN})
    unset(_value)
    unset(_property_name)
    message(STATUS "ARG_PROPERTIES = ${ARG_PROPERTIES}")
    foreach(_property ${ARG_PROPERTIES})
        if (_value)
            set(_value false)
            message(STATUS "setting add.target.${_target} ${_property_name} to ${_property}")
            global_set(add.target.${_target} ${_property_name} ${_property})
        else()
            set(_property_name ${_property})
            set(_value true)
        endif()
    endforeach()
endfunction()

function(calm_add_executable _target)
    cmake_parse_arguments(ARG "TEST" "" "DEPENDENCIES;INCLUDES;SOURCES" ${ARGN})
    mock_add_library(${_target} EXECUTABLE ${ARG_SOURCES})
endfunction()

function(_calm_add_executable _target)
    mock_add_library(${_target} EXECUTABLE ${ARGN})
endfunction()

function(_calm_target_sources _target)
    global_get(add.target.${_target} TYPE _type)
    if(_type STREQUAL INTERFACE_LIBRARY)
        _calm_set_target_properties(${_target} PROPERTIES INTERFACE_SOURCES ${ARGN})
    else()
        _calm_set_target_properties(${_target} PROPERTIES SOURCES ${ARGN})
    endif()
endfunction()

function(_calm_add_library _target)
    cmake_parse_arguments(ARG "INTERFACE" "" "" ${ARGN})
    if (ARG_INTERFACE)
        mock_add_library(${_target} INTERFACE_LIBRARY stub.cc)
    else()
        mock_add_library(${_target} STATIC_LIBRARY ${ARGN})
    endif()
endfunction()

macro(_calm_add_custom_target _target)
    mock_add_library(${_target} CUSTOM src/main.cc)
endmacro()

function(_calm_add_dependencies)
endfunction()

function(obtain)
endfunction()

set(PROJECT_SOURCE_DIR ${_current_test_dir}/../..)
set(CMAKE_CXX_COMPILER_ID GNU)

list(APPEND CMAKE_MODULE_PATH "${catch2_SOURCE_DIR}")
