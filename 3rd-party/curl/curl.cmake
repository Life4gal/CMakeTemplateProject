CPMAddPackage(
		NAME CURL
		GIT_TAG curl-7_87_0
		GITHUB_REPOSITORY "curl/curl"
		OPTIONS "CURL_USE_OPENSSL"
)

cmake_language(
		CALL
		${PROJECT_NAME_PREFIX}cpm_install
		${PROJECT_NAME} CURL PRIVATE libcurl
)
list(APPEND ${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES "libcurl 7.87.0")

if (LIB_OPENSSL_PATH)
	# todo: It looks like we have to let libcurl know the path to the openssl headers installed by nuget.
	target_include_directories(
			libcurl
			SYSTEM
			PRIVATE
			${LIB_OPENSSL_PATH}/include
	)
endif (LIB_OPENSSL_PATH)

get_target_property(
		target_binary_directory
		${PROJECT_NAME}
		RUNTIME_OUTPUT_DIRECTORY
)

add_custom_command(
		TARGET ${PROJECT_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "[CURL] Copying 'cacert.pem' to '${target_binary_directory}'."
		COMMAND ${CMAKE_COMMAND} -E make_directory ${target_binary_directory}
		COMMAND ${CMAKE_COMMAND} -E copy_if_different ${${PROJECT_NAME_PREFIX}3RD_PARTY_PATH}/curl/cacert.pem ${target_binary_directory}/cacert.pem
)
