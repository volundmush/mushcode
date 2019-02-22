INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(2,"Vampire","Blood Potency")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);


INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Vampire */
	(20000,2,"Clan",0),
	(20001,2,"Covenant",1),
	(20002,2,"Bloodline",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

/* Splat Data */
INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES 

	/* Vampire X Splats - Clans */
	(20000,20000,"Daeva"),
	(20001,20000,"Gangrel"),
	(20002,20000,"Mekhet"),
	(20003,20000,"Nosferatu"),
	(20004,20000,"Ventrue"),
	
	/* Vampire Y Splats - Covenants */
	(20100,20001,"Carthian Movement"),
	(20101,20001,"Circle of the Crone"),
	(20102,20001,"Invictus"),
	(20103,20001,"Lancea Sanctum"),
	(20104,20001,"Ordo Dracul")
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
	(24,2,"Ordo Dracul")
ON DUPLICATE KEY UPDATE z_splat_name=VALUES(z_splat_name);
*/

/* Vampire Fields - Mask and Dirge */
INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES
	(20000,"Mask"),
	(20001,"Dirge")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	(20000,20000,2),
	(20001,20001,2)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* Vampire Advantages */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	(20000,2,"Discipline","Disciplines",0),
	(20001,2,"Devotion","Devotions",0),
	(20002,2,"Cruac Rite","Cruac Rites",0),
	
	(20007,2,"Vampire Merit","Vampire Merits",0),
    (20008,2,"Vampire Flaw","Vampire Flaws",0),
    (20009,2,"Vampire Style","Vampire Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (20007,27000,27999),
    (20008,28000,28999),
    (20009,29000,29999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

/* Vampire - Disciplines IDs 20100 to 20199 */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	
	/* Vampire - Disciplines */
	(20000,2,20200,"Animalism"),
	(20000,2,20201,"Auspex"),
	(20000,2,20202,"Celerity"),
	(20000,2,20203,"Dominate"),
	(20000,2,20204,"Majesty"),
	(20000,2,20205,"Nightmare"),
	(20000,2,20206,"Obfuscate"),
	(20000,2,20207,"Protean"),
	(20000,2,20208,"Resilience"),
	(20000,2,20209,"Vigor"),
	(20000,2,20210,"Cruac")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

/* Vampire - Devotions Ids 20200 to 20299 */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	
	(20001,2,20400,"Body of Will"),
	(20001,2,20401,"Chain of Command"),
	(20001,2,20402,"Cloak of the Gathering"),
	(20001,2,20403,"Conditioning Cross-Contamination"),
	(20001,2,20404,"Cult of Personality"),
	(20001,2,20405,"Enchantment"),
	(20001,2,20406,"Enfeebling Aura"),
	(20001,2,20407,"Foul Grave"),
	(20001,2,20408,"Force of Nature"),
	(20001,2,20409,"Gargoyle's Vigilance"),
	(20001,2,20410,"Hint of Fear"),
	(20001,2,20411,"Juggernaut's Gait"),
	(20001,2,20412,"Quicken Sight"),
	(20001,2,20413,"Reason's Salon"),
	(20001,2,20414,"Riot"),
	(20001,2,20415,"Shared Sight"),
	(20001,2,20416,"Shatter the Shroud"),
	(20001,2,20417,"Stalwart Servant"),
	(20001,2,20418,"Subsude the Lesser Beast"),
	(20001,2,20419,"Summoning"),
	(20001,2,20420,"Sun's Brutal Dreamscape"),
	(20001,2,20421,"Touch of Deprivation"),
	(20001,2,20422,"Undying Familiar"),
	(20001,2,20423,"Wet Dream"),
	(20001,2,20424,"The Wish"),
	(20001,2,20425,"Vermin Flood"),
	(20001,2,20426,"Wraith's Presence")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);
	
/* Vampire - Cruac Rites IDs 20300 to 20399*/
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	(20002,2,20600,"Pangs of Proserpina"),
	(20002,2,20601,"Rigor Mortis"),
	(20002,2,20602,"Cheval"),
	(20002,2,20603,"The Hydra's Vitae"),
	(20002,2,20604,"Deflection of Wooden Doom"),
	(20002,2,20605,"Touch of the Morrigan"),
	(20002,2,20606,"Blood Price"),
	(20002,2,20607,"Willful Vitae"),
	(20002,2,20608,"Blood Blight"),
	(20002,2,20609,"Feeding the Crone")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Vampire */
	(3,1,"Vitae","Vitae","Point","Points",2),
	(4,2,"Humanity","Humanity","Dot","Dots",1)

ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);