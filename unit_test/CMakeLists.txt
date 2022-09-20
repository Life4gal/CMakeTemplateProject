project(
		CMakeTemplateProject-unit-test
		LANGUAGES CXX
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_executable(
		${PROJECT_NAME}

		src/main.cpp
)

set(CMAKE_CXX_STANDARD 23)
set_compile_options_private(${PROJECT_NAME})
turn_off_warning(${PROJECT_NAME})

set(${PROJECT_NAME}_LINK_LIBS "")

include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/boost-ext-ut.cmake)

message("The dependencies of project ${PROJECT_NAME} are: ${${PROJECT_NAME}_LINK_LIBS}")

target_link_libraries(
		${PROJECT_NAME}
		PRIVATE
		gal::CTP
		${${PROJECT_NAME}_LINK_LIBS}
)
