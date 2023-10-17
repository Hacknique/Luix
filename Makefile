LUAEXE=lua
ROCKSPEC=rockspecs/luix-0.0.1-1.rockspec

install:
	luarocks make --local $(ROCKSPEC)

upload-rocks:
	luarocks upload --api-key=$(LUAROCKS_APIKEY) $(ROCKSPEC)

.PHONY: test test-all test-rocks upload-rocks
