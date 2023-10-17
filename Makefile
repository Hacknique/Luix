LUAEXE=lua
ROCKSPEC=rockspecs/lunix-0.0.1-1.rockspec

install:
	luarocks make --lua-version=5.1 --local $(ROCKSPEC)

upload-rocks:
	luarocks upload --api-key=$(LUAROCKS_APIKEY) $(ROCKSPEC)

.PHONY: test test-all test-rocks upload-rocks
