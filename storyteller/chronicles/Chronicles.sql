INSERT INTO vol_story_templates
	(template_id,template_name,template_playable)
VALUES
	(0,"Universal",0)
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(1,"Mortal",NULL),
	(6,"Promethean","Azoth"),
	(7,"Hunter",NULL),
	(8,"Sin-Eater","Psyche"),
	(9,"Mummy","Sekhem"),
	(10,"Demon","Primum"),
	(11,"Beast","Lair")
	ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	
	/* Promethean */
	(13,6,"Lineage",0),
	(14,6,"Refinement",1),
	(15,6,"Athanor",2),
	
	/* Hunter */
	(16,7,"Compact",0),
	
	/* Sin-Eater */
	(19,8,"Threshold",0),
	(20,8,"Archetype",1),
	
	/* Mummy */
	(22,9,"Decree",0),
	(23,9,"Guild",1),
	
	/* Demon */
	(25,10,"Incarnation",0),
	(26,10,"Agenda",1),
	
	/* Beast */
	(28,11,"Family",0),
	(29,11,"Hunger",1)
	ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES	
	/* Promethean X Splats - Lineages */
	(4000,13,"Tammuz"),
	(4001,13,"Osiran"),
	(4002,13,"Ulgan"),
	(4003,13,"Galateid"),
	(4004,13,"Frankenstein"),
	(4005,13,"Zeka"),
	
		/* Promethean Y Splats - Refinements */
	(4006,14,"Aurum"),
	(4007,14,"Cuprum"),
	(4008,14,"Ferrum"),
	(4009,14,"Mercurius"),
	(4010,14,"Stannum"),
	(4011,14,"Aes"),
	(4012,14,"Argentum"),
	(4013,14,"Cobalus"),
	(4014,14,"Phosphorum"),
	(4015,14,"Plumbum"),
	(4016,14,"Centimani"),
	
	/* Hunter X Splats - Compacts-Conspiracies */
	(5000,16,"Ahl al-Jabal"),
	(5001,16,"Ashwood Abbey"),
	(5002,16,"The Bear Lodge"),
	(5003,16,"Barrett Commission"),
	(5004,16,"Division Six"),
	(5005,16,"Habibti Ma"),
	(5006,16,"The Hunt Club"),
	(5007,16,"The Illuminated Brotherhood"),
	(5008,16,"Keepers of the Source"),
	(5009,16,"Long Night"),
	(5010,16,"Loyalists of Thule"),
	(5011,16,"Maiden's Blood Sisterhood"),
	(5012,16,"Network Zero"),
	(5013,16,"Night Watch"),
	(5014,16,"Null Mysteriis"),
	(5015,16,"The Promethean Brotherhood"),
	(5016,16,"Talbot Group"),
	(5017,16,"The Union"),
	(5018,16,"Utopia Now"),
	(1509,16,"Aegis Kai Doru"),
	(5010,16,"Ascending Ones"),
	(5011,16,"The Cainite Heresy"),
	(5012,16,"The Cheiron Group"),
	(5013,16,"The Faithful of Shulpae"),
	(5014,16,"Knights of Saint Adrian"),
	(5015,16,"The Knights of Saint George"),
	(5016,16,"Les Mysteres"),
	(5017,16,"Lucifuge"),
	(5018,16,"Malleus Maleficarum"),
	(5019,16,"Task Force: VALKYRIE"),
	(5020,16,"Vanguard Serial Crimes Unit"),
	
	/* Sin-Eater X Splats - Thresholds */
	(6000,19,"Torn"),
	(6001,19,"Silent"),
	(6002,19,"Prey"),
	(6003,19,"Stricken"),
	(6004,19,"Forgotten"),
	
	/* Sin-Eater Y Splats - Archetype */
	(6005,20,"Bonepicker"),
	(6006,20,"Celebrant"),
	(6008,20,"Gatekeeper"),
	(6009,20,"Mourner"),
	(6010,20,"Advocate"),
	(6011,20,"Reaper"),
	(6012,20,"Necromancer"),
	(6013,20,"Pilgrim"),
	
	/* Mummy X Splats - Decrees */
	(7000,22,"Heart"),
	(7001,22,"Spirit"),
	(7002,22,"Essence"),
	(7003,22,"Name"),
	(7004,22,"Shadow"),
	
	/* Mummy Y Splats - Guilds */
	(7005,23,"Maa-Kep"),
	(7006,23,"Mesen-Nebu"),
	(7007,23,"Sesha-Hebsu"),
	(7008,23,"Su-Menent"),
	(7009,23,"Tef-Aabhi"),
	
	/* Demon X Splats - Incarnations */
	(8000,25,"Destroyer"),
	(8001,25,"Guardian"),
	(8002,25,"Messenger"),
	(8003,25,"Psychopomp"),
	(8004,25,"Analyst"),
	
	/* Demon Y Splats - Agendas */
	(8005,26,"Inquisitor"),
	(8006,26,"Integrator"),
	(8007,26,"Saboteur"),
	(8008,26,"Tempter"),
	(8009,26,"Uncalled"),
	
	/* Beast X Splats - Family */
	(9000,28,"Anakim"),
	(9001,28,"Eshmaki"),
	(9002,28,"Makara"),
	(9003,28,"Namtaru"),
	(9004,28,"Ugallu"),
	(9005,28,"Inguma"),
	(9006,28,"Talassii")
	
	/* Beast Y Splats - Hungers */
	(9007,29,"Predator"),
	(9008,29,"Tyrant"),
	(9009,29,"Nemesis"),
	(9010,29,"Ravager"),
	(9011,29,"Collector"),
	(9012,29,"Whisper"),
	(9013,29,"Enabler")
	
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);

