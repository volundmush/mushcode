INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(5,"Changeling","Wyrd")
	ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);
	
/* Splat Data */
INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	/* Changeling */
	(10,5,"Seeming",0),
	(11,5,"Kith",1),
	(12,5,"Court",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES	
	/* Changeling X Splats - Seeming */
	(3000,10,"Beast"),
	(3001,10,"Darkling"),
	(3002,10,"Elemental"),
	(3003,10,"Fairest"),
	(3004,10,"Ogre"),
	(3005,10,"Wizened"),
	
	/* Changeling Y Splats - Kiths */
	(3006,11,"Artist"),
	(3007,11,"Bright One"),
	(3008,11,"Chatelaine"),
	(3009,11,"Gristlegrinder"),
	(3010,11,"Helldiver"),
	(3011,11,"Hunterheart"),
	(3012,11,"Leechfinger"),
	(3013,11,"Mirrorskin"),
	(3014,11,"Nightsinger"),
	(3015,11,"Notary"),
	(3016,11,"Playmate"),
	(3017,11,"Snowskin")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);

/* Field Data */
INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES
	(7,"Needle"),
	(8,"Thread")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	(7,7,5),
	(8,8,5)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* Advantages */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_name_plural,stat_can_set)
VALUES	
	(50,5,"Common Contract","Common Contracts",0),
	(51,5,"Royal Contract","Royal Contracts",0),
	(52,5,"Goblin Contract","Goblin Contracts",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_name_plural=VALUES(stat_name_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	/* Changeling - Common Contracts */
	(4000,5,100005,"Hostile Takeover"),
	(4001,5,100005,"Mask of Superiority"),
	(4002,5,100005,"Paralyzing Presence"),
	(4003,5,100005,"Summon the Loyal Servant"),
	(4004,5,100005,"Tumult"),
	(4005,5,100005,"Blessing of Perfection"),
	(4006,5,100005,"Changing Fortunes"),
	(4007,5,100005,"Light-Shy"),
	(4008,5,100005,"Murkblur"),
	(4009,5,100005,"Trivial Reworking"),
	(4010,5,100005,"Glimpse of a Distant Mirror"),
	(4011,5,100005,"Know the Competition"),
	(4012,5,100005,"Portents and Visions"),
	(4013,5,100005,"Read Lucidity"),
	(4014,5,100005,"Walls Have Ears"),
	(4015,5,100005,"Reflections of the Past"),
	(4016,5,100005,"Fae Cunning"),
	(4017,5,100005,"Shared Burden"),
	(4018,5,100005,"Thorns and Brambles"),
	(4019,5,100005,"Trapdoor Spider's Trick"),
	(4020,5,100005,"Boon of the Scuttling Spider"),
	(4021,5,100005,"Dreamsteps"),
	(4022,5,100005,"Neverthread"),
	(4023,5,100005,"Pathfinder"),
	(4024,5,100005,"Seven-League Leap"),
	(4025,5,100005,"Elemental Weapon"),
	(4026,5,100005,"Might of the Terrible Brute"),
	(4027,5,100005,"Overpowering Dread"),
	(4028,5,100005,"Primal Glory"),
	(4029,5,100005,"Touch of Wrath"),
	(4030,5,100005,"Cupid's Arrow"),
	(4031,5,100005,"Dreams of the Earth"),
	(4032,5,100005,"Gift of Warm Breath"),
	(4033,5,100005,"Spring's Kiss"),
	(4034,5,100005,"Wyrd-Faced Stranger"),
	(4035,5,100005,"Baleful Sense"),
	(4036,5,100005,"Child of the Hearth"),
	(4037,5,100005,"Helios' Light"),
	(4038,5,100005,"High Summer's Zeal"),
	(4039,5,100005,"Vigilance of Ares"),
	(4040,5,100005,"Autumn's Fury"),
	(4041,5,100005,"Last Harvest"),
	(4042,5,100005,"Tale of the Baba Yaga"),
	(4043,5,100005,"Twilight's Harbinger"),
	(4044,5,100005,"Witches' Intuition"),
	(4045,5,100005,"The Dragon Knows"),
	(4046,5,100005,"Heart of Ice"),
	(4047,5,100005,"Ice Queen's Call"),
	(4048,5,100005,"Slipknot Dreams"),
	(4049,5,100005,"Touch of Winter"),
	
	/* Changeling - Royal Contracts */
	(5000,5,100006,"Discreet Summons"),
	(5001,5,100006,"Matermind's Gambit"),
	(5002,5,100006,"Pipes of the Beastcaller"),
	(5003,5,100006,"The Royal Court"),
	(5004,5,100006,"Spinning Wheel"),
	(5005,5,100006,"Changeling Hours"),
	(5006,5,100006,"Dance of the Toys"),
	(5007,5,100006,"Hidden Reality"),
	(5008,5,100006,"Stealing the Solid Reflection"),
	(5009,5,100006,"Tatterdemalion's Workshop"),
	(5010,5,100006,"Props and Scenery"),
	(5011,5,100006,"Riddle-Kith"),
	(5012,5,100006,"Skinmask"),
	(5013,5,100006,"Unravel the Tapestry"),
	(5014,5,100006,"Cloak of Night"),
	(5015,5,100006,"Fortifying Presence"),
	(5016,5,100006,"Hedgewall"),
	(5017,5,100006,"Pure Clarity"),
	(5018,5,100006,"Vow of No Compromise"),
	(5019,5,100006,"Whispers of Morning"),
	(5020,5,100006,"Chrysalis"),
	(5021,5,100006,"Flickering Hours"),
	(5022,5,100006,"Leaping Toward Nightfall"),
	(5023,5,100006,"Mirror Walk"),
	(5024,5,100006,"Talon and Wing"),
	(5025,5,100006,"Elemental Fury"),
	(5026,5,100006,"Oathbreaker's Punishment"),
	(5027,5,100006,"Red Revenge"),
	(5028,5,100006,"Relentless Pursuit"),
	(5029,5,100006,"Thief of Reason"),
	(5030,5,100006,"Blessing of Spring"),
	(5031,5,100006,"Gift of Warm Blood"),
	(5032,5,100006,"Pandora's Gift"),
	(5033,5,100006,"Prince of Ivy"),
	(5034,5,100006,"Waking the Inner Fae"),
	(5035,5,100006,"Fiery Tongue"),
	(5036,5,100006,"Flames of Summer"),
	(5037,5,100006,"Helios' Judgement"),
	(5038,5,100006,"Solstice Revelation"),
	(5039,5,100006,"Sunburnt Heart"),
	(5040,5,100006,"Famine's Bulwak"),
	(5041,5,100006,"Mien of the Baba Yaga"),
	(5042,5,100006,"Riding the Falling Leaves"),
	(5043,5,100006,"Sorceror's Rebuke"),
	(5044,5,100006,"Tasting the Harvest"),
	(5045,5,100006,"Ermine's Coat"),
	(5046,5,100006,"Fallow Fields"),
	(5047,5,100006,"Field of Regret"),
	(5048,5,100006,"Mantle of Frost"),
	(5049,5,100006,"Winter's Curse"),
	
	/* Changeling - Goblin Contracts */
	(6000,5,100007,"Blessing of Forgetfulness"),
	(6001,5,100007,"Glib Tongue"),
	(6002,5,100007,"Goblin's Eye"),
	(6003,5,100007,"Goblin's Luck"),
	(6004,5,100007,"Huntsman's Clarion"),
	(6005,5,100007,"Lost Visage"),
	(6006,5,100007,"Mantle Mask"),
	(6007,5,100007,"Sight of Truth and Lies"),
	(6008,5,100007,"Uncanny"),
	(6009,5,100007,"Wayward Guide")
	
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);