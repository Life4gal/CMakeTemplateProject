#include <fmt/format.h>
#include <spdlog/spdlog.h>

#include <CMakeTemplateProject/hello.hpp>

namespace ctp
{
	auto answer() -> int
	{
		return 42;
	}

	auto log_me() -> void
	{
		SPDLOG_INFO("`{}` called.", __func__);
	}
}// namespace ctp
