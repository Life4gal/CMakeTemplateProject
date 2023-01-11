#pragma once

#include <CMakeTemplateProject/macro.hpp>
#include <cstddef>
#include <string>
#include <string_view>

namespace ctp
{
	CTP_EXPORTED_SYMBOL auto answer() -> int;

	CTP_EXPORTED_SYMBOL auto log_me() -> void;

	CTP_EXPORTED_SYMBOL auto md5(std::string_view string) -> std::string;

	CTP_EXPORTED_SYMBOL auto load_image(std::string_view filename, int* x, int* y, int* channels, int desired_channels = 4) -> std::uint8_t*;
	CTP_EXPORTED_SYMBOL auto free_image(std::uint8_t* image) -> void;

	CTP_EXPORTED_SYMBOL auto fontconfig_version() -> int;
}// namespace ctp
