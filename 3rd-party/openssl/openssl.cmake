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

	# generate FindOpenSSL.cmake for find_package.
	# It looks like if we provide a FindOpenSSL.cmake directly, cmake will use ours (instead of its own), even though it is considered an empty file on linux.
	configure_file(
			${${PROJECT_NAME_PREFIX}3RD_PARTY_PATH}/openssl/FindOpenSSL.cmake.in
			#${PROJECT_SOURCE_DIR}/cmake_modules/FindOpenSSL.cmake
			${${PROJECT_NAME_PREFIX}TEMP_MODULE_PATH}/FindOpenSSL.cmake
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

	# If it is not the Windows platform then delete the FindOpenSSL.cmake that may have been generated previously.
	#file(REMOVE ${PROJECT_SOURCE_DIR}/cmake_modules/FindOpenSSL.cmake)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "openssl ${LIB_OPENSSL_VERSION}" PARENT_SCOPE)
endfunction(install_openssl_linux)

function(install_openssl_macos)
	# see .github/workflows/main.yml --> runs-on: macos-latest --> Install libssl
	# see .github/workflows/main.yml --> runs-on: macos-latest --> Configure
	# todo: A better solution
	set(ENV{PKG_CONFIG_PATH} "/usr/local/opt/openssl@3/lib/pkgconfig")

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

	# If it is not the Windows platform then delete the FindOpenSSL.cmake that may have been generated previously.
	#file(REMOVE ${PROJECT_SOURCE_DIR}/cmake_modules/FindOpenSSL.cmake)

	set(${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES ${${PROJECT_NAME_PREFIX}3RD_PARTY_DEPENDENCIES} "openssl ${LIB_OPENSSL_VERSION}" PARENT_SCOPE)
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