local MAX_PLAYERS = 64
local JobCount = {}
local playerCount = 0

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    JobCount = lib.callback.await('ducky_scoreboard:getJobs', false)
end)

RegisterNetEvent('ducky_scoreboard:updateTable', function(totalcount, jobName, jobCount)
    playerCount = totalcount
    if jobName then JobCount[jobName] = jobCount end
end)
RegisterNetEvent('ducky_scoreboard:updateTable', function(totalcount, jobName, jobCount)
    playerCount = totalcount
    if jobName then JobCount[jobName] = jobCount end
    
    if lib.getOpenContextMenu() == "scoreboard" then
        lib.hideContext()
        lib.showContext("scoreboard")
    end
end)

RegisterCommand('scoreboard', function()
    if lib.getOpenContextMenu() then lib.hideContext(false) end -- In case they press the key again

    local options = {
        {
            title       = 'Citizens Online',
            description = ('Total: %s/%d'):format(playerCount, MAX_PLAYERS),
            icon        = 'user',
            iconColor   = 'white',
            readOnly    = true,
            disabled    = false
        }

    }

    for JobName, JobData in pairs(Config.Jobs) do

        local option = {
            title       = JobData.title or JobData:sub(1, 1):upper() .. JobData:sub(2),
            description = ("%s Online"):format(JobCount[JobName]),
            icon        = JobData.icon or "user",
            readOnly    = true,
            disabled    = true
        }

        if JobData.iconColor then option.iconColor = JobData.iconColor end

        option.disabled = JobCount[JobName] == 0

        options[#options+1] = option

    end

    lib.registerContext({
        id      = 'scoreboard',
        title   = 'Scoreboard',
        options = options
    })

    lib.showContext('scoreboard')

end, false)

RegisterKeyMapping('scoreboard', 'Score Board', 'keyboard', Config.Key or 'HOME')
