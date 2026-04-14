📖 GUIDE D'IMPORTATION DANS ROBLOX STUDIO

# Comment Importer Dark Soul dans Roblox Studio

Ce guide vous aide à importer le jeu Dark Soul complet dans Roblox Studio.

## Prérequis

1. **Roblox Studio** installé (gratuit, téléchargez-le ici : https://www.roblox.com/create)
2. **Un compte Roblox**
3. **GitHub Desktop** ou **Git** pour cloner le repository (optionnel mais recommandé)

---

## Méthode 1 : Importation Simple (Recommandée)

### Étape 1 : Télécharger les fichiers

1. Allez sur : https://github.com/Donono2810/Dark-Soul
2. Cliquez sur **"Code"** (bouton vert)
3. Cliquez sur **"Download ZIP"**
4. Dézippez le fichier téléchargé

### Étape 2 : Créer une nouvelle place dans Roblox Studio

1. Ouvrez **Roblox Studio**
2. Cliquez sur **"New"** ou **"File"** → **"New"**
3. Choisissez un **template vierge** (Baseplate ou Blank)
4. Cliquez sur **"Create"**

### Étape 3 : Importer les scripts

#### Pour les scripts serveur (ServerScriptService) :

1. Dans Roblox Studio, ouvrez **Explorer** (panneau à gauche)
2. Développez **Workspace** → Cliquez sur **"+"** à côté de **ServerScriptService**
3. Choisissez **Script** (crée un nouveau serveur script)
4. Ouvrez le fichier correspondant du dossier téléchargé (ex: `GameInit.lua`)
5. Copiez le contenu du fichier
6. Collez-le dans le script Roblox Studio
7. Renommez le script avec le même nom (ex: "GameInit")
8. **Répétez** pour tous les fichiers dans `ServerScriptService/` :
   - `GameInit.lua`
   - `HealthManager.lua` → À IGNORER (remplacé par ClassHealthManager)
   - `ClassHealthManager.lua`
   - `Zone2.lua`
   - `Zone3.lua`
   - `Zone4.lua`
   - `Zone5.lua`
   - `Dungeon.lua`
   - `NPC.lua`

#### Pour les modules (ReplicatedStorage) :

1. Dans Explorer, cliquez sur **"+"** à côté de **ReplicatedStorage**
2. Choisissez **ModuleScript** 
3. Copiez/collez le contenu du fichier dans `ReplicatedStorage/` :
   - `WeaponModule.lua`
   - `InventoryModule.lua`
   - `EnemyModule.lua`
   - `BossModule.lua`
   - `QuestModule.lua`
   - `CraftModule.lua`
   - `SaveModule.lua`
   - `ClassModule.lua`

#### Pour les scripts locaux (StarterPlayer) :

1. Dans Explorer, trouvez **StarterPlayer** → **StarterCharacterScripts** et **StarterPlayerScripts**
2. Cliquez sur **"+"** à côté de **StarterPlayerScripts**
3. Choisissez **LocalScript**
4. Copiez/collez les fichiers de `StarterPlayer/StarterPlayerScripts/` :
   - `PlayerControls.lua`
   - `UI.lua`
   - `ClassSelection.lua`
   - `InventoryUI.lua`
   - `MagicControls.lua`
   - `AdvancedMagic.lua`

---

## Méthode 2 : Avec GitHub Desktop (Pour Développeurs)

### Étape 1 : Cloner le repository

1. Téléchargez **GitHub Desktop** (https://desktop.github.com/)
2. Ouvrez **GitHub Desktop**
3. Cliquez sur **File** → **Clone Repository**
4. Entrez `Donono2810/Dark-Soul`
5. Cliquez sur **Clone**

### Étape 2 : Importer comme ci-dessus

Les fichiers sont maintenant prêts, suivez les étapes de la **Méthode 1** (à partir de l'étape 2).

---

## Méthode 3 : Avec Git en Ligne de Commande

### Pour Windows/Mac/Linux :

```bash
# Dans un terminal, naviguez vers où vous voulez cloner
cd C:\Users\YourName\Desktop

# Clonez le repository
git clone https://github.com/Donono2810/Dark-Soul.git

# Les fichiers sont dans le dossier Dark-Soul
cd Dark-Soul
```

Puis suivez la **Méthode 1** pour importer.

---

## Checklist d'Importation

Assurez-vous d'avoir importé **TOUS** ces fichiers (sinon le jeu ne fonctionnera pas) :

### ✅ ServerScriptService (9 scripts)
- [ ] GameInit
- [ ] ClassHealthManager
- [ ] Zone2
- [ ] Zone3
- [ ] Zone4
- [ ] Zone5
- [ ] Zone6
- [ ] Zone7
- [ ] Dungeon
- [ ] NPC

### ✅ ReplicatedStorage (8 modules)
- [ ] WeaponModule
- [ ] InventoryModule
- [ ] EnemyModule
- [ ] BossModule
- [ ] QuestModule
- [ ] CraftModule
- [ ] SaveModule
- [ ] ClassModule

### ✅ StarterPlayer/StarterPlayerScripts (6 scripts)
- [ ] PlayerControls
- [ ] UI
- [ ] ClassSelection
- [ ] InventoryUI
- [ ] MagicControls
- [ ] AdvancedMagic

---

## Test du Jeu

1. Après l'importation, cliquez sur **Play** (bouton ► haut à gauche)
2. Vous devriez voir l'**écran de sélection de classe**
3. Choisissez une classe et cliquez **"Confirmer"**
4. Vous êtes maintenant dans le jeu !

### Test des Contrôles

- **Clic gauche** : Attacker les ennemis
- **Clic droit** : Lancer Fireball
- **Q** : Bouclier (réduit dégâts)
- **R** : Heal (soigne)
- **E** : Utiliser potion
- **WASD** : Bouger

---

## Dépannage

### Le jeu ne démarre pas
- **Vérifiez** que tous les scripts sont correctement nommés
- **Cherchez** dans la **Output Console** (View → Output) pour les erreurs
- **Assurez-vous** que tous les modules sont dans **ReplicatedStorage**

### Les ennemis n'apparaissent pas
- Vérifiez que `GameInit.lua` est bien dans **ServerScriptService**
- Attendez quelques secondes après le démarrage
- Vérifiez la **Output Console** pour les erreurs Lua

### Les scripts affichent des erreurs
- Assurez-vous d'avoir copié **EXACTEMENT** le contenu
- Vérifiez les **noms des fichiers** (sensible à la casse)
- Assurez-vous qu'aucun fichier n'est oublié

### Mon personnage n'a pas les items de sa classe
- **Attendez 2-3 secondes** après la sélection
- Vérifiez que `ClassSelection.lua` est bien importé

---

## Optionnel : Customisation

### Changez les positions des zones

Ouvrez les fichiers de zone (Zone2.lua, Zone3.lua, etc.) et modifiez les positions :

```lua
teleporter.Position = Vector3.new(50, 0, 0) -- Changez ces chiffres
```

### Augmentez la difficulté

Modifiez les HP des ennemis dans `EnemyModule.lua` :

```lua
health = 150 -- Augmentez pour plus difficile
```

### Changez les stats des armes

Modifiez `WeaponModule.lua` :

```lua
["Sword"] = {damage = 20, speed = 1.5} -- Augmentez damage pour plus fort
```

---

## Questions & Support

- **GitHub Issues** : https://github.com/Donono2810/Dark-Soul/issues
- **Email** : Contactez le créateur via GitHub

---

**Bon jeu ! 🎮**