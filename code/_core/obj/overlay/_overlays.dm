/obj/overlay
	name = "overlay"
	desc = "overlay object"
	icon = 'icons/invisible.dmi'
	icon_state = "0"

	var/initial_icon
	var/initial_icon_state

/obj/overlay/update_icon()

	var/icon/I = new /icon(initial_icon,initial_icon_state)

	for(var/id in additional_blends)
		var/icon_blend/IB = additional_blends[id]

		if(IB.special_type & ICON_BLEND_MASK)
			var/icon/OI = new (IB.icon,IB.icon_state)
			var/icon/MI = new (initial_icon,initial_icon_state)
			MI.Blend("#FFFFFF",ICON_ADD)
			MI.Blend(OI,ICON_MULTIPLY)
			I.Blend(MI,ICON_OVERLAY)

		else if(IB.special_type & ICON_BLEND_OVERLAY)
			var/icon/OI = new (IB.icon,IB.icon_state)
			OI.Blend(IB.color,ICON_MULTIPLY)
			I.Blend(OI,ICON_OVERLAY)

		if(IB.special_type & ICON_BLEND_COLOR)
			I.Blend(IB.color,ICON_MULTIPLY)


		//world.log << "[IB.id] [IB.icon] [IB.icon_state]"

	icon = I

