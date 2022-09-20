CPMFindPackage(
		NAME fmtlib
#		GIT_TAG master
		GIT_TAG 9.1.0
		GITHUB_REPOSITORY "fmtlib/fmt"
		OPTIONS "FMT_PEDANTIC ON" "FMT_WERROR ON" "FMT_DOC OFF" "FMT_INSTALL ON" "FMT_TEST ON"
)

if(fmtlib_ADDED)
	message("Successfully added fmtlib, the source files path is ${fmtlib_SOURCE_DIR}!")
else()
	message("Found the local fmtlib package, the source files path is ${fmtlib_SOURCE_DIR}!")
	add_subdirectory(
			${fmtlib_SOURCE_DIR}
			${fmtlib_BINARY_DIR}
			EXCLUDE_FROM_ALL
	)
endif(fmtlib_ADDED)

list(APPEND ${PROJECT_NAME}_LINK_LIBS fmt)
