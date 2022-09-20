CPMFindPackage(
		NAME ut
		GIT_TAG v1.1.9
		GITHUB_REPOSITORY "boost-ext/ut"
		OPTIONS "BOOST_UT_USE_WARNINGS_AS_ERORS ON"
)

if(ut_ADDED)
	message("Successfully added ut, the source files path is ${ut_SOURCE_DIR}!")
else()
	message("Found the local ut package, the source files path is ${ut_SOURCE_DIR}!")
	add_subdirectory(
			${ut_SOURCE_DIR}
			${ut_BINARY_DIR}
			EXCLUDE_FROM_ALL
	)
endif(ut_ADDED)

list(APPEND ${PROJECT_NAME}_LINK_LIBS ut)