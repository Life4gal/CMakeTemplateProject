set(CPM_USE_LOCAL_PACKAGES ON)

function(CPM_add_package_source package_name)
	if(${package_name}_ADDED)
		message("Successfully added [${package_name}], the source files path is [${${package_name}_SOURCE_DIR}], the binary files path is [${${package_name}_BINARY_DIR}]!")
	else()
		message("Found the local [${package_name}] package, the source files path is [${${package_name}_SOURCE_DIR}], the binary files path is [${${package_name}_BINARY_DIR}]!")
		add_subdirectory(
				${${package_name}_SOURCE_DIR}
				${${package_name}_BINARY_DIR}
				EXCLUDE_FROM_ALL
		)
	endif(${package_name}_ADDED)
endfunction(CPM_add_package_source)
