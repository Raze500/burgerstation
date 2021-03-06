/class/detective
	name = "The Detective"
	desc = "You're a detective. Detectives get bonuses in Resolve, Fortitude, and Endurance, as well as a bonus in Unarmed, Ranged, and Stealth."
	id = "default"

	//Limits:
	//3 ATTRIBUTE_STARTING_PRIMARY
	//3 ATTRIBUTE_STARTING_SECONDARY
	//3 ATTRIBUTE_STARTING_TERTIARY
	//Luck untouched
	attributes = list(
		ATTRIBUTE_STRENGTH = ATTRIBUTE_STARTING_SECONDARY,
		ATTRIBUTE_VITALITY = ATTRIBUTE_STARTING_TERTIARY,
		ATTRIBUTE_FORTITUDE = ATTRIBUTE_STARTING_PRIMARY,

		ATTRIBUTE_INTELLIGENCE = ATTRIBUTE_STARTING_SECONDARY,
		ATTRIBUTE_RESOLVE = ATTRIBUTE_STARTING_PRIMARY,
		ATTRIBUTE_WILLPOWER = ATTRIBUTE_STARTING_TERTIARY,

		ATTRIBUTE_DEXTERITY = ATTRIBUTE_STARTING_TERTIARY,
		ATTRIBUTE_AGILITY = ATTRIBUTE_STARTING_SECONDARY,
		ATTRIBUTE_ENDURANCE = ATTRIBUTE_STARTING_PRIMARY,

		ATTRIBUTE_LUCK = 50
	)


	//Limits
	//3 SKILL_STARTING_PRIMARY
	//2 SKILL_STARTING_SECONDARY
	//6 SKILL_STARTING_TERTIARY
	skills = list(

		SKILL_UNARMED = SKILL_STARTING_PRIMARY,
		SKILL_MELEE = SKILL_STARTING_SECONDARY,
		SKILL_RANGED = SKILL_STARTING_PRIMARY,

		SKILL_BLOCK = SKILL_STARTING_SECONDARY,
		SKILL_DODGE = SKILL_STARTING_TERTIARY,
		SKILL_PARRY = SKILL_STARTING_TERTIARY,

		SKILL_STEALTH = SKILL_STARTING_PRIMARY,
		SKILL_THEFT = SKILL_STARTING_TERTIARY,

		SKILL_ALCHEMY = SKILL_STARTING_TERTIARY,
		SKILL_COOKING = SKILL_STARTING_TERTIARY,
		SKILL_CRAFTING = SKILL_STARTING_TERTIARY,

		//THESE MUST HAVE SKILL_STARTING_NONE
		SKILL_MAGIC_OFFENSIVE = SKILL_STARTING_NONE,
		SKILL_MAGIC_DEFENSIVE = SKILL_STARTING_NONE,
		SKILL_MAGIC_SUPPORT = SKILL_STARTING_NONE,
		SKILL_MAGIC_REALITY = SKILL_STARTING_NONE,
		SKILL_ENCHANTING = SKILL_STARTING_NONE,
		SKILL_LOCKPICKING = SKILL_STARTING_NONE,

	)