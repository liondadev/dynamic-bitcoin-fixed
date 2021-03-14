/*
    Dynamic Bitcoins is really cool you should use it forever
    just saying, it really is

    I might make a full bitminer addon later, but idk lmao
*/

net.Receive("DynamicBitcoin:UpdatePrice", function()
    -- NOTE(Livaco): This won't be negative. Why use a signed int?
    local pr = net.ReadUInt(32)
    if (!pr) then
        MsgC(dynamicbitcoin.theme["chat_prefix"], "[Dynamic Bitcoin] ", dynamicbitcoin.theme["chat_msg"], "Failed to get networked bitcoin price: ", dynamicbitcoin.theme["chat_error"], "Price not networked!" .. "\n")
        return
    end

    dynamicbitcoin.currentPrice = pr
end)

hook.Add("OnPlayerChat", "DynamicBitcoin:ChatCMD", function(ply, text)
    if (ply != LocalPlayer()) then return end

    text = string.lower(text)

    if (text == dynamicbitcoin.cmd) then
        chat.AddText(dynamicbitcoin.theme["chat_msg"], "Current Bitcoin Price: ", dynamicbitcoin.theme["chat_error"], tostring(DarkRP.formatMoney(dynamicbitcoin.currentPrice)))

        -- NOTE(Livaco): Thought you returned "" for this?
        return true // Fuck the message
    end
end)