/*
INSERT INTO vol_story_z_splats 
	(z_splat_id,template_id,z_splat_name)
VALUES
	 Vampire Z Splats - Bloodlines 
	(20,2,"Amara Havana"),
	(21,2,"Anvari"),
	(22,2,"The Ansam"),
	(23,2,"The Carnival"),
	(24,2,"Ordo Dracul"),

	 Werewolf Z Splats - Lodges 
	(30,3,"Einherjar"),
	(31,3,"Hundred Dogs"),
	(32,3,"Hook Hand"),
	(33,3,"Shield"),
	(34,3,"Roman Ritual"),
	(35,3,"Eaters of the Dead"),
	(36,3,"Chronicle"),
	(37,3,"Gargoyles"),
	
	 Changeling Z Splats - Courts 
	(50,5,"Spring"),
	(51,5,"Summer"),
	(52,5,"Autumn"),
	(53,5,"Winter")
	
	ON DUPLICATE KEY UPDATE z_splat_name=VALUES(z_splat_name);
*/

INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES

	/* Mortal Fields */
	(0,"Virtue"),
	(1,"Vice")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	
	/* Mortal - Virtue and Vice */
	(1,0,1),
	(2,1,1)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);
	

INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_name_plural,stat_can_set)
VALUES
	/* Universal - Template ID 0 */
	(1,0,"Attribute","Attributes",0),
	(2,0,"Skill","Skills",0),
	(3,0,"Merit","Merits",0),
	(4,0,"Flaw","Flaws",0)	
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_name_plural=VALUES(stat_name_plural),stat_can_set=VALUES(stat_can_set);

/* UNIVERSAL Data - IDs up to 9,999 */
/* Universal Data - Attributes */
INSERT INTO vol_story_stats
	(stat_parent,stat_id,template_id,stat_name,stat_can_set,stat_allows_zero)
VALUES
	(1,20,0,"Intelligence",1,0),
	(1,21,0,"Wits",1,0),
	(1,22,0,"Resolve",1,0),
	(1,23,0,"Strength",1,0),
	(1,24,0,"Dexterity",1,0),
	(1,25,2,"Stamina",1,0),
	(1,26,2,"Presence",1,0),
	(1,27,2,"Manipulation",1,0),
	(1,28,2,"Composure",1,0)
ON DUPLICATE KEY UPDATE stat_parent=VALUES(stat_parent),template_id=VALUES(template_id),stat_name=VALUES(stat_name);

/* Universal Data - Skills */
INSERT INTO vol_story_stats
	(stat_parent,stat_id,template_id,stat_name,stat_can_set,stat_allows_zero,stat_specialties)
