add_subdirectory(${gmock_dir} ${PROJECT_BINARY_DIR}/gmock)

# supress warnings when compiling external libraries
target_compile_options(gtest PRIVATE -w)
target_compile_options(gtest_main PRIVATE -w)
target_compile_options(gmock PRIVATE -w)
target_compile_options(gmock_main PRIVATE -w)

#
# add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gtest target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gmock_main)
    add_test(${target} ${PROJECT_BINARY_DIR}/bin/${target})

    add_custom_command(TARGET ${target}
            POST_BUILD
            COMMAND ${target}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            COMMENT "Running ${target}" VERBATIM)
endfunction()

