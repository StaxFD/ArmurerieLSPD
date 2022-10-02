_ArmurerieLSPD.Menu = _ArmurerieLSPD.Menu or {}
_ArmurerieLSPD.Stock = _ArmurerieLSPD.Stock or {}
_ArmurerieLSPD.Inventory = _ArmurerieLSPD.Inventory or {}
_ArmurerieLSPD.HistoriqueSQL = _ArmurerieLSPD.HistoriqueSQL or {}
-- https://discord.gg/g9dXrcAcwn
_ArmurerieLSPD.Menu.Create = function()
    _ArmurerieLSPD.Menu.main = RageUI.CreateMenu(_ArmurerieLSPD.Translations.Menu.Title, _ArmurerieLSPD.Translations.Menu.Title)
    _ArmurerieLSPD.Menu.submain = RageUI.CreateSubMenu(_ArmurerieLSPD.Menu.main,_ArmurerieLSPD.Translations.Menu.Title, _ArmurerieLSPD.Translations.Menu.Title)
    _ArmurerieLSPD.Menu.submain2 = RageUI.CreateSubMenu(_ArmurerieLSPD.Menu.main,_ArmurerieLSPD.Translations.Menu.Title, _ArmurerieLSPD.Translations.Menu.Title)
    _ArmurerieLSPD.Menu.subhistoriquemain = RageUI.CreateSubMenu(_ArmurerieLSPD.Menu.main,_ArmurerieLSPD.Translations.Menu.Title, _ArmurerieLSPD.Translations.Menu.Title)
end