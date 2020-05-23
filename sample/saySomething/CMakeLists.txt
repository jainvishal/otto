cmake_minimum_required(VERSION 3.17)

include(/home/vishalj/workspace/gh/otto/otto.cmake)

# define project name, its version and programming language
project(saySomething
    VERSION 1.0.0
    LANGUAGES CXX)

## Targets
# name of application
set(APP_NAME ${PROJECT_NAME})

## Dependencies
set(APP_OBJS src/saySomething.cpp)

set(OTTO_DEPENDENCY_ON sayHello:0.0)

## Automate
include(otto_run)
