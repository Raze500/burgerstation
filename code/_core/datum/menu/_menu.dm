/menu/
	var/name = "Menu"
	var/id

	var/file
	var/list/resources = list()

	var/size = "300x300"
	var/border = FALSE
	var/can_close = TRUE
	var/can_resize = TRUE
	var/can_minimize = TRUE
	var/show_titlebar = TRUE

/menu/proc/open(var/user)
	//Credit to Multiverse7 for providing the code for getting this to work.
	cache_resources(user)
	winclone(user, "window", id)
	winshow(user,id)
	winset(user, "browser([id])", "parent=[id];type=browser;size=0x0;anchor1=0,0;anchor2=100,100")
	sleep(1) //TODO: OnLoad function here.
	user << output(file, "browser([id])")
	winset(user, "browser([id])", "parent=[id];size=[size]")

/menu/proc/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "browser([id]):eval")

/menu/proc/on_load(var/user)
	//When the browser sucessfully loaded.

/menu/proc/cache_resources(var/user)
	for(var/k in resources)
		var/v = resources[k]
		user << browse_rsc(v,k)

/menu/Topic(href,href_list)
	//Do topic things here.

/proc/open_menu(user,menu_id)
	var/menu/M = all_menus[menu_id]
	M.open(user)


/proc/send_load(user,menu_id) //A common command I use every time I visit your mom.
	var/menu/M = all_menus[menu_id]
	M.on_load(user)
