#pragma once

#include <CMakeTemplateProject/macro.hpp>
#include <string>
#include <string_view>

namespace ctp
{
	class CTP_EXPORTED_SYMBOL EasyNetwork
	{
	public:
		[[nodiscard]] static auto https_support_check() -> bool;
	};
}// namespace ctp
