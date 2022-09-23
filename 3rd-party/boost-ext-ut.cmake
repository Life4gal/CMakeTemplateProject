CPMFindPackage(
		NAME ut
		GIT_TAG v1.1.9
		GITHUB_REPOSITORY "boost-ext/ut"
		OPTIONS "BOOST_UT_USE_WARNINGS_AS_ERORS ON"
)

CPM_add_package_source(ut)
list(APPEND ${PROJECT_NAME}_LINK_LIBS ut)