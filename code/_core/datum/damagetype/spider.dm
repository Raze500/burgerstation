/damagetype/unarmed/spider
	name = "Spider Damage"
	id = "spider_bite"
	desc = "The bite of a spider"
	attack_verbs = list("bit","chomp","scratch")
	weapon_name = "fangs"

	base_attack_damage = list(
		BRUTE = 20,
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
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	attack_delay = 5