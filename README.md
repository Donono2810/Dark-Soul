# Dark Soul - Jeu Roblox Ultra-Méga-Complet avec Classes

Ce projet est un jeu Roblox ultra-méga-complet inspiré de Dark Souls avec 5 classes jouables et un système de progression complet.

## 5 Classes Jouables
- **Warrior** (150 HP, +15 dmg, vitesse 12) : Force brute, haute santé, charge brutale, items : Épée, Potions
  - Passive : Régénération accrue (HP +5/s)
  - Active (Y) : Cri de guerre (boost dmg 20s, 40 stamina)
- **Mage** (80 HP, +10 dmg, vitesse 10) : Magie puissante, low HP, tempête de feu, items : Dague, Fireballs, Potions
  - Passive : Mana regen +10/s
  - Active (Y) : Bouclier magique (absorbe 50 dmg, 30 mana)
- **Archer** (100 HP, +12 dmg, vitesse 15) : Rapide et précis, salve de flèches, items : Arc, Dague, Potions
  - Passive : Vitesse +2
  - Active (Y) : Tir précis (dmg x2, 25 stamina)
- **Rogue** (90 HP, +20 dmg, vitesse 18) : Ultra-rapide, coup fatal, items : 2x Dague, Rapier, Potions
  - Passive : Esquive +10% (réduit dmg reçu)
  - Active (Y) : Invisibilité (5s, 50 stamina)
- **Paladin** (140 HP, +18 dmg, vitesse 11) : Équilibré, aura protectrice, items : Épée, Sorts de protection/heal
  - Passive : Résistance +10% (réduit dmg reçu)
  - Active (Y) : Jugement (dégâts sacrés AoE, 60 mana)

## Capacités Spéciales (Touche T)
- **Warrior** : Charge brutale (dash + dégâts AoE, 50 stamina).
- **Mage** : Tempête de feu (dégâts AoE, 40 stamina).
- **Archer** : Salve de flèches (5 tirs rapides, 30 stamina).
- **Rogue** : Coup fatal (dégâts élevés sur cible proche, 60 stamina).
- **Paladin** : Aura protectrice (heal + bouclier 10s, 70 stamina).

## Armes (10 types avec stats avancées)
- **Épée** (20 dmg, 1.5s, 5% crit) : Équilibrée
- **Hache** (35 dmg, 2.0s, 10% crit) : Puissante mais lente
- **Dague** (15 dmg, 1.0s, 15% crit) : Rapide et légère
- **Greatsword** (50 dmg, 2.5s, 8% crit) : Très puissante
- **Arc** (25 dmg, 1.2s, 12% crit) : À distance
- **Katana** (45 dmg, 1.3s, 20% crit) : Rapide et forte avec crit élevé
- **Hammer** (60 dmg, 3.0s, 5% crit, stun 10%) : Peut stunner
- **Spear** (30 dmg, 1.4s, 8% crit) : Allongée et équilibrée
- **Scythe** (55 dmg, 2.3s, 18% crit, 10% lifesteal) : Régénère de la vie
- **Rapier** (18 dmg, 0.8s, 25% crit) : Ultra-rapide avec crit très élevé

## Armures (3 sets - Leather, Iron, Gold)
### Leather Set (faible défense, léger)
- Helmet (5 déf, +2 esquive)
- Chest (10 déf)
- Legs (8 déf, +1 vitesse)
- Shield (15 déf, +20% block)

### Iron Set (défense moyenne, lourd)
- Helmet (10 déf)
- Chest (20 déf)
- Legs (15 déf, -1 vitesse)
- Shield (25 déf, +35% block)

### Gold Set (haute défense, magique)
- Helmet (15 déf, +3 esquive, +5 mana_regen)
- Chest (28 déf, +2 health_regen)
- Legs (20 déf, +2 vitesse)
- Shield (35 déf, +50% block, +10% reflection)

## Potions & Consommables
- **Potion** (30 healing) : Basique
- **GreatPotion** (60 healing) : Avancée
- **MegaPotion** (100 healing) : Puissante
- **EtherPotion** (50 mana) : Restaure mana
- **StaminaPotion** (50 stamina) : Restaure stamina
- **AntidotePotion** : Élimine poison

## Sorts
- **Fireball** (40 dmg, 30 mana) : Basique
- **IceSpell** (35 dmg, 25 mana, stun 5%) : Gèle l'ennemi
- **LightningBolt** (50 dmg, 35 mana, 20% crit) : Éclair puissant
- **HealSpell** (40 healing, 30 mana) : Soin magique
- **ShieldSpell** (+20 déf, 25 mana, 10s) : Bouclier magique

## Matériaux & Accessoires
### Matériaux (pour craft)
- Iron Ore (commun)
- Silver Ore (peu rare)
- Gold Ore (rare)
- Crystal Shard (légendaire)
- Dragon Scale (épique)

### Accessoires (stat bonuses)
- Amulet of Strength (+15 dmg)
- Ring of Speed (+3 vitesse)
- Amulet of Protection (+10 déf)
- Ring of Mana (+50 mana, +5 mana_regen)

