kernel.process = {}
kernel.process.__index = {
    -- Define methods to access and modify the process object
    set_value = function(self, name, value)
        if not os.is_call_from_kernel() then
            error("Access denied: Cannot modify process from outside the kernel")
        end
        self[name] = value
    end,
    get_value = function(self, name)
        return self[name]
    end,
}

function kernel.bootstrap_self()
    if not os.is_call_from_kernel() then
        error("Access denied: Cannot bootstrap process from outside the kernel")
    end

    -- Create the "self" process
    local self_process = {
        name = "self",
        pid = 1
    }

    -- Optionally set a metatable for the process object, e.g., for method access
    setmetatable(self_process, kernel.process)

    -- Store the "self" process in the kernel's process table
    kernel.process = self_process  -- Assign self_process directly to kernel.process

    -- Optionally return the "self" process or its identifier
    return self_process
end

-- Bootstrap the "self" process
kernel.bootstrap_self()