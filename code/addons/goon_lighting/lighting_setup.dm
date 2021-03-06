/proc/create_all_lighting_overlays()
	for(var/zlevel = 1 to world.maxz)
		create_lighting_overlays_zlevel(zlevel)

/proc/create_lighting_overlays_zlevel(var/zlevel)
	ASSERT(zlevel)

	for(var/turf/T in block(locate(1, 1, zlevel), locate(world.maxx, world.maxy, zlevel)))
		if(!T.dynamic_lighting)
			continue
		else
			var/area/A = T.loc
			if(!A.dynamic_lighting)
				continue

		getFromPool(/atom/movable/lighting_overlay, T, TRUE)

/world/New()
	. = ..()
	var/benchmark = world.time
	world.log << "Creating lighting overlays..."
	create_all_lighting_overlays()
	world.log << "Lighting overlays took [DECISECONDS_TO_SECONDS(world.time - benchmark)] seconds."
