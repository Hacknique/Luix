-- Create a function to check if the call is from the Luix kernel
function os.is_call_from_kernel()
    local info = debug.getinfo(3, "S")  -- Adjust the level as necessary
    -- Check if the path contains the /src/ directory
    return string.find(info.source, "^@?%.%./src/") ~= nil
end
