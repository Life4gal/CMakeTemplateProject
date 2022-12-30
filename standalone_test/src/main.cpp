#include <CMakeTemplateProject/hello.hpp>
#include <iostream>

auto main() -> int
{
	std::cout << "Hello CMakeTemplateProject!"
			  << "\nCompiler Name: " << CMakeTemplateProject_COMPILER_ID
			  << "\nCompiler Version: " << CMakeTemplateProject_COMPILER_VERSION
			  << "\nCTP Version: " << CMakeTemplateProject_VERSION
			  << "\nAnswer: " << ctp::answer() << '\n'
			  << "\nMD5 of string [\"CMakeTemplateProject\"]: " << ctp::md5("CMakeTemplateProject") << '\n';

	ctp::log_me();
}
