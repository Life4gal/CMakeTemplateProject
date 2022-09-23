#include <CMakeTemplateProject/hello.hpp>
#include <spdlog/spdlog.h>
#include <eve/wide.hpp>
#include <eve/module/core.hpp>
#include <eve/module/math.hpp>
#include <iostream>

namespace
{
	eve::wide<float> rho(eve::wide<float> x, eve::wide<float> y)
	{
		return  eve::sqrt(x * x + y * y);
	}

	eve::wide<float> theta(eve::wide<float> x, eve::wide<float> y)
	{
		return eve::atan2(y, x);
	}
}

namespace ctp
{
	auto answer() -> int
	{
		return 42;
	}

	auto log_me() -> void
	{
		spdlog::info("`{}` called.", __func__);
	}

	auto check_wide() -> void
	{
		eve::wide<float> x1{4};
		eve::wide<float> y1{[](auto i, auto ) { return 1.5f*(i+1); }};

		std::cout << x1 << " " << y1 << " => " << rho(x1,y1) << "\n";

		float data[] = {1.5f, 3, 4.5f, 6, 7.5f, 9, 10.5f, 12, 13.5, 15, 16.5, 18, 19.5, 21, 22.5, 24};
		eve::wide<float> y2{&data[0]};

		std::cout << x1 << " " << y2 << " => " << theta(x1,y2) << "\n";
	}
}// namespace ctp
