INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(1,"Mortal",NULL),
	(11,"Beast","Lair")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Beast */
	(28,11,"Family",0),
	(29,11,"Hunger",1)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES
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

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Beast */
	(19,2,"Satiety","Satiety","Point","Points",1)

ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);