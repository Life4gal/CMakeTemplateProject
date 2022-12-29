set(CPM_INSTALL_LINK_TYPE PUBLIC PRIVATE INTERFACE)

function(
		cpm_pack_header_only
		library_name
)
	if (${library_name}_ADDED)
		message(STATUS "An interface library will be generated for library ${library_name}, the included headers' path is [${${library_name}_SOURCE_DIR}/include].")
		add_library(${library_name} INTERFACE IMPORTED GLOBAL)
		target_include_directories(${library_name} SYSTEM INTERFACE ${${library_name}_SOURCE_DIR}/include)
	else ()
		message(FATAL_ERROR "Library ${library_name} is not installed and cannot generate target for it!")
	endif (${library_name}_ADDED)

	# mark it
	set(${library_name}_HEADER_ONLY_GENERATED PARENT_SCOPE)
endfunction(cpm_pack_header_only)

function(
		cpm_install
		this_project
		linked_project
		link_type
		# linked_library = linked_project
)
	###############################################
	############# CHECK LINK TYPE #################
	###############################################
	list(FIND CPM_INSTALL_LINK_TYPE ${link_type} link_type_index)
	if (link_type_index EQUAL -1)
		message(FATAL_ERROR "[link type(${link_type})] must be one of ${CPM_INSTALL_LINK_TYPE}")
	endif (link_type_index EQUAL -1)

	###############################################
	################ ADD LIBRARY ##################
	###############################################
	if (${linked_project}_ADDED)
		message("Successfully added [${linked_project}], the source files path is [${${linked_project}_SOURCE_DIR}], the binary files path is [${${linked_project}_BINARY_DIR}]!")
	else ()
		message("Found the local [${linked_project}] package, the source files path is [${${linked_project}_SOURCE_DIR}], the binary files path is [${${linked_project}_BINARY_DIR}]!")
		# add_subdirectory(
		# 		${${linked_project}_SOURCE_DIR}
		# 		${${linked_project}_BINARY_DIR}
		# 		EXCLUDE_FROM_ALL
		# )
	endif (${linked_project}_ADDED)

	###############################################
	########### CHECK OPTIONAL ARGS ###############
	###############################################
	if (${ARGC} MATCHES 2)
		list(GET ARGN 0 linked_library)
		set(linked_project linked_library)
		message("The library's name [${linked_library}] is different with the project's name [${linked_project}], the library's name will be used as the linked library name!")
	endif (${ARGC} MATCHES 2)

	###############################################
	############### LINK_LIBRARY ##################
	###############################################
	if (link_type_index EQUAL 0)
		# PUBLIC
		message(STATUS "Project [${this_project}] will [PUBLIC] link [${linked_project}].")

		target_include_directories(
				${this_project}
				SYSTEM PUBLIC
				${${linked_project}_SOURCE_DIR}/include
		)
		target_link_libraries(
				${this_project}
				PUBLIC
				${linked_prokect}
		)
	elseif (link_type_index EQUAL 1)
		# PRIVATE
		message(STATUS "Project [${this_project}] will [PRIVATE] link [${linked_project}].")

		target_include_directories(
				${this_project}
				SYSTEM PRIVATE
				${${linked_project}_SOURCE_DIR}/include
		)
		target_link_libraries(
				${this_project}
				PRIVATE
				${linked_prokect}
		)
	elseif (link_type_index EQUAL 2)
		# INTERFACE
		message(STATUS "Project [${this_project}] will [INTERFACE] link [${linked_project}].")

		target_include_directories(
				${this_project}
				SYSTEM INTERFACE
				${${linked_project}_SOURCE_DIR}/include
		)
		target_link_libraries(
				${this_project}
				INTERFACE
				${linked_prokect}
		)
	else ()
		message(FATAL_ERROR "Impossible happened!!!Invalid link type ${link_type}.")
	endif (link_type_index EQUAL 0)
endfunction(cpm_install)
