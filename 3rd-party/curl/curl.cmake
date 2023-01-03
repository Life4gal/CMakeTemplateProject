CPMAddPackage(
		NAME CURL
		GIT_TAG curl-7_87_0
		GITHUB_REPOSITORY "curl/curl"
		OPTIONS "CURL_USE_OPENSSL"
)

cpm_install(${PROJECT_NAME} CURL PUBLIC libcurl)
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

configure_file(
		${${PROJECT_NAME_PREFIX}3RD_PARTY_PATH}/curl/cacert.pem
		${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/cacert.pem
		COPYONLY
)
