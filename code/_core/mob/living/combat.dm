/mob/living/proc/add_stun(var/value,var/max_value = 40)

	value = max(value,10)

	if(stun_time > max_value)
		return FALSE

	stun_time = min(max_value,stun_time + value)

	return TRUE

/mob/living/get_attack_delay(var/atom/victim,var/params)
	return attack_delay * (0.5 + 0.5*(1 - get_attribute_power(ATTRIBUTE_DEXTERITY,1,100)))

/mob/living/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_PARRY,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance

/mob/living/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_DODGE,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance

/mob/living/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_BLOCK,1,100)*50 + get_luck_calc(src,0.5,attacker,-0.5)
	return base_chance


/mob/living/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		var/distance = get_dist(attacker,src)
		if(distance <= 1)
			return 0
		else
			return 30 + distance*10
	return 0