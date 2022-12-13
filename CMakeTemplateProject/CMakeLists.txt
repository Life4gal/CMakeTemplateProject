project(
	CMakeTemplateProject-impl
	LANGUAGES CXX
)

file(
	GLOB_RECURSE  
	${PROJECT_NAME}_SOURCE 
	CONFIGURE_DEPENDS 

	${PROJECT_SOURCE_DIR}/src/*.cpp
)

# this is the "object library" target: compiles the sources only once
add_library(
	${PROJECT_NAME}-objlib
	OBJECT

	${${PROJECT_NAME}_SOURCE}
)

set_property(TARGET ${PROJECT_NAME}-objlib PROPERTY POSITION_INDEPENDENT_CODE ON)

target_include_directories(
	${PROJECT_NAME}-objlib
	PUBLIC

	${CMAKE_CURRENT_SOURCE_DIR}/include
)

CPM_link_libraries_DECL()
include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/fmtlib.cmake)
include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/spdlog.cmake)
include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/eve.cmake)
include(${${PROJECT_NAME_PREFIX}CMAKE_3RDPARTY_PATH}/bdwgc.cmake)
CPM_link_libraries_LINK(${PROJECT_NAME}-objlib)

# shared and static libraries built from the same object files
# see target_link_libraries below (in project_setup)

#add_library(${PROJECT_NAME}-shared SHARED $<TARGET_OBJECTS:${PROJECT_NAME}-objlib>)
# todo: source file?
add_library(${PROJECT_NAME}-shared SHARED dummy/dummy.cpp)
#add_library(${PROJECT_NAME}-static STATIC $<TARGET_OBJECTS:${PROJECT_NAME}-objlib>)
# todo: source file?
add_library(${PROJECT_NAME}-static STATIC dummy/dummy.cpp)

set_target_properties(
	${PROJECT_NAME}-shared PROPERTIES
	OUTPUT_NAME ${PROJECT_NAME}-shared
)
set_target_properties(
	${PROJECT_NAME}-static PROPERTIES
	OUTPUT_NAME ${PROJECT_NAME}-static
)

function(project_setup project_name)
	target_include_directories(
		${project_name}
		PUBLIC

#		${CMAKE_CURRENT_SOURCE_DIR}/include
		$<TARGET_PROPERTY:${PROJECT_NAME}-objlib,INTERFACE_INCLUDE_DIRECTORIES>
	)

	target_link_libraries(
		${project_name}
		PUBLIC
		${PROJECT_NAME}-objlib
	)

	target_compile_definitions(
			${project_name}
			PUBLIC

			${PROJECT_NAME_PREFIX}MAJOR_VERSION=${${PROJECT_NAME_PREFIX}MAJOR_VERSION}
			${PROJECT_NAME_PREFIX}MINOR_VERSION=${${PROJECT_NAME_PREFIX}MINOR_VERSION}
			${PROJECT_NAME_PREFIX}PATCH_VERSION=${${PROJECT_NAME_PREFIX}PATCH_VERSION}
			${PROJECT_NAME_PREFIX}VERSION="${${PROJECT_NAME_PREFIX}VERSION}"
			${PROJECT_NAME_PREFIX}COMPILER_NAME="${${PROJECT_NAME_PREFIX}COMPILER_NAME}"
			${PROJECT_NAME_PREFIX}COMPILER_VERSION="${${PROJECT_NAME_PREFIX}COMPILER_VERSION}"

			$<$<CXX_COMPILER_ID:MSVC>:${PROJECT_NAME_PREFIX}COMPILER_MSVC>
			$<$<CXX_COMPILER_ID:GNU>:${PROJECT_NAME_PREFIX}COMPILER_GNU>
			# clang-cl
			# Also defines MSVC
			$<$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>:${PROJECT_NAME_PREFIX}COMPILER_CLANG_CL ${PROJECT_NAME_PREFIX}COMPILER_MSVC>
			# clang
			$<$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${PROJECT_NAME_PREFIX}COMPILER_CLANG>
			# TODO: MORE COMPILERS HERE.
	)

	set_compile_options_private(${project_name})
	turn_off_warning(${project_name})
endfunction(project_setup)

project_setup(${PROJECT_NAME}-shared)
project_setup(${PROJECT_NAME}-static)

# todo: library name?

add_library(
	gal::CTP-static
	ALIAS
	${PROJECT_NAME}-static
)

add_library(
		gal::CTP-shared
		ALIAS
		${PROJECT_NAME}-shared
)
