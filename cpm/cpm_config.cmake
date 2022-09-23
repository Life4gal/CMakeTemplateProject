set(CPM_USE_LOCAL_PACKAGES ON)

macro(CPM_link_libraries_DECL)
	set(${PROJECT_NAME}_LINK_PUBLIC "")
	set(${PROJECT_NAME}_LINK_PRIVATE "")
	set(${PROJECT_NAME}_LINK_INTERFACE "")
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
		list(APPEND ${PROJECT_NAME}_LINK_PUBLIC ${lib_name})
		message("Project [${PROJECT_NAME}] will [PUBLIC] link [${lib_name}].")
	# PRIVATE
	elseif(append_type_index EQUAL 1)
		list(APPEND ${PROJECT_NAME}_LINK_PRIVATE ${lib_name})
		message("Project [${PROJECT_NAME}] will [PRIVATE] link [${lib_name}].")
	# INTERFACE
	elseif(append_type_index EQUAL 2)
		list(APPEND ${PROJECT_NAME}_LINK_INTERFACE ${lib_name})
		message("Project [${PROJECT_NAME}] will [INTERFACE] link [${lib_name}].")
	else()
		message(FATAL_ERROR "Impossible happened!!!")
	endif(append_type_index EQUAL 0)
endmacro(CPM_link_libraries_APPEND)

macro(CPM_link_libraries_LINK)
	message("The dependencies of project ${PROJECT_NAME} are:
		[PUBLIC:    ${${PROJECT_NAME}_LINK_PUBLIC}]
		[PRIVATE:   ${${PROJECT_NAME}_LINK_PRIVATE}]
		[INTERFACE: ${${PROJECT_NAME}_LINK_INTERFACE}]")

	target_link_libraries(
		${PROJECT_NAME}

		PUBLIC
		${${PROJECT_NAME}_LINK_PUBLIC}

		PRIVATE
		${${PROJECT_NAME}_LINK_PRIVATE}

		INTERFACE
		${${PROJECT_NAME}_LINK_INTERFACE}
	)
endmacro(CPM_link_libraries_LINK)
