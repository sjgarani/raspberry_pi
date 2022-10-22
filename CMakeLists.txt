project(sysrepo-cpp LANGUAGES CXX)
cmake_minimum_required(VERSION 3.19)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS_DEBUG "-Werror ${CMAKE_CXX_FLAGS_DEBUG}")

set(CMAKE_CXX_FLAGS "-Wall -Wextra -pedantic -Woverloaded-virtual -Wimplicit-fallthrough -Wsuggest-override ${CMAKE_CXX_FLAGS}")

find_package(PkgConfig)
pkg_check_modules(LIBYANG_CPP REQUIRED libyang-cpp=1.1.0 IMPORTED_TARGET)
set(SYSREPO_CPP_PKG_VERSION "1.1.0")

add_executable(raspberry_pi src/raspberry_pi.cpp)
target_link_libraries(raspberry_pi PRIVATE sysrepo-cpp PUBLIC PkgConfig::LIBYANG_CPP)
