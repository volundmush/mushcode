INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(3,"Werewolf","Primal Urge")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

/* Splat Data */
INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES

	(30000,3,"Auspice",0),
	(30001,3,"Tribe",1),
	(30002,3,"Lodge",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);
	
INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
	/* Werewolf X Splats - Auspices */
	(30000,30000,"Cahalith"),
	(30001,30000,"Elodoth"),
	(30002,30000,"Irraka"),
	(30003,30000,"Ithaeur"),
	(30004,30000,"Rahu"),
	
	/* Werewolf Y Splats - Tribes */
	(30005,30001,"Blood Talons"),
	(30006,30001,"Bone Shadows"),
	(30007,30001,"Hunters in Darkness"),
	(30008,30001,"Iron Masters"),
	(30009,30001,"Storm Lords"),
	(30010,30001,"Ghost Wolves")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);

/*
INSERT INTO vol_story_z_splats
	(z_splat_id,template_id,z_splat_name)
VALUES
	 Werewolf Z Splats - Lodges
	(30,3,"Einherjar"),
	(31,3,"Hundred Dogs"),
	(32,3,"Hook Hand"),
	(33,3,"Shield"),
	(34,3,"Roman Ritual"),
	(35,3,"Eaters of the Dead"),
	(36,3,"Chronicle"),
	(37,3,"Gargoyles")
ON DUPLICATE KEY UPDATE z_splat_name=VALUES(z_splat_name);
*/

