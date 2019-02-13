/subsystem/client/
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = 1
	priority = SS_ORDER_CLIENT

/subsystem/client/on_life()
	for(var/client/C in all_clients)
		if(!C.mob)
			continue
		C.mob.on_life_client()

	return TRUE