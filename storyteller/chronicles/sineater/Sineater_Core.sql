INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(8,"Sin-Eater","Psyche")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Sin-Eater */
	(19,8,"Threshold",0),
	(20,8,"Archetype",1)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
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
	(6013,20,"Pilgrim")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);