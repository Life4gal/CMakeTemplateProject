#pragma once

#include <CMakeTemplateProject/macro.hpp>
#include <cstddef>

namespace ctp
{
	CTP_EXPORTED_SYMBOL auto answer() -> int;

	CTP_EXPORTED_SYMBOL auto log_me() -> void;

	CTP_EXPORTED_SYMBOL auto check_wide() -> void;

	CTP_EXPORTED_SYMBOL auto allocate(std::size_t size) -> void*;
}// namespace ctp
