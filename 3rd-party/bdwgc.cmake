if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
	set(GSL_GC_ENABLE_THREADS ON)
else()
	set(GSL_GC_ENABLE_THREADS OFF)
endif (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")

CPMFindPackage(
		NAME gc
		GIT_TAG v8.2.2
		GITHUB_REPOSITORY "ivmai/bdwgc"
		OPTIONS 
		"enable_cplusplus ON" 
		# build dll?
		#"BUILD_SHARED_LIBS OFF"
		# https://github.com/ivmai/bdwgc/blob/6c47e6d4c929d97aa59efc970c0b3a07d6ee7ad6/CMakeLists.txt#L201
		"enable_threads ${GSL_GC_ENABLE_THREADS}"
)

CPM_link_libraries_APPEND(gc PRIVATE)

target_compile_definitions(
		gc
		PRIVATE

		$<$<CXX_COMPILER_ID:GNU>:GC_BUILTIN_ATOMIC>
)
