function(install_freetype_windows)
	set(archive_version 2.12.1)
	set(archive_name freetype-windows-binaries-${archive_version})
	set(archive_name_with_postfix ${archive_name}.zip)

	set(dest_folder ${${PROJECT_NAME_PREFIX}TEMP_ARCHIVE_PATH}/${archive_name})
	set(dest_archive ${${PROJECT_NAME_PREFIX}TEMP_ARCHIVE_PATH}/${archive_name_with_postfix})

	# download
	if (NOT EXISTS ${dest_archive})
		message(STATUS "The file ${archive_name_with_postfix} is not exists, downloading...(dest: ${dest_archive})")

		# download
		file(
				DOWNLOAD
				https://github.com/ubawurinna/freetype-windows-binaries/archive/refs/tags/v${archive_version}.zip
				${dest_archive}
				SHOW_PROGRESS
				STATUS download_result
		)

		list(GET download_result 0 download_error_code)
		list(GET download_result 1 download_error_string)
		if (NOT download_error_code EQUAL 0)
			message(FATAL_ERROR "Cannot download ${archive_name_with_postfix} ! --> ${download_error_string}")
		endif (NOT download_error_code EQUAL 0)
	else ()
		message(STATUS "The archive ${archive_name_with_postfix} is exists(${dest_archive}), no need to download...")
	endif (NOT EXISTS ${dest_archive})

	# extract
	if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
		set(extract_dest_lib_path ${dest_folder}/release\ dll/win64)
		set(extract_lib_hash_dll 4D8A9B352D21EBBBE9006FF4340ACE97DD67D57D801333D6A3D43F178C3109B2)
		set(extract_lib_hash_lib A2D8DD42110E63645B43E91EA0C8ED4C4CAFFA7491FE25296C2D1FDF0C5BF0C2)
	elseif (${CMAKE_SIZEOF_VOID_P} MATCHES 4)
		set(extract_dest_lib_path ${dest_folder}/release\ dll/win32)
		set(extract_lib_hash_dll 9B820ABCBB06B5508B3FDB7DB0FE62F2E6ECD4ABCB641726BA1147AF5025984D)
		set(extract_lib_hash_lib 8401F44029CE3CDB0D424F0ED2F265D85EBF262878E26CAAA41524B9551FA23B)
	else ()
		message(FATAL_ERROR "Unknown architecture!")
	endif (${CMAKE_SIZEOF_VOID_P} MATCHES 8)

	if (NOT EXISTS ${dest_folder} OR NOT EXISTS ${extract_dest_lib_path})
		file(
				ARCHIVE_EXTRACT
				INPUT ${dest_archive}
				DESTINATION ${${PROJECT_NAME_PREFIX}TEMP_ARCHIVE_PATH}
		)
	endif (NOT EXISTS ${dest_folder} OR NOT EXISTS ${extract_dest_lib_path})

	# check sha256
	function(check_sha256 lib_name required_result)
		file(
				SHA256
				${extract_dest_lib_path}/${lib_name}
				result
		)

		string(TOUPPER ${result} result)

		if (NOT ${result} MATCHES ${required_result})
			message(FATAL_ERROR "File ${extract_dest_lib_path}/${lib_name} hash mismatch!\nGot -->${result}\nRequired -->${required_result}")
		endif (NOT ${result} MATCHES ${required_result})
	endfunction(check_sha256)

	check_sha256(freetype.dll ${extract_lib_hash_dll})
	check_sha256(freetype.lib ${extract_lib_hash_lib})

	# include header files
	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${dest_folder}/include
	)

	# copy dll
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${extract_dest_lib_path}/freetype.lib
	)
	configure_file(
			${extract_dest_lib_path}/freetype.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/freetype.dll
			COPYONLY
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "${archive_name}" PARENT_SCOPE)
endfunction(install_freetype_windows)

function(install_freetype_linux)
	find_package(PkgConfig REQUIRED)

	pkg_check_modules(LIB_FREETYPE REQUIRED freetype2)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_FREETYPE_INCLUDE_DIRS}
	)
	target_link_directories(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FREETYPE_LIBRARY_DIRS}
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FREETYPE_LIBRARIES}
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "freetype2 ${LIB_FREETYPE_VERSION}" PARENT_SCOPE)
endfunction(install_freetype_linux)

function(install_freetype_macos)
	find_package(PkgConfig REQUIRED)

	pkg_check_modules(LIB_FREETYPE REQUIRED freetype2)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_FREETYPE_INCLUDE_DIRS}
	)
	target_link_directories(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FREETYPE_LIBRARY_DIRS}
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FREETYPE_LIBRARIES}
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "freetype2 ${LIB_FREETYPE_VERSION}" PARENT_SCOPE)
endfunction(install_freetype_macos)

if (${PROJECT_NAME_PREFIX}PLATFORM_WINDOWS)
	#########################
	# MSVC / CLANG-CL
	########################
	install_freetype_windows()
elseif (${PROJECT_NAME_PREFIX}PLATFORM_LINUX)
	#########################
	# GCC / CLANG
	########################
	install_freetype_linux()
elseif (${PROJECT_NAME_PREFIX}PLATFORM_MACOS)
	#########################
	# APPLE CLANG
	########################
	install_freetype_macos()
else ()
	message(FATAL_ERROR "Unsupported compilers: ${CMAKE_CXX_COMPILER}")
endif (${PROJECT_NAME_PREFIX}PLATFORM_WINDOWS)
