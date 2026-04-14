local MultiLanguageModule = {}

-- Module pour le support multilingue
MultiLanguageModule.Languages = {
    English = {Greeting = "Hello"},
    French = {Greeting = "Bonjour"}
}

-- Fonction pour changer la langue
function MultiLanguageModule.SetLanguage(player, lang)
    player:SetAttribute("Language", lang)
end

-- Fonction pour traduire
function MultiLanguageModule.Translate(key, lang)
    return MultiLanguageModule.Languages[lang][key]
end

return MultiLanguageModule