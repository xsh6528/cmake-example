include_directories(SYSTEM ${gtest_SOURCE_DIR}/include
                           ${gmock_SOURCE_DIR}/include)
add_gtest(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore)
