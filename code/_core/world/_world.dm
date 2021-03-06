var/global/list/active_subsystems
var/global/curtime = 0
var/global/ticks = 0

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 0

/world/New()
	log = file("logs/mylog.txt")
	..()
	life()


/world/proc/update_status()

	var/server_name = "Burgerstation 13"
	var/server_link = "https://discord.gg/yEaV92a"
	//var/github_link = "https://github.com/BurgerLUA/burgerstation"
	var/github_name = "Space Station 13 Code <b>FROM SCRATCH</b>"
	var/gamemode = "Team Deathmatch"

	var/minutes = floor(curtime / 600) % 60
	var/hours = floor(curtime / 12000)

	if(minutes < 10)
		minutes = "0[minutes]"

	var/duration = "[hours]:[minutes]"
	var/map = "Square Arena(64x64x1)"

	//Format it.
	status = "<a href='[server_link]'><b>[server_name]</b></a>] ([github_name])<br><br>"
	status += "Currently playing: <b>[gamemode]</b><br>"
	status += "Map: <b>[map]</b><br>"
	status += "Round Duration: <b>[duration]</b>"

/world/proc/life()
	set background = TRUE

	world.log << "STARTING WORLD."

	active_subsystems = new(SS_ORDER_SIZE)

	update_status()

	var/benchmark = world.time

	world.log << "STARTING WORLD."

	for(var/S in subtypesof(/subsystem/))
		var/subsystem/new_subsystem = new S
		if(!new_subsystem.priority)
			qdel(S)
			continue
		active_subsystems[new_subsystem.priority] = new_subsystem

	world.log << "Subsystem Creation took [DECISECONDS_TO_SECONDS(world.time - benchmark)] seconds."

	benchmark = world.time

	var/first_run = TRUE

	spawn while(TRUE)
		for(var/subsystem/S in active_subsystems)
			if(!S.tick_rate || S.next_run <= ticks)
				if(!S.on_life())
					active_subsystems -= S
					qdel(S)
					continue
				S.next_run = ticks + S.tick_rate

		if(first_run)
			world.log << "First time initialization took [DECISECONDS_TO_SECONDS(world.time - benchmark)] seconds."

		first_run = FALSE

		curtime = round(curtime + TICK_LAG,TICK_LAG)
		ticks += 1
		sleep(tick_lag)


