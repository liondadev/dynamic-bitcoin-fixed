util.AddNetworkString("DynamicBitcoin:UpdatePrice") // Network string poggers

// Networking function
dynamicbitcoin.networkPriceChange = function()
    net.Start("DynamicBitcoin:UpdatePrice")
    net.WriteUInt(dynamicbitcoin.currentPrice, 32) -- NOTE(Livaco): This won't be negative. Why use a signed int?
    net.Broadcast()
end

dynamicbitcoin.updatePrice = function()
    // Send a request to update the bitcoin price
    -- NOTE(Livaco): HTTP function to do this is weird, but okay.
    HTTP({
        failed = function(rea)
            // Fuck, looks like we failed!
            // Might as well alert the server owner that somthing fucked up
            MsgC(dynamicbitcoin.theme["chat_prefix"], "[Dynamic Bitcoin] ", dynamicbitcoin.theme["chat_msg"], "Failed to get bitcoin price: ", dynamicbitcoin.theme["chat_error"], rea .. "\n")
        end,
        success = function(_, body)
            if (!body) then return end // For some reason I decide to check if body exists, even though it always should

            // JSONify
            local tbl = util.JSONToTable(body)
            if (!tbl) then return end

            // Manipulate Variables
            dynamicbitcoin.currentPrice = tbl.last_trade_price / dynamicbitcoin.devide

            dynamicbitcoin.updateFunc(dynamicbitcoin.currentPrice) // Call function from the config

            if (SERVER) then
                dynamicbitcoin.networkPriceChange()
            end
        end,
        method = "GET", // We need to GET it, haha funny joke ;)
        url = dynamicbitcoin.apiURL, // That joke wasnt very funny
    })
end

// Litterally a fucking timer
timer.Create("DynamicBitcoin:Update", dynamicbitcoin.apiDelay, 0, function()
    dynamicbitcoin.updatePrice()
end)

// Concommand
concommand.Add("dynamicbitcoin_update", function(ply)
    if (IsValid(ply)) then return end
    dynamicbitcoin.updatePrice()
end)