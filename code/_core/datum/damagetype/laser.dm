/damagetype/ranged/laser/
	name = "laser"
	id = "none"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BURN,
		ATTRIBUTE_AGILITY = BURN,
		ATTRIBUTE_INTELLIGENCE = BURN
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BURN,
		SKILL_MELEE = BURN,
		SKILL_RANGED = BURN
	)

	skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0.5
	)

/damagetype/ranged/laser/pistol
	name = "laser pistol"
	id = "laser_pistol"

	base_attack_damage = list(
		BRUTE = 0,
		BURN = 10,
		TOX = 0,
		OXY = 0
	)