VALUES
	/* Skills - Mental */
	(2,29,3,"Academics",1,0,1),
	(2,30,3,"Computer",1,0,1),
	(2,31,3,"Crafts",1,0,1),
	(2,32,3,"Investigation",1,0,1),
	(2,33,3,"Medicine",1,0,1),
	(2,34,3,"Occult",1,0,1),
	(2,35,3,"Politics",1,0,1),
	(2,36,3,"Science",1,0,1),
	
	/* Skills - Physical */
	(2,37,3,"Athletics",1,0,1),
	(2,38,3,"Brawl",1,0,1),
	(2,39,3,"Drive",1,0,1),
	(2,40,3,"Firearms",1,0,1),
	(2,41,3,"Larceny",1,0,1),
	(2,42,3,"Stealth",1,0,1),
	(2,43,3,"Survival",1,0,1),
	(2,44,3,"Weaponry",1,0,1),
	
	/* Skills - Social */
	(2,45,3,"Animal Ken",1,0,1),
	(2,46,3,"Empathy",1,0,1),
	(2,47,3,"Expression",1,0,1),
	(2,48,3,"Intimidation",1,0,1),
	(2,49,3,"Persuasion",1,0,1),
	(2,50,3,"Socialize",1,0,1),
	(2,51,3,"Streetwise",1,0,1),
	(2,52,3,"Subterfuge",1,0,1)
	
ON DUPLICATE KEY UPDATE stat_parent=VALUES(stat_parent),template_id=VALUES(template_id),stat_name=VALUES(stat_name);
	
INSERT INTO vol_story_stat_defaults
	(template_id,stat_id,stat_value)
VALUES
	/* Attributes */
	(0,20,1),
	(0,21,1),
	(0,22,1),
	(0,23,1),
	(0,24,1),
	(0,25,1),
	(0,26,1),
	(0,27,1),
	(0,28,1),
	/* Skills */
	(0,29,0),
	(0,30,0),
	(0,31,0),
	(0,32,0),
	(0,33,0),
	(0,34,0),
	(0,35,0),
	(0,36,0),
	(0,37,0),
	(0,38,0),
	(0,39,0),
	(0,40,0),
	(0,41,0),
	(0,42,0),
	(0,43,0),
	(0,44,0),
	(0,45,0),
	(0,46,0),
	(0,47,0),
	(0,48,0),
	(0,49,0),
	(0,50,0),
	(0,51,0),
	(0,52,0)
ON DUPLICATE KEY UPDATE stat_value=VALUES(stat_value);

/* MORTAL Data - IDs 10,000 to 19,999 */



INSERT INTO vol_story_pools_categories
	(pool_category_id,pool_category_name)
VALUES
	(1,"Pool"),
	(2,"Morality")
	
	ON DUPLICATE KEY UPDATE pool_category_name=VALUES(pool_category_name);

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Universal */
	(1,1,"Willpower","Temporary Willpower","Point","Points",0),
	
	/* Mortal and Hunter */
	(2,2,"Integrity","Integrity","Dot","Dots",1),
	
	/* Vampire */
	(3,1,"Vitae","Vitae","Point","Points",2),
	(4,2,"Humanity","Humanity","Dot","Dots",1),
	
	/* Werewolf */
	(5,1,"Essence","Essence","Point","Points",2),
	(6,2,"Harmony","Harmony","Dot","Dots",1),
	
	/* Changeling */
	(7,1,"Glamour","Glamour","Point","Points",2),
	(8,2,"Clarity","Clarity","Dot","Dots",1),
	
	/* Mage */
	(9,1,"Mana","Mana","Point","Points",2),
	(10,2,"Wisdom","Wisdom","Dot","Dots",1),
	
	/* Demon */
	(11,1,"Aether","Aether","Point","Points",2),
	(12,2,"Cover","Cover","Dot","Dots",1),
	
	/* Promethean */
	(13,1,"Pyros","Pyros","Point","Points",2),
	/* Prometheans use Vampire Humanity */
	
	/* Sin-Eater */
	(15,1,"Plasm","Plasm","Point","Points",2),
	(16,2,"Synergy","Synergy","Dot","Dots",1),

	/* Mummy */
	/* It seems Mummies just spend lots of Willpower! */
	(18,2,"Memory","Memory","Dot","Dots",1),
	
	/* Beast */
	(19,2,"Satiety","Satiety","Point","Points",1)

	ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);

INSERT INTO vol_story_xp
	(xp_id,xp_name,xp_sort)
VALUES
	(1,"XP",0),
	(2,"Arcane XP",1)
ON DUPLICATE KEY UPDATE xp_name=VALUES(xp_name),xp_sort=VALUES(xp_sort);