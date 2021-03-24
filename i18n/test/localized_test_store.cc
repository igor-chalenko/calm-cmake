// Copyright (c) 2020 Igor Chalenko
// Distributed under the MIT License (MIT).
// See accompanying file LICENSE.txt or copy at
// https://opensource.org/licenses/MIT

/// @brief Sipapu - C++ logical programming library
/// @details todo add some details

#include <locale>
#include <gtest/gtest.h>

#include "syntagma/i18n/localized_text_store.h"

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
        translations_["text"] = "more text";
    }

    void set_locale(const std::string &posix_name) override {}

private:
    std::map<std::string, std::string> translations_;
};

TEST(localized_text_store, create) { // NOLINT
    test_localized_store store;

    const auto &translation = store.translate("text");
    ASSERT_EQ(translation, "more text");
    const auto &translation2 = store.translate("other text");
    ASSERT_EQ(translation2, "other text");
}

TEST(localized_text_store, create2) { // NOLINT
    test_localized_store store;

    const auto &translation = store.translate("text");
    ASSERT_EQ(translation, "more text");
    const auto &translation2 = store.translate("other text");
    ASSERT_EQ(translation2, "other text");
}
