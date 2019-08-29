###### HUNTER PACKAGE MANAGER ######
include(cmake/Hunter.cmake)
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.23.111.tar.gz"
    SHA1 "4189bbd869abe4eb69b5303d3f916c03d34dc154"
)

###### GENERAL SETTINGS ######
cmake_minimum_required(VERSION 3.10)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(PROJECT_NAME "cplate")
if((NOT PROJECT_NAME))
  message(FATAL_ERROR "Project name must be specified!")
endif ((NOT PROJECT_NAME))

###### GENERAL FLAGS ######
project(${PROJECT_NAME})
message (STATUS "${CMAKE_PROJECT_NAME}")
set(${CMAKE_PROJECT_NAME}_SUMMARY               "A simple CMAKE and CXX template")
set(${CMAKE_PROJECT_NAME}_VENDOR_NAME           "bresilla")
set(${CMAKE_PROJECT_NAME}_VENDOR_CONTACT        "trim.bresilla@gmail.com")
set(${CMAKE_PROJECT_NAME}_VERSION_MAJOR         0)
set(${CMAKE_PROJECT_NAME}_VERSION_MINOR         1)
set(${CMAKE_PROJECT_NAME}_VERSION_PATCH         0)
set(PROJECT_VERSION                             "${${CMAKE_PROJECT_NAME}_VERSION_MAJOR}.${${CMAKE_PROJECT_NAME}_VERSION_MINOR}.${${CMAKE_PROJECT_NAME}_VERSION_PATCH}")
set(PROJECT_PATH                               "${CMAKE_CURRENT_SOURCE_DIR}")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}     "${PROJECT_PATH}/cmake")
set(INCLUDE_PATH                               "${PROJECT_PATH}/src")
set(SRC_PATH                                   "${PROJECT_PATH}/src")
set(TEST_SRC_PATH                              "${PROJECT_PATH}/test")
set(EXTERNAL_PATH                              "${PROJECT_PATH}/thrd")
set(DOXYGEN_PATH                               "${PROJECT_PATH}/docs")
set(LIB_PATH                                   "${PROJECT_BINARY_DIR}/lib")
set(LIB_NAME                                   "${PROJECT_NAME}")
set(BIN_PATH                                   "${PROJECT_BINARY_DIR}/bin")
set(MAIN_NAME                                  "${PROJECT_NAME}_main")
set(TEST_PATH                                  "${PROJECT_BINARY_DIR}/test")
set(TEST_NAME                                  "test_${PROJECT_NAME}")
set(EXECUTABLE_OUTPUT_PATH                      ${BIN_PATH})
set(LIBRARY_OUTPUT_PATH                         ${LIB_PATH})

OPTION(BUILD_MAIN                              "Build main function"            ON)
OPTION(BUILD_DOXYGEN_DOCS                      "Build Doxygen docs"             ON)
OPTION(BUILD_DEPENDENCIES                      "Force build of dependencies"    OFF)


####### ENABLE MODULES and TESTING ######
include(Compiler)
include(Buildtype)
include(Warnings)
include(Coverage)
include(Packaging)
include(CppCheck)

if(BUILD_DOXYGEN_DOCS)
    add_subdirectory(${PROJECT_SOURCE_DIR}/docs)
endif()

include(CTest)
include(GNUInstallDirs)
enable_testing()


#SUBDIRECTORIES (they must have their own CMakeLists.txt)
add_subdirectory(${PROJECT_SOURCE_DIR}/src)
add_subdirectory(${PROJECT_SOURCE_DIR}/test)
add_subdirectory(${PROJECT_SOURCE_DIR}/thrd EXCLUDE_FROM_ALL)

