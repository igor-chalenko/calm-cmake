//
// Created by crusoe on 16.10.2020.
//

#ifndef SYNTAGMA_FORMAT_H
#define SYNTAGMA_FORMAT_H

#include <string>
#include <fmt/format.h>
#include <boost/predef.h>
#include "localized_text_store.h"

namespace syntagma::i18n {

    using store = localized_text_store;

    template<typename ...Ts>
    std::string format(store &translations,
                       const std::string &message,
                       Ts &&... arguments) {
        const auto & string_template = translations.translate(message);

        return fmt::format(fmt::runtime(string_template), std::forward<Ts>(arguments)...);
    }

}

#endif //SYNTAGMA_FORMAT_H
