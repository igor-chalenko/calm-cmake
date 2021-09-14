function(_calm_init_locale)
    get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)
    get_property(_cpm_initialized GLOBAL PROPERTY CPM_INITIALIZED)

    set(_deps "")
    foreach (_dep ${ARGN})
        list(APPEND _deps Boost::${_dep})
    endforeach()

    if (_cpm_initialized)
        foreach (_dep ${ARGN})
            include(${_current_dir}/build-modules/Boost/${_dep}.cmake)
        endforeach()

        find_package(ICU COMPONENTS uc dt in)
        find_package(Iconv)

        if(CMAKE_SYSTEM MATCHES "SunOS.*")
            set(BOOST_LOCALE_WITH_STD Off CACHE BOOL "")
        else()
            set(BOOST_LOCALE_WITH_STD On CACHE BOOL "")
        endif()

        _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS locale)

        if (DEFINED boost_locale_SOURCE_DIR)
            set(_sources
                    "${boost_locale_SOURCE_DIR}/src/encoding/codepage.cpp;${boost_locale_SOURCE_DIR}/src/shared/date_time.cpp;${boost_locale_SOURCE_DIR}/src/shared/format.cpp;${boost_locale_SOURCE_DIR}/src/shared/formatting.cpp;${boost_locale_SOURCE_DIR}/src/shared/generator.cpp;${boost_locale_SOURCE_DIR}/src/shared/ids.cpp;${boost_locale_SOURCE_DIR}/src/shared/localization_backend.cpp;${boost_locale_SOURCE_DIR}/src/shared/message.cpp;${boost_locale_SOURCE_DIR}/src/shared/mo_lambda.cpp;${boost_locale_SOURCE_DIR}/src/util/codecvt_converter.cpp;${boost_locale_SOURCE_DIR}/src/util/gregorian.cpp;${boost_locale_SOURCE_DIR}/src/util/default_locale.cpp;${boost_locale_SOURCE_DIR}/src/util/info.cpp;${boost_locale_SOURCE_DIR}/src/util/locale_data.cpp"
                    )
            if(BOOST_LOCALE_WITH_STD)
                list(APPEND _sources
                        "${boost_locale_SOURCE_DIR}/src/std/codecvt.cpp;${boost_locale_SOURCE_DIR}/src/std/collate.cpp;${boost_locale_SOURCE_DIR}/src/std/converter.cpp;${boost_locale_SOURCE_DIR}/src/std/numeric.cpp;${boost_locale_SOURCE_DIR}/src/std/std_backend.cpp;${boost_locale_SOURCE_DIR}/src/util/gregorian.cpp")
            endif()

            calm_add_library(boost_locale
                    SOURCES ${_sources}
                    INCLUDES $<BUILD_INTERFACE:${boost_locale_SOURCE_DIR}/include>;$<INSTALL_INTERFACE:include>
                    DEPENDENCIES ${_deps}
                    NAMESPACE Boost
                    EXPORT_NAME locale
                    )

            if(NOT BOOST_LOCALE_WITH_STD)
                target_compile_definitions(boost_locale PUBLIC BOOST_LOCALE_NO_STD_BACKEND=1)
            endif()
            if(ICONV_FOUND)
                target_compile_definitions(boost_locale PUBLIC BOOST_LOCALE_WITH_ICONV=1)
                target_link_libraries(boost_locale PUBLIC Iconv::Iconv)
            endif()

            if(ICU_FOUND)
                target_compile_definitions(boost_locale PUBLIC BOOST_LOCALE_WITH_ICU=1)
                target_link_libraries(boost_locale PUBLIC ICU::uc ICU::dt ICU::in)
                target_sources(boost_locale PRIVATE
                        ${boost_locale_SOURCE_DIR}/src/icu/boundary.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/codecvt.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/collator.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/conversion.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/date_time.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/formatter.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/icu_backend.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/numeric.cpp
                        ${boost_locale_SOURCE_DIR}/src/icu/time_zone.cpp
                        )
            endif()
            if(WIN32)
                target_sources(boost_locale PRIVATE
                        ${boost_locale_SOURCE_DIR}/src/win32/collate.cpp
                        ${boost_locale_SOURCE_DIR}/src/win32/converter.cpp
                        ${boost_locale_SOURCE_DIR}/src/win32/numeric.cpp
                        ${boost_locale_SOURCE_DIR}/src/win32/win_backend.cpp
                        )
            else()
                target_compile_definitions(boost_locale PUBLIC BOOST_LOCALE_NO_WINAPI_BACKEND=1)
            endif()
            if(UNIX)
                target_sources(boost_locale PRIVATE
                        ${boost_locale_SOURCE_DIR}/src/posix/collate.cpp
                        ${boost_locale_SOURCE_DIR}/src/posix/converter.cpp
                        ${boost_locale_SOURCE_DIR}/src/posix/numeric.cpp
                        ${boost_locale_SOURCE_DIR}/src/posix/codecvt.cpp
                        ${boost_locale_SOURCE_DIR}/src/posix/posix_backend.cpp
                        )
            else()
                target_compile_definitions(boost_locale PUBLIC BOOST_LOCALE_NO_POSIX_BACKEND=1)
            endif()
        else()
            message(STATUS "Using Locally installed Boost::locale")
        endif()
    else()
        find_package(Boost QUIET REQUIRED COMPONENTS locale)
    endif()
endfunction()

if (NOT TARGET Boost::locale)
    _calm_init_locale(regex core static_assert iterator tuple optional mpl
            functional detail assert type_traits concept_check preprocessor
            array thread conversion numeric_conversion utility)
endif()

