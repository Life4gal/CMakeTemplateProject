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
set(TEST_PNG_FILE_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/test.png)
file(
		TOUCH
		${TEST_PNG_FILE_PATH}
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
