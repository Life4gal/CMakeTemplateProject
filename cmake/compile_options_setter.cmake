#set(GSL_MSVC_BASIC_COMPILE_OPTIONS /std:c++latest
#		#/experimental:module
#		/W4 /WX)
#set(GSL_MSVC_EXTRA_COMPILE_OPTIONS_Debug /MDd /Zi /Ob0 /Od /RTC1)
#set(GSL_MSVC_EXTRA_COMPILE_OPTIONS_Release /DNDEBUG /MD /O2 /Ob2)
#set(GSL_MSVC_EXTRA_COMPILE_OPTIONS_RelWithDebInfo /DNDEBUG /MD /Zi /O2 /Ob1)
#set(GSL_MSVC_EXTRA_COMPILE_OPTIONS_MinSizeRel /DNDEBUG /MD /O1 /Ob1)
#
#set(GSL_GNU_BASIC_COMPILE_OPTIONS -std=c++2b -Wall -Wextra -Wpedantic -Werror)
#set(GSL_GNU_EXTRA_COMPILE_OPTIONS_Debug -O0 -g)
#set(GSL_GNU_EXTRA_COMPILE_OPTIONS_Release -DNDEBUG -O3)
#set(GSL_GNU_EXTRA_COMPILE_OPTIONS_RelWithDebInfo -DNDEBUG -O2 -g)
#set(GSL_GNU_EXTRA_COMPILE_OPTIONS_MinSizeRel -DNDEBUG -Os)
#
#set(GSL_CLANG_CL_BASIC_COMPILE_OPTIONS /std:c++latest /W4 /WX)
#set(GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Debug /MDd /Zi /Ob0 /Od)
#set(GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Release /DNDEBUG /MD /O2 /Ob2)
#set(GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_RelWithDebInfo /DNDEBUG /MD /Zi /O2 /Ob1)
#set(GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_MinSizeRel /DNDEBUG /MD /O1 /Ob1)
#
#set(GSL_CLANG_BASIC_COMPILE_OPTIONS -std=c++2b -Wall -Wextra -Wpedantic -Werror)
#set(GSL_CLANG_EXTRA_COMPILE_OPTIONS_Debug -O0 -g)
#set(GSL_CLANG_EXTRA_COMPILE_OPTIONS_Release -DNDEBUG -O3)
#set(GSL_CLANG_EXTRA_COMPILE_OPTIONS_RelWithDebInfo -DNDEBUG -O2 -g)
#set(GSL_CLANG_EXTRA_COMPILE_OPTIONS_MinSizeRel -DNDEBUG -Os)
#
#macro(set_compile_options_private target_name)
#	message("Setting compile parameters for project ${target_name}...")
#	target_compile_options(
#		${target_name}
#		PRIVATE
#
#		### basic flag
#		$<$<CXX_COMPILER_ID:MSVC>:${GSL_MSVC_BASIC_COMPILE_OPTIONS}>
#		$<$<CXX_COMPILER_ID:GNU>:${GSL_GNU_BASIC_COMPILE_OPTIONS}>
#		# clang-cl
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>:${GSL_CLANG_CL_BASIC_COMPILE_OPTIONS}>
#		# clang
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_BASIC_COMPILE_OPTIONS}>
#		### basic flag end
#
#		### extra flag
#
#		# build type ==> Debug
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Debug}>
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Debug}>
#
#		# build type ==> Release
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Release}>
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Release}>
#
#		# build type ==> RelWithDebInfo
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang-cl
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#
#		# build type ==> MinSizeRel
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang-cl
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		### extra flag end
#	)
#endmacro()
#
#macro(set_compile_options_public target_name)
#	message("Setting compile parameters for project ${target_name}...")
#	target_compile_options(
#		${target_name}
#		PUBLIC
#
#		### basic flag
#		$<$<CXX_COMPILER_ID:MSVC>:${GSL_MSVC_BASIC_COMPILE_OPTIONS}>
#		$<$<CXX_COMPILER_ID:GNU>:${GSL_GNU_BASIC_COMPILE_OPTIONS}>
#		# clang-cl
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>:${GSL_CLANG_CL_BASIC_COMPILE_OPTIONS}>
#		# clang
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_BASIC_COMPILE_OPTIONS}>
#		### basic flag end
#
#		### extra flag
#
#		# build type ==> Debug
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Debug}>
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Debug}>
#
#		# build type ==> Release
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Release}>
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Release}>
#
#		# build type ==> RelWithDebInfo
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang-cl
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#
#		# build type ==> MinSizeRel
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang-cl
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		### extra flag end
#	)
#endmacro()
#
#macro(set_compile_options_interface target_name)
#	message("Setting compile parameters for project ${target_name}...")
#	target_compile_options(
#		${target_name}
#		INTERFACE
#
#		### basic flag
#		$<$<CXX_COMPILER_ID:MSVC>:${GSL_MSVC_BASIC_COMPILE_OPTIONS}>
#		$<$<CXX_COMPILER_ID:GNU>:${GSL_GNU_BASIC_COMPILE_OPTIONS}>
#		# clang-cl
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>:${GSL_CLANG_CL_BASIC_COMPILE_OPTIONS}>
#		# clang
#		$<$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_BASIC_COMPILE_OPTIONS}>
#		### basic flag end
#
#		### extra flag
#
#		# build type ==> Debug
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Debug}>
#		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Debug}>
#		# clang
#		$<$<AND:$<CONFIG:Debug>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Debug}>
#
#		# build type ==> Release
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_Release}>
#		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang-cl
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_Release}>
#		# clang
#		$<$<AND:$<CONFIG:Release>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_Release}>
#
#		# build type ==> RelWithDebInfo
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang-cl
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#		# clang
#		$<$<AND:$<CONFIG:RelWithDebInfo>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_RelWithDebInfo}>
#
#		# build type ==> MinSizeRel
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:MSVC>>:${GSL_MSVC_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		$<$<AND:$<CONFIG:MinSizeRel>,$<CXX_COMPILER_ID:GNU>>:${GSL_GNU_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang-cl
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>:${GSL_CLANG_CL_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		# clang
#		$<$<AND:$<CONFIG:MinSizeRel>,$<AND:$<CXX_COMPILER_ID:Clang>,$<NOT:$<STREQUAL:"${CMAKE_CXX_SIMULATE_ID}","MSVC">>>>:${GSL_CLANG_EXTRA_COMPILE_OPTIONS_MinSizeRel}>
#		### extra flag end
#	)
#endmacro()
function(set_compile_property target_name)
	set_target_properties(
			${target_name}
			PROPERTIES
			CXX_STANDARD 20
			CXX_STANDARD_REQUIRED TRUE
	)

	if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
		set_target_properties(
				${target_name}
				PROPERTIES
				COMPILE_OPTIONS "/W4;/WX;/D_CRT_SECURE_NO_WARNINGS"
		)
	elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		set_target_properties(
				${target_name}
				PROPERTIES
				COMPILE_OPTIONS "-Wall;-Wextra;-Wpedantic;-Werror"
		)
	elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		if ("${CMAKE_CXX_SIMULATE_ID}" STREQUAL "MSVC")
			# clang-cl
			# todo: It looks like the above command passes -std=c++20 to clang-cl (instead of /std:c++latest)
			set_target_properties(
					${target_name}
					PROPERTIES
					COMPILE_OPTIONS "/W4;/WX;/D_CRT_SECURE_NO_WARNINGS;/std:c++latest"
			)
		else ()
			# clang
			set_target_properties(
					${target_name}
					PROPERTIES
					COMPILE_OPTIONS "-Wall;-Wextra;-Wpedantic;-Werror"
			)
		endif ()
	elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
		set_target_properties(
				${target_name}
				PROPERTIES
				COMPILE_OPTIONS "-Wall;-Wextra;-Wpedantic;-Werror"
		)
	else ()
		message(FATAL_ERROR "Unknown Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
	endif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
endfunction(set_compile_property)
