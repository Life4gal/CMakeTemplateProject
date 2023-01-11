function(install_openssl_windows)
	set(archive_version 2.13.1)
	set(archive_name fontconfig-windows-${archive_version})
	set(archive_name_with_postfix ${archive_name}.zip)

	set(dest_folder ${${PROJECT_NAME_PREFIX}TEMP_ARCHIVE_PATH}/fontconfig)
	set(dest_archive ${${PROJECT_NAME_PREFIX}TEMP_ARCHIVE_PATH}/${archive_name_with_postfix})

	# download
	if (NOT EXISTS ${dest_archive})
		message(STATUS "The file ${archive_name_with_postfix} is not exists, downloading...(dest: ${dest_archive})")

		# download
		file(
				DOWNLOAD
				https://github.com/Life4gal/archive/raw/main/${archive_name_with_postfix}
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
		set(extract_dest_lib_path ${dest_folder}/x64)
		set(extract_lib_hash_fontconfig_dll E6AC355D3200F997B5EED72EDC644047B8B14A37B879B38FB6A80CE8EF930605)
		set(extract_lib_hash_fontconfig_lib DA5CFBB2006A7E9DAA3FB8415BC003A1C49E8C5178F6FAA39882EBEB340A615A)
		set(extract_lib_hash_libiconv_dll 44FFED5DB0909ECB26E9E4C3D57925D30C9862667E4B401FC8ACB640113BC635)
		set(extract_lib_hash_libxml2_dll 4F2C2F1E16B0CF2BB5406AA573476A9A40A64DC4E2228A1CD8BB64842CBB4284)
	elseif (${CMAKE_SIZEOF_VOID_P} MATCHES 4)
		set(extract_dest_lib_path ${dest_folder}/x86)
		set(extract_lib_hash_fontconfig_dll EE897F9F2D145D6159DCFD921D28214A92F94BBACF5E876C4A0DF676D9DA7182)
		set(extract_lib_hash_fontconfig_lib 4AE3D252634F8C2FE33CAC90215D45F0C00C7CE0320BEC03A1367E44886ACF81)
		set(extract_lib_hash_libiconv_dll F739136D5977A3C3F3BC6BC587FAECCE5A2A8D90F36985067183DA5D93DB3860)
		set(extract_lib_hash_libxml2_dll 44263C4220FF60DE1087A50C91572F746D1BA262AF1F0D84B995A828EE59CF96)
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

	check_sha256(fontconfig.dll ${extract_lib_hash_fontconfig_dll})
	check_sha256(fontconfig.lib ${extract_lib_hash_fontconfig_lib})
	check_sha256(libiconv.dll ${extract_lib_hash_libiconv_dll})
	check_sha256(libxml2.dll ${extract_lib_hash_libxml2_dll})

	# include header files
	#file(
	#		RENAME
	#		${dest_folder}/include/fontconfig
	#		${${PROJECT_NAME_PREFIX}TEMP_HEADER_PATH}/fontconfig
	#)
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
			${extract_dest_lib_path}/fontconfig.lib
	)
	configure_file(
			${extract_dest_lib_path}/fontconfig.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/fontconfig.dll
			COPYONLY
	)
	configure_file(
			${extract_dest_lib_path}/libiconv.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libiconv.dll
			COPYONLY
	)
	configure_file(
			${extract_dest_lib_path}/libxml2.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libxml2.dll
			COPYONLY
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "${archive_name}" PARENT_SCOPE)
endfunction(install_openssl_windows)

function(install_openssl_linux)
	find_package(PkgConfig REQUIRED)

	pkg_check_modules(LIB_FONTCONFIG REQUIRED fontconfig)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_FONTCONFIG_INCLUDE_DIRS}
	)
	target_link_directories(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FONTCONFIG_LIBRARY_DIRS}
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FONTCONFIG_LIBRARIES}
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "fontconfig ${LIB_FONTCONFIG_VERSION}" PARENT_SCOPE)
endfunction(install_openssl_linux)

function(install_openssl_macos)
	find_package(PkgConfig REQUIRED)

	pkg_check_modules(LIB_FONTCONFIG REQUIRED fontconfig)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_FONTCONFIG_INCLUDE_DIRS}
	)
	target_link_directories(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FONTCONFIG_LIBRARY_DIRS}
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${LIB_FONTCONFIG_LIBRARIES}
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "fontconfig ${LIB_FONTCONFIG_VERSION}" PARENT_SCOPE)
endfunction(install_openssl_macos)

if (${PROJECT_NAME_PREFIX}PLATFORM_WINDOWS)
	#########################
	# MSVC / CLANG-CL
	########################
	install_openssl_windows()
elseif (${PROJECT_NAME_PREFIX}PLATFORM_LINUX)
	#########################
	# GCC / CLANG
	########################
	install_openssl_linux()
elseif (${PROJECT_NAME_PREFIX}PLATFORM_MACOS)
	#########################
	# APPLE CLANG
	########################
	install_openssl_macos()
else ()
	message(FATAL_ERROR "Unsupported compilers: ${CMAKE_CXX_COMPILER}")
endif (${PROJECT_NAME_PREFIX}PLATFORM_WINDOWS)