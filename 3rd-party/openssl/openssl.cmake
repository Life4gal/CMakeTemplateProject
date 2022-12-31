function(install_openssl_windows)
	set(LIB_OPENSSL_NAME openssl-vc142)
	set(LIB_OPENSSL_VERSION 1.1.0)

	set(LIB_OPENSSL_PATH ${CMAKE_BINARY_DIR}/packages/${LIB_OPENSSL_NAME}.${LIB_OPENSSL_VERSION}/build/native)
	set(LIB_OPENSSL_PATH ${CMAKE_BINARY_DIR}/packages/${LIB_OPENSSL_NAME}.${LIB_OPENSSL_VERSION}/build/native PARENT_SCOPE)

	nuget_install(LIB_OPENSSL ${${PROJECT_NAME_PREFIX}3RD_PARTY_PATH}/openssl/openssl.config.in)

	add_library(OpenSSL::Crypto SHARED IMPORTED)
	set_target_properties(
			OpenSSL::Crypto PROPERTIES
			IMPORTED_LOCATION ${LIB_OPENSSL_PATH}/bin/libcrypto-vc142-x64-1_1_0.dll
			IMPORTED_IMPLIB ${LIB_OPENSSL_PATH}/bin/libcrypto-vc142-x64-1_1_0.lib
	)

	add_library(OpenSSL::SSL SHARED IMPORTED)
	set_target_properties(
			OpenSSL::SSL PROPERTIES
			IMPORTED_LOCATION ${LIB_OPENSSL_PATH}/bin/libssl-vc142-x64-1_1_0.dll
			IMPORTED_IMPLIB ${LIB_OPENSSL_PATH}/bin/libssl-vc142-x64-1_1_0.lib
	)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_OPENSSL_PATH}/include
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			#${LIB_OPENSSL_PATH}/bin/libssl-vc142-x64-1_1_0.lib
			#${LIB_OPENSSL_PATH}/bin/libcrypto-vc142-x64-1_1_0.lib

			OpenSSL::SSL
			OpenSSL::Crypto
	)
	configure_file(
			${LIB_OPENSSL_PATH}/bin/libssl-vc142-x64-1_1_0.dll
			#${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libssl-vc142-x64-1_1_0.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libssl-1_1-x64.dll
			COPYONLY
	)
	configure_file(
			${LIB_OPENSSL_PATH}/bin/libcrypto-vc142-x64-1_1_0.dll
			#${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libcrypto-vc142-x64-1_1_0.dll
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/libcrypto-1_1-x64.dll
			COPYONLY
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "${LIB_OPENSSL_NAME} ${LIB_OPENSSL_VERSION}" PARENT_SCOPE)
endfunction(install_openssl_windows)

function(install_openssl_linux)
	find_package(PkgConfig REQUIRED)

	pkg_check_modules(LIB_OPENSSL REQUIRED openssl)

	target_include_directories(
			${PROJECT_NAME}
			SYSTEM
			PRIVATE
			${LIB_OPENSSL_INCLUDE_DIRS}
	)
	target_link_directories(
			${PROJECT_NAME}
			PRIVATE
			${LIB_OPENSSL_LIBRARY_DIRS}
	)
	target_link_libraries(
			${PROJECT_NAME}
			PRIVATE
			${LIB_OPENSSL_LIBRARIES}
	)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "openssl ${LIB_OPENSSL_VERSION}" PARENT_SCOPE)
endfunction(install_openssl_linux)

if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
	#########################
	# MSVC
	########################
	install_openssl_windows()
elseif (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
	#########################
	# GCC
	########################
	install_openssl_linux()
elseif (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
	if (CMAKE_CXX_SIMULATE_ID MATCHES "MSVC")
		#########################
		# CLANG-CL
		########################
		install_openssl_windows()
	else ()
		#########################
		# CLANG
		########################
		install_openssl_linux()
	endif (CMAKE_CXX_SIMULATE_ID MATCHES "MSVC")
elseif (CMAKE_CXX_COMPILER_ID MATCHES "AppleClang")
	#########################
	# CLANG
	########################
	# todo
	install_openssl_linux()
else ()
	message(FATAL_ERROR "Unsupported compilers: ${CMAKE_CXX_COMPILER}")
endif (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")