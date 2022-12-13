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
		gal::CTP-static
)

set_compile_options_private(${PROJECT_NAME})
turn_off_warning(${PROJECT_NAME})
