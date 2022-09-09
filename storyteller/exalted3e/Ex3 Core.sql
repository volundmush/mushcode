INSERT INTO vol_story_templates
	(template_id,template_name,template_playable,template_x_name,template_sort)
VALUES
	(1,"Mortal",1,"Profession",0),
	(2,"Solar",1,"Caste",1),
	(3,"Abyssal",1,"Caste",2),
	(4,"Dragon-Blooded",1,"Aspect",3),
	(5,"Lunar",1,"Caste",4),
	(6,"Sidereal",1,"Caste",5),
	(7,"Liminal",1,"Aspect",6),
	(8,"Exigent",1,"Tier",7),
	(9,"Infernal",1,"Caste",8),
	(10,"Getimian",1,"Caste",9),
	(11,"Alchemical",1,"Caste",10),
	(100,"Martial Arts",0,NULL,80),
	(120,"Sorcery",0,NULL,90),
	(130,"Necromancy",0,NULL,100)
	ON DUPLICATE KEY UPDATE template_name=VALUES(template_name),template_x_name=VALUES(template_x_name),template_sort=VALUES(template_sort);
	
INSERT INTO vol_story_x_splats 
	(x_splat_id,template_id,x_splat_name)
VALUES
	/* Mortal X Splats */
	(10,1,"Warrior"),
	(11,1,"Priest"),
	(12,1,"Savant"),
	(13,1,"Criminal"),
	(14,1,"Broker"),

	/* Solar X Splats */
	(20,2,"Dawn"),
	(21,2,"Zenith"),
	(22,2,"Twilight"),
	(23,2,"Night"),
	(24,2,"Eclipse"),
	
	/* Abyssal X Splats */
	(30,3,"Dusk"),
	(31,3,"Midnight"),
	(32,3,"Daybreak"),
	(33,3,"Day"),
	(34,3,"Moonshadow"),
	
	/* Dragon-Blooded X Splats */
	(40,4,"Air"),
	(41,4,"Earth"),
	(42,4,"Fire"),
	(43,4,"Water"),
	(44,4,"Wood"),
	
	/* Lunar X Splats - Includes the Lost Castes for completionism.*/
	(50,5,"Full Moon"),
	(51,5,"Changing Moon"),
	(52,5,"No Moon"),
	(53,5,"Waning Moon"),
	(54,5,"Waxing Moon"),
	(55,5,"Half Moon"),
	(56,5,"Casteless"),
	
	/* Sidereal X Splats */
	(60,6,"Journeys"),
	(61,6,"Serenity"),
	(62,6,"Battles"),
	(63,6,"Secrets"),
	(64,6,"Endings"),
	
	/* Liminal X Splats */
	(70,7,"Blood"),
	(71,7,"Breath"),
	(72,7,"Flesh"),
	(73,7,"Marrow"),
	(74,7,"Soil"),
	
	/* Exigents X Splats  */
	(80,8,"Terrestrial"),
	(81,8,"Celestial"),

	/* Infernal X Splats */
	(90,9,"Azimuth"),
    (91,9,"Ascendant"),
    (92,9,"Horizon"),
    (93,9,"Nadir"),
    (94,9,"Penumbra"),

    /* Getimian X Splats */
    (100,10,"Spring"),
    (101,10,"Summer"),
    (102,10,"Autumn"),
    (103,10,"Winter"),

    /* Alchemical X Splats */
    (110,11,"Adamant"),
    (111,11,"Orichalcum"),
    (112,11,"Moonsilver"),
    (113,11,"Jade"),
    (114,11,"Starmetal"),
    (115,11,"Soulsteel")

ON DUPLICATE KEY UPDATE x_splat_name=VALUES(x_splat_name);

INSERT INTO vol_story_fields
	(field_id,template_id,field_name)
VALUES

	/* Solar Fields */
	(20,2,"Limit Trigger"),
	
	/* Dragon-Blooded Fields */
	(40,4,"Nation"),
	(41,4,"House"),
	
	/* Full Moon Fields */
	(50,5,"Totem"),

	/* Infernal Fields */
	(90,9,"Shintai")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);
	
	
