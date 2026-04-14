local TaxesModule = {}

-- Module pour taxes et impôts
TaxesModule.TaxRate = 0.1 -- 10%

-- Fonction pour appliquer taxe sur vente
function TaxesModule.ApplyTax(saleAmount)
    return saleAmount * (1 - TaxesModule.TaxRate)
end

-- Fonction pour collecter taxes pour événements
function TaxesModule.CollectTaxes()
    -- Utiliser pour financer événements
end

return TaxesModule