/obj/hud/proc/human_hud()

	adding = list(  )
	other = list(  )
	intents = list(  )
	mon_blo = list(  )
	m_ints = list(  )
	mov_int = list(  )
	vimpaired = list(  )
	darkMask = list(  )
	welding = list( )


	g_dither = new h_type( src )
	g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	g_dither.name = "gasmask"
	g_dither.icon_state = "dither12g"
	g_dither.layer = 18
	g_dither.mouse_opacity = 0

	r_dither = new h_type(src)
	r_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	r_dither.name = "thermal glasses"
	r_dither.icon_state = "ditherred"
	r_dither.layer = 18
	r_dither.mouse_opacity = 0

	gray_dither = new h_type(src)
	gray_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	gray_dither.name = "sunglasses"
	gray_dither.icon_state = "dark32"
	gray_dither.layer = 18
	gray_dither.mouse_opacity = 0

	lp_dither = new h_type(src)
	lp_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	lp_dither.name = "mesons"
	lp_dither.icon_state = "ditherlimepulse"
	lp_dither.layer = 18
	lp_dither.mouse_opacity = 0

	breath = new h_type( src )
	breath.screen_loc = "WEST,SOUTH to EAST,NORTH"
	breath.name = "breath"
	breath.icon_state = "breath"
	breath.layer = 18
	breath.mouse_opacity = 0

	//old usingmask effect
	/*using = new h_type( src )
	using.screen_loc = "WEST,SOUTH to EAST,NORTH"
	using.name = "using helmet"
	using.icon_state = "dark128"
	using.layer = 18
	using.mouse_opacity = 0*/

	alien_view = new h_type(src)
	alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	alien_view.name = "Alien"
	alien_view.icon_state = "alien"
	alien_view.layer = 18
	alien_view.mouse_opacity = 0

	blurry = new h_type( src )
	blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	blurry.name = "Blurry"
	blurry.icon_state = "blurry"
	blurry.layer = 17
	blurry.mouse_opacity = 0

	druggy = new h_type( src )
	druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	druggy.name = "Druggy"
	druggy.icon_state = "druggy"
	druggy.layer = 17
	druggy.mouse_opacity = 0

	// station explosion cinematic
	station_explosion = new h_type( src )
	station_explosion.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	station_explosion.icon_state = "start"
	station_explosion.layer = 20
	station_explosion.mouse_opacity = 0
	station_explosion.screen_loc = "1,3"

	var/obj/screen/using

	//usingmask effect from tgstation
	using = new src.h_type( src )
	using.name = "using helmet"
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "3,3 to 5,13"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "5,3 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,13"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "11,3 to 13,13"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "black"
	using.screen_loc = "1,1 to 15,2"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "black"
	using.screen_loc = "1,3 to 2,15"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "black"
	using.screen_loc = "14,3 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	using.icon_state = "black"
	using.screen_loc = "3,14 to 13,15"
	using.layer = 17
	using.mouse_opacity = 0
	welding += using
	//end usingmask effect

	using = new h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	adding += using
	action_intent = using

	using = new h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	adding += using
	move_intent = using

	using = new h_type(src) //Right hud bar
	using.dir = SOUTH
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	adding += using

	using = new h_type(src) //Lower hud bar
	using.dir = EAST
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	adding += using

	using = new h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "arrowleft"
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "arrowright"
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "drop"
	using.icon_state = "act_drop"
	using.screen_loc = ui_dropbutton
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "i_clothing"
	using.dir = SOUTH
	using.icon_state = "center"
	using.screen_loc = ui_iclothing
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon_state = "equip"
	using.screen_loc = ui_oclothing
	using.layer = 19
	adding += using

/*	using = new h_type( src )
	using.name = "headset"
	using.dir = SOUTHEAST
	using.icon_state = "equip"
	using.screen_loc = ui_headset
	using.layer = 19
	if(istype(mymob,/mob/living/carbon/monkey)) using.overlays += blocked
	other += using*/

	using = new h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon_state = "equip"
	using.screen_loc = ui_rhand
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon_state = "equip"
	using.screen_loc = ui_lhand
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "id"
	using.dir = SOUTHWEST
	using.icon_state = "equip"
	using.screen_loc = ui_id
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "mask"
	using.dir = NORTH
	using.icon_state = "equip"
	using.screen_loc = ui_mask
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "back"
	using.dir = NORTHEAST
	using.icon_state = "equip"
	using.screen_loc = ui_back
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "storage1"
	using.icon_state = "pocket"
	using.screen_loc = ui_storage1
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "storage2"
	using.icon_state = "pocket"
	using.screen_loc = ui_storage2
	using.layer = 19
	adding += using

	using = new src.h_type( src )
	using.name = "suit storage"
	//using.icon = ui_style
	using.icon_state = "suit_slot"
	using.screen_loc = ui_sstore1
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "hat storage"
	//using.icon = ui_style
	using.icon_state = "hat_slot"
	using.screen_loc = ui_hstore1
	using.layer = 19
	src.other += using

	using = new h_type( src )
	using.name = "resist"
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "other"
	using.icon_state = "other"
	using.screen_loc = ui_shoes
	using.layer = 20
	adding += using

