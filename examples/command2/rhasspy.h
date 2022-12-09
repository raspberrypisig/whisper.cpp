#include <SDL.h>
#include <SDL_audio.h>

#include <cassert>
#include <cstdio>
#include <fstream>
#include <mutex>
#include <regex>
#include <string>
#include <thread>
#include <vector>

void rhasspy(const std::string url, const std::string payload);
