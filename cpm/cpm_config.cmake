set(CPM_USE_LOCAL_PACKAGES ON)

macro(CPM_link_libraries_DECL)
	set(extra_args ${ARGN})
	# Currently we have only one optional parameter: prefix.
	list(LENGTH extra_args extra_args_count)

	set(CPM_LINK_TARGET_PREFIX "CPM_COMMON_LINK_TARGET")
	if(${extra_args_count} EQUAL 1)
		set(CPM_LINK_TARGET_PREFIX ${extra_args})
	elseif(${extra_args_count} GREATER 1)
		message(WARNING "Currently we have only one optional parameter: prefix.")
	endif(${extra_args_count} EQUAL 1)

	set(${CPM_LINK_TARGET_PREFIX}_HEADER_PUBLIC)
	set(${CPM_LINK_TARGET_PREFIX}_HEADER_PRIVATE)
	set(${CPM_LINK_TARGET_PREFIX}_HEADER_INTERFACE)
	set(${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC)
	set(${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE)
	set(${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE)
endmacro(CPM_link_libraries_DECL)

set(CPM_link_libraries_LINK_TYPE PUBLIC PRIVATE INTERFACE)

# CPM_link_libraries_APPEND(library_name, link_type[, library_header_only])
macro(CPM_link_libraries_APPEND lib_name link_type)

	###############################################
	########### CHECK OPTIONAL ARGS ###############
	###############################################
	set(append_extra_args ${ARGN})
	# Currently we have only one optional parameter: header_only.
	list(LENGTH append_extra_args append_extra_args_count)

	set(append_header_only 0)
	if(${append_extra_args_count} EQUAL 1)
		set(append_header_only 1)
	elseif(${append_extra_args_count} GREATER 1)
		message(WARNING "Currently we have only one optional parameter: header_only.")
	endif(${append_extra_args_count} EQUAL 1)

	###############################################
	############# CHECK LINK TYPE #################
	###############################################
	list(FIND CPM_link_libraries_LINK_TYPE ${link_type} append_type_index)
	if(append_type_index EQUAL -1)
		message(FATAL_ERROR "[link type(${link_type})] must be one of ${CPM_link_libraries_LINK_TYPE}")
	endif(append_type_index EQUAL -1)

	###############################################
	################ ADD LIBRARY ##################
	###############################################
	if(${lib_name}_ADDED)
		message("Successfully added [${lib_name}], the source files path is [${${lib_name}_SOURCE_DIR}], the binary files path is [${${lib_name}_BINARY_DIR}]!")
		# header_only
		if(${append_header_only})
			message("Since [${lib_name}] is [header_only], a interface target will generated for it, the included headers' path is [${${lib_name}_SOURCE_DIR}/include].")
			add_library(${lib_name} INTERFACE IMPORTED GLOBAL)
			target_include_directories(${lib_name} INTERFACE ${${lib_name}_SOURCE_DIR}/include)
		endif(${append_header_only})
	else()
		message("Found the local [${lib_name}] package, the source files path is [${${lib_name}_SOURCE_DIR}], the binary files path is [${${lib_name}_BINARY_DIR}]!")
		add_subdirectory(
				${${lib_name}_SOURCE_DIR}
				${${lib_name}_BINARY_DIR}
				EXCLUDE_FROM_ALL
		)
	endif(${lib_name}_ADDED)

	###############################################
	############### LINK_LIBRARY ##################
	###############################################
	# PUBLIC
	if(append_type_index EQUAL 0)
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC ${lib_name})
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_HEADER_PUBLIC ${${lib_name}_SOURCE_DIR}/include)
	# PRIVATE
	elseif(append_type_index EQUAL 1)
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE ${lib_name})
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_HEADER_PRIVATE ${${lib_name}_SOURCE_DIR}/include)
	# INTERFACE
	elseif(append_type_index EQUAL 2)
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE ${lib_name})
		list(APPEND ${CPM_LINK_TARGET_PREFIX}_HEADER_INTERFACE ${${lib_name}_SOURCE_DIR}/include)
	else()
		message(FATAL_ERROR "Impossible happened!!!")
	endif(append_type_index EQUAL 0)
endmacro(CPM_link_libraries_APPEND)

macro(CPM_link_libraries_LINK project_name)
	set(extra_args ${ARGN})
	# Currently we have only one optional parameter: prefix.
	list(LENGTH extra_args extra_args_count)

	set(CPM_LINK_TARGET_PREFIX "CPM_COMMON_LINK_TARGET")
	if(${extra_args_count} EQUAL 1)
		set(CPM_LINK_TARGET_PREFIX ${extra_args})
	elseif(${extra_args_count} GREATER 1)
		message(WARNING "Currently we have only one optional parameter: prefix.")
	endif(${extra_args_count} EQUAL 1)

	foreach(public_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC)
		message(VERBOSE "Project [${project_name}] will [PUBLIC] link [${public_library}].")
	endforeach(public_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC)
	foreach(public_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_PUBLIC)
		message(VERBOSE "Project [${project_name}] will [PUBLIC] include [${public_header}].")
	endforeach(public_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_PUBLIC)

	foreach(private_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE)
		message(VERBOSE "Project [${project_name}] will [PRIVATE] link [${private_library}].")
	endforeach(private_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE)
	foreach(private_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_PRIVATE)
		message(VERBOSE "Project [${project_name}] will [PRIVATE] include [${private_header}].")
	endforeach(private_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_PRIVATE)

	foreach(interface_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE)
		message(VERBOSE "Project [${project_name}] will [INTERFACE] link [${interface_library}].")
	endforeach(interface_library IN LISTS ${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE)
	foreach(interface_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_INTERFACE)
		message(VERBOSE "Project [${project_name}] will [INTERFACE] include [${interface_header}].")
	endforeach(interface_header IN LISTS ${CPM_LINK_TARGET_PREFIX}_HEADER_INTERFACE)

	message("The dependencies of project ${project_name} are:
	[PUBLIC:    ${${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC}]
	[PRIVATE:   ${${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE}]
	[INTERFACE: ${${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE}]")

	target_link_libraries(
		${project_name}

		PUBLIC
		${${CPM_LINK_TARGET_PREFIX}_LINK_PUBLIC}

		PRIVATE
		${${CPM_LINK_TARGET_PREFIX}_LINK_PRIVATE}

		INTERFACE
		${${CPM_LINK_TARGET_PREFIX}_LINK_INTERFACE}
	)

	target_include_directories(
		${project_name}

		PUBLIC
		${${CPM_LINK_TARGET_PREFIX}_HEADER_PUBLIC}

		PRIVATE
		${${CPM_LINK_TARGET_PREFIX}_HEADER_PRIVATE}

		INTERFACE
		${${CPM_LINK_TARGET_PREFIX}_HEADER_INTERFACE}
	)
endmacro(CPM_link_libraries_LINK)