INSERT INTO vol_story_merit_categories
	(merit_category_id,merit_category_name,merit_category_custom)
VALUES
	(1,"Merit",0),
	(2,"Supernatural Merit",0),
	(3,"Flaw",0),
	(4,"Ritual",1)
ON DUPLICATE KEY UPDATE merit_category_name=VALUES(merit_category_name);
	
INSERT INTO vol_story_stats_categories
	(stat_category_id,stat_category_name,stat_category_custom,stat_category_specialties)
VALUES
	(1,"Advantage",0,0),
	(2,"Attribute",0,0),
	(3,"Ability",0,1),
	(4,"Style",0,0),
	(5,"Craft",1,0),
	(6,"Sorcery",0,0),
	(7,"Necromancy",0,0)
ON DUPLICATE KEY UPDATE stat_category_name=VALUES(stat_category_name),stat_category_custom=VALUES(stat_category_custom),stat_category_specialties=VALUES(stat_category_specialties);
	
INSERT INTO vol_story_stats
	(stat_id,stat_category_id,stat_name,stat_default,stat_sort)
VALUES
	/* Advantages */
	(1000,1,"Essence",1,0),
	(1001,1,"Willpower",5,0),
	
	/* Attributes */
	(2000,2,"Strength",1,1),
	(2001,2,"Dexterity",1,2),
	(2002,2,"Stamina",1,3),
	(2003,2,"Charisma",1,4),
	(2004,2,"Manipulation",1,5),
	(2005,2,"Appearance",1,6),
	(2006,2,"Perception",1,7),
	(2007,2,"Intelligence",1,8),
	(2008,2,"Wits",1,9),

	/* Lunar Charm Categories */
    (2009,1,"Universal",0,100),
	
	/* Abilities */
	(3000,3,"Archery",0,0),
	(3001,3,"Athletics",0,0),
	(3002,3,"Awareness",0,0),
	(3003,3,"Brawl",0,0),
	(3004,3,"Bureaucracy",0,0),
	(3005,3,"Craft",0,0),
	(3006,3,"Dodge",0,0),
	(3007,3,"Integrity",0,0),
	(3008,3,"Investigation",0,0),
	(3009,3,"Larceny",0,0),
	(3010,3,"Linguistics",0,0),
	(3011,3,"Lore",0,0),
	(3012,3,"Martial Arts",0,0),
	(3013,3,"Medicine",0,0),
	(3014,3,"Melee",0,0),
	(3015,3,"Occult",0,0),
	(3016,3,"Performance",0,0),
	(3017,3,"Presence",0,0),
	(3018,3,"Resistance",0,0),
	(3019,3,"Ride",0,0),
	(3020,3,"Sail",0,0),
	(3021,3,"Socialize",0,0),
	(3022,3,"Stealth",0,0),
	(3023,3,"Survival",0,0),
	(3024,3,"Thrown",0,0),
	(3025,3,"War",0,0),
	
	/* Styles */
	(4000,4,"Snake",0,0),
	(4001,4,"Tiger",0,0),
	(4002,4,"Single Point Shining Into the Void",0,0),
	(4003,4,"White Reaper",0,0),
	(4004,4,"Ebon Shadow",0,0),
	(4005,4,"Crane",0,0),
	(4006,4,"Silver-Voiced Nightingale",0,0),
	(4007,4,"Righteous Devil",0,0),
	(4008,4,"Black Claw",0,0),
	(4009,4,"Dreaming Pearl Courtesan",0,0),
	(4010,4,"Steel Devil",0,0),
	
	/* What Fire Has Wrought styles */
	(4011,4,"Air Dragon",0,0),
	(4012,4,"Earth Dragon",0,0),
	(4013,4,"Fire Dragon",0,0),
	(4014,4,"Water Dragon",0,0),
	(4015,4,"Wood Dragon",0,0),
	(4016,4,"Golden Janissary",0,0),
	(4017,4,"Mantis",0,0),
	(4018,4,"White Veil",0,0),

	/* Lunar styles */
    (4019,4,"Centipede",0,0),
    (4020,4,"Falcon",0,0),
    (4021,4,"Laughing Monster",0,0),
    (4022,4,"Swaying Grass Dance",0,0)

	/* Sorcery */
	(6000,6,"Terrestrial",0,1),
	(6001,6,"Celestial",0,2),
	(6002,6,"Solar",0,3),

	/* Necromancy */
	(7000,7,"Ivory",0,1),
	(7001,7,"Shadow",0,2),
	(7002,7,"Void",0,3)

ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name),stat_category_id=VALUES(stat_category_id),stat_default=VALUES(stat_default),stat_sort=VALUES(stat_sort);

