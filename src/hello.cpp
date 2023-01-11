#include <openssl/evp.h>
#include <spdlog/spdlog.h>
#define STB_IMAGE_IMPLEMENTATION
#include <fontconfig/fontconfig.h>
#include <freetype/freetype.h>
#include <stb/stb_image.h>

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

	auto md5(const std::string_view string) -> std::string
	{
		// MD5_Init
		auto* md5_context = EVP_MD_CTX_new();
		EVP_DigestInit_ex(md5_context, EVP_md5(), nullptr);

		// MD5_Update
		EVP_DigestUpdate(md5_context, string.data(), string.size());

		// MD5_Final
		auto  md5_digest_len = static_cast<unsigned int>(EVP_MD_size(EVP_md5()));
		auto* md5_digest	 = static_cast<unsigned char*>(OPENSSL_malloc(md5_digest_len));
		EVP_DigestFinal_ex(md5_context, md5_digest, &md5_digest_len);

		// write result
		std::string ret{};
		ret.resize(static_cast<std::string::size_type>(md5_digest_len) * 2);
		for (decltype(md5_digest_len) i = 0; i < md5_digest_len; ++i)
		{
			sprintf(ret.data() + i * 2, "%02x", md5_digest[i]);
		}

		EVP_MD_CTX_free(md5_context);
		OPENSSL_free(md5_digest);

		return ret;
	}

	auto load_image(std::string_view filename, int* x, int* y, int* channels, int desired_channels) -> std::uint8_t*
	{
		return stbi_load(filename.data(), x, y, channels, desired_channels);
	}

	auto free_image(std::uint8_t* image) -> void
	{
		stbi_image_free(image);
	}

	auto fontconfig_version() -> int
	{
		return FcGetVersion();
	}
}// namespace ctp
