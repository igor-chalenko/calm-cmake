function(_plugin_concepts_manifest)
    _calm_plugin_manifest(concepts
            REQUIRED
            TARGET_TYPES main test
            DESCRIPTION [=[
This plugin performs the following actions on each configured target:
1) Enable C++20 and enforces it via `CXX_STANDARD_REQUIRED` enabled and `CXX_EXTENSIONS` disabled.
2) Configures compiler flags that enable concepts for the compiler currently configured in CMake.
   It's `-fconcepts` for gcc-9, for example.]=])
endfunction()

function(_plugin_concepts_init)

    include(CMakePushCheckState)
    include(CheckIncludeFileCXX)
    include(CheckCXXSourceCompiles)

    cmake_push_check_state(RESET)

    set(code [[

        template <typename T>
        concept Animal = requires(T a) {
            { a.make_sound() };
        };

        template <Animal T>
        void make_sound(T animal) {
            animal.make_sound();
        }

        struct Cat {
            void make_sound() {
                /* Meow */
            }
        };

        int main() {
            Cat c;
            make_sound(c);
        }

    ]])

    if (DEFINED CMAKE_CXX_STANDARD)
        set(_backup ${CMAKE_CXX_STANDARD})
    endif ()
    set(CMAKE_CXX_STANDARD 20)
    check_cxx_source_compiles("${code}" HAVE_CXX_CONCEPTS)
    if (DEFINED _backup)
        set(CMAKE_CXX_STANDARD ${_backup})
    else ()
        unset(CMAKE_CXX_STANDARD)
    endif ()

    if (NOT HAVE_CXX_CONCEPTS)
        set(CMAKE_REQUIRED_FLAGS -fconcepts)
        check_cxx_source_compiles("${code}" HAVE_CXX_CONCEPTS_WITH_FCONCEPTS)
        if (NOT HAVE_CXX_CONCEPTS_WITH_FCONCEPTS)
            set(CMAKE_REQUIRED_DEFINITIONS "-Dconcept=concept\\ bool")
            if (CMAKE_REQUIRED_DEFINITIONS)
                check_cxx_source_compiles("${code}" HAVE_CXX_CONCEPTS_TS_WITH_FCONCEPTS)
                unset(CMAKE_REQUIRED_DEFINITIONS)
            endif ()
        endif ()
    endif ()

    if (HAVE_CXX_CONCEPTS_TS_WITH_FCONCEPTS OR HAVE_CXX_CONCEPTS_WITH_FCONCEPTS OR HAVE_CXX_CONCEPTS)
        add_library(CXX::Concepts INTERFACE IMPORTED)
        target_compile_definitions(CXX::Concepts INTERFACE CXX_CONCEPTS_AVAILABLE)
    endif ()

    if (HAVE_CXX_CONCEPTS_TS_WITH_FCONCEPTS OR HAVE_CXX_CONCEPTS_WITH_FCONCEPTS)
        target_compile_options(CXX::Concepts INTERFACE -fconcepts)
    endif ()

    if (HAVE_CXX_CONCEPTS_TS_WITH_FCONCEPTS)
        target_compile_definitions(CXX::Concepts INTERFACE "concept=concept bool")
    endif ()
endfunction()

function(_plugin_concepts_apply _target)
    get_target_property(_type ${_target} TYPE)
    if (${_type} STREQUAL INTERFACE_LIBRARY)
        set_target_properties(${_target}
                PROPERTIES
                INTERFACE_CXX_STANDARD 20
                INTERFACE_CXX_STANDARD_REQUIRED YES
                INTERFACE_CXX_EXTENSIONS NO
                )
    else()
        set_target_properties(${_target}
                PROPERTIES
                CXX_STANDARD 20
                CXX_STANDARD_REQUIRED YES
                CXX_EXTENSIONS NO
                )
    endif ()
endfunction()

function(_plugin_concepts_apply_2 _target)
    set(_plugin_target "CXX::Concepts")
    if (TARGET CXX::Concepts)
        get_target_property(_type ${_target} TYPE)
        if (${_type} STREQUAL INTERFACE_LIBRARY)
            target_link_libraries(${_target} INTERFACE ${_plugin_target})
        else()
            target_link_libraries(${_target} PUBLIC ${_plugin_target})
            set_target_properties(${_target}
                    PROPERTIES
                        CXX_STANDARD 20
                        CXX_STANDARD_REQUIRED YES
                        CXX_EXTENSIONS NO
                    )
        endif ()
    else()
        message(STATUS "The target ${_plugin_target} doesn't exist.")
        message(FATAL_ERROR [[
Plugin `concepts` did not initialize, or the target name changed in the implementation.]])
    endif ()
endfunction()
