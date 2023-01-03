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
		# linked_target = linked_project
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
	# see CPM.cmake --> cpm_export_variables
	if (${linked_project}_ADDED)
		# downloaded
		message(STATUS "Successfully added [${linked_project}], the source files path is [${${linked_project}_SOURCE_DIR}], the binary files path is [${${linked_project}_BINARY_DIR}]!")
		# add_subdirectory(
		# 		${${linked_project}_SOURCE_DIR}
		# 		${${linked_project}_BINARY_DIR}
		# 		EXCLUDE_FROM_ALL
		# )
	else ()
		# todo: https://github.com/cpm-cmake/CPM.cmake/issues/433
		message(FATAL_ERROR "Library [${linked_project}] not found!")
	endif (${linked_project}_ADDED)

	###############################################
	########### CHECK OPTIONAL ARGS ###############
	###############################################
	if (NOT (${ARGC} MATCHES 3))
		list(GET ARGN 0 linked_target)
		message(STATUS "The target's name [${linked_target}] is different with the project's name [${linked_project}], the target's name will be used as the linked library name!")
	else()
		set(linked_target ${linked_project})
	endif (NOT (${ARGC} MATCHES 3))

	###############################################
	############### LINK_LIBRARY ##################
	###############################################
	message(STATUS "Project [${this_project}] will [${link_type}] link [${linked_target}].")
	if (link_type_index EQUAL 0)
		# PUBLIC
#		target_include_directories(
#				${this_project}
#				SYSTEM
#				PUBLIC
#				${${linked_project}_SOURCE_DIR}/include
#		)
		target_link_libraries(
				${this_project}
				PUBLIC
				${linked_target}
		)
	elseif (link_type_index EQUAL 1)
		# PRIVATE
#		target_include_directories(
#				${this_project}
#				SYSTEM
#				PRIVATE
#				${${linked_project}_SOURCE_DIR}/include
#		)
		target_link_libraries(
				${this_project}
				PRIVATE
				${linked_target}
		)
	elseif (link_type_index EQUAL 2)
		# INTERFACE
#		target_include_directories(
#				${this_project}
#				SYSTEM
#				INTERFACE
#				${${linked_project}_SOURCE_DIR}/include
#		)
		target_link_libraries(
				${this_project}
				INTERFACE
				${linked_target}
		)
	else ()
		message(FATAL_ERROR "Impossible happened!!!Invalid link type ${link_type}.")
	endif (link_type_index EQUAL 0)

	# todo: `PUBLIC` and `INTERFACE` items will populate the `INTERFACE_INCLUDE_DIRECTORIES` property of <target>.
	# If a non-PRIVATE directory include will causes vvv
	# Target <target> interface_include_directories property contains path: <dependency header files path> which is prefixed in the build directory.
	target_include_directories(
			${this_project}
			SYSTEM
			PRIVATE
			${${linked_project}_SOURCE_DIR}/include
	)
endfunction(cpm_install)
