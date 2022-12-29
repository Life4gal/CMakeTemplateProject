#include <CMakeTemplateProject/hello.hpp>
#include <iostream>
#include <span>

auto main() -> int
{
	std::cout << "Hello CMakeTemplateProject!"
			  << "\nCompiler Name: " << CMakeTemplateProject_COMPILER_ID
			  << "\nCompiler Version: " << CMakeTemplateProject_COMPILER_VERSION
			  << "\nCTP Version: " << CMakeTemplateProject_VERSION
			  << "\nAnswer: " << ctp::answer() << '\n';

	ctp::log_me();
}
