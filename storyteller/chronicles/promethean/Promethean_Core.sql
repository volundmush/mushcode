INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(6,"Promethean","Azoth")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES

	(13,6,"Lineage",0),
	(14,6,"Refinement",1),
	(15,6,"Athanor",2)
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
	(4016,14,"Centimani")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);
