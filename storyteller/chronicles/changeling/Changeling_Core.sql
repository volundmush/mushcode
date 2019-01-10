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
	(50000,5,"Seeming",0),
	(50001,5,"Kith",1),
	(50002,5,"Court",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES	
	/* Changeling X Splats - Seeming */
	(50000,50000,"Beast"),
	(50001,50000,"Darkling"),
	(50002,50000,"Elemental"),
	(50003,50000,"Fairest"),
	(50004,50000,"Ogre"),
	(50005,50000,"Wizened"),
	
	/* Changeling Y Splats - Kiths */
	(50010,50001,"Artist"),
	(50011,50001,"Bright One"),
	(50012,50001,"Chatelaine"),
	(50013,50001,"Gristlegrinder"),
	(50014,50001,"Helldiver"),
	(50015,50001,"Hunterheart"),
	(50016,50001,"Leechfinger"),
	(50017,50001,"Mirrorskin"),
	(50018,50001,"Nightsinger"),
	(50019,50001,"Notary"),
	(50020,50001,"Playmate"),
	(50021,50001,"Snowskin"),

     /* Changeling Z Splats - Courts */
    (50030,50002,"Spring"),
    (50031,50002,"Summer"),
    (50032,50002,"Autumn"),
    (50033,50002,"Winter")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);

/* Field Data */
INSERT INTO vol_story_fields
	(field_id,field_name)
VALUES
	(50000,"Needle"),
	(50001,"Thread")
ON DUPLICATE KEY UPDATE field_name=VALUES(field_name);

INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES
	(50000,50000,5),
	(50001,50001,5)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* Advantages */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES	
	(50000,5,"Common Contract","Common Contracts",0),
	(50001,5,"Royal Contract","Royal Contracts",0),
	(50002,5,"Goblin Contract","Goblin Contracts",0),

	(50007,5,"Changeling Merit","Changeling Merits",0),
	(50008,5,"Changeling Flaw","Changeling Flaws",0),
	(50009,5,"Changeling Style","Changeling Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (50007,57000,57999),
    (50008,58000,58999),
    (50009,59000,59999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name)
VALUES
	/* Changeling - Common Contracts */
	(50000,5,50100,"Hostile Takeover"),
	(50000,5,50101,"Mask of Superiority"),
	(50000,5,50102,"Paralyzing Presence"),
	(50000,5,50102,"Summon the Loyal Servant"),
	(50000,5,50103,"Tumult"),
	(50000,5,50104,"Blessing of Perfection"),
	(50000,5,50105,"Changing Fortunes"),
	(50000,5,50106,"Light-Shy"),
	(50000,5,50107,"Murkblur"),
	(50000,5,50108,"Trivial Reworking"),
	(50000,5,50109,"Glimpse of a Distant Mirror"),
	(50000,5,50110,"Know the Competition"),
	(50000,5,50111,"Portents and Visions"),
	(50000,5,50112,"Read Lucidity"),
	(50000,5,50113,"Walls Have Ears"),
	(50000,5,50114,"Reflections of the Past"),
	(50000,5,50115,"Fae Cunning"),
	(50000,5,50116,"Shared Burden"),
	(50000,5,50117,"Thorns and Brambles"),
	(50000,5,50118,"Trapdoor Spider's Trick"),
	(50000,5,50119,"Boon of the Scuttling Spider"),
	(50000,5,50120,"Dreamsteps"),
	(50000,5,50121,"Neverthread"),
	(50000,5,50122,"Pathfinder"),
	(50000,5,50123,"Seven-League Leap"),
	(50000,5,50124,"Elemental Weapon"),
	(50000,5,50125,"Might of the Terrible Brute"),
	(50000,5,50126,"Overpowering Dread"),
	(50000,5,50127,"Primal Glory"),
	(50000,5,50128,"Touch of Wrath"),
	(50000,5,50129,"Cupid's Arrow"),
	(50000,5,50130,"Dreams of the Earth"),
	(50000,5,50131,"Gift of Warm Breath"),
	(50000,5,50132,"Spring's Kiss"),
	(50000,5,50133,"Wyrd-Faced Stranger"),
	(50000,5,50134,"Baleful Sense"),
	(50000,5,50135,"Child of the Hearth"),
	(50000,5,50136,"Helios' Light"),
	(50000,5,50137,"High Summer's Zeal"),
	(50000,5,50138,"Vigilance of Ares"),
	(50000,5,50139,"Autumn's Fury"),
	(50000,5,50140,"Last Harvest"),
	(50000,5,50141,"Tale of the Baba Yaga"),
	(50000,5,50142,"Twilight's Harbinger"),
	(50000,5,50143,"Witches' Intuition"),
	(50000,5,50144,"The Dragon Knows"),
	(50000,5,50144,"Heart of Ice"),
	(50000,5,50145,"Ice Queen's Call"),
	(50000,5,50146,"Slipknot Dreams"),
	(50000,5,50147,"Touch of Winter"),
	
	/* Changeling - Royal Contracts */
	(50001,5,50300,"Discreet Summons"),
	(50001,5,50301,"Matermind's Gambit"),
	(50001,5,50302,"Pipes of the Beastcaller"),
	(50001,5,50303,"The Royal Court"),
	(50001,5,50304,"Spinning Wheel"),
	(50001,5,50305,"Changeling Hours"),
	(50001,5,50306,"Dance of the Toys"),
	(50001,5,50307,"Hidden Reality"),
	(50001,5,50308,"Stealing the Solid Reflection"),
	(50001,5,50309,"Tatterdemalion's Workshop"),
	(50001,5,50310,"Props and Scenery"),
	(50001,5,50311,"Riddle-Kith"),
	(50001,5,50312,"Skinmask"),
	(50001,5,50313,"Unravel the Tapestry"),
	(50001,5,50314,"Cloak of Night"),
	(50001,5,50315,"Fortifying Presence"),
	(50001,5,50316,"Hedgewall"),
	(50001,5,50317,"Pure Clarity"),
	(50001,5,50318,"Vow of No Compromise"),
	(50001,5,50319,"Whispers of Morning"),
	(50001,5,50320,"Chrysalis"),
	(50001,5,50321,"Flickering Hours"),
	(50001,5,50322,"Leaping Toward Nightfall"),
	(50001,5,50323,"Mirror Walk"),
	(50001,5,50324,"Talon and Wing"),
	(50001,5,50325,"Elemental Fury"),
	(50001,5,50326,"Oathbreaker's Punishment"),
	(50001,5,50327,"Red Revenge"),
	(50001,5,50328,"Relentless Pursuit"),
	(50001,5,50329,"Thief of Reason"),
	(50001,5,50330,"Blessing of Spring"),
	(50001,5,50331,"Gift of Warm Blood"),
	(50001,5,50332,"Pandora's Gift"),
	(50001,5,50333,"Prince of Ivy"),
	(50001,5,50334,"Waking the Inner Fae"),
	(50001,5,50335,"Fiery Tongue"),
	(50001,5,50336,"Flames of Summer"),
	(50001,5,50337,"Helios' Judgement"),
	(50001,5,50338,"Solstice Revelation"),
	(50001,5,50339,"Sunburnt Heart"),
	(50001,5,50340,"Famine's Bulwak"),
	(50001,5,50341,"Mien of the Baba Yaga"),
	(50001,5,50342,"Riding the Falling Leaves"),
	(50001,5,50343,"Sorceror's Rebuke"),
	(50001,5,50344,"Tasting the Harvest"),
	(50001,5,50345,"Ermine's Coat"),
	(50001,5,50346,"Fallow Fields"),
	(50001,5,50347,"Field of Regret"),
	(50001,5,50348,"Mantle of Frost"),
	(50001,5,50349,"Winter's Curse"),
	
	/* Changeling - Goblin Contracts */
	(50002,5,50500,"Blessing of Forgetfulness"),
	(50002,5,50501,"Glib Tongue"),
	(50002,5,50502,"Goblin's Eye"),
	(50002,5,50503,"Goblin's Luck"),
	(50002,5,50504,"Huntsman's Clarion"),
	(50002,5,50505,"Lost Visage"),
	(50002,5,50506,"Mantle Mask"),
	(50002,5,50507,"Sight of Truth and Lies"),
	(50002,5,50508,"Uncanny"),
	(50002,5,50509,"Wayward Guide")
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);