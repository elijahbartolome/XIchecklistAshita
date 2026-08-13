## **Usage**:
| Command | Description |
|---|---|
| `/addon load xichecklist` | load then <ins>**zone**</ins> to get the UI menu updated |
| `/xic help` | print help in chatlog |
| `/xic hide` | hide the UI |
| `/xic show` | show the UI |
| `/xic log <category>` | print <category> in chat log.<br>Example: `/xic log summary`<br>Available categories `main` `summary` `titles` `titles_by_content` `roe` `monstrosity` (`monsterlevels` `monstervariants` `racejobinstincts` `monsterinstincts`) `mmm` (`mmmvouchers` `mmmrunes`) `meeble` `zones` `warps` (`homepoints` `survivalguides` `waypoints` `telepoints` `cavernousmaws` `lycopodium` `eschanportals` `outposts` `protowaypoints`) `atmacite` `vorseals` `ergonlocus` `emporox` `fish` `odyssey` (`sheola` `sheolb` `sheolc` `sheolgaol`) `missions` `quests` (`sandoria` `bastok` `windurst` `jeuno` `ahturhgan` `assaults` `crystalwar` `outlands` `other` `abyssea` `adoulin` `coalition` `campaign` `sandoriamissions` `bastokmissions` `windurstmissions` `zilartmissions` `ahturhganmissions` `wotgmissions` `copmissions` `acpmissions` `mkdmissions` `asamissions` `soamissions` `rovmissions` `tvrmissions`)   |
| `/xic showcomplete` | toggle showing completed objectives in green |

The following are updated by talking to NPCs (some require opening certain menus)  
will be saved in config so only need to do it once (or when need to update)

| Data | Description |
|---|---|
| Titles | Speak to all [Titles NPCs](https://www.bg-wiki.com/ffxi/Category:Title_NPC)<br>Current title updated by opening status menu. |
| Outpost Warps | Speak to any [Nation Teleporter](https://www.bg-wiki.com/ffxi/Outpost#Nation_Teleporters) |
| MMM Maze Count | Speak to [Chatnachoq](https://www.bg-wiki.com/ffxi/Chatnachoq) |
| Proto-Waypoint | Speak to any [Proto-Waypoints](https://www.bg-wiki.com/ffxi/Waypoint#Proto-Waypoints) |
| Fishes Caught | Fish Tracker NPC [Katsunaga](https://www.bg-wiki.com/ffxi/Katsunaga) <br>`(Menu: Types of fish caught)` |
| Meeble Burrows | Speak to any [Burrow Researcher](https://www.bg-wiki.com/ffxi/Burrow_Researcher) or [Burrow Investigator](https://www.bg-wiki.com/ffxi/Burrow_Investigator) <br>`(Menu: Review expedition specifics -> Zone)` |
| Atmacite levels | Speak to any [Atmacite Refiner](https://www.bg-wiki.com/ffxi/Atmacite_Refiner) <br>`(Menu: Enrich Atmacite)` |
| Wing Skill | Speak to chocobo kids [Arvilauge/Gonija/Kiria-Romaria](https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging#Basics) |
| Sheol Gaol & Moogle Mastery | Speak to [??? in Rabao](https://www.bg-wiki.com/ffxi/Category:Odyssey) <br>`(Status Report: Sheol Gaol)`<br>`(Status Report: Moogle Mastery)` |
| Escha Vorseals | Speak to [Shiftrix in Reisenjima](https://www.bg-wiki.com/ffxi/Shiftrix) |
| Ergon Locus | Speak to [Rienne in Western Adoulin](https://www.bg-wiki.com/ffxi/Rienne) |
| Emporox Goodness | Speak to [Emporox in Reisenjima #8](https://www.bg-wiki.com/ffxi/Emporox) |
| Abyssea Teleports | Speak to [Veridical Conflux #01 in each Abyssea zone](https://www.bg-wiki.com/ffxi/Category:Abyssea) |

<br>

**Note**:
1. By default anything completed is hidden from the UI, to show completed objectives (in green), use the command `xic showcomplete`
2. First load may freeze a few seconds due to first-time registering of RoEs.

## **Tracking**:

- Monstrosity `(Monster levels / Race & Job Instincts / Monster variants)`
- Titles
- Moblin Maze Mongers `(Vouchers / Runes / Maze Count)`
- Meeble Burrows
- Sheol Gaol / Moogle Mastery Goals
- Types of fish caught
- Records of Eminence (RoE) 
- Warps `(Home Points / Survival Guides / Waypoints / Outposts / Proto-Waypoints / Telepoints / Cavernous Maws / Lycopodium / Eschan Portals)`
- Campaign Ops
- Missions `(San d'Oria / Bastok / Windurst / Zilart / CoP / TOAU / Assaults / WOTG / ACP / MKD / ASA / SoA / RoV / TVR)`
- Quests `(San d'Oria / Bastok / Windurst / Jeuno / Aht Urhgan / Crystal War / Outlands / Other / Abyssea / Adoulin / Coalition)`
- Key items `(Permenant / Maps / Mounts / Claim Slips / Job KIs / Active Effects / Atmacite levels)`
- Magic Spells `(White Magic / Black Magic / Summoner Pacts / Ninjutsu / Bard Songs / Blue Magic / Trusts)`
- leveling related `(Merit / Job points / Master levels / Fishing Skill / Crafting Skill / Wing Skill / Alter Ego Points)`
- Ergon Locus

![screenshot](https://imgur.com/yyldUyv.png)

![screenshot2](https://imgur.com/eWG0YPj.png)

![screenshot3](https://imgur.com/fzTX99m.png)

![screenshot4](https://imgur.com/02S7SY6.png)

![screenshot5](https://imgur.com/mFtw4Ff.png)

- this thing is free to use/share/edit/anything i dont care what you do with it





### **Changes**:

- 0.3.0 - more mission support, more warps, vorseals, ergon locus, sheol gaol, moogle mastery
- 0.2.0 - missions support
- 0.1.0 - release

## Credits
- Most of the code is based off HiPotionQ8's Windower addon XIchecklist
- Thanks to Thorny for providing code snippets to help guide the porting