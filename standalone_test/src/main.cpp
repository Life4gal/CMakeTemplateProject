#include <CMakeTemplateProject/hello.hpp>
#include <iostream>

auto main() -> int
{
	std::cout << "Hello CMakeTemplateProject!"
		<< "\nCompiler Name: " << CMakeTemplateProject_COMPILER_NAME
		<< "\nCompiler Version: " << CMakeTemplateProject_COMPILER_VERSION
		<< "\nCTP Version: " << CMakeTemplateProject_VERSION
		<< "\nAnswer: " << ctp::answer() << '\n';

	ctp::log_me();
	ctp::check_wide();
}
