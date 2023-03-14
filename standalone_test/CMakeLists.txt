project(
		CMakeTemplateProject-standalone-test
		LANGUAGES CXX
)

file(
		GLOB_RECURSE
		${PROJECT_NAME}_SOURCE
		CONFIGURE_DEPENDS

		src/*.cpp
)

add_executable(
		${PROJECT_NAME}

		${${PROJECT_NAME}_SOURCE}
)

target_include_directories(
		${PROJECT_NAME}
		PUBLIC
		${PROJECT_SOURCE_DIR}/include
)

target_link_libraries(
		${PROJECT_NAME}
		PRIVATE
		CMakeTemplateProject::CMakeTemplateProject
)

# create test.png
get_target_property(
		target_binary_directory
		${PROJECT_NAME}
		RUNTIME_OUTPUT_DIRECTORY
)

set(TEST_PNG_FILE_PATH ${target_binary_directory}/test.png)

add_custom_command(
		TARGET ${PROJECT_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "Creating test png file '${TEST_PNG_FILE_PATH}'."
		COMMAND ${CMAKE_COMMAND} -E make_directory ${target_binary_directory}
		COMMAND ${CMAKE_COMMAND} -E touch ${TEST_PNG_FILE_PATH}
)

target_compile_definitions(
		${PROJECT_NAME}
		PRIVATE
		TEST_PNG_FILE_PATH="${TEST_PNG_FILE_PATH}"
)

add_test(
		NAME ${PROJECT_NAME}
		COMMAND ${PROJECT_NAME}
)