## Systèmes de Stats
- **Dégâts (Damage)** : Augmenté par les armes, les classes et les accessoires.
- **Critique (Crit)** : Probabilité de coup critique infliger 1.5x dégâts (Katana : 20%, Rapier : 25%).
- **Lifesteal** : % de dégâts regagnés en tant que santé (Scythe : 10%).
- **Défense (Defense)** : Réduit les dégâts entrants basé sur l'armure équipée.
- **Block** : Probabilité de bloquer une partie des dégâts avec un bouclier.
- **Vitesse (Speed)** : Bonus de vitesse de déplacement (Archer passive +2, Gold legs +2).
- **Esquive (Dodge)** : Réduction aléatoire de dégâts (Leather helm +2, Gold helm +3).
- **Parry (U)** : Reduce incoming damage by 50% for 1 second.
- **Reflection** : % de dégâts renvoyés à l'attaquant (Gold Shield : 10%).
- **Regen** : Régénération passive de santé ou mana (Warrior passive +5 HP/s, Gold chest +2 HP/s).

## Fonctionnalités
- **Combat** : Au corps à corps (clic gauche) et magie (clic droit, Q bouclier, R heal).
- **Santé & Régénération** : Lente, comme Dark Souls.
- **Niveaux & Exp** : Gagner exp en tuant, level up, perte à la mort.
- **Équipement** : Armures (casque, plastron, jambières, bouclier) avec défense, craftables.
- **Craft** : 7 armes + 8 armures (Leather/Iron sets) + accessoires.
- **Quêtes** : Différentes par zone avec récompenses.
- **Zones** : 5 niveaux avec monstres variés, **multiples boss par zone**.
- **Sauvegarde** : Persistance niveau/exp/inventaire.
- **Boss** : Phases avec compétences (poison, AoE stun, summon).
- **Ennemis** : Basic (aucune compétence), Goblin (poison), Orc (stun), Skeleton (summon) avec stats différentes.
- **Animations d'attaques** : Animations spécifiques par arme pour plus d'immersion.
- **Tenues différentes** : Apparence du personnage change selon la classe choisie (couleurs distinctes).
- **Stamina** : Système de stamina limitant attaques et capacités spéciales.
- **Capacités spéciales** : Chaque classe a une capacité unique (T pour activer).
- **Compétences** : Passives (toujours actives) et actives (Y) pour chaque classe.
- **Buffs/Débuffs** : Effets temporaires comme poison.
- **Quêtes secondaires** : Missions optionnelles (tuer Gobelins, collecter loots).
- **Parry** : Système de parade (U) pour réduire les dégâts entrants.
- **Mode multijoueur** : Choix entre Solo, Coop et PvP via l'interface.
- **Boutique VIP** : Statut VIP achetable en Robux avec avantages de dégâts et statut spécial.
- **Système de Réputation et Factions** : 3 factions (Chevaliers, Sorciers, Mercenaires) avec quêtes exclusives et bonus.
- **Événements Temporaires** : Invasions de boss, raids coopératifs, nuits d'undead avec récompenses spéciales.
- **Crafting Avancé** : Recettes multi-étapes pour items enchantés (ex. : EnchantedSword, DivineShield).
- **Personnalisation Visuelle** : Skins débloquables (GoldenKnight VIP, ShadowAssassin rare) avec couleurs personnalisées.
- **Système de Guildes** : Création/join de guildes, points collectifs, buffs d'équipe.
- **Mini-Jeux et Défis Quotidiens** : Défis quotidiens (tuer ennemis, collecter items), mini-jeux comme arènes de duel.
- **Compagnons (Pets)** : Loups, corbeaux, golems apprivoisables avec capacités d'aide en combat.
- **Mode Survie** : Défense contre vagues d'ennemis croissantes avec récompenses basées sur la survie.
- **Économie Dynamique** : Prix fluctuants pour les items, marché joueur avec taxes.
- **Classement PvP** : Top kills affiché en jeu avec un tableau de score.

## Contrôles
- Clic gauche : Attaquer (coûte 20 stamina).
- Clic droit : Fireball.
- Q : Bouclier (réduit dégâts 10s).
- R : Heal (soigne 50 HP).
- T : Capacité spéciale de classe (coûte stamina).
- Y : Compétence active de classe (coûte stamina/mana).
- U : Parry (réduit dégâts de 50% pendant 1s).
- E : Potion.
- Bouton "Inventaire" : Menu avec craft.
- **Au démarrage** : Écran de sélection de classe (cliquez sur une classe, puis "Confirmer").
- Mouvement : WASD.

## Zones & Boss
- **Zone 1** : Dans le monde, 3 ennemis basiques + 1 boss.
- **Zone 2** : Téléporteur (50,0,0), 3 ennemis + **3 boss**.
- **Zone 3** : Téléporteur (150,0,0), 5 Goblins + **3 boss**.
- **Zone 4** : Téléporteur (300,0,0), 3 Orcs + 3 Skeletons + **3 boss**.
- **Zone 5** : Téléporteur (450,0,0), mélange 6 ennemis + **3 boss finaux**.
- **Donjon** : Porte grise (200,0,0), pièges, 4 ennemis variés + **3 boss dungeon**.

**Total : 18 boss dans le jeu !**

Importez dans Roblox Studio pour jouer !

📖 **[👉 LIRE LE GUIDE D'IMPORTATION 👈](INSTALLATION.md)**

---