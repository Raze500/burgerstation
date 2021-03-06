/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	name = "assault rifle"
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/rifle/
	damage_type = "melee_rifle"

	bullet_speed = 31
	shoot_delay = 2

	automatic = TRUE

	bullet_capacity = 1 //One in the chamber

	bullet_type = "7.62"

	shoot_sounds = list('sounds/weapon/ranged/bullet/assault_rifle.ogg')

	can_wield = TRUE

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))