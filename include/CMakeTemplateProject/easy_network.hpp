#pragma once

#include <string>
#include <string_view>

namespace ctp
{
	class EasyNetwork
	{
	public:
		[[nodiscard]] static auto https_support_check() -> bool;
	};
}// namespace ctp
