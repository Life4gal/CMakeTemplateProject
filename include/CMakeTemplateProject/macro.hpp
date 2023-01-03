#pragma once

#if defined(CMakeTemplateProject_PLATFORM_WINDOWS)
	#define CTP_UNREACHABLE() __assume(0)
	#define CTP_DEBUG_TRAP() __debugbreak()
	#define CTP_IMPORTED_SYMBOL __declspec(dllimport)
	#define CTP_EXPORTED_SYMBOL __declspec(dllexport)
	#define CTP_LOCAL_SYMBOL

	#define CTP_DISABLE_WARNING_PUSH __pragma(warning(push))
	#define CTP_DISABLE_WARNING_POP __pragma(warning(pop))
	#define CTP_DISABLE_WARNING(warningNumber) __pragma(warning(disable \
																: warningNumber))
#elif defined(CMakeTemplateProject_PLATFORM_LINUX)
	#define CTP_UNREACHABLE() __builtin_unreachable()
	#define CTP_DEBUG_TRAP() __builtin_trap()
	#define CTP_IMPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_EXPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_LOCAL_SYMBOL __attribute__((visibility("hidden")))

	#define CTP_DISABLE_WARNING_PUSH _Pragma("GCC diagnostic push")
	#define CTP_DISABLE_WARNING_POP _Pragma("GCC diagnostic pop")

	#define CTP_PRIVATE_DO_PRAGMA(X) _Pragma(#X)
	#define CTP_DISABLE_WARNING(warningName) CTP_PRIVATE_DO_PRAGMA(GCC diagnostic ignored #warningName)
#elif defined(CMakeTemplateProject_PLATFORM_MACOS)
	// todo: check it!
	#define CTP_UNREACHABLE() __builtin_unreachable()
	#define CTP_DEBUG_TRAP() __builtin_trap()
	#define CTP_IMPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_EXPORTED_SYMBOL __attribute__((visibility("default")))
	#define CTP_LOCAL_SYMBOL __attribute__((visibility("hidden")))

	#define CTP_DISABLE_WARNING_PUSH _Pragma("clang diagnostic push")
	#define CTP_DISABLE_WARNING_POP _Pragma("clang diagnostic pop")

	#define CTP_PRIVATE_DO_PRAGMA(X) _Pragma(#X)
	#define CTP_DISABLE_WARNING(warningName) CTP_PRIVATE_DO_PRAGMA(clang diagnostic ignored #warningName)
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
