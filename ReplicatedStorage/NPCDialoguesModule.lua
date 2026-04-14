local NPCDialoguesModule = {}

-- Module pour les dialogues NPC enrichis
NPCDialoguesModule.Dialogues = {
    Merchant = {
        Greeting = "Bonjour, aventurier!",
        Options = {"Acheter", "Vendre", "Quitter"}
    }
}

-- Fonction pour démarrer un dialogue
function NPCDialoguesModule.StartDialogue(player, npcName)
    local dialogue = NPCDialoguesModule.Dialogues[npcName]
    if dialogue then
        -- Afficher GUI de dialogue
    end
end

return NPCDialoguesModule