set(
		${PROJECT_NAME_PREFIX}cmake_utils_files
		"CPM.cmake"
		"cpm_install.cmake"
		"doc_var.cmake"
		"nuget_install.cmake"
)

foreach (file IN LISTS ${PROJECT_NAME_PREFIX}cmake_utils_files)
	set(
			${PROJECT_NAME_PREFIX}cmake_utils_files_url
			"https://github.com/Life4gal/CMakeTemplateProject/tree/master/cmake_utils"
	)

	set(local_file_path ${CMAKE_CURRENT_SOURCE_DIR}/cmake_utils/${file})
	set(remote_file_path "${${PROJECT_NAME_PREFIX}cmake_utils_files_url}/${file}")

	if (NOT EXISTS ${local_file_path})
		message(STATUS "File [${local_file_path}] not exists, fetching...(${remote_file_path})")

		file(
				DOWNLOAD
				${remote_file_path}
				${local_file_path}
				SHOW_PROGRESS
				STATUS download_result
		)

		list(GET download_result 0 error_code)
		list(GET download_result 1 error_string)
		if (NOT error_code EQUAL 0)
			message(FATAL_ERROR "Cannot download [${remote_file_path}] ! --> ${error_string}")
		endif (NOT error_code EQUAL 0)
	endif (NOT EXISTS ${local_file_path})
endforeach (file IN LISTS ${PROJECT_NAME_PREFIX}cmake_utils_files)
