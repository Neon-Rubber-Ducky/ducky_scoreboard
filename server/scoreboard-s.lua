local playerCount = 0
local PlayerJobTable = {}
local JobCount = {}

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local job = xPlayer.job.name
    playerCount = playerCount + 1

    if Config.Jobs[job] then
        JobCount[job] = JobCount[job] + 1
        PlayerJobTable[playerId] = job
        TriggerClientEvent('ducky_scoreboard:updateTable', -1, playerCount, job, JobCount[job])
        return
    end

    TriggerClientEvent('ducky_scoreboard:updateTable', -1, playerCount)
end)

AddEventHandler('esx:setJob', function(playerId, job)

    if PlayerJobTable[playerId] then
        JobCount[PlayerJobTable[playerId]] = JobCount[PlayerJobTable[playerId]] - 1
        TriggerClientEvent('ducky_scoreboard:updateTable', -1, playerCount, PlayerJobTable[playerId], JobCount[PlayerJobTable[playerId]])
        PlayerJobTable[playerId] = nil
    end

    if Config.Jobs[job.name] then
        JobCount[job.name] = JobCount[job.name] + 1
        PlayerJobTable[playerId] = job.name
        TriggerClientEvent("ducky_scoreboard:updateTable", -1, playerCount, job.name, JobCount[job.name])
    end
end)


AddEventHandler('esx:playerDropped', function(playerId)
    playerCount = playerCount - 1

    -- Update Job Count
    local job = PlayerJobTable[playerId]
    if job then
        JobCount[job] = JobCount[job] - 1
        TriggerClientEvent("ducky_scoreboard:updateTable", -1, playerCount, job, JobCount[job])
        PlayerJobTable[playerId] = nil
        return
    end

    TriggerClientEvent("ducky_scoreboard:updateTable", -1, playerCount)
    PlayerJobTable[playerId] = nil
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    
    for job,_ in pairs(Config.Jobs) do
        JobCount[job] = 0
    end
    
    local xPlayers = ESX.GetExtendedPlayers()
    playerCount = #xPlayers
end)

lib.callback.register('ducky_scoreboard:getJobs', function(source)
    return JobCount
end)
