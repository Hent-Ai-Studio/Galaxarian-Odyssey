local LEADERBOARD_NET_REFERENCE = script:GetCustomProperty("LEADERBOARD_NET_REFERENCE")
local CONCURRENT_SHARED_STORAGE_KEY = script:GetCustomProperty("CONCURRENT_SHARED_STORAGE_KEY")


function PrintAllLeaderboardEntries()

    

    local leaderboardEntries = Leaderboards.GetLeaderboard(LEADERBOARD_NET_REFERENCE, LeaderboardType.WEEKLY)

    print("---- BEGIN PRINTING ".. #leaderboardEntries.." ENTRIES ----")

    for index, entry in ipairs(leaderboardEntries) do

        --retrieve the preferred wallet address of the player using the player id saved in the leaderboard entry
        local playerData = Storage.GetConcurrentSharedPlayerData(CONCURRENT_SHARED_STORAGE_KEY, entry.id)
        local walletAddress = playerData.preferredWalletAddress or "none"

        --print everything related to that leaderboard entry
        print("Number: "..index.." |Player Name: "..entry.name.." |Player ID: "..entry.id.." |Score: "..tostring(entry.score).." |Player Preferred Wallet Address: "..walletAddress)

    end

    print("---- END ----")

end

--init
while not Leaderboards.HasLeaderboards() do
    Task.Wait()
end

PrintAllLeaderboardEntries()