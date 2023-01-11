#include <CMakeTemplateProject/easy_network.hpp>
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

	std::cout << std::boolalpha << ctp::EasyNetwork::https_support_check() << '\n';

	{
		int	  x{-1};
		int	  y{-1};
		int	  channels{-1};
		auto* data = ctp::load_image(TEST_PNG_FILE_PATH, &x, &y, &channels);
		std::cout
				<< "test.png: \n"
				<< "\tdata: " << static_cast<void*>(data) << '\n'
				<< "\tx: " << x << '\n'
				<< "\ty: " << y << '\n'
				<< "\tchannels: " << channels << '\n';
		ctp::free_image(data);
	}

	{
		std::cout << "fontconfig version: " << ctp::fontconfig_version() << '\n';
	}
}
