module Item
  extend ActiveSupport::Concern

  # Current as of Patch 5.16.1
  ITEMS = {
    "3725" => {"name" => "Ranger's Trailblazer: Cinderhulk", "image" => "3725.png"},
    "3724" => {"name" => "Ranger's Trailblazer: Runeglaive", "image" => "3724.png"},
    "3089" => {"name" => "Rabadon's Deathcap", "image" => "3089.png"},
    "2009" => {"name" => "Total Biscuit of Rejuvenation", "image" => "2009.png"},
    "3723" => {"name" => "Ranger's Trailblazer: Warrior", "image" => "3723.png"},
    "3722" => {"name" => "Poacher's Knife: Devourer", "image" => "3722.png"},
    "3087" => {"name" => "Statikk Shiv", "image" => "3087.png"},
    "3721" => {"name" => "Poacher's Knife: Cinderhulk", "image" => "3721.png"},
    "3086" => {"name" => "Zeal", "image" => "3086.png"},
    "2004" => {"name" => "Mana Potion", "image" => "2004.png"},
    "1319" => {"name" => "Ninja Tabi: Homeguard", "image" => "1319.png"},
    "3260" => {"name" => "Ninja Tabi: Homeguard", "image" => "1319.png"},
    "3720" => {"name" => "Poacher's Knife: Runeglaive", "image" => "3720.png"},
    "3085" => {"name" => "Runaan's Hurricane", "image" => "3085.png"},
    "1318" => {"name" => "Ninja Tabi: Distortion", "image" => "1318.png"},
    "3263" => {"name" => "Ninja Tabi: Distortion", "image" => "1318.png"},
    "3084" => {"name" => "Overlord's Bloodmail", "image" => "3084.png"},
    "1317" => {"name" => "Ninja Tabi: Captain", "image" => "1317.png"},
    "3261" => {"name" => "Ninja Tabi: Captain", "image" => "1317.png"},
    "2003" => {"name" => "Health Potion", "image" => "2003.png"},
    "3083" => {"name" => "Warmog's Armor", "image" => "3083.png"},
    "1316" => {"name" => "Ninja Tabi: Alacrity", "image" => "1316.png"},
    "3264" => {"name" => "Ninja Tabi: Alacrity", "image" => "1316.png"},
    "3082" => {"name" => "Warden's Mail", "image" => "3082.png"},
    "1315" => {"name" => "Ninja Tabi: Furor", "image" => "1315.png"},
    "3262" => {"name" => "Ninja Tabi: Furor", "image" => "1315.png"},
    "1314" => {"name" => "Sorcerer's Shoes: Homeguard", "image" => "1314.png"},
    "3255" => {"name" => "Sorcerer's Shoes: Homeguard", "image" => "1314.png"},
    "1313" => {"name" => "Sorcerer's Shoes: Distortion", "image" => "1313.png"},
    "3258" => {"name" => "Sorcerer's Shoes: Distortion", "image" => "1313.png"},
    "1312" => {"name" => "Sorcerer's Shoes: Captain", "image" => "1312.png"},
    "3256" => {"name" => "Sorcerer's Shoes: Captain", "image" => "1312.png"},
    "3285" => {"name" => "Luden's Echo", "image" => "3285.png"},
    "1311" => {"name" => "Sorcerer's Shoes: Alacrity", "image" => "1311.png"},
    "3259" => {"name" => "Sorcerer's Shoes: Alacrity", "image" => "1311.png"},
    "1310" => {"name" => "Sorcerer's Shoes: Furor", "image" => "1310.png"},
    "3257" => {"name" => "Sorcerer's Shoes: Furor", "image" => "1310.png"},
    "3726" => {"name" => "Ranger's Trailblazer: Devourer", "image" => "3726.png"},
    "3924" => {"name" => "Flesheater", "image" => "3924.png"},
    "2010" => {"name" => "Total Biscuit of Rejuvenation", "image" => "2010.png"},
    "3711" => {"name" => "Poacher's Knife", "image" => "3711.png"},
    "3098" => {"name" => "Frostfang", "image" => "3098.png"},
    "3714" => {"name" => "Skirmisher's Sabre: Warrior", "image" => "3714.png"},
    "3713" => {"name" => "Ranger's Trailblazer", "image" => "3713.png"},
    "1329" => {"name" => "Boots of Mobility: Homeguard", "image" => "1329.png"},
    "3270" => {"name" => "Boots of Mobility: Homeguard", "image" => "1329.png"},
    "3290" => {"name" => "Twin Shadows", "image" => "3290.png"},
    "1328" => {"name" => "Boots of Mobility: Distortion", "image" => "1328.png"},
    "3273" => {"name" => "Boots of Mobility: Distortion", "image" => "1328.png"},
    "3710" => {"name" => "Stalker's Blade: Devourer", "image" => "3710.png"},
    "3097" => {"name" => "Targon's Brace", "image" => "3097.png"},
    "3096" => {"name" => "Nomad's Medallion", "image" => "3096.png"},
    "3091" => {"name" => "Wit's End", "image" => "3091.png"},
    "1325" => {"name" => "Boots of Mobility: Furor", "image" => "1325.png"},
    "3272" => {"name" => "Boots of Mobility: Furor", "image" => "1325.png"},
    "3719" => {"name" => "Poacher's Knife: Warrior", "image" => "3719.png"},
    "3090" => {"name" => "Wooglet's Witchcap", "image" => "3090.png"},
    "1324" => {"name" => "Mercury's Treads: Homeguard", "image" => "1324.png"},
    "3265" => {"name" => "Mercury's Treads: Homeguard", "image" => "1324.png"},
    "3093" => {"name" => "Avarice Blade", "image" => "3093.png"},
    "1327" => {"name" => "Boots of Mobility: Captain", "image" => "1327.png"},
    "3271" => {"name" => "Boots of Mobility: Captain", "image" => "1327.png"},
    "1326" => {"name" => "Boots of Mobility: Alacrity", "image" => "1326.png"},
    "3274" => {"name" => "Boots of Mobility: Alacrity", "image" => "1326.png"},
    "3092" => {"name" => "Frost Queen's Claim", "image" => "3092.png"},
    "1321" => {"name" => "Mercury's Treads: Alacrity", "image" => "1321.png"},
    "3269" => {"name" => "Mercury's Treads: Alacrity", "image" => "1321.png"},
    "3716" => {"name" => "Skirmisher's Sabre: Runeglaive", "image" => "3716.png"},
    "1320" => {"name" => "Mercury's Treads: Furor", "image" => "1320.png"},
    "3267" => {"name" => "Mercury's Treads: Furor", "image" => "1320.png"},
    "3715" => {"name" => "Skirmisher's Sabre", "image" => "3715.png"},
    "1323" => {"name" => "Mercury's Treads: Distortion", "image" => "1323.png"},
    "3268" => {"name" => "Mercury's Treads: Distortion", "image" => "1323.png"},
    "3718" => {"name" => "Skirmisher's Sabre: Devourer", "image" => "3718.png"},
    "1322" => {"name" => "Mercury's Treads: Captain", "image" => "1322.png"},
    "3266" => {"name" => "Mercury's Treads: Captain", "image" => "1322.png"},
    "3717" => {"name" => "Skirmisher's Sabre: Cinderhulk", "image" => "3717.png"},
    "1330" => {"name" => "Ionian Boots of Lucidity: Furor", "image" => "1330.png"},
    "3277" => {"name" => "Ionian Boots of Lucidity: Furor", "image" => "1330.png"},
    "3911" => {"name" => "Martyr's Gambit", "image" => "3911.png"},
    "3742" => {"name" => "Dead Man's Plate", "image" => "3742.png"},
    "3599" => {"name" => "The Black Spear", "image" => "3599.png"},
    "3745" => {"name" => "Puppeteer", "image" => "3745.png"},
    "3744" => {"name" => "Staff of Flowing Water", "image" => "3744.png"},
    "1075" => {"name" => "Doran's Blade (Showdown)", "image" => "1075.png"},
    "1074" => {"name" => "Doran's Shield (Showdown)", "image" => "1074.png"},
    "3844" => {"name" => "Murksphere", "image" => "3844.png"},
    "1076" => {"name" => "Doran's Ring (Showdown)", "image" => "1076.png"},
    "3748" => {"name" => "Titanic Hydra", "image" => "3748.png"},
    "3841" => {"name" => "Swindler's Orb", "image" => "3841.png"},
    "3840" => {"name" => "Globe of Trust", "image" => "3840.png"},
    "1307" => {"name" => "Boots of Swiftness: Captain", "image" => "1307.png"},
    "3281" => {"name" => "Boots of Swiftness: Captain", "image" => "1307.png"},
    "1306" => {"name" => "Boots of Swiftness: Alacrity", "image" => "1306.png"},
    "3284" => {"name" => "Boots of Swiftness: Alacrity", "image" => "1306.png"},
    "1309" => {"name" => "Boots of Swiftness: Homeguard", "image" => "1309.png"},
    "3280" => {"name" => "Boots of Swiftness: Homeguard", "image" => "1309.png"},
    "1308" => {"name" => "Boots of Swiftness: Distortion", "image" => "1308.png"},
    "3283" => {"name" => "Boots of Swiftness: Distortion", "image" => "1308.png"},
    "1301" => {"name" => "Berserker's Greaves: Alacrity", "image" => "1301.png"},
    "3254" => {"name" => "Berserker's Greaves: Alacrity", "image" => "1301.png"},
    "1063" => {"name" => "Prospector's Ring", "image" => "1063.png"},
    "1300" => {"name" => "Berserker's Greaves: Furor", "image" => "1300.png"},
    "3252" => {"name" => "Berserker's Greaves: Furor", "image" => "1300.png"},
    "1062" => {"name" => "Prospector's Blade", "image" => "1062.png"},
    "1303" => {"name" => "Berserker's Greaves: Distortion", "image" => "1303.png"},
    "3253" => {"name" => "Berserker's Greaves: Distortion", "image" => "1303.png"},
    "1302" => {"name" => "Berserker's Greaves: Captain", "image" => "1302.png"},
    "3251" => {"name" => "Berserker's Greaves: Captain", "image" => "1302.png"},
    "1305" => {"name" => "Boots of Swiftness: Furor", "image" => "1305.png"},
    "3282" => {"name" => "Boots of Swiftness: Furor", "image" => "1305.png"},
    "1304" => {"name" => "Berserker's Greaves: Homeguard", "image" => "1304.png"},
    "3250" => {"name" => "Berserker's Greaves: Homeguard", "image" => "1304.png"},
    "1058" => {"name" => "Needlessly Large Rod", "image" => "1058.png"},
    "1056" => {"name" => "Doran's Ring", "image" => "1056.png"},
    "1057" => {"name" => "Negatron Cloak", "image" => "1057.png"},
    "3930" => {"name" => "Stalker's Blade: Sated Devourer", "image" => "3930.png"},
    "3931" => {"name" => "Skirmisher's Sabre: Sated Devourer", "image" => "3931.png"},
    "3932" => {"name" => "Poacher's Knife: Sated Devourer", "image" => "3932.png"},
    "3933" => {"name" => "Ranger's Trailblazer: Sated Devourer", "image" => "3933.png"},
    "3110" => {"name" => "Frozen Heart", "image" => "3110.png"},
    "3111" => {"name" => "Mercury's Treads", "image" => "3111.png"},
    "3112" => {"name" => "Orb of Winter", "image" => "3112.png"},
    "3240" => {"name" => "Boots of Speed: Furor", "image" => "3240.png"},
    "3241" => {"name" => "Boots of Speed: Alacrity", "image" => "3241.png"},
    "3242" => {"name" => "Boots of Speed: Captain", "image" => "3242.png"},
    "3243" => {"name" => "Boots of Speed: Distortion", "image" => "3243.png"},
    "3244" => {"name" => "Boots of Speed: Homeguard", "image" => "3244.png"},
    "3621" => {"name" => "Offense Upgrade 1", "image" => "3621.png"},
    "3622" => {"name" => "Offense Upgrade 2", "image" => "3622.png"},
    "3625" => {"name" => "Defense Upgrade 2", "image" => "3625.png"},
    "3626" => {"name" => "Defense Upgrade 3", "image" => "3626.png"},
    "3829" => {"name" => "Trickster's Glass", "image" => "3829.png"},
    "3623" => {"name" => "Offense Upgrade 3", "image" => "3623.png"},
    "3624" => {"name" => "Defense Upgrade 1", "image" => "3624.png"},
    "3106" => {"name" => "Madred's Razors", "image" => "3106.png"},
    "3108" => {"name" => "Fiendish Codex", "image" => "3108.png"},
    "3102" => {"name" => "Banshee's Veil", "image" => "3102.png"},
    "3105" => {"name" => "Aegis of the Legion", "image" => "3105.png"},
    "3104" => {"name" => "Lord Van Damm's Pillager", "image" => "3104.png"},
    "3616" => {"name" => "Mercenary Upgrade 2", "image" => "3616.png"},
    "3100" => {"name" => "Lich Bane", "image" => "3100.png"},
    "3617" => {"name" => "Mercenary Upgrade 3", "image" => "3617.png"},
    "3101" => {"name" => "Stinger", "image" => "3101.png"},
    "3611" => {"name" => "Razorfin", "image" => "3611.png"},
    "3612" => {"name" => "Ironback", "image" => "3612.png"},
    "3613" => {"name" => "Plundercrab", "image" => "3613.png"},
    "3614" => {"name" => "Ocklepod", "image" => "3614.png"},
    "3615" => {"name" => "Mercenary Upgrade 1", "image" => "3615.png"},
    "3245" => {"name" => "Boots of Speed: Teleport", "image" => "3245.png"},
    "3801" => {"name" => "Crystalline Bracer", "image" => "3801.png"},
    "3706" => {"name" => "Stalker's Blade", "image" => "3706.png"},
    "3707" => {"name" => "Stalker's Blade: Warrior", "image" => "3707.png"},
    "3800" => {"name" => "Righteous Glory", "image" => "3800.png"},
    "3504" => {"name" => "Ardent Censer", "image" => "3504.png"},
    "3708" => {"name" => "Stalker's Blade: Runeglaive", "image" => "3708.png"},
    "3709" => {"name" => "Stalker's Blade: Cinderhulk", "image" => "3709.png"},
    "3508" => {"name" => "Essence Reaver", "image" => "3508.png"},
    "3361" => {"name" => "Greater Stealth Totem", "image" => "3361.png"},
    "3362" => {"name" => "Greater Vision Totem", "image" => "3362.png"},
    "3363" => {"name" => "Farsight Orb", "image" => "3363.png"},
    "3364" => {"name" => "Oracle's Lens", "image" => "3364.png"},
    "2140" => {"name" => "Elixir of Wrath", "image" => "2140.png"},
    "2138" => {"name" => "Elixir of Iron", "image" => "2138.png"},
    "2139" => {"name" => "Elixir of Sorcery", "image" => "2139.png"},
    "2137" => {"name" => "Elixir of Ruin", "image" => "2137.png"},
    "1004" => {"name" => "Faerie Charm", "image" => "1004.png"},
    "1001" => {"name" => "Boots of Speed", "image" => "1001.png"},
    "3146" => {"name" => "Hextech Gunblade", "image" => "3146.png"},
    "1006" => {"name" => "Rejuvenation Bead", "image" => "1006.png"},
    "3006" => {"name" => "Berserker's Greaves", "image" => "3006.png"},
    "3003" => {"name" => "Archangel's Staff", "image" => "3003.png"},
    "3004" => {"name" => "Manamune", "image" => "3004.png"},
    "3009" => {"name" => "Boots of Swiftness", "image" => "3009.png"},
    "3007" => {"name" => "Archangel's Staff (Crystal Scar)", "image" => "3007.png"},
    "3008" => {"name" => "Manamune (Crystal Scar)", "image" => "3008.png"},
    "3342" => {"name" => "Scrying Orb", "image" => "3342.png"},
    "3341" => {"name" => "Sweeping Lens", "image" => "3341.png"},
    "3340" => {"name" => "Warding Totem", "image" => "3340.png"},
    "3010" => {"name" => "Catalyst the Protector", "image" => "3010.png"},
    "3156" => {"name" => "Maw of Malmortius", "image" => "3156.png"},
    "3155" => {"name" => "Hexdrinker", "image" => "3155.png"},
    "3154" => {"name" => "Wriggle's Lantern", "image" => "3154.png"},
    "3153" => {"name" => "Blade of the Ruined King", "image" => "3153.png"},
    "3200" => {"name" => "Prototype Hex Core", "image" => "3200.png"},
    "3152" => {"name" => "Will of the Ancients", "image" => "3152.png"},
    "1011" => {"name" => "Giant's Belt", "image" => "1011.png"},
    "3151" => {"name" => "Liandry's Torment", "image" => "3151.png"},
    "3150" => {"name" => "Mirage Blade", "image" => "3150.png"},
    "3139" => {"name" => "Mercurial Scimitar", "image" => "3139.png"},
    "3135" => {"name" => "Void Staff", "image" => "3135.png"},
    "3136" => {"name" => "Haunting Guise", "image" => "3136.png"},
    "3137" => {"name" => "Dervish Blade", "image" => "3137.png"},
    "3348" => {"name" => "Hextech Sweeper", "image" => "3348.png"},
    "3345" => {"name" => "Soul Anchor", "image" => "3345.png"},
    "3001" => {"name" => "Abyssal Scepter", "image" => "3001.png"},
    "3143" => {"name" => "Randuin's Omen", "image" => "3143.png"},
    "3142" => {"name" => "Youmuu's Ghostblade", "image" => "3142.png"},
    "3145" => {"name" => "Hextech Revolver", "image" => "3145.png"},
    "3401" => {"name" => "Face of the Mountain", "image" => "3401.png"},
    "3144" => {"name" => "Bilgewater Cutlass", "image" => "3144.png"},
    "3211" => {"name" => "Spectre's Cowl", "image" => "3211.png"},
    "3141" => {"name" => "Sword of the Occult", "image" => "3141.png"},
    "3140" => {"name" => "Quicksilver Sash", "image" => "3140.png"},
    "3124" => {"name" => "Guinsoo's Rageblade", "image" => "3124.png"},
    "3029" => {"name" => "Rod of Ages (Crystal Scar)", "image" => "3029.png"},
    "3027" => {"name" => "Rod of Ages", "image" => "3027.png"},
    "3028" => {"name" => "Chalice of Harmony", "image" => "3028.png"},
    "3025" => {"name" => "Iceborn Gauntlet", "image" => "3025.png"},
    "3026" => {"name" => "Guardian Angel", "image" => "3026.png"},
    "3512" => {"name" => "Zz'Rot Portal", "image" => "3512.png"},
    "3035" => {"name" => "Last Whisper", "image" => "3035.png"},
    "3031" => {"name" => "Infinity Edge", "image" => "3031.png"},
    "3222" => {"name" => "Mikael's Crucible", "image" => "3222.png"},
    "3134" => {"name" => "The Brutalizer", "image" => "3134.png"},
    "3113" => {"name" => "Aether Wisp", "image" => "3113.png"},
    "3114" => {"name" => "Forbidden Idol", "image" => "3114.png"},
    "3430" => {"name" => "Rite of Ruin", "image" => "3430.png"},
    "3115" => {"name" => "Nashor's Tooth", "image" => "3115.png"},
    "3431" => {"name" => "Netherstride Grimoire", "image" => "3431.png"},
    "3116" => {"name" => "Rylai's Crystal Scepter", "image" => "3116.png"},
    "3117" => {"name" => "Boots of Mobility", "image" => "3117.png"},
    "3022" => {"name" => "Frozen Mallet", "image" => "3022.png"},
    "3024" => {"name" => "Glacial Shroud", "image" => "3024.png"},
    "3023" => {"name" => "Twin Shadows", "image" => "3023.png"},
    "3020" => {"name" => "Sorcerer's Shoes", "image" => "3020.png"},
    "3122" => {"name" => "Wicked Hatchet", "image" => "3122.png"},
    "2053" => {"name" => "Raptor Cloak", "image" => "2053.png"},
    "2054" => {"name" => "Diet Poro-Snax", "image" => "2054.png"},
    "3048" => {"name" => "Seraph's Embrace", "image" => "3048.png"},
    "3047" => {"name" => "Ninja Tabi", "image" => "3047.png"},
    "2050" => {"name" => "Explorer's Ward", "image" => "2050.png"},
    "2051" => {"name" => "Guardian's Horn", "image" => "2051.png"},
    "2052" => {"name" => "Poro-Snax", "image" => "2052.png"},
    "3434" => {"name" => "Pox Arcana", "image" => "3434.png"},
    "1051" => {"name" => "Brawler's Gloves", "image" => "1051.png"},
    "3197" => {"name" => "The Hex Core mk-2", "image" => "3197.png"},
    "3198" => {"name" => "Perfect Hex Core", "image" => "3198.png"},
    "3433" => {"name" => "Lost Chapter", "image" => "3433.png"},
    "1054" => {"name" => "Doran's Shield", "image" => "1054.png"},
    "1055" => {"name" => "Doran's Blade", "image" => "1055.png"},
    "3196" => {"name" => "The Hex Core mk-1", "image" => "3196.png"},
    "1052" => {"name" => "Amplifying Tome", "image" => "1052.png"},
    "1053" => {"name" => "Vampiric Scepter", "image" => "1053.png"},
    "3191" => {"name" => "Seeker's Armguard", "image" => "3191.png"},
    "3053" => {"name" => "Sterak's Gage", "image" => "3053.png"},
    "3050" => {"name" => "Zeke's Harbinger", "image" => "3050.png"},
    "3190" => {"name" => "Locket of the Iron Solari", "image" => "3190.png"},
    "2047" => {"name" => "Oracle's Extract", "image" => "2047.png"},
    "3056" => {"name" => "Ohmwrecker", "image" => "3056.png"},
    "3057" => {"name" => "Sheen", "image" => "3057.png"},
    "2049" => {"name" => "Sightstone", "image" => "2049.png"},
    "1341" => {"name" => "Ionian Boots of Lucidity: Teleport", "image" => "1341.png"},
    "1340" => {"name" => "Boots of Mobility: Teleport", "image" => "1340.png"},
    "3301" => {"name" => "Ancient Coin", "image" => "3301.png"},
    "3303" => {"name" => "Spellthief's Edge", "image" => "3303.png"},
    "3302" => {"name" => "Relic Shield", "image" => "3302.png"},
    "1037" => {"name" => "Pickaxe", "image" => "1037.png"},
    "1036" => {"name" => "Long Sword", "image" => "1036.png"},
    "1039" => {"name" => "Hunter's Machete", "image" => "1039.png"},
    "1038" => {"name" => "B. F. Sword", "image" => "1038.png"},
    "3187" => {"name" => "Hextech Sweeper", "image" => "3187.png"},
    "1339" => {"name" => "Mercury's Treads: Teleport", "image" => "1339.png"},
    "1042" => {"name" => "Dagger", "image" => "1042.png"},
    "1043" => {"name" => "Recurve Bow", "image" => "1043.png"},
    "3184" => {"name" => "Entropy", "image" => "3184.png"},
    "3185" => {"name" => "The Lightbringer", "image" => "3185.png"},
    "1335" => {"name" => "Berserker's Greaves: Teleport", "image" => "1335.png"},
    "1336" => {"name" => "Boots of Swiftness: Teleport", "image" => "1336.png"},
    "3040" => {"name" => "Seraph's Embrace", "image" => "3040.png"},
    "1337" => {"name" => "Sorcerer's Shoes: Teleport", "image" => "1337.png"},
    "3041" => {"name" => "Mejai's Soulstealer", "image" => "3041.png"},
    "3180" => {"name" => "Odyn's Veil", "image" => "3180.png"},
    "1338" => {"name" => "Ninja Tabi: Teleport", "image" => "1338.png"},
    "3042" => {"name" => "Muramana", "image" => "3042.png"},
    "3181" => {"name" => "Sanguine Blade", "image" => "3181.png"},
    "1331" => {"name" => "Ionian Boots of Lucidity: Alacrity", "image" => "1331.png"},
    "3279" => {"name" => "Ionian Boots of Lucidity: Alacrity", "image" => "1331.png"},
    "3043" => {"name" => "Muramana", "image" => "3043.png"},
    "1332" => {"name" => "Ionian Boots of Lucidity: Captain", "image" => "1332.png"},
    "3276" => {"name" => "Ionian Boots of Lucidity: Captain", "image" => "1332.png"},
    "3044" => {"name" => "Phage", "image" => "3044.png"},
    "1333" => {"name" => "Ionian Boots of Lucidity: Distortion", "image" => "1333.png"},
    "3278" => {"name" => "Ionian Boots of Lucidity: Distortion", "image" => "1333.png"},
    "1334" => {"name" => "Ionian Boots of Lucidity: Homeguard", "image" => "1334.png"},
    "3275" => {"name" => "Ionian Boots of Lucidity: Homeguard", "image" => "1334.png"},
    "3046" => {"name" => "Phantom Dancer", "image" => "3046.png"},
    "3901" => {"name" => "Fire at Will", "image" => "3901.png"},
    "3069" => {"name" => "Talisman of Ascension", "image" => "3069.png"},
    "3903" => {"name" => "Raise Morale", "image" => "3903.png"},
    "1029" => {"name" => "Cloth Armor", "image" => "1029.png"},
    "3902" => {"name" => "Death's Daughter", "image" => "3902.png"},
    "1028" => {"name" => "Ruby Crystal", "image" => "1028.png"},
    "1027" => {"name" => "Sapphire Crystal", "image" => "1027.png"},
    "1026" => {"name" => "Blasting Wand", "image" => "1026.png"},
    "3460" => {"name" => "Golden Transcendence", "image" => "3460.png"},
    "3070" => {"name" => "Tear of the Goddess", "image" => "3070.png"},
    "1033" => {"name" => "Null-Magic Mantle", "image" => "1033.png"},
    "3071" => {"name" => "The Black Cleaver", "image" => "3071.png"},
    "3174" => {"name" => "Athene's Unholy Grail", "image" => "3174.png"},
    "3751" => {"name" => "Bami's Cinder", "image" => "3751.png"},
    "1031" => {"name" => "Chain Vest", "image" => "1031.png"},
    "3172" => {"name" => "Zephyr", "image" => "3172.png"},
    "3078" => {"name" => "Trinity Force", "image" => "3078.png"},
    "3077" => {"name" => "Tiamat", "image" => "3077.png"},
    "3074" => {"name" => "Ravenous Hydra", "image" => "3074.png"},
    "3075" => {"name" => "Thornmail", "image" => "3075.png"},
    "3170" => {"name" => "Moonflair Spellblade", "image" => "3170.png"},
    "3072" => {"name" => "The Bloodthirster", "image" => "3072.png"},
    "3652" => {"name" => "Typhoon Claws", "image" => "3652.png"},
    "3073" => {"name" => "Tear of the Goddess (Crystal Scar)", "image" => "3073.png"},
    "2041" => {"name" => "Crystalline Flask", "image" => "2041.png"},
    "2044" => {"name" => "Stealth Ward", "image" => "2044.png"},
    "2045" => {"name" => "Ruby Sightstone", "image" => "2045.png"},
    "2043" => {"name" => "Vision Ward", "image" => "2043.png"},
    "3158" => {"name" => "Ionian Boots of Lucidity", "image" => "3158.png"},
    "3157" => {"name" => "Zhonya's Hourglass", "image" => "3157.png"},
    "1018" => {"name" => "Cloak of Agility", "image" => "1018.png"},
    "3159" => {"name" => "Grez's Spectral Lantern", "image" => "3159.png"},
    "3060" => {"name" => "Banner of Command", "image" => "3060.png"},
    "3165" => {"name" => "Morellonomicon", "image" => "3165.png"},
    "3065" => {"name" => "Spirit Visage", "image" => "3065.png"},
    "3067" => {"name" => "Kindlegem", "image" => "3067.png"},
    "3068" => {"name" => "Sunfire Cape", "image" => "3068.png"},
  }

  module ClassMethods
    def item_name_for_id(item_id)
      ITEMS[item_id]["name"]
    end

    def item_image_for_id(item_id)
      ITEMS[item_id]["image"]
    end
  end
end
