project(
		CMakeTemplateProject-unit-test
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

target_compile_definitions(
		${PROJECT_NAME}
		PUBLIC

		BOOST_UT_DISABLE_MODULE
)

include(${${PROJECT_NAME_PREFIX}3RD_PARTY_PATH}/ut/ut.cmake)

target_link_libraries(
		${PROJECT_NAME}
		PRIVATE
		CMakeTemplateProject::CMakeTemplateProject
)

add_test(
		NAME ${PROJECT_NAME}
		COMMAND ${PROJECT_NAME}
)
