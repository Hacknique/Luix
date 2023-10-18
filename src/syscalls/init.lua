dofile("./src/syscalls/process.lua")
dofile("./src/syscalls/rw.lua")

-- Define syscall numbers
local SYSCALL = {
    READ = 0,
    WRITE = 1,
}

-- Use Metatable to make a gobal public SYSCALL constant that wount change or be modified
os.SYSCALL = setmetatable(SYSCALL, {
    __newindex = function()
        error("Cannot modify SYSCALL constant")
    end,
    __metatable = false,
})

-- Syscall handler functions
local syscall_handlers = {
    [SYSCALL.READ] = function(fd, buf, count)
        kernel.read(fd, buf, count)
    end,
    [SYSCALL.WRITE] = function(fd, buf, count)
        kernel.write(fd, buf, count)
    end,
}

-- Function to perform a syscall
function os.syscall(num, ...)
    local handler = syscall_handlers[num]
    if handler then
        return handler(...)
    else
        error("Unknown syscall number: " .. num)
    end
end
