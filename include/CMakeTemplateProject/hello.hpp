#pragma once

#include <CMakeTemplateProject/macro.hpp>
#include <cstddef>

namespace ctp
{
	CTP_EXPORTED_SYMBOL auto answer() -> int;

	CTP_EXPORTED_SYMBOL auto log_me() -> void;
}// namespace ctp