-- Solars - All Abilities.
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 2,stat_id FROM vol_story_stats WHERE stat_category_id=3 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Abyssals - All Abilities.
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 3,stat_id FROM vol_story_stats WHERE stat_category_id=3 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Dragon-Blooded - All Abilities
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 4,stat_id FROM vol_story_stats WHERE stat_category_id=3 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Lunars - All Attributes + Universal
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 5,stat_id FROM vol_story_stats WHERE stat_category_id=2 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
INSERT INTO vol_story_wordpower_category (template_id,stat_id) VALUES (5,0) ON DUPLICATE KEY UPDATE stat_id=stat_id;
-- Sidereal - All Abilities
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 6,stat_id FROM vol_story_stats WHERE stat_category_id=3 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Infernal - All Abilities
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 9,stat_id FROM vol_story_stats WHERE stat_category_id=3 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Alchemical - All Attributes
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 11,stat_id FROM vol_story_stats WHERE stat_category_id=2 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Martial Arts
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 100,stat_id FROM vol_story_stats WHERE stat_category_id=4 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Sorcery
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 120,stat_id FROM vol_story_stats WHERE stat_category_id=6 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);
-- Necromancy
INSERT INTO vol_story_wordpower_category (template_id,stat_id) SELECT 130,stat_id FROM vol_story_stats WHERE stat_category_id=7 ON DUPLICATE KEY UPDATE stat_id=VALUES(stat_id);


DROP PROCEDURE IF EXISTS volp_rollable_stats;
DELIMITER $$
CREATE PROCEDURE volp_rollable_stats(IN in_persona_id INT UNSIGNED)
  BEGIN
    SELECT s.stat_name,IF(p.stat_value IS NULL,0,p.stat_value) FROM vol_story_stats AS s LEFT JOIN vol_story_persona_stats AS p ON s.stat_id=p.stat_id AND p.persona_id=in_persona_id WHERE s.stat_category_id<4 OR p.stat_value>0 UNION SELECT CONCAT_WS('/',s1.stat_name,ps.specialty_name),p1.stat_value+ps.specialty_value FROM vol_story_persona_stats_specialties AS ps LEFT JOIN vol_story_persona_stats AS p1 ON p1.stat_id=ps.stat_id AND p1.persona_id=ps.persona_id LEFT JOIN vol_story_stats AS s1 ON s1.stat_id=p1.stat_id WHERE ps.persona_id=in_persona_id;
  END $$
DELIMITER ;
	
INSERT INTO vol_story_pools_categories
	(pool_category_id,pool_category_name)
VALUES
	(1,"Pool"),
	(2,"Track");

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	(1,1,"Willpower","Temporary Willpower","Point","Points",0),
	(2,1,"Personal","Personal Essence","Mote","Motes",5),
	(3,1,"Peripheral","Peripheral Essence","Mote","Motes",10),
	(4,2,"Limit","Limit","Point","Points",100),
	(5,2,"Resonance", "Resonance", "Point", "Points", 100);

	
INSERT INTO vol_story_xp
	(xp_id,xp_name,xp_sort)
VALUES
	(1,"XP",0),
	(2,"Role XP",1),
	(3,"Silver XP",2),
	(4,"Gold XP",3),
	(5,"White XP",4)
ON DUPLICATE KEY UPDATE xp_name=VALUES(xp_name),xp_sort=VALUES(xp_sort);
