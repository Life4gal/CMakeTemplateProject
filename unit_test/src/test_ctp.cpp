#include <CMakeTemplateProject/hello.hpp>
#include <boost/ut.hpp>

//CTP_DISABLE_WARNING_PUSH
//CTP_DISABLE_WARNING(-Wswitch-enum)

// :(
#include <fmt/format.h>

//CTP_DISABLE_WARNING_POP

using namespace boost::ut;

namespace
{
	suite answer_test = []{
		expect(type<decltype(ctp::answer())> == type<int>) << fmt::format("Expected type of answer is `{}`, but actually `{}`.", reflection::type_name<int>(), reflection::type_name<decltype(ctp::answer())>());
		expect(ctp::answer() == 42_i) << "No! The answer should be 42!";
	};
}
