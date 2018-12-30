INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(10,"Demon","Primum")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Demon */
	(25,10,"Incarnation",0),
	(26,10,"Agenda",1)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
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
	(8009,26,"Uncalled")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);