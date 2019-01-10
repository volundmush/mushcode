

INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(1,"Mortal",NULL)
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES
	/* Mortal Fields */
	(0,"Virtue"),
	(1,"Vice")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	/* Mortal - Virtue and Vice */
	(0,0,1),
	(1,1,1)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* Advantages */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	/* Mortal - Template ID 1 */
	(10005,1,"Supernatural Merit","Supernatural Merits",0),
	(10006,1,"Supernatural Flaw","Supernatural Flaws",0),
	(10007,1,"Mortal Merit","Mortal Merits",0),
	(10008,1,"Mortal Flaw","Mortal Flaws",0),
	(10009,1,"Mortal Style","Mortal Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (10005,15000,15999),
    (10006,16000,16999),
    (10007,17000,17999),
    (10008,18000,18999),
    (10009,19000,19999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);