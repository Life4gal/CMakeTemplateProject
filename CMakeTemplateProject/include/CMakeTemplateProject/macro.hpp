#pragma once

#if defined(CMakeTemplateProject_COMPILER_MSVC) || defined(_MSC_VER)
	#define CTP_UNREACHABLE() __assume(0)
	#define CTP_DEBUG_TRAP() __debugbreak()
	#define CTP_IMPORTED_SYMBOL __declspec(dllimport)
	#define CTP_EXPORTED_SYMBOL __declspec(dllexport)
	#define CTP_LOCAL_SYMBOL

	#define CTP_DISABLE_WARNING_PUSH __pragma(warning(push))
	#define CTP_DISABLE_WARNING_POP __pragma(warning(pop))
	#define CTP_DISABLE_WARNING(warningNumber) __pragma(warning(disable \
																: warningNumber))
#elif defined(CMakeTemplateProject_COMPILER_GNU) || defined(CMakeTemplateProject_COMPILER_CLANG) || defined(__GNUC__) || defined(__clang__)
	#define CTP_UNREACHABLE() __builtin_unreachable()
	#define CTP_DEBUG_TRAP() __builtin_trap()
	#define CTP_IMPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_EXPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_LOCAL_SYMBOL __attribute__((visibility("hidden")))

	#define CTP_DISABLE_WARNING_PUSH _Pragma("GCC diagnostic push")
	#define CTP_DISABLE_WARNING_POP _Pragma("GCC diagnostic pop")

	#define CTP_PRIVATE_DO_PRAGMA(X) _Pragma(#X)
	#define CTP_DISABLE_WARNING(warningName) CTP_PRIVATE_DO_PRAGMA(GCC diagnostic ignored #warningName)
#else
	#define CTP_UNREACHABLE()
	#define CTP_DEBUG_TRAP()
	#define CTP_IMPORTED_SYMBOL
	#define CTP_EXPORTED_SYMBOL
	#define CTP_LOCAL_SYMBOL

	#define CTP_DISABLE_WARNING_PUSH
	#define CTP_DISABLE_WARNING_POP
	#define CTP_DISABLE_WARNING(warningName)
#endif
