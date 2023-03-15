print("Loading net_capture...")

local shouldCapture = false
local capturedMessages = {}
local original_net_receivers = {}

local function capture_net_message(name, original_function)
    net.Receive(name, function(len)
        if shouldCapture then
            capturedMessages[name] = capturedMessages[name] or {size = 0, count = 0}
            capturedMessages[name].size = capturedMessages[name].size + len
            capturedMessages[name].count = capturedMessages[name].count + 1
        end

        if original_function then
            original_function(len)
        end
    end)
end

local function override_net_receivers()
    for name, original_function in pairs(net.Receivers) do
        original_net_receivers[name] = original_function
        capture_net_message(name, original_function)
    end
end

local function restore_net_receivers()
    for name, original_function in pairs(original_net_receivers) do
        net.Receivers[name] = original_function
    end
end

local function print_captured_messages()
    local sortedMessages = {}
    for name, data in pairs(capturedMessages) do
        table.insert(sortedMessages, {name = name, size = data.size, count = data.count})
    end

    table.sort(sortedMessages, function(a, b) return a.size > b.size end)

    print("\nCaptured network messages:")
    for _, message in ipairs(sortedMessages) do
        print(string.format("%s | Size: %d bytes | Count: %d", message.name, message.size, message.count))
    end

    local fileName = "net_capture_".. os.date("%Y-%m-%d_%H-%M-%S") .. ".json"

    file.Write(fileName, util.TableToJSON(sortedMessages, true))

    print("\nSaved captured network messages to " .. fileName)
end

local function checkAdmin(ply)
    if ply:IsAdmin() then
        return true
    else
        ply:ChatPrint("You must be an admin to use this command.")
        return false
    end
end

concommand.Add("net_capture_start", function(ply)
    if not IsValid(ply) or checkAdmin(ply) then
        shouldCapture = true
        capturedMessages = {}
        override_net_receivers()
        print("Network message capturing started.")
        timer.Create("net_capture_status", 1, 0, function()
            print("Capturing network messages... (type net_capture_stop to stop capturing)")
        end)
    end
end)

concommand.Add("net_capture_stop", function(ply)
    if not IsValid(ply) or checkAdmin(ply) then
        shouldCapture = false
        restore_net_receivers()
        print("Network message capturing stopped.")
        print_captured_messages()
        timer.Remove("net_capture_status")
    end
end)


print("Loaded net_capture. Type net_capture_start and net_capture_stop in console to start and stop capturing network messages.")