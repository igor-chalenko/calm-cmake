#include <catch2/catch_all.hpp>
#include <boost/filesystem.hpp>

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

TEST_CASE("cat") { // NOLINT
    Cat c;
    make_sound(c);

    namespace fs = boost::filesystem;

    // get a path that is known to exist
    fs::path cp = fs::current_path();

    // demo: get tstring from the path
    auto cp_as_tstring = cp.string<std::string>();

    // demo: pass tstring to filesystem function taking path
    REQUIRE( fs::exists( cp_as_tstring ) );
}
