cmake_minimum_required (VERSION 3.4)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
project(heloy_wld)
add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/hello_world.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../formatter_ex_lib)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../formatter_ex_lib formatter_ex)
target_link_libraries(heloy_wld formatter_ex)
 
 
