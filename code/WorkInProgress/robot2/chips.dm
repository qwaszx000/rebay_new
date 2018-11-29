/obj/machinery/robot2/chip
	var/obj/machinery/robot2/robot/robot = null

/obj/machinery/robot2/chip/event
	name = "Generic event chip"
	icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	icon_state = "mainboard"
	var/datum/robotinstructions/instructions = null

/obj/machinery/robot2/chip/_do
	name = "Do chip"
	icon = 'icons/Uristqwerty/food_processor_placeholder.dmi'
	icon_state = "id_mod"

/obj/machinery/robot2/chip/_do/proc/debug()
	return

/obj/machinery/robot2/chip/_do/proc/trigger()
	return