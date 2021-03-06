/damagetype/
	var/name = "Damage type."
	var/id
	var/desc = "The type of damage dealt and all it's information."
	var/list/attack_verbs = list("strike","hit","pummel") //Verbs to use
	var/list/miss_verbs = list("swing")
	var/weapon_name
	var/impact_sounds = list()
	var/miss_sounds = list()

	//var/wound/wound_type

	//How much base attack damage to deal
	var/list/base_attack_damage = list(
		BRUTE = 0,
		BURN = 0,
		TOX = 0,
		OXY = 0
	)

	var/attack_delay = 8
	var/attack_last = 0

	var/list/attribute_stats = list(
		ATTRIBUTE_STRENGTH = CLASS_F,
		ATTRIBUTE_AGILITY = CLASS_F,
		ATTRIBUTE_INTELLIGENCE = CLASS_F
	)

	var/list/attribute_damage = list(
		ATTRIBUTE_STRENGTH = BRUTE,
		ATTRIBUTE_AGILITY = BRUTE,
		ATTRIBUTE_INTELLIGENCE = BRUTE
	)

	var/list/skill_stats = list(
		SKILL_UNARMED = CLASS_F,
		SKILL_MELEE = CLASS_F,
		SKILL_RANGED = CLASS_F
	)

	var/list/skill_damage = list(
		SKILL_UNARMED = BRUTE,
		SKILL_MELEE = BRUTE,
		SKILL_RANGED = BRUTE
	)

	var/list/skill_xp_per_damage = list(
		SKILL_UNARMED = 0,
		SKILL_MELEE = 0,
		SKILL_RANGED = 0
	)

	var/allow_parry = TRUE
	var/allow_parry_counter = TRUE
	var/allow_miss = TRUE
	var/allow_block = TRUE
	var/allow_dodge = TRUE

/damagetype/proc/get_miss_chance()
	return 0

/damagetype/proc/get_attack_type()
	return ATTACK_TYPE_MELEE

/damagetype/proc/perform_miss(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(!victim.get_miss_chance(attacker,weapon,hit_object) + get_miss_chance())
		return FALSE
	do_miss_sound(attacker,victim,weapon,hit_object)
	do_attack_animation(attacker,victim,weapon,hit_object)
	display_miss_message(attacker,victim,weapon,hit_object,"avoided")
	return TRUE

/damagetype/proc/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(attack_last + get_attack_delay(attacker,victim,weapon,hit_object) > world.time)
		return FALSE

	return TRUE

/damagetype/proc/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(!is_living(attacker))
		return base_attack_damage

	var/mob/living/L = attacker
	var/list/new_attack_damage = base_attack_damage.Copy()

	for(var/k in attribute_stats)
		var/v = attribute_stats[k]
		new_attack_damage[attribute_damage[k]] += L.get_attribute_level(k)*v

	for(var/k in skill_stats)
		var/v = skill_stats[k]
		new_attack_damage[skill_damage[k]] += L.get_skill_level(k)*v

	return new_attack_damage

/damagetype/proc/get_attack_delay(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return attack_delay


/damagetype/proc/display_hit_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	attacker.visible_message(\
		get_attack_message_3rd(attacker,victim,weapon,hit_object),\
		get_attack_message_1st(attacker,victim,weapon,hit_object),\
		get_attack_message_sound(attacker,victim,weapon,hit_object)\
	)


/damagetype/proc/display_miss_message(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/miss_text = "misses!")

	attacker.visible_message(\
		replacetext(get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)

/damagetype/proc/do_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(is_living(victim))
		var/mob/living/A = victim
		if(A.status & FLAG_STATUS_IMMORTAL)
			return 0

	var/damage_to_deal = get_attack_damage(attacker,victim,weapon,hit_object)


	var/brute_damage_dealt = hit_object.adjust_brute_loss(damage_to_deal[BRUTE])
	var/burn_damage_dealt = hit_object.adjust_burn_loss(damage_to_deal[BURN])
	var/tox_damage_dealt = hit_object.adjust_tox_loss(damage_to_deal[TOX])
	var/oxy_damage_dealt = hit_object.adjust_oxy_loss(damage_to_deal[OXY])
	var/damage_dealt =  brute_damage_dealt + burn_damage_dealt + tox_damage_dealt + oxy_damage_dealt


	play_effects(attacker,victim,weapon,hit_object)
	display_hit_message(attacker,victim,weapon,hit_object)

	hit_object.update_health(damage_dealt)

	if(victim != hit_object)
		victim.update_health(damage_dealt)

	if(is_living(attacker) && victim && attacker != victim)
		var/mob/living/A = attacker
		for(var/skill in skill_xp_per_damage)
			var/xp_to_give = floor(skill_xp_per_damage[skill] * damage_dealt * victim.get_xp_multiplier())
			if(xp_to_give > 0)
				A.add_skill_xp(skill,xp_to_give)


	return damage_dealt

/damagetype/proc/play_effects(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	do_attack_sound(attacker,victim,weapon,hit_object)
	do_attack_animation(attacker,victim,weapon,hit_object)

/damagetype/proc/do_attack_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(impact_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(impact_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_miss_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(length(miss_sounds))
		var/area/A = get_area(victim)
		play_sound(pick(miss_sounds),all_mobs_with_clients,vector(victim.x,victim.y,victim.z),environment = A.sound_environment)

/damagetype/proc/do_attack_animation(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	var/pixel_x_offset = 0
	var/pixel_y_offset = 0
	var/punch_distance = 12

	if(attacker.dir & NORTH)
		pixel_y_offset = punch_distance

	if(attacker.dir & SOUTH)
		pixel_y_offset = -punch_distance

	if(attacker.dir & EAST)
		pixel_x_offset = punch_distance

	if(attacker.dir & WEST)
		pixel_x_offset = -punch_distance

	if(is_mob(attacker))
		var/mob/M = attacker
		//M.add_animation(pixel_x = movement_x, pixel_y = movement_y, time = 2)
		//M.add_animation(pixel_x = -movement_x, pixel_y = -movement_y, time = 4, delay = 2, time = 4)

		var/matrix/attack_matrix = matrix()
		attack_matrix.Translate(pixel_x_offset,pixel_y_offset)

		animate(M, transform = attack_matrix, time = ATTACK_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
		animate(transform = matrix(), time = ATTACK_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

/damagetype/proc/get_weapon_name(var/atom/backup)
	if(weapon_name)
		return weapon_name
	else
		return backup.name

/damagetype/proc/get_attack_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker] [pick(attack_verbs)]s \the [hit_object] with \the [get_weapon_name(weapon)].")
	else
		return span("danger","\The [attacker] [pick(attack_verbs)]s \the [victim]'s [hit_object.name] with \the [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(attack_verbs)] \the [hit_object] with your [get_weapon_name(weapon)].")
	else
		return span("warning","You [pick(attack_verbs)] \the [victim]'s [hit_object.name] with your [get_weapon_name(weapon)].")

/damagetype/proc/get_attack_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a sickening impact.")

/damagetype/proc/get_miss_message_3rd(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("danger","\The [attacker] [pick(miss_verbs)]s at \the [hit_object] with \the [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("danger","\The [attacker] [pick(miss_verbs)]s at \the [victim]'s [hit_object.name] with \the [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_1st(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	if(victim == hit_object)
		return span("warning","You [pick(miss_verbs)] at \the [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")
	else
		return span("warning","You [pick(miss_verbs)] at \the [victim]'s [hit_object.name] with your [get_weapon_name(weapon)], but the attack was #REASON!")

/damagetype/proc/get_miss_message_sound(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return span("danger","You hear a swoosh...")