/obj/item/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwy with this."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver_map"
	inhand_icon_state = "screwdriver"
	worn_icon_state = "screwdriver"
	belt_icon_state = "screwdriver"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1 | IS_PLAYER_COLORABLE_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=75)
	attack_verb_continuous = list("stabs")
	attack_verb_simple = list("stab")
	hitsound = 'sound/weapons/bladeslice.ogg'
	usesound = list('sound/items/screwdriver.ogg', 'sound/items/screwdriver2.ogg')
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 1
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 30)
	drop_sound = 'sound/items/handling/screwdriver_drop.ogg'
	pickup_sound =  'sound/items/handling/screwdriver_pickup.ogg'
	sharpness = SHARP_POINTY
	greyscale_config = /datum/greyscale_config/screwdriver
	greyscale_config_inhand_left = /datum/greyscale_config/screwdriver_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/screwdriver_inhand_right
	greyscale_config_belt = /datum/greyscale_config/screwdriver_belt
	/// If the item should be assigned a random color
	var/random_color = TRUE
	/// List of possible random colors
	var/static/list/screwdriver_colors = list(
		"blue" = "#1861d5",
		"red" = "#ff0000",
		"pink" = "#d5188d",
		"brown" = "#a05212",
		"green" = "#0e7f1b",
		"cyan" = "#18a2d5",
		"yellow" = "#ffa500"
	)

/obj/item/screwdriver/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is stabbing [src] into [user.p_their()] [pick("temple", "heart")]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return(BRUTELOSS)

/obj/item/screwdriver/Initialize()
	if(random_color)
		var/our_color = pick(screwdriver_colors)
		set_greyscale(colors=list(screwdriver_colors[our_color]))
	. = ..()
	AddElement(/datum/element/eyestab)

/obj/item/screwdriver/abductor //SKYRAT EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "alien screwdriver"
	desc = "An ultrasonic screwdriver."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "screwdriver_a"
	inhand_icon_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.1
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/screwdriver/abductor/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver_nuke")

/obj/item/screwdriver/power
	name = "hand drill"
	desc = "A simple powered hand drill."
	icon_state = "drill" //SKYRAT EDIT CHANGE
	inhand_icon_state = "drill"
	worn_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25) //done for balance reasons, making them high value for research, but harder to get
	force = 8 //might or might not be too high, subject to change
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 8
	throw_speed = 2
	throw_range = 3//it's heavier than a screw driver/wrench, so it does more damage, but can't be thrown as far
	attack_verb_continuous = list("drills", "screws", "jabs", "whacks")
	attack_verb_simple = list("drill", "screw", "jab", "whack")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 1	// SKYRAT EDIT
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

//SKYRAT EDIT ADDITION BEGIN
	var/powered_toolspeed = 0.4
	var/powered = FALSE

/obj/item/screwdriver/Initialize()
	. = ..()
	update_appearance()

/obj/item/screwdriver/power/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell, null, CALLBACK(src, .proc/turn_off))

/obj/item/screwdriver/power/CtrlClick(mob/user)
	. = ..()
	if(!powered)
		if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
			return
	powered = !powered
	if(powered)
		to_chat(user, "<span class='notice'>You turn [src] on.</span>")
		turn_on()
	else
		to_chat(user, "<span class='notice'>You turn [src] off.</span>")
		turn_off()
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)

/obj/item/screwdriver/power/proc/turn_off()
	powered = FALSE
	toolspeed = initial(toolspeed)
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/item/screwdriver/power/proc/turn_on()
	toolspeed = powered_toolspeed
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/item/screwdriver/power/process(delta_time)
	if(!powered)
		turn_off()
		return
	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		turn_off()
		return

/obj/item/screwdriver/power/update_overlays()
	. = ..()
	if(powered)
		. += mutable_appearance('modular_skyrat/modules/aesthetics/tools/tools.dmi', "drill_on")
	. += "[initial(icon_state)]_[tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"]"
//SKYRAT EDIT END

/obj/item/screwdriver/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] bit."
	. += "[src] is currently [powered ? "powered" : "unpowered"]." //SKYRAT EDIT ADDITION

/obj/item/screwdriver/power/suicide_act(mob/user)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		user.visible_message(span_suicide("[user] is putting [src] to [user.p_their()] temple. It looks like [user.p_theyre()] trying to commit suicide!"))
	else
		user.visible_message(span_suicide("[user] is pressing [src] against [user.p_their()] head! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(loc, 'sound/items/drill_use.ogg', 50, TRUE, -1)
	return(BRUTELOSS)

/obj/item/screwdriver/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		balloon_alert(user, "attached bolt bit")
		//icon_state = "drill_bolt"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		balloon_alert(user, "attached screw bit")
		//icon_state = "drill_screw"
	update_appearance() //SKYRAT EDIT ADDITION

/obj/item/screwdriver/cyborg//SKYRAT EDIT - ICON OVERRIDEN BY AESTHETICS - SEE MODULE
	name = "automated screwdriver"
	desc = "A powerful automated screwdriver, designed to be both precise and quick."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "screwdriver_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE
