

#include <cstdlib>
#include <cerrno>

#include <curlpp/cURLpp.hpp>
#include <curlpp/Easy.hpp>
#include <curlpp/Options.hpp>
#include <curlpp/Exception.hpp>

void rhasspy(const char* url, const std::string payload) {
  try {
    curlpp::Cleanup cleaner;
    curlpp::Easy request;

    request.setOpt(new curlpp::options::Url(url)); 
    request.setOpt(new curlpp::options::Verbose(true)); 

    std::list<std::string> header; 
    header.push_back("Content-Type: text/*"); 
    request.setOpt(new curlpp::options::Verbose(true));    
    request.setOpt(new curlpp::options::HttpHeader(header)); 

    //std::string payload = "is the garage door open";
    std::size_t size = payload.size();

    request.setOpt(new curlpp::options::PostFields(payload));
    request.setOpt(new curlpp::options::PostFieldSize(size));

    request.perform();
  }
  catch ( curlpp::LogicError & e ) {
    std::cout << e.what() << std::endl;
  }
  catch ( curlpp::RuntimeError & e ) {
    std::cout << e.what() << std::endl;
  }

}


