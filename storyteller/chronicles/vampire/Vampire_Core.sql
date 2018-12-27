INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(2,"Vampire","Blood Potency"),
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);


INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Vampire */
	(20000,2,"Clan",0),
	(20001,2,"Covenant",1),
	(20002,2,"Bloodline",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

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
	(stat_id,template_id,stat_name,stat_name_plural,stat_can_set)
VALUES
	(20000,2,"Discipline","Disciplines",0),
	(20001,2,"Devotion","Devotions",0),
	(20002,2,"Cruac Rite","Cruac Rites",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_name_plural=VALUES(stat_name_plural),stat_can_set=VALUES(stat_can_set);

/* Vampire - Disciplines IDs 20100 to 20199 */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	
	/* Vampire - Disciplines */
	(20000,2,20100,"Animalism"),
	(20000,2,20101,"Auspex"),
	(20000,2,20102,"Celerity"),
	(20000,2,20103,"Dominate"),
	(20000,2,20104,"Majesty"),
	(20000,2,20105,"Nightmare"),
	(20000,2,20106,"Obfuscate"),
	(20000,2,20107,"Protean"),
	(20000,2,20108,"Resilience"),
	(20000,2,20109,"Vigor"),
	(20000,2,20110,"Cruac")
	
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

/* Vampire - Devotions Ids 20200 to 20299 */
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	
	(20001,2,100001,"Body of Will"),
	(20001,2,100001,"Chain of Command"),
	(20001,2,100001,"Cloak of the Gathering"),
	(20001,2,100001,"Conditioning Cross-Contamination"),
	(20001,2,100001,"Cult of Personality"),
	(20001,2,100001,"Enchantment"),
	(20001,2,100001,"Enfeebling Aura"),
	(20001,2,100001,"Foul Grave"),
	(20001,2,100001,"Force of Nature"),
	(20001,2,100001,"Gargoyle's Vigilance"),
	(20001,2,100001,"Hint of Fear"),
	(20001,2,100001,"Juggernaut's Gait"),
	(20001,2,100001,"Quicken Sight"),
	(20001,2,100001,"Reason's Salon"),
	(20001,2,100001,"Riot"),
	(20001,2,100001,"Shared Sight"),
	(20001,2,100001,"Shatter the Shroud"),
	(20001,2,100001,"Stalwart Servant"),
	(20001,2,100001,"Subsude the Lesser Beast"),
	(20001,2,100001,"Summoning"),
	(20001,2,100001,"Sun's Brutal Dreamscape"),
	(20001,2,100001,"Touch of Deprivation"),
	(20001,2,100001,"Undying Familiar"),
	(20001,2,100001,"Wet Dream"),
	(20001,2,100001,"The Wish"),
	(20001,2,100001,"Vermin Flood"),
	(20001,2,100001,"Wraith's Presence")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);
	
/* Vampire - Cruac Rites IDs 20300 to 20399*/
INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES

	(1,2,20300,"Pangs of Proserpina"),
	(2,2,20301,"Rigor Mortis"),
	(3,2,20302,"Cheval"),
	(4,2,20303,"The Hydra's Vitae"),
	(5,2,20304,"Deflection of Wooden Doom"),
	(6,2,20305,"Touch of the Morrigan"),
	(7,2,20306,"Blood Price"),
	(8,2,20307,"Willful Vitae"),
	(9,2,20308,"Blood Blight"),
	(10,2,20309,"Feeding the Crone")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);