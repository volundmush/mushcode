INSERT INTO vol_story_templates
	(template_id,template_name,template_playable)
VALUES
	(0,"Universal",0)
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);


INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	/* Universal - Template ID 0 */
	(1,0,"Attribute","Attributes",0),
	(2,0,"Skill","Skills",0),
	(3,0,"Merit","Merits",0),
	(4,0,"Flaw","Flaws",0),
	(5,0,"Style","Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (3,3000,3999),
    (4,4000,4999),
    (5,5000,5999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

/* UNIVERSAL Data - IDs up to 9,999 */
/* Universal Data - Attributes */
INSERT INTO vol_story_stats
	(stat_parent,stat_id,template_id,stat_name,stat_can_set,stat_allows_zero)
VALUES
	(1,20,0,"Intelligence",1,0),
	(1,21,0,"Wits",1,0),
	(1,22,0,"Resolve",1,0),
	(1,23,0,"Strength",1,0),
	(1,24,0,"Dexterity",1,0),
	(1,25,0,"Stamina",1,0),
	(1,26,0,"Presence",1,0),
	(1,27,0,"Manipulation",1,0),
	(1,28,0,"Composure",1,0)
ON DUPLICATE KEY UPDATE stat_parent=VALUES(stat_parent),template_id=VALUES(template_id),stat_name=VALUES(stat_name);

/* Universal Data - Skills */
INSERT INTO vol_story_stats
	(stat_parent,stat_id,template_id,stat_name,stat_can_set,stat_allows_zero,stat_specialties)
VALUES
	/* Skills - Mental */
	(2,29,0,"Academics",1,0,1),
	(2,30,0,"Computer",1,0,1),
	(2,31,0,"Crafts",1,0,1),
	(2,32,0,"Investigation",1,0,1),
	(2,33,0,"Medicine",1,0,1),
	(2,34,0,"Occult",1,0,1),
	(2,35,0,"Politics",1,0,1),
	(2,36,0,"Science",1,0,1),
	
	/* Skills - Physical */
	(2,37,0,"Athletics",1,0,1),
	(2,38,0,"Brawl",1,0,1),
	(2,39,0,"Drive",1,0,1),
	(2,40,0,"Firearms",1,0,1),
	(2,41,0,"Larceny",1,0,1),
	(2,42,0,"Stealth",1,0,1),
	(2,43,0,"Survival",1,0,1),
	(2,44,0,"Weaponry",1,0,1),
	
	/* Skills - Social */
	(2,45,0,"Animal Ken",1,0,1),
	(2,46,0,"Empathy",1,0,1),
	(2,47,0,"Expression",1,0,1),
	(2,48,0,"Intimidation",1,0,1),
	(2,49,0,"Persuasion",1,0,1),
	(2,50,0,"Socialize",1,0,1),
	(2,51,0,"Streetwise",1,0,1),
	(2,52,0,"Subterfuge",1,0,1)
ON DUPLICATE KEY UPDATE stat_parent=VALUES(stat_parent),template_id=VALUES(template_id),stat_name=VALUES(stat_name);
	
INSERT INTO vol_story_stat_defaults
	(template_id,stat_id,stat_value)
VALUES
	/* Attributes */
	(0,20,1),
	(0,21,1),
	(0,22,1),
	(0,23,1),
	(0,24,1),
	(0,25,1),
	(0,26,1),
	(0,27,1),
	(0,28,1),
	/* Skills */
	(0,29,0),
	(0,30,0),
	(0,31,0),
	(0,32,0),
	(0,33,0),
	(0,34,0),
	(0,35,0),
	(0,36,0),
	(0,37,0),
	(0,38,0),
	(0,39,0),
	(0,40,0),
	(0,41,0),
	(0,42,0),
	(0,43,0),
	(0,44,0),
	(0,45,0),
	(0,46,0),
	(0,47,0),
	(0,48,0),
	(0,49,0),
	(0,50,0),
	(0,51,0),
	(0,52,0)
ON DUPLICATE KEY UPDATE stat_value=VALUES(stat_value);

INSERT INTO vol_story_pools_categories
	(pool_category_id,pool_category_name)
VALUES
	(1,"Pool"),
	(2,"Morality")
ON DUPLICATE KEY UPDATE pool_category_name=VALUES(pool_category_name);

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Universal */
	(1,1,"Willpower","Temporary Willpower","Point","Points",0),
	
	/* Mortal and Hunter */
	(2,2,"Integrity","Integrity","Dot","Dots",1),
	
	/* Vampire */
	(3,1,"Vitae","Vitae","Point","Points",2),
	(4,2,"Humanity","Humanity","Dot","Dots",1),
	
	/* Werewolf */
	(5,1,"Essence","Essence","Point","Points",2),
	(6,2,"Harmony","Harmony","Dot","Dots",1),
	
	/* Changeling */
	(7,1,"Glamour","Glamour","Point","Points",2),
	(8,2,"Clarity","Clarity","Dot","Dots",1),
	
	/* Mage */
	(9,1,"Mana","Mana","Point","Points",2),
	(10,2,"Wisdom","Wisdom","Dot","Dots",1),
	
	/* Demon */
	(11,1,"Aether","Aether","Point","Points",2),
	(12,2,"Cover","Cover","Dot","Dots",1),
	
	/* Promethean */
	(13,1,"Pyros","Pyros","Point","Points",2),
	/* Prometheans use Vampire Humanity */
	
	/* Sin-Eater */
	(15,1,"Plasm","Plasm","Point","Points",2),
	(16,2,"Synergy","Synergy","Dot","Dots",1),

	/* Mummy */
	/* It seems Mummies just spend lots of Willpower! */
	(18,2,"Memory","Memory","Dot","Dots",1),
	
	/* Beast */
	(19,2,"Satiety","Satiety","Point","Points",1)

	ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);

INSERT INTO vol_story_xp
	(xp_id,xp_name,xp_sort)
VALUES
	(1,"XP",0),
	(2,"Arcane XP",1)
ON DUPLICATE KEY UPDATE xp_name=VALUES(xp_name),xp_sort=VALUES(xp_sort);

/*
(3,0,201,"Acute Senses",0)
(3,0,202,"Advanced Library",1)
(3,0,203,"Air of Menace",0)
(3,0,204,"Allies",1)
(3,0,205,"Alternate Identity",1)
(3,0,206,"Ambidextrous",0)
(3,0,207,"Anchored",1)
(3,0,208,"Animal Possession",0)
(3,0,209,"Animal Speech",1)
(3,0,210,"Anonymity",0)
(3,0,211,"Apportation",0)
(3,0,212,"Arcadian Metabolism",0)
(3,0,213,"Area of Expertise",0)
(3,0,214,"Armed Restraint",0)
(3,0,215,"Assertive Implement",1)
(3,0,216,"Astral Adept",1)
(3,0,217,"Aura Reading",0)
(3,0,218,"Automatic Writing",0)
(3,0,219,"Automotive Genius",0)
(3,0,220,"Banner-Bearer",1)
(3,0,221,"Barfly",0)
(3,0,222,"Beast Whispers",0)
(3,0,223,"Beloved",1)
(3,0,224,"Biokinesis",0)
(3,0,225,"Biomimicry",0)
(3,0,226,"Bless Amulet",0)
(3,0,227,"Blood or Bone Affinity",1)
(3,0,228,"Body as Weapon",0)
(3,0,229,"Boot Party",0)
(3,0,230,"Brownie's Boon",0)
(3,0,231,"Burrow",1)
(3,0,232,"Call Out",0)
(3,0,233,"Camera Obscura",0)
(3,0,234,"Cheap Shot",0)
(3,0,235,"Choke Hold",0)
(3,0,236,"Citywalker",0)
(3,0,237,"Clairvoyance",1)
(3,0,238,"Clear-Sighted",0)
(3,0,239,"Clinch Strike",0)
(3,0,240,"Cloak of LEaves",0)
(3,0,241,"Closed Book",0)
(3,0,242,"Code of Honor",1)
(3,0,243,"Cohesive Unit",0)
(3,0,244,"Cold Hearted",0)
(3,0,245,"Common Sense",0)
(3,0,246,"Communal Sleeper",0)
(3,0,247,"Consecrate Weapon",0)
(3,0,248,"Contacts",1)
(3,0,249,"Controlled Burn",0)
(3,0,250,"Court Goodwill",1)
(3,0,251,"Covert Operative",0)
(3,0,252,"Crack Driver",0)
(3,0,253,"Creative Tactician",0)
(3,0,254,"Crescent Moon's Birth",0)
(3,0,255,"Curse Effigy",0)
(3,0,256,"Cursed",1)
(3,0,257,"Danger Sense",0)
(3,0,258,"Dark Passenger",1)
(3,0,259,"Deadpan",0)
(3,0,260,"Dedicated Locus",1)
(3,0,261,"Defender",0)
(3,0,262,"Defensive Combat",1)
(3,0,263,"Defensive Dreamscaping",0)
(3,0,264,"Demesne",1)
(3,0,265,"Demolisher",0)
(3,0,266,"Den",1)
(3,0,267,"Detail Oriented",0)
(3,0,268,"Directed Rage",0)
(3,0,269,"Direction Sense",0)
(3,0,270,"Diviner",0)
(3,0,271,"Doppleganger",0)
(3,0,272,"Double Jointed",0)
(3,0,273,"Dream Shaper",0)
(3,0,274,"Dream Warrior",1)
(3,0,275,"Dreamweaver",0)
(3,0,276,"Dull Beacon",0)
(3,0,277,"Efficient Killer",0)
(3,0,278,"Eidetic Memory",0)
(3,0,279,"Embodiment of the Firstborn",1)
(3,0,280,"Empath",0)
(3,0,281,"Empowered to Speak",1)
(3,0,282,"Encyclopedic Knowledge",0)
(3,0,283,"Esoteric Armory",1)
(3,0,284,"Evil Eye",0)
(3,0,285,"Eye for the Strange",0)
(3,0,286,"Fading",0)
(3,0,287,"Fae Mount",1)
(3,0,288,"Faerie Favor",1)
(3,0,289,"Fair Harvest",1)
(3,0,290,"Fame",1)
(3,0,291,"Family Ties",1)
(3,0,292,"Fast Reflexes",0)
(3,0,293,"Fenris-Ur's Blood",0)
(3,0,294,"Fetishism",1)
(3,0,295,"Fighting Finesse",1)
(3,0,296,"Find the Oathbreaker",0)
(3,0,297,"Firebrand",0)
(3,0,298,"Fitful Slumber",0)
(3,0,299,"Fixer",0)
(3,0,300,"Flanking",0)
(3,0,301,"Fleet of Foot",0)
(3,0,302,"Fortified Form",1)
(3,0,303,"Full Moon's Birth",0)
(3,0,304,"Gentrified Bearing",0)
(3,0,305,"Ghost Child",0)
(3,0,306,"Giant",0)
(3,0,307,"Gibbous Moon's Birth",0)
(3,0,308,"Glamour Fasting",0)
(3,0,309,"Goblin Bounty",1)
(3,0,310,"Good Time Management",0)
(3,0,311,"Greyhound",0)
(3,0,312,"Ground and Pound",0)
(3,0,313,"Ground Fighter",0)
(3,0,314,"Grounded",0)
(3,0,315,"Half-Moon's Birth",0)
(3,0,316,"Hallow",1)
(3,0,317,"Hardened Exorcist",0)
(3,0,318,"Hardy",0)
(3,0,319,"Haven",1)
(3,0,320,"Headbutt",0)
(3,0,321,"Hearing Whispers",0)
(3,0,322,"Hedge Brawler",0)
(3,0,323,"Hedge Delver",0)
(3,0,324,"Hedge Sense",0)
(3,0,325,"Hikaon-Ur's Blood",0)
(3,0,326,"Hob Kin",0)
(3,0,327,"Hobbyist Clique",1)
(3,0,328,"Holistic Awareness",0)
(3,0,329,"Hollow",1)
(3,0,330,"Impartial Mediator",0)
(3,0,331,"Incite Ecosystem",0)
(3,0,332,"Indomitable",0)
(3,0,333,"Inherited",0)
(3,0,334,"Insomniac",0)
(3,0,335,"Inspiring",0)
(3,0,336,"Instinctive Defense",0)
(3,0,337,"Interdisciplinary Specialty",1)
(3,0,338,"Investigative Aide",1)
(3,0,339,"Investigative Prodigy",0)
(3,0,340,"Invoke Spirit",1)
(3,0,341,"Iron Chin",0)
(3,0,342,"Iron Skin",0)
(3,0,343,"Iron Stamina",0)
(3,0,344,"Iron Will",0)
(3,0,345,"Kamduis-Ur's Blood",0)
(3,0,346,"Killer Instinct",0)
(3,0,347,"Language",1)
(3,0,348,"Laying on Hands",0)
(3,0,349,"Lethal Mien",0)
(3,0,350,"Liar",0)
(3,0,351,"Library",1)
(3,0,352,"Living Weapon",1)
(3,0,353,"Lodge Armory",1)
(3,0,354,"Lodge Connections",1)
(3,0,355,"Lodge Lorehouse",1)
(3,0,356,"Lodge Sorcery",1)
(3,0,357,"Lodge Stronghold",1)
(3,0,358,"Loved",1)
(3,0,359,"Lucid Dreamer",0)
(3,0,360,"Lurch",1)
(3,0,361,"Magnanimous Totem",1)
(3,0,362,"Mandragora Garden",1)
(3,0,363,"Mantle",1)
(3,0,364,"Manymask",0)
(3,0,365,"Market Sense",0)
(3,0,366,"Meditative Mind",0)
(3,0,367,"Medium",1)
(3,0,368,"Mentor",1)
(3,0,369,"Mind Control",0)
(3,0,370,"Mind of a Madman",0)
(3,0,371,"Moon's Grace",0)
(3,0,372,"Moon-Kissed",1)
(3,0,373,"Multilingual",1)
(3,0,374,"Nest Guardian",1)
(3,0,375,"No Moon's Birth",0)
(3,0,376,"Noblesse Oblige",1)
(3,0,377,"Nowhere to Run",0)
(3,0,378,"Numbing Touch",0)
(3,0,379,"Oathkeeper",0)
(3,0,380,"Omen Sensitivity",0)
(3,0,381,"Pack Bond",1)
(3,0,382,"Pack Dynamics",0)
(3,0,383,"Pandemoniacal",0)
(3,0,384,"Parallel Lives",1)
(3,0,385,"Patient",0)
(3,0,386,"Peacemaker",0)
(3,0,387,"Phalanx Fighter",0)
(3,0,388,"Phantasmagoria",0)
(3,0,389,"Producer",0)
(3,0,390,"Promise of Debt",1)
(3,0,391,"Promise of Love",1)
(3,0,392,"Promise of Loyalty",1)
(3,0,393,"Promise of Protection",1)
(3,0,394,"Promise to Provide",1)
(3,0,395,"Promise to Serve",1)
(3,0,396,"Protected",1)
(3,0,397,"Proxy Voice",1)
(3,0,398,"Psychic Concealment",0)
(3,0,399,"Psychic Onslaught",0)
(3,0,400,"Psychic Poltergeist",0)
(3,0,401,"Psychokinesis",1)
(3,0,402,"Psychokinetic Resistance",0)
(3,0,403,"Psychometry",0)
(3,0,404,"Punch Drunk",0)
(3,0,405,"Punish the Oathbreaker",0)
(3,0,406,"Pusher",0)
(3,0,407,"Quick Draw",1)
(3,0,408,"Raised by Wolves",0)
(3,0,409,"Relentless",0)
(3,0,410,"Relic Attuned",0)
(3,0,411,"Residential Area",1)
(3,0,412,"Resonance Shaper",1)
(3,0,413,"Resources",1)
(3,0,414,"Retain Weapon",0)
(3,0,415,"Retainer",1)
(3,0,416,"Rigid Mask",0)
(3,0,417,"Ritual Savvy",0)
(3,0,418,"Ritual Sorcerer",1)
(3,0,419,"Roadkill",0)
(3,0,420,"Rune Caster",1)
(3,0,421,"Sacrificial Offering",0)
(3,0,422,"Safe Place",1)
(3,0,423,"Safehouse Cache",1)
(3,0,424,"Safehouse Secrecy",1)
(3,0,425,"Sagrim-Ur's Blood",0)
(3,0,426,"Sanctum",1)
(3,0,427,"Scarred",0)
(3,0,428,"Seizing the Edge",0)
(3,0,429,"Self-Control",0)
(3,0,430,"Sense Vows",0)
(3,0,431,"Sexualized",0)
(3,0,432,"Shiv",0)
(3,0,433,"Skolis-Ur's Blood",0)
(3,0,434,"Sleepwalker",0)
(3,0,435,"Sleight of Hand",0)
(3,0,436,"Slippery",0)
(3,0,437,"Small Unit Tactics",0)
(3,0,438,"Small-Framed",0)
(3,0,439,"Sojourner",0)
(3,0,440,"Song in Your Heart",0)
(3,0,441,"Sorcerous Knowledge",1)
(3,0,442,"Sounds of the City",0)
(3,0,443,"Source Sympathy",1)
(3,0,444,"Spin Doctor",0)
(3,0,445,"Spiritual Blockage",0)
(3,0,446,"Stable Trod",1)
(3,0,447,"Staff",1)
(3,0,448,"Status",1)
(3,0,449,"Stigmata",0)
(3,0,450,"Strained",0)
(3,0,451,"Striking Looks",0)
(3,0,452,"Strings of the Heart",0)
(3,0,453,"Subduing Strikes",0)
(3,0,454,"Supernatural Resistance",0)
(3,0,455,"Support Network",1)
(3,0,456,"Survivalist",0)
(3,0,457,"Svikiro",0)
(3,0,458,"Svikiro Channel",0)
(3,0,459,"Svikiro Nganga",0)
(3,0,460,"Svikiro Ridden",0)
(3,0,461,"Sympathetic",0)
(3,0,462,"Table Turner",0)
(3,0,463,"Takes One to Know One",0)
(3,0,464,"Taste",1)
(3,0,465,"Taste of Fear",1)
(3,0,466,"Taste of Gold",1)
(3,0,467,"Taste of Shadow",1)
(3,0,468,"Taste of the Serpent",1)
(3,0,469,"Taste of the Wild",1)
(3,0,470,"Technopathy",0)
(3,0,471,"Telekinesis",0)
(3,0,472,"Telekinetic Evasion",0)
(3,0,473,"Telepathy",0)
(3,0,474,"Tell",1)
(3,0,475,"Temple of Damnation",1)
(3,0,476,"Territorial Advantage",1)
(3,0,477,"Thief of Fate",0)
(3,0,478,"Token",1)
(3,0,479,"Tolerance for Biology",0)
(3,0,480,"Totem",1)
(3,0,481,"Touchstone",1)
(3,0,482,"Trained Observer",0)
(3,0,483,"Transfer Maneuver",0)
(3,0,484,"True Friend",1)
(3,0,485,"Trunk Squeeze",0)
(3,0,486,"Unobtrusive",1)
(3,0,487,"Unseen Sense",1)
(3,0,488,"Untouchable",0)
(3,0,489,"Vengeful Soul",1)
(3,0,490,"Vice-Ridden",1)
(3,0,491,"Virtuous",1)
(3,0,492,"Vitae Hound",1)
(3,0,493,"Warcry",0)
(3,0,494,"Warded Dreams",0)
(3,0,495,"Watch Dog",1)
(3,0,496,"Weakened Bond",1)
(3,0,497,"Weakest Link",0)
(3,0,498,"Workshop",1)
*/