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

CPM_link_libraries_DECL()
include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/boost-ext-ut.cmake)
CPM_link_libraries_LINK()

target_link_libraries(
		${PROJECT_NAME}
		PRIVATE
		gal::CTP
)

set_compile_options_private(${PROJECT_NAME})
turn_off_warning(${PROJECT_NAME})
