INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(7,"Hunter",NULL)
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Hunter */
	(16,7,"Compact",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);


INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
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
	(5020,16,"Vanguard Serial Crimes Unit")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);