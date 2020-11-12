get_property(_current_dir GLOBAL PROPERTY _CURRENT_CMAKE_DIR)

if (NOT TARGET Boost::locale)
    include(${_current_dir}/build-modules/Boost/regex.cmake)
    include(${_current_dir}/build-modules/Boost/core.cmake)
    include(${_current_dir}/build-modules/Boost/static_assert.cmake)
    include(${_current_dir}/build-modules/Boost/iterator.cmake)
    include(${_current_dir}/build-modules/Boost/tuple.cmake)
    include(${_current_dir}/build-modules/Boost/optional.cmake)
    include(${_current_dir}/build-modules/Boost/mpl.cmake)
    include(${_current_dir}/build-modules/Boost/functional.cmake)
    include(${_current_dir}/build-modules/Boost/detail.cmake)
    include(${_current_dir}/build-modules/Boost/assert.cmake)
    include(${_current_dir}/build-modules/Boost/type_traits.cmake)
    include(${_current_dir}/build-modules/Boost/concept_check.cmake)
    include(${_current_dir}/build-modules/Boost/preprocessor.cmake)
    include(${_current_dir}/build-modules/Boost/array.cmake)
    include(${_current_dir}/build-modules/Boost/thread.cmake)
    include(${_current_dir}/build-modules/Boost/numeric_conversion.cmake)
    include(${_current_dir}/build-modules/Boost/utility.cmake)

    project(boost_locale VERSION 1.74.0)
    _calm_find_package(Boost ${_git_tag} REQUIRED COMPONENTS locale)

    # todo ?
    find_package(ICU COMPONENTS uc dt in)
    find_package(Iconv)

    add_library(boost_locale
            ${boost_locale_SOURCE_DIR}/src/encoding/codepage.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/date_time.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/format.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/formatting.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/generator.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/ids.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/localization_backend.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/message.cpp
            ${boost_locale_SOURCE_DIR}/src/shared/mo_lambda.cpp
            ${boost_locale_SOURCE_DIR}/src/util/codecvt_converter.cpp
            ${boost_locale_SOURCE_DIR}/src/util/gregorian.cpp
            ${boost_locale_SOURCE_DIR}/src/util/default_locale.cpp
            ${boost_locale_SOURCE_DIR}/src/util/info.cpp
            ${boost_locale_SOURCE_DIR}/src/util/locale_data.cpp
            )
    if(BOOST_LOCALE_WITH_STD)
        target_sources(boost_locale PRIVATE
                ${boost_locale_SOURCE_DIR}/src/std/codecvt.cpp
                ${boost_locale_SOURCE_DIR}/src/std/collate.cpp
                ${boost_locale_SOURCE_DIR}/src/std/converter.cpp
                ${boost_locale_SOURCE_DIR}/src/std/numeric.cpp
                ${boost_locale_SOURCE_DIR}/src/std/std_backend.cpp
                ${boost_locale_SOURCE_DIR}/src/util/gregorian.cpp)
    else()
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

    bcm_setup_version(VERSION 1.74.0)

    if(CMAKE_SYSTEM MATCHES "SunOS.*")
        set(BOOST_LOCALE_WITH_STD Off CACHE BOOL "")
    else()
        set(BOOST_LOCALE_WITH_STD On CACHE BOOL "")
    endif()

    #add_library(boost_locale ${_sources})
    #target_include_directories(boost_locale PUBLIC ${boost_locale_SOURCE_DIR}/include)
    add_library(Boost::locale ALIAS boost_locale)

    target_link_libraries(boost_locale PUBLIC Boost::function)
    target_link_libraries(boost_locale PUBLIC Boost::static_assert)
    target_link_libraries(boost_locale PUBLIC Boost::thread)
    target_link_libraries(boost_locale PUBLIC Boost::iterator)
    target_link_libraries(boost_locale PUBLIC Boost::assert)
    target_link_libraries(boost_locale PUBLIC Boost::type_traits)
    target_link_libraries(boost_locale PUBLIC Boost::smart_ptr)
    target_link_libraries(boost_locale PUBLIC Boost::config)
    target_link_libraries(boost_locale PUBLIC Boost::unordered)
    bcm_deploy(TARGETS boost_locale INCLUDE ${boost_locale_SOURCE_DIR}/include NAMESPACE Boost::)
endif()