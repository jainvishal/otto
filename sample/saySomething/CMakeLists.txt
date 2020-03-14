cmake_minimum_required(VERSION 3.13)

# define project name, its version and programming language
project(saySomething
    VERSION 1.0.0
    LANGUAGES CXX)

include(/home/vishalj/workspace/gh/otto/otto.cmake)

## Targets
# name of application
set(APP_NAME ${PROJECT_NAME})

## Dependencies
set(APP_OBJS src/saySomething.cpp)

## Automate
include(otto_run)

find_package(sayHello 0.0 REQUIRED)
if (sayHello_FOUND)
    target_link_libraries(${APP_NAME}-bin sayHello::sayHello)
endif()
