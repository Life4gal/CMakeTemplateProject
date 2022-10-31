#include <CMakeTemplateProject/hello.hpp>
#include <iostream>
#include <span>

auto main() -> int
{
	std::cout << "Hello CMakeTemplateProject!"
		<< "\nCompiler Name: " << CMakeTemplateProject_COMPILER_NAME
		<< "\nCompiler Version: " << CMakeTemplateProject_COMPILER_VERSION
		<< "\nCTP Version: " << CMakeTemplateProject_VERSION
		<< "\nAnswer: " << ctp::answer() << '\n';

	ctp::log_me();
	ctp::check_wide();

	auto *arr = static_cast<int *>(ctp::allocate(24 * sizeof(int)));

	for (size_t i = 0; i < 24; ++i) {
		arr[i] = int(i * 42);
	}

	for (const auto i : std::span{ arr, 24 }) {
		std::cout << i << '\t';
	}
}
