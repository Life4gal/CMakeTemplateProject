set(
	GSL_MSVC_WARNINGS 

	/Wv:18
)

set(
	GSL_GNU_WARNINGS

)

set(
	GSL_CLANG_CL_WARNINGS

)

set(
	GSL_CLANG_WARNINGS

)

macro(turn_off_warning target_name)
	message("Turn off compile warning for project ${target_name}...")
	target_compile_options(
		${target_name}
		PRIVATE

		$<$<CXX_COMPILER_ID:MSVC>:${GSL_MSVC_WARNINGS}>
		$<$<CXX_COMPILER_ID:GNU>:${GSL_GNU_WARNINGS}>
		# clang-cl
		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>:${GSL_CLANG_CL_WARNINGS}>
		# clang
		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_WARNINGS}>
	)
endmacro()
