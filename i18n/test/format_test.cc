#include <catch2/catch_all.hpp>
#include <type_traits>

#include "syntagma/i18n/format.h"

namespace i18n = syntagma::i18n;
using namespace fmt::literals;

constexpr const char *ERROR_CODE_MSG = "error code is {code}";

template<class T, class U>
concept SameHelper = std::is_same<T, U>::value;

struct test_localized_store : public syntagma::i18n::localized_text_store {
    [[nodiscard]]
    const std::string &translate(const std::string &text) override {
        const auto &res = translations_.find(text);
        if (res != translations_.end()) {
            return res->second;
        } else {
            translations_[text] = text;
            return translations_[text];
        }
    }

    test_localized_store() {
        translations_[ERROR_CODE_MSG] = "код ошибки: {code}";
    }

    void set_locale(const std::string &posix_name) override {}

private:
    std::map<std::string, std::string> translations_;
};

TEST_CASE("format") {
    test_localized_store store;

    i18n::format(store, ERROR_CODE_MSG, "code"_a = 42);
}

