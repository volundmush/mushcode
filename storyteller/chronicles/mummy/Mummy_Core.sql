INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(9,"Mummy","Sekhem")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Mummy */
	(22,9,"Decree",0),
	(23,9,"Guild",1)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);


INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
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
	(7009,23,"Tef-Aabhi")

ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);