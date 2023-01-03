#include <curl/curl.h>

#include <CMakeTemplateProject/easy_network.hpp>

namespace ctp
{
	auto EasyNetwork::https_support_check() -> bool
	{
		const auto *vinfo = curl_version_info(CURLVERSION_NOW);
		if (vinfo->features & CURL_VERSION_SSL)
		{
			return true;
		}
		return false;
	}
}// namespace ctp
