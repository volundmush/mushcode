INSERT INTO vol_story_templates
	(template_id,template_name,template_playable)
VALUES
	(0,"Universal",0)
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);


INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	/* Universal - Template ID 0 */
	(1,0,"Attribute","Attributes",0),
	(2,0,"Skill","Skills",0),
	(3,0,"Merit","Merits",0),
	(4,0,"Flaw","Flaws",0),
	(5,0,"Style","Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (3,3000,3999),
    (4,4000,4999),
    (5,5000,5999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

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
	(1,25,0,"Stamina",1,0),
	(1,26,0,"Presence",1,0),
	(1,27,0,"Manipulation",1,0),
	(1,28,0,"Composure",1,0)
ON DUPLICATE KEY UPDATE stat_parent=VALUES(stat_parent),template_id=VALUES(template_id),stat_name=VALUES(stat_name);

/* Universal Data - Skills */
INSERT INTO vol_story_stats
	(stat_parent,stat_id,template_id,stat_name,stat_can_set,stat_allows_zero,stat_specialties)
VALUES
	/* Skills - Mental */
	(2,29,0,"Academics",1,0,1),
	(2,30,0,"Computer",1,0,1),
	(2,31,0,"Crafts",1,0,1),
	(2,32,0,"Investigation",1,0,1),
	(2,33,0,"Medicine",1,0,1),
	(2,34,0,"Occult",1,0,1),
	(2,35,0,"Politics",1,0,1),
	(2,36,0,"Science",1,0,1),
	
	/* Skills - Physical */
	(2,37,0,"Athletics",1,0,1),
	(2,38,0,"Brawl",1,0,1),
	(2,39,0,"Drive",1,0,1),
	(2,40,0,"Firearms",1,0,1),
	(2,41,0,"Larceny",1,0,1),
	(2,42,0,"Stealth",1,0,1),
	(2,43,0,"Survival",1,0,1),
	(2,44,0,"Weaponry",1,0,1),
	
	/* Skills - Social */
	(2,45,0,"Animal Ken",1,0,1),
	(2,46,0,"Empathy",1,0,1),
	(2,47,0,"Expression",1,0,1),
	(2,48,0,"Intimidation",1,0,1),
	(2,49,0,"Persuasion",1,0,1),
	(2,50,0,"Socialize",1,0,1),
	(2,51,0,"Streetwise",1,0,1),
	(2,52,0,"Subterfuge",1,0,1)
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
	(1,1,"Willpower","Temporary Willpower","Point","Points",0)

ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);

INSERT INTO vol_story_xp
	(xp_id,xp_name,xp_sort)
VALUES
	(1,"XP",0),
	(2,"Super XP",1)
ON DUPLICATE KEY UPDATE xp_name=VALUES(xp_name),xp_sort=VALUES(xp_sort);