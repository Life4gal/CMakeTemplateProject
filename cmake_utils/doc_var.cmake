include(CMakeParseArguments)

# Sets a cache variable with a docstring joined from multiple arguments:
#   set(<variable> <value>... CACHE <type> <docstring>...)
# This allows splitting a long docstring for readability.
function(
		doc_var
		variable_name
		variable_value
		variable_type
		# docstring...
)
	# Joins arguments and places the results in ${result_var}.
	function(
			join
			result_var
			# args...
	)
		set(result "")
		foreach (arg ${ARGN})
			set(result "${result}${arg}")
		endforeach ()
		set(${result_var} "${result}" PARENT_SCOPE)
	endfunction()

	# list(GET ARGN 0 variable_name)
	# list(REMOVE_AT ARGN 0)
	# list(GET ARGN 0 variable_value)
	# list(REMOVE_AT ARGN 0)
	# # CACHE
	# list(REMOVE_AT ARGN 0)
	# list(GET ARGN 0 variable_type)
	# list(REMOVE_AT ARGN 0)

	join(doc ${ARGN})

	set(${variable_name} ${variable_value} CACHE ${variable_type} ${doc})
endfunction()
