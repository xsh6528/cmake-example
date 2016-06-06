include_directories(${PROJECT_SOURCE_DIR})
add_library(toDoCore ToDo.cc)
set_target_properties(toDoCore PROPERTIES VERSION 1.2 SOVERSION 1 OUTPUT_NAME toDoCore)

install(TARGETS toDoCore
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

add_subdirectory(test)