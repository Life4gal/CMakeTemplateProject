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
}// namespace ctp
