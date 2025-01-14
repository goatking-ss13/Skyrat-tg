/obj/item/tickle_feather
	name = "tickling feather"
	desc = "Feather that can be used for tickling or even torturing. Have fun!"
	icon_state = "feather"
	inhand_icon_state = "feather"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/tickle_feather/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(!istype(M, /mob/living/carbon/human))
		return

	var/message = ""

	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			if(M.is_bottomless())
				message = (user == M) ? pick("tickles themselves with the [src]","gently teases their belly with [src]") : pick("teases [M]'s belly with [src]", "uses [src] to tickle [M]'s belly","tickles [M] with [src]")
				if(M.stat != DEAD)
					if(prob(70))
						M.emote(pick("laugh","giggle","twitch","twitch_s"))
					M.do_jitter_animation()
				M.adjustStaminaLoss(4)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
				M.adjustArousal(3)
				user.visible_message("<font color=purple>[user] [message].</font>")
				playsound(loc, pick('sound/items/handling/cloth_drop.ogg', 					//i duplicate this part of code because im useless shitcoder that can't make it work properly without tons of repeating code blocks
            			            'sound/items/handling/cloth_pickup.ogg',				//if you can make it better - go ahead, modify it, please.
        	       	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)	//selfdestruction - 100
			else
				to_chat(user, "<span class='danger'>Looks like [M]'s groin is covered!</span>")
				return

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/genital/badonkers = M.getorganslot(ORGAN_SLOT_BREASTS)
			if(M.is_topless() || badonkers.visibility_preference == GENITAL_ALWAYS_SHOW)
				message = (user == M) ? pick("tickles themselves with the [src]","gently teases their nipples with [src]") : pick("teases [M]'s nipples with [src]", "uses [src] to tickle [M]'s left nipple", "uses [src] to tickle [M]'s right nipple")
				if(M.stat != DEAD)
					if(prob(70))
						M.emote(pick("laugh","giggle","twitch","twitch_s","moan",))
					M.do_jitter_animation()
				M.adjustStaminaLoss(4)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
				M.adjustArousal(3)
				user.visible_message("<font color=purple>[user] [message].</font>")
				playsound(loc, pick('sound/items/handling/cloth_drop.ogg',
            			            'sound/items/handling/cloth_pickup.ogg',
        	       	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)
			else
				to_chat(user, "<span class='danger'>Looks like [M]'s chest is covered!</span>")
				return

		if(BODY_ZONE_L_LEG)
			if(M.has_feet())
				if(M.is_barefoot())
					message = (user == M) ? pick("tickles themselves with the [src]","gently teases their feet with [src]") : pick("teases [M]'s feet with [src]", "uses [src] to tickle [M]'s left foot", "uses [src] to tickle [M]'s toes")
					if(M.stat != DEAD)
						if(prob(70))
							M.emote(pick("laugh","giggle","twitch","twitch_s","moan",))
						M.do_jitter_animation()
					M.adjustStaminaLoss(4)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
					M.adjustArousal(3)
					user.visible_message("<font color=purple>[user] [message].</font>")
					playsound(loc, pick('sound/items/handling/cloth_drop.ogg',
            				            'sound/items/handling/cloth_pickup.ogg',
        	        	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)
				else
					to_chat(user, "<span class='danger'>Looks like [M]'s toes is covered!</span>")
					return
			else
				to_chat(user, "<span class='danger'>Looks like [M] don't have any legs!</span>")
				return

		if(BODY_ZONE_R_LEG)
			if(M.has_feet())
				if(M.is_barefoot())
					message = (user == M) ? pick("tickles themselves with the [src]","gently teases their feet with [src]") : pick("teases [M]'s feet with [src]", "uses [src] to tickle [M]'s right foot", "uses [src] to tickle [M]'s toes")
					if(M.stat != DEAD)
						if(prob(70))
							M.emote(pick("laugh","giggle","twitch","twitch_s","moan",))
						M.do_jitter_animation()
					M.adjustStaminaLoss(4)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
					M.adjustArousal(3)
					user.visible_message("<font color=purple>[user] [message].</font>")
					playsound(loc, pick('sound/items/handling/cloth_drop.ogg',
            				            'sound/items/handling/cloth_pickup.ogg',
        	        	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)

				else
					to_chat(user, "<span class='danger'>Looks like [M]'s toes is covered!</span>")
					return
			else
				to_chat(user, "<span class='danger'>Looks like [M] don't have any legs!</span>")
				return

		if(BODY_ZONE_R_ARM)
			if(M.is_topless())
				message = (user == M) ? pick("tickles themselves with the [src]","gently teases their armpit with [src]") : pick("teases [M]'s right armpit with [src]", "uses [src] to tickle [M]'s right armpit", "uses [src] to tickle [M]'s underarm")
				if(M.stat != DEAD)
					if(prob(70))
						M.emote(pick("laugh","giggle","twitch","twitch_s","moan",))
					M.do_jitter_animation()
				M.adjustStaminaLoss(4)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
				M.adjustArousal(3)
				user.visible_message("<font color=purple>[user] [message].</font>")
				playsound(loc, pick('sound/items/handling/cloth_drop.ogg',
           				            'sound/items/handling/cloth_pickup.ogg',
       	        	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)

			else
				to_chat(user, "<span class='danger'>Looks like [M]'s armpits is covered!</span>")
				return

		if(BODY_ZONE_L_ARM)
			if(M.is_topless())
				message = (user == M) ? pick("tickles themselves with the [src]","gently teases their armpit with [src]") : pick("teases [M]'s left armpit with [src]", "uses [src] to tickle [M]'s left armpit", "Uses [src] to tickle [M]'s underarm")
				if(M.stat != DEAD)
					if(prob(70))
						M.emote(pick("laugh","giggle","twitch","twitch_s","moan",))
					M.do_jitter_animation()
				M.adjustStaminaLoss(4)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tickled", /datum/mood_event/tickled)
				M.adjustArousal(3)
				user.visible_message("<font color=purple>[user] [message].</font>")
				playsound(loc, pick('sound/items/handling/cloth_drop.ogg',
           				            'sound/items/handling/cloth_pickup.ogg',
       	        	    		    'sound/items/handling/cloth_pickup.ogg'), 70, 1, -1)

			else
				to_chat(user, "<span class='danger'>Looks like [M]'s armpits is covered!</span>")
				return

//Mood boost
/datum/mood_event/tickled
	description = "<span class='nicegreen'>Wooh... I was tickled. It was... Funny!</span>\n"
	mood_change = 4
	timeout = 2 MINUTES
