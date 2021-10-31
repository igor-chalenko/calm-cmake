#include <utility>

// Copyright (c) 2020 Igor Chalenko
// Distributed under the MIT License (MIT).
// See accompanying file LICENSE.txt or copy at
// https://opensource.org/licenses/MIT

/// @brief Sipapu - C++ logical programming library
/// @details todo add some details

#ifndef SYNTAGMA_INCLUDE_SYNTAGMA_LOCALIZED_TEXT_STORE_H_
#define SYNTAGMA_INCLUDE_SYNTAGMA_LOCALIZED_TEXT_STORE_H_

namespace syntagma::i18n {

/**
 * Takes care of the text translation. Does not do any formatting.
 */
    class localized_text_store {
    public:
        virtual void set_locale(const std::string &posix_name) = 0;

        [[nodiscard]]
        virtual const std::string &translate(const std::string &text) = 0;

        //virtual void add_search_path(const std::string &path) = 0;
    };

}

#endif //SYNTAGMA_INCLUDE_SYNTAGMA_LOCALIZED_TEXT_STORE_H_