/* Fields data */
INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES
	(30000,"Blood"),
	(30001,"Bone")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	(30000,30000,3),
	(30001,30001,3)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* ADVANTAGES */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	(30000,3,"Moon Gift","Moon Gifts",0),
	(30001,3,"Shadow Gift","Shadow Gifts",0),
	(30002,3,"Wolf Gift","Wolf Gifts",0),
	(30003,3,"Rite","Rites",0),

	(30007,3,"Werewolf Merit","Werewolf Merits",0),
	(30008,3,"Werewolf Flaw","Werewolf Flaws",0),
	(30009,3,"Werewolf Style","Werewolf Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (30007,37000,37999),
    (30008,38000,38999),
    (30009,39000,39999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

/* Werewolf - Moon Gifts */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	(30000,3,30100,"Crescent Moon"),
	(30000,3,30101,"Full Moon"),
	(30000,3,30102,"Gibbous Moon"),
	(30000,3,30103,"Half Moon"),
	(30000,3,30104,"New Moon")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);


/* Werewolf - Shadow Gifts */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	(30001,3,30200,"Cold Embrace"),
	(30001,3,30201,"Barghest"),
	(30001,3,30202,"Memento Mori"),
	(30001,3,30203,"Eyes of the Dead"),
	(30001,3,30204,"Primal Allure"),
	(30001,3,30205,"Glorious Lunacy"),
	(30001,3,30206,"Lay Low the Challenger"),
	(30001,3,30207,"Snarl of the Predator"),
	(30001,3,30208,"Lead the Lesser Pack"),
	(30001,3,30209,"Breath of Air"),
	(30001,3,30210,"Catastrophe"),
	(30001,3,30211,"Flesh of Earth"),
	(30001,3,30212,"Tongue of Flame"),
	(30001,3,30213,"Heart of Water"),
	(30001,3,30214,"Feet of Mist"),
	(30001,3,30215,"Fog of War"),
	(30001,3,30216,"Deny Everything"),
	(30001,3,30217,"Hit and Run"),
	(30001,3,30218,"Exit Strategy"),
	(30001,3,30219,"Prey on Weakness"),
	(30001,3,30220,"Read the World's Loom"),
	(30001,3,30221,"Echo Dream"),
	(30001,3,30222,"Scent the Unnatural"),
	(30001,3,30222,"One Step Ahead"),
	(30001,3,30223,"Lunatic Inspiration"),
	(30001,3,30224,"Fearless Hunter"),
	(30001,3,30225,"Pack Triumphs Together"),
	(30001,3,30226,"Unity"),
	(30001,3,30227,"Still Small Voice"),
	(30001,3,30228,"Needle"),
	(30001,3,30229,"This Story is True"),
	(30001,3,30230,"Know Thy Prey"),
	(30001,3,30231,"Lore of the Land"),
	(30001,3,30232,"Sift the Sands"),
	(30001,3,30233,"Nature's Lure"),
	(30001,3,30234,"Black Earth Red Hunger"),
	(30001,3,30235,"Knotted Paths"),
	(30001,3,30236,"Pack Kin"),
	(30001,3,30237,"Beast Ride"),
	(30001,3,30238,"Incite Fury"),
	(30001,3,30239,"Berserker's Might"),
	(30001,3,30240,"Perfected Rage"),
	(30001,3,30241,"Raging Lunacy"),
	(30001,3,30242,"Moldywarp"),
	(30001,3,30243,"Shield-Breaker"),
	(30001,3,30244,"Entropy's Toll"),
	(30001,3,30245,"Perfection of Form"),
	(30001,3,30246,"Sculpt"),
	(30001,3,30247,"Shadow Pelt"),
	(30001,3,30248,"Predator's Shadow"),
	(30001,3,30249,"Pack Stalks the Prey"),
	(30001,3,30250,"The Hunter Waits"),
	(30001,3,30251,"Running Silent"),
	(30001,3,30252,"Unchained"),
	(30001,3,30253,"Predator's Unmatched Pursuit"),
	(30001,3,30254,"Crushing Blow"),
	(30001,3,30255,"Primal Strength"),
	(30001,3,30256,"Rending Claws"),
	(30001,3,30257,"Garble"),
	(30001,3,30258,"Unmake"),
	(30001,3,30259,"Command Artifice"),
	(30001,3,30260,"Shutdown"),
	(30001,3,30261,"Iron Slave"),
	(30001,3,30262,"Maze Ward"),
	(30001,3,30263,"Ward the Wolf's Den"),
	(30001,3,30264,"All Doors Locked"),
	(30001,3,30265,"Predator's Claim"),
	(30001,3,30266,"Boundary Ward"),
	(30001,3,30267,"Cloak of Mist and Haze"),
	(30001,3,30268,"Heavens Unleashed"),
	(30001,3,30269,"Hunt Under Iron Skies"),
	(30001,3,30270,"Grasp of Howling Winds"),
	(30001,3,30271,"Hunt of Fire and Ice")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

/* Werewolf - Wolf Gifts */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	(30002,3,30400,"Skin Thief"),
	(30002,3,30401,"The Father's Form"),
	(30002,3,30402,"Gaze of the Moon"),
	(30002,3,30403,"Luna's Embrace"),
	(30002,3,30404,"Quicksilver Flesh"),
	(30002,3,30405,"Honed Senses"),
	(30002,3,30406,"Cow the Prey"),
	(30002,3,30407,"Beast Talker"),
	(30002,3,30408,"Tireless Hunter"),
	(30002,3,30409,"Impossible Spoor"),
	(30002,3,30410,"Reflected Facets"),
	(30002,3,30411,"Down the Prey"),
	(30002,3,30412,"Totem's Wrath"),
	(30002,3,30413,"Maw of Madness"),
	(30002,3,30414,"Pack Awareness")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);
	
/* Werewolf - Rites */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	(30003,3,30500,"Chain Rage"),
	(30003,3,30501,"Messenger"),
	(30003,3,30502,"Bottle Secret"),
	(30003,3,30503,"Sacred Hunt"),
	(30003,3,30504,"Kindle Fury"),
	(30003,3,30505,"Shadowbind"),
	(30003,3,30506,"Fetish"),
	(30003,3,30507,"Twilight Purge"),
	(30003,3,30508,"Forge Alliance"),
	(30003,3,30509,"Urfarah's Bane"),
	(30003,3,30510,"Veil"),
	(30003,3,30511,"Banish"),
	(30003,3,30512,"Harness the Cycle"),
	(30003,3,30513,"Totemic Empowerment"),
	(30003,3,30514,"Hunting Ground"),
	(30003,3,30515,"Moon's Mad Love"),
	(30003,3,30516,"Wellspring"),
	(30003,3,30517,"Raiment of the Storm"),
	(30003,3,30518,"Shadowcall"),
	(30003,3,30519,"Supplication"),
	(30003,3,30520,"Hidden Path"),
	(30003,3,30521,"Expel"),
	(30003,3,30522,"Great Hunt")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Werewolf */
	(5,1,"Essence","Essence","Point","Points",2),
	(6,2,"Harmony","Harmony","Dot","Dots",1)

ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);