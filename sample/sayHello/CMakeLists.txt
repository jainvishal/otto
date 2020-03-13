cmake_minimum_required(VERSION 3.13)

# define project name, its version and programming language
project(sayHello
    VERSION 0.0.1
    LANGUAGES CXX)

include(/home/vishalj/workspace/gh/otto/otto.cmake)

## Targets
# name of application 
set(APP_NAME hello)
# name of library
set(LIB_NAME ${PROJECT_NAME})

## Dependencies
set(APP_OBJS src/sayit.cpp)
set(LIB_OBJS src/sayHello.cpp)

## Automate
include(otto_run)
