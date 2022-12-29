function(nuget_install package_name config_file)
	find_program(NUGET_EXE NAMES nuget REQUIRED)

	configure_file(${config_file} ${CMAKE_BINARY_DIR}/packages.${package_name}.config)
	execute_process(
			COMMAND
			${NUGET_EXE} restore packages.${package_name}.config -SolutionDirectory ${CMAKE_BINARY_DIR}
			WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
	)
endfunction(nuget_install)
