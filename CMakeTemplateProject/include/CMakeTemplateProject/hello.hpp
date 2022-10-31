#pragma once

#include <cstddef>

namespace ctp
{
	auto answer() -> int;

	auto log_me() -> void;

	auto check_wide() -> void;

	auto allocate(std::size_t size) -> void*;
}