/*
	using = new h_type( src )
	using.name = "intent"
	using.icon_state = "intent"
	using.screen_loc = "15,15"
	using.layer = 20
	adding += using

	using = new h_type( src )
	using.name = "m_intent"
	using.icon_state = "move"
	using.screen_loc = "15,14"
	using.layer = 20
	adding += using
*/

	using = new h_type( src )
	using.name = "gloves"
	using.icon_state = "gloves"
	using.screen_loc = ui_gloves
	using.layer = 19
	other += using

	using = new h_type( src )
	using.name = "eyes"
	using.icon_state = "glasses"
	using.screen_loc = ui_glasses
	using.layer = 19
	other += using

	using = new h_type( src )
	using.name = "ears"
	using.icon_state = "ears"
	using.screen_loc = ui_ears
	using.layer = 19
	other += using

	using = new h_type( src )
	using.name = "head"
	using.icon_state = "hair"
	using.screen_loc = ui_head
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.name = "shoes"
	using.icon_state = "shoes"
	using.screen_loc = ui_shoes
	using.layer = 19
	other += using

	using = new h_type( src )
	using.name = "belt"
	using.icon_state = "belt"
	using.screen_loc = ui_belt
	using.layer = 19
	adding += using

/*
	using = new h_type( src )
	using.name = "grab"
	using.icon_state = "grab"
	using.screen_loc = "12:-11,15"
	using.layer = 19
	intents += using
	//ICONS
	using = new h_type( src )
	using.name = "hurt"
	using.icon_state = "harm"
	using.screen_loc = "15:-11,15"
	using.layer = 19
	intents += using
	m_ints += using

	using = new h_type( src )
	using.name = "disarm"
	using.icon_state = "disarm"
	using.screen_loc = "14:-10,15"
	using.layer = 19
	intents += using

	using = new h_type( src )
	using.name = "help"
	using.icon_state = "help"
	using.screen_loc = "13:-10,15"
	using.layer = 19
	intents += using
	m_ints += using

	using = new h_type( src )
	using.name = "face"
	using.icon_state = "facing"
	using.screen_loc = "15:-11,14"
	using.layer = 19
	mov_int += using

	using = new h_type( src )
	using.name = "walk"
	using.icon_state = "walking"
	using.screen_loc = "14:-11,14"
	using.layer = 19
	mov_int += using

	using = new h_type( src )
	using.name = "run"
	using.icon_state = "running"
	using.screen_loc = "13:-11,14"
	using.layer = 19
	mov_int += using
*/

	using = new h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	vimpaired += using
	using = new h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	vimpaired += using
	using = new h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	vimpaired += using
	using = new h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	vimpaired += using

	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_throw

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

/*
	mymob.i_select = new /obj/screen( null )
	mymob.i_select.icon_state = "selector"
	mymob.i_select.name = "intent"
	mymob.i_select.screen_loc = "16:-11,15"

	mymob.m_select = new /obj/screen( null )
	mymob.m_select.icon_state = "selector"
	mymob.m_select.name = "moving"
	mymob.m_select.screen_loc = "16:-11,14"
*/

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.internals = new /obj/screen( null )
	mymob.internals.icon_state = "internal0"
	mymob.internals.name = "internal"
	mymob.internals.screen_loc = ui_internal

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.bodytemp = new /obj/screen( null )
	mymob.bodytemp.icon_state = "temp1"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = ui_temp

	mymob.healths = new /obj/screen( null )
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon_state = "black"
	mymob.blind.name = "blind"
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0
	mymob.blind.alpha = 255

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.pain = new /obj/screen( null )
	mymob.pain.icon_state = "blank"
	mymob.pain.name = "pain"
	mymob.pain.screen_loc = "1,1 to 15,15"
	mymob.pain.layer = 17

	mymob.hands = new /obj/screen( null )
	mymob.hands.icon_state = "hand"
	mymob.hands.name = "hand"
	mymob.hands.screen_loc = ui_hand
	mymob.hands.dir = NORTH

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest

	/*/Monkey blockers

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_ears
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_belt
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_shoes
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage2
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_glasses
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_gloves
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage1
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_headset
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_oclothing
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_iclothing
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_id
	using.layer = 20
	mon_blo += using

	using = new h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_head
	using.layer = 20
	mon_blo += using
//Monkey blockers
*/

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'icons/Uristqwerty/food_processor_placeholder.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	//, mymob.i_select, mymob.m_select
	mymob.client.screen += list( mymob.pain, mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.bodytemp, mymob.internals, mymob.fire, mymob.hands, mymob.healths, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += adding + other

	//if(istype(mymob,/mob/living/carbon/monkey)) mymob.client.screen += mon_blo

	return

	/*
	using = new h_type( src )
	using.dir = WEST
	using.screen_loc = "1,3 to 2,3"
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.dir = NORTHEAST
	using.screen_loc = "3,3"
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.dir = NORTH
	using.screen_loc = "3,2"
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.dir = SOUTHEAST
	using.screen_loc = "3,1"
	using.layer = 19
	adding += using

	using = new h_type( src )
	using.dir = SOUTHWEST
	using.screen_loc = "1,1 to 2,2"
	using.layer = 19
	adding += using
	*/