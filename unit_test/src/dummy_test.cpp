#include <boost/ut.hpp>
#include <tuple>

using namespace boost::ut;

namespace
{
	suite test_parameterized = []
	{
		for (auto i: std::vector{1, 2, 3})
		{
			test("parameterized " + std::to_string(i)) = [i]
			{
				expect(that % i > 0);
			};
		}
	};

	suite test_args_and_types = []
	{
		"args"_test = [](auto arg)
		{
			expect(arg >= 1_i);
		} | std::vector{1, 2, 3};

		"types"_test = []<typename T>
		{
			expect(std::is_integral_v<T>) << "all types are integrals";
		} | std::tuple<bool, int>{};

		"args and types"_test = []<typename T>(T arg)
		{
			expect(std::is_integral_v<T> >> fatal);
			// todo: ambiguous?
			// expect(42_i == arg or "is true"_b == arg);
			expect(type<T> == type<int> or type<T> == type<bool>);
			if constexpr (type<T> == type<int>)
			{
				expect(42_i == arg);
			}
			else
			{
				expect("is true"_b == arg);
			}
		} | std::tuple{true, 42};
	};
}
