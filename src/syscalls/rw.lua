local FD = {
    STDIN = 0,
    STDOUT = 1,
    STDERR = 2,
}

-- Make a metatable for the file descriptor type
os.FD = setmetatable(FD, {
    __newindex = function()
        error("Cannot modify FD constant")
    end,
    __metatable = false,
})

-- Backup original io functions
local original_io = {
    write = io.write,
    read = io.read
}

-- Override io functions with gated access
--[[
io.write = function(...)
    local args = {...}
    if os.is_call_from_kernel() then
        -- Access original function if call is from Luix kernel
        return original_io.write(unpack(args))
    else
        -- Convert arguments to syscall format if necessary
        -- Trigger write syscall
        return os.syscall(os.SYSCALL.WRITE, unpack(args))
    end
end

io.read = function(...)
    local args = {...}
    if os.is_call_from_kernel() then
        -- Access original function if call is from Luix kernel
        return original_io.read(unpack(args))
    else
        -- Convert arguments to syscall format if necessary
        -- Trigger read syscall
        return os.syscall(os.SYSCALL.READ, unpack(args))
    end
end
--]]

kernel.read = function(fd, buf, count)
    -- Implement read syscall
end

kernel.write = function(fd, buf, count)
    -- Implement write syscall
end
