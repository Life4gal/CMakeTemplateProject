CPMFindPackage(
		NAME spdlog
		VERSION 1.10.0
		GITHUB_REPOSITORY "gabime/spdlog"
		OPTIONS "SPDLOG_BUILD_EXAMPLE OFF" "SPDLOG_BUILD_TESTS  OFF" "SPDLOG_BUILD_TESTS_HO OFF" "SPDLOG_INSTALL ON" "SPDLOG_FMT_EXTERNAL ON"
)

if(spdlog_ADDED)
	message("Successfully added spdlog, the source files path is [${spdlog_SOURCE_DIR}]!")
else()
	message("Found the local spdlog package, the source files path is [${spdlog_SOURCE_DIR}]!")
	add_subdirectory(
			${spdlog_SOURCE_DIR}
			${spdlog_BINARY_DIR}
			EXCLUDE_FROM_ALL
	)
endif(spdlog_ADDED)

list(APPEND ${PROJECT_NAME}_LINK_LIBS spdlog)
