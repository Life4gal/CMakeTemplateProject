function(check_and_download_stb_image)
	set(dest_path ${${PROJECT_NAME_PREFIX}TEMP_HEADER_PATH}/stb/stb_image.h)

	if (NOT EXISTS ${dest_path})
		message(STATUS "The file stb_image is not exists, downloading...(dest: ${dest_path})")

		file(
				DOWNLOAD
				https://raw.githubusercontent.com/nothings/stb/master/stb_image.h
				${dest_path}
				SHOW_PROGRESS
				STATUS download_result
		)

		list(GET download_result 0 error_code)
		list(GET download_result 1 error_string)
		if (NOT error_code EQUAL 0)
			message(FATAL_ERROR "Cannot download stb_image.h ! --> ${error_string}")
		endif (NOT error_code EQUAL 0)
	else ()
		message(STATUS "The file stb_image is exists(${dest_path}), no need to download...")
	endif (NOT EXISTS ${dest_path})
	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "stb_image" PARENT_SCOPE)
endfunction(check_and_download_stb_image)

check_and_download_stb_image()
