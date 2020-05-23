cmake_minimum_required(VERSION 3.17)

include(/home/vishalj/workspace/gh/otto/otto.cmake)

# define project name, its version and programming language
project(sayHello
    VERSION 0.0.1
    LANGUAGES CXX)

## Targets
# name of application 
set(APP_NAME ${PROJECT_NAME})
# name of library
set(LIB_NAME ${PROJECT_NAME})

## Dependencies
set(APP_OBJS src/sayit.cpp)
set(LIB_OBJS src/sayHello.cpp)
set(LIB_HEADERS
    include/sayHello.h
    include/dummy.h)

## Automate
include(otto_run)
