#include <gtest/gtest.h>

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

TEST(cat, main) { // NOLINT
    Cat c;
    make_sound(c);
}
