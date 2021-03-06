/obj/item/weapon/ranged/magic/staff
	cost_charge = 10
	total_charge = 1000

/obj/item/weapon/ranged/magic/staff/examine(var/mob/caller)
	..()
	caller.to_chat(span("notice","It has [get_ammo_count()] charges ([total_charge]) remaining."))

/obj/item/weapon/ranged/magic/staff/handle_ammo(var/mob/caller as mob,var/atom/object,location,params)
	total_charge -= cost_charge
	update_icon()

/obj/item/weapon/ranged/magic/staff/get_ammo_count()
	return round(total_charge / cost_charge)

/obj/item/weapon/ranged/magic/staff/fire
	name = "Wand of Fireballs"
	desc = "Shoot fireballs!"
	cost_charge = 1000
	total_charge = 1000

	bullet_speed = 16

	icon = 'icons/obj/items/weapons/ranged/magic/fire.dmi'

	projectile = /obj/projectile/bullet/fireball
	damage_type = /damagetype/sword/

	override_icon_state = TRUE

	shoot_sounds = list('sounds/weapon/ranged/magic/fireball.ogg')

/obj/item/weapon/ranged/magic/staff/fire/New()
	..()
	update_icon()

/obj/item/weapon/ranged/magic/staff/fire/update_icon()

	icon_state = "[initial(icon_state)][get_ammo_count() >= 1 ? "_1" : ""]"

	..()

/obj/item/weapon/ranged/magic/staff/chaos

	name = "Staff of Chaos"
	desc = "Summon Chaos!"
	cost_charge = 250
	total_charge = 1000

	bullet_speed = 10

	bullet_count = 9

	icon = 'icons/obj/items/weapons/ranged/magic/chaos.dmi'

	projectile = /obj/projectile/bullet/chaos
	damage_type = /damagetype/sword/

	shoot_sounds = list('sounds/weapon/ranged/magic/chaos.ogg')


/obj/item/weapon/ranged/magic/staff/chaos/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/bullet_num,var/accuracy)

	var/num = bullet_num/bullet_count

	var/norm_x = sin(num*360)
	var/norm_y = cos(num*360)

	return list(norm_x,norm_y)

/obj/item/weapon/ranged/magic/staff/basic

	name = "Staff of Magic"
	desc = "MAGIC MWISSLE."
	cost_charge = 100
	total_charge = 1000

	bullet_speed = 20

	bullet_count = 1

	icon = 'icons/obj/items/weapons/ranged/magic/basic.dmi'

	projectile = /obj/projectile/bullet/magic_missile
	damage_type = /damagetype/sword/

	shoot_sounds = list('sounds/weapon/ranged/magic/magic_missile.ogg')

/obj/item/weapon/ranged/magic/staff/focus

	name = "Staff of the Rift"
	desc = "Shoot rifts and annoy the shit out of people."
	cost_charge = 100
	total_charge = 1000

	bullet_speed = 31

	bullet_count = 1

	icon = 'icons/obj/items/weapons/ranged/magic/focus.dmi'

	projectile = /obj/projectile/bullet/rift
	damage_type = /damagetype/sword/

	shoot_sounds = list('sounds/weapon/ranged/magic/teleport_out.ogg')

