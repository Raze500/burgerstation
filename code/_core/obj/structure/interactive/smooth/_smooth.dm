obj/structure/smooth/
	name = "table"
	desc = "What does it do?"
	icon = 'icons/obj/structure/modern/table.dmi'
	icon_state = "table"

	var/corner_category = "none"
	var/corner_icons = TRUE

obj/structure/smooth/proc/same_object(var/obj/structure/smooth/A)
	return A.corner_category == corner_category

obj/structure/smooth/update_icon()

	if(!corner_icons)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		calc_list[direction_to_text(d)] = FALSE
		var/turf/T = get_step(src,d)
		if(!T)
			continue
		for(var/obj/structure/smooth/A in T.contents)
			if(same_object(A))
				calc_list[direction_to_text(d)] = TRUE
				break

	var/ne = ""
	var/nw = ""
	var/sw = ""
	var/se = ""

	if(calc_list["north"])
		ne += "n"
		nw += "n"
	if(calc_list["south"])
		se += "s"
		sw += "s"
	if(calc_list["east"])
		ne += "e"
		se += "e"
	if(calc_list["west"])
		nw += "w"
		sw += "w"

	if(nw == "nw" && calc_list["northwest"])
		nw = "f"

	if(ne == "ne" && calc_list["northeast"])
		ne = "f"

	if(sw == "sw" && calc_list["southwest"])
		sw = "f"

	if(se == "se" && calc_list["southeast"])
		se = "f"

	if(!ne) ne = "i"
	if(!nw) nw = "i"
	if(!se) se = "i"
	if(!sw) sw = "i"

	var/icon/I = ICON_INVISIBLE

	var/icon/NW = new /icon(icon,"1-[nw]")
	I.Blend(NW,ICON_OVERLAY)

	var/icon/NE = new /icon(icon,"2-[ne]")
	I.Blend(NE,ICON_OVERLAY)

	var/icon/SW = new /icon(icon,"3-[sw]")
	I.Blend(SW,ICON_OVERLAY)

	var/icon/SE = new /icon(icon,"4-[se]")
	I.Blend(SE,ICON_OVERLAY)

	icon = I
	pixel_x = (32 - I.Width())/2
	pixel_y = (32 - I.Height())/2
	layer = initial(layer) + 0.1