-- A basic encounter script skeleton you can copy and modify for your own creations.

music = "AXOLOTL" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "SONG BY SUMMER BLOOM\nThere's only one wave" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"attack"}
wavetimer = 273
arenasize = {555, 130}
Player.name = "TEST"
enemies = {
"AXOLOTL"
}

enemypositions = {
{0, 0}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"attack"}

function EncounterStarting()
    SetPPCollision(true)
    Audio.Stop()
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
    BattleDialog({"Selected item " .. ItemID .. "."})
end