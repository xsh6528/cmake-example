cmake_minimum_required(VERSION 3.5)
project(cmake-example CXX C)

find_package(Boost 1.32 REQUIRED COMPONENTS program_options)
include_directories(SYSTEM ${Boost_INCLUDE_DIRS})

set(gmock_dir "$ENV{HOME}/code/gmock" CACHE PATH "The path to the GoogleMock test framework." FORCE)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)
include(gtest)

enable_testing()

# install path prefix, modify this for formal projects
set(CMAKE_INSTALL_PREFIX $ENV{HOME}/installed_cmake_example)
set(CMAKE_BUILD_TYPE Debug)
set(BUILD_SHARED_LIBS TRUE)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

set(CMAKE_INSTALL_PREFIX $ENV{HOME}/installed_cmake_example)
LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
IF("${isSystemDir}" STREQUAL "-1")
    SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
ENDIF("${isSystemDir}" STREQUAL "-1")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)  # for libs outside the sourcetree

set(cmake_cxx_flags_general "-pthread -std=c++11")
set(cmake_cxx_flags_warnings "-Wall -Wextra -Werror")
set(CMAKE_CXX_FLAGS "${cmake_cxx_flags_general} ${cmake_cxx_flags_warnings}")

add_subdirectory(ToDoCore)

add_executable(toDo main.cc)
target_link_libraries(toDo toDoCore ${Boost_LIBRARIES})

# install
install(TARGETS toDo
        RUNTIME DESTINATION bin)

install(PROGRAMS run.sh DESTINATION bin)
install(FILES COPYRIGHT README DESTINATION doc)
install(DIRECTORY doc/ DESTINATION doc)