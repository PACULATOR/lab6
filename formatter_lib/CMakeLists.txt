cmake_minimum_required(VERSION 3.4)

project(formatter_lib)
set(CMAKE_CXX_STANDARD  14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
file(GLOB
        CPP "*.cpp")
add_library(${PROJECT_NAME} STATIC ${CPP})


