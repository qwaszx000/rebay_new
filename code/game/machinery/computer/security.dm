/obj/machinery/computer/secure_data/attackby(obj/I, mob/user)
	if (istype(I, /obj/item/weapon/disk/data))
		if (!src.diskette)
			user.drop_item(I)
			I.loc = src
			src.diskette = I
			user << "You insert [I]."
			src.updateUsrDialog()
			return
	else if(istype(I, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				var/obj/computerframe/A = new /obj/computerframe( src.loc )
				new /obj/item/weapon/shard( src.loc )
				var/obj/item/weapon/circuitboard/secure_data/M = new /obj/item/weapon/circuitboard/secure_data( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.anchored = 1
				del(src)
			else
				user << "\blue You disconnect the monitor."
				var/obj/computerframe/A = new /obj/computerframe( src.loc )
				var/obj/item/weapon/circuitboard/secure_data/M = new /obj/item/weapon/circuitboard/secure_data( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.anchored = 1
				del(src)
	else
		src.attack_hand(user)
	return

/obj/machinery/computer/secure_data/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/secure_data/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/secure_data/attack_hand(mob/user as mob)
	if(..())
		return
	var/dat
	if (src.temp)
		dat = text("<TT>[]</TT><BR><BR><A href='?src=\ref[];temp=1'>Clear Screen</A>", src.temp, src)
	else
		dat = text("Confirm Identity: <A href='?src=\ref[];scan=1'>[]</A><HR>", src, (src.scan ? text("[]", src.scan.name) : "----------"))
		if (src.authenticated)
			switch(src.screen)
				if(1.0)
					dat += text("<A href='?src=\ref[src];search=1'>Search Records</A><BR>\n<A href='?src=\ref[src];list=1'>List Records</A><BR>\n<A href='?src=\ref[src];search_f=1'>Search Fingerprints</A><BR>\n<A href='?src=\ref[src];new_r=1'>New Record</A><BR>\n<BR>\n<A href='?src=\ref[src];rec_m=1'>Record Maintenance</A><BR>\n<A href='?src=\ref[src];logout=1'>{Log Out}</A><BR>\n")
				if(2.0)
					dat += "<B>Record List</B>:<HR>"
					for(var/datum/data/record/R in data_core.general)
						dat += text("<A href='?src=\ref[];d_rec=\ref[]'>[]: []<BR>", src, R, R.fields["id"], R.fields["name"])
						//Foreach goto(136)
					dat += text("<HR><A href='?src=\ref[];main=1'>Back</A>", src)
				if(3.0)
					dat += text("<B>Records Maintenance</B><HR>\n<A href='?src=\ref[];back=1'>Backup To Disk</A><BR>\n<A href='?src=\ref[];u_load=1'>Upload From disk</A><BR>\n<A href='?src=\ref[];del_all=1'>Delete All Records</A><BR>\n<BR>\n<A href='?src=\ref[];main=1'>Back</A>", src, src, src, src)
				if(4.0)
					dat += "<CENTER><B>Security Record</B></CENTER><BR>"
					if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
						dat += text("Name: <A href='?src=\ref[];field=name'>[]</A> ID: <A href='?src=\ref[];field=id'>[]</A><BR>\nSex: <A href='?src=\ref[];field=sex'>[]</A><BR>\nAge: <A href='?src=\ref[];field=age'>[]</A><BR>\nRank: <A href='?src=\ref[];field=rank'>[]</A><BR>\nFingerprint: <A href='?src=\ref[];field=fingerprint'>[]</A><BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src, src.active1.fields["name"], src, src.active1.fields["id"], src, src.active1.fields["sex"], src, src.active1.fields["age"], src, src.active1.fields["rank"], src, src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
					else
						dat += "<B>General Record Lost!</B><BR>"
					if ((istype(src.active2, /datum/data/record) && data_core.security.Find(src.active2)))
						dat += text("<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: <A href='?src=\ref[];field=criminal'>[]</A><BR>\n<BR>\nMinor Crimes: <A href='?src=\ref[];field=mi_crim'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=mi_crim_d'>[]</A><BR>\n<BR>\nMajor Crimes: <A href='?src=\ref[];field=ma_crim'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=ma_crim_d'>[]</A><BR>\n<BR>\nImportant Notes:<BR>\n\t<A href='?src=\ref[];field=notes'>[]</A><BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src, src.active2.fields["criminal"], src, src.active2.fields["mi_crim"], src, src.active2.fields["mi_crim_d"], src, src.active2.fields["ma_crim"], src, src.active2.fields["ma_crim_d"], src, src.active2.fields["notes"])
						var/counter = 1
						while(src.active2.fields[text("com_[]", counter)])
							dat += text("[]<BR><A href='?src=\ref[];del_c=[]'>Delete Entry</A><BR><BR>", src.active2.fields[text("com_[]", counter)], src, counter)
							counter++
						dat += text("<A href='?src=\ref[];add_c=1'>Add Entry</A><BR><BR>", src)
						dat += text("<A href='?src=\ref[];del_r=1'>Delete Record (Security Only)</A><BR><BR>", src)
					else
						dat += "<B>Security Record Lost!</B><BR>"
						dat += text("<A href='?src=\ref[];new=1'>New Record</A><BR><BR>", src)
					dat += text("\n<A href='?src=\ref[];dela_r=1'>Delete Record (ALL)</A><BR><BR>\n<A href='?src=\ref[];print_p=1'>Print Record</A><BR>\n<A href='?src=\ref[];list=1'>Back</A><BR>", src, src, src)
				else
		else
			dat += text("<A href='?src=\ref[];login=1'>{Log In}</A>", src)
	user << browse(text("<HEAD><TITLE>Security Records</TITLE></HEAD><TT>[]</TT>", dat), "window=secure_rec")
	onclose(user, "secure_rec")
	return

/obj/machinery/computer/secure_data/Topic(href, href_list)
	if(..())
		return
	if (!( data_core.general.Find(src.active1) ))
		src.active1 = null
	if (!( data_core.security.Find(src.active2) ))
		src.active2 = null
	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.machine = src
		if (href_list["temp"])
			src.temp = null
		if (href_list["scan"])
			if (src.scan)
				src.scan.loc = src.loc
				src.scan = null
			else
				var/obj/item/I = usr.equipped()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I.loc = src
					src.scan = I
		else
			if (href_list["logout"])
				src.authenticated = null
				src.screen = null
				src.active1 = null
				src.active2 = null
			else
				if (href_list["login"])
					if (istype(usr, /mob/living/silicon))
						src.active1 = null
						src.active2 = null
						src.authenticated = 1
						src.rank = "AI"
						src.screen = 1
					if (istype(src.scan, /obj/item/weapon/card/id))
						src.active1 = null
						src.active2 = null
						if(check_access(src.scan))
							src.authenticated = src.scan.registered
							src.rank = src.scan.assignment
							src.screen = 1
		if (src.authenticated)
			if (href_list["list"])
				src.screen = 2
				src.active1 = null
				src.active2 = null
			else
				if (href_list["rec_m"])
					src.screen = 3
					src.active1 = null
					src.active2 = null
				else
					if (href_list["del_all"])
						src.temp = text("Are you sure you wish to delete all records?<br>\n\t<A href='?src=\ref[];temp=1;del_all2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
					else
						if (href_list["del_all2"])
							for(var/datum/data/record/R in data_core.security)
								//R = null
								del(R)
								//Foreach goto(497)
							src.temp = "All records deleted."
						else
							if (href_list["main"])
								src.screen = 1
								src.active1 = null
								src.active2 = null
							else
								if (href_list["field"])
									var/a1 = src.active1
									var/a2 = src.active2
									switch(href_list["field"])
										if("name")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input name:", "Secure. records", src.active1.fields["name"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon)))) || src.active1 != a1)
													return
												src.active1.fields["name"] = t1
										if("id")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input id:", "Secure. records", src.active1.fields["id"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active1 != a1))
													return
												src.active1.fields["id"] = t1
										if("fingerprint")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input fingerprint hash:", "Secure. records", src.active1.fields["fingerprint"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active1 != a1))
													return
												src.active1.fields["fingerprint"] = t1
										if("sex")
											if (istype(src.active1, /datum/data/record))
												if (src.active1.fields["sex"] == "Male")
													src.active1.fields["sex"] = "Female"
												else
													src.active1.fields["sex"] = "Male"
										if("age")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input age:", "Secure. records", src.active1.fields["age"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active1 != a1))
													return
												src.active1.fields["age"] = t1
										if("mi_crim")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input minor disabilities list:", "Secure. records", src.active2.fields["mi_crim"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
													return
												src.active2.fields["mi_crim"] = t1
										if("mi_crim_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize minor dis.:", "Secure. records", src.active2.fields["mi_crim_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
													return
												src.active2.fields["mi_crim_d"] = t1
										if("ma_crim")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input major diabilities list:", "Secure. records", src.active2.fields["ma_crim"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
													return
												src.active2.fields["ma_crim"] = t1
										if("ma_crim_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize major dis.:", "Secure. records", src.active2.fields["ma_crim_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
													return
												src.active2.fields["ma_crim_d"] = t1
										if("notes")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize notes:", "Secure. records", src.active2.fields["notes"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
													return
												src.active2.fields["notes"] = t1
										if("criminal")
											if (istype(src.active2, /datum/data/record))
												src.temp = text("<B>Criminal Status:</B><BR>\n\t;<A href='?src=\ref[];temp=1;criminal2=none'>None</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=arrest'>*Arrest*</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=incarcerated'>Incarcerated</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=parolled'>Parolled</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=released'>Released</A><BR>", src, src, src, src, src)
										if("rank")
											var/list/L = list( "Head of Personnel", "Captain", "AI" )
											if ((istype(src.active1, /datum/data/record) && L.Find(src.rank)))
												var/dat
												dat += text("<B>Choose a rank or enter <A href='?src=\ref[];temp=1;rank=custom'>custom</A></B><BR>\n", src)
												for (var/jobtype in get_job_types())
													dat += "<B>[jobtype]:</B><BR>\n"
													for(var/job in get_type_jobs(jobtype))
														dat += text("<A href='?src=\ref[];temp=1;rank=[job]'>[job]</A><BR>\n", src)
												src.temp = dat
											else
												alert(usr, "You do not have the required rank to do this!")
										else
								else
									if (href_list["rank"])
										if (src.active1)
											if (href_list["rank"] == "custom")
												src.active1.fields["rank"] = sanitize(input("Enter rank for person","Rank"))
											else
												src.active1.fields["rank"] = href_list["rank"]
									else
										if (href_list["criminal2"])
											if (src.active2)
												switch(href_list["criminal2"])
													if("none")
														src.active2.fields["criminal"] = "None"
													if("arrest")
														src.active2.fields["criminal"] = "*Arrest*"
													if("incarcerated")
														src.active2.fields["criminal"] = "Incarcerated"
													if("parolled")
														src.active2.fields["criminal"] = "Parolled"
													if("released")
														src.active2.fields["criminal"] = "Released"

										else
											if (href_list["del_r"])
												if (src.active2)
													src.temp = text("Are you sure you wish to delete the record (Security Portion Only)?<br>\n\t<A href='?src=\ref[];temp=1;del_r2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
											else
												if (href_list["del_r2"])
													if (src.active2)
														//src.active2 = null
														del(src.active2)
												else
													if (href_list["dela_r"])
														if (src.active1)
															src.temp = text("Are you sure you wish to delete the record (ALL)?<br>\n\t<A href='?src=\ref[];temp=1;dela_r2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
													else
														if (href_list["dela_r2"])
															for(var/datum/data/record/R in data_core.medical)
																if ((R.fields["name"] == src.active1.fields["name"] || R.fields["id"] == src.active1.fields["id"]))
																	//R = null
																	del(R)
																else
															if (src.active2)
																//src.active2 = null
																del(src.active2)
															if (src.active1)
																//src.active1 = null
																del(src.active1)
														else
															if (href_list["d_rec"])
																var/datum/data/record/R = locate(href_list["d_rec"])
																var/S = locate(href_list["d_rec"])
																if (!( data_core.general.Find(R) ))
																	src.temp = "Record Not Found!"
																	return
																for(var/datum/data/record/E in data_core.security)
																	if ((E.fields["name"] == R.fields["name"] || E.fields["id"] == R.fields["id"]))
																		S = E
																	else
																		//Foreach continue //goto(2614)
																src.active1 = R
																src.active2 = S
																src.screen = 4
															else
																if (href_list["new_r"])
																	var/datum/data/record/G = new /datum/data/record(  )
																	G.fields["name"] = "New Record"
																	G.fields["id"] = text("[]", add_zero(num2hex(rand(1, 1.6777215E7)), 6))
																	G.fields["rank"] = "Unassigned"
																	G.fields["sex"] = "Male"
																	G.fields["age"] = "Unknown"
																	G.fields["fingerprint"] = "Unknown"
																	G.fields["p_stat"] = "Active"
																	G.fields["m_stat"] = "Stable"
																	data_core.general += G
																	src.active1 = G
																	src.active2 = null
																else
																	if (href_list["new"])
																		if ((istype(src.active1, /datum/data/record) && !( istype(src.active2, /datum/data/record) )))
																			var/datum/data/record/R = new /datum/data/record(  )
																			R.fields["name"] = src.active1.fields["name"]
																			R.fields["id"] = src.active1.fields["id"]
																			R.name = text("Security Record #[]", R.fields["id"])
																			R.fields["criminal"] = "None"
																			R.fields["mi_crim"] = "None"
																			R.fields["mi_crim_d"] = "No minor crime convictions."
																			R.fields["ma_crim"] = "None"
																			R.fields["ma_crim_d"] = "No major crime convictions."
																			R.fields["notes"] = "No notes."
																			data_core.security += R
																			src.active2 = R
																			src.screen = 4
																	else
																		if (href_list["add_c"])
																			if (!( istype(src.active2, /datum/data/record) ))
																				return
																			var/a2 = src.active2
																			var/t1 = input("Add Comment:", "Secure. records", null, null)  as message
																			if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || (!in_range(src, usr) && (!istype(usr, /mob/living/silicon))) || src.active2 != a2))
																				return
																			var/counter = 1
																			while(src.active2.fields[text("com_[]", counter)])
																				counter++
																			src.active2.fields[text("com_[]", counter)] = text("Made by [] ([]) on [], 2053<BR>[]", src.authenticated, src.rank, time2text(world.realtime, "DDD MMM DD hh:mm:ss"), t1)
																		else
																			if (href_list["del_c"])
																				if ((istype(src.active2, /datum/data/record) && src.active2.fields[text("com_[]", href_list["del_c"])]))
																					src.active2.fields[text("com_[]", href_list["del_c"])] = "<B>Deleted</B>"
																			else
																				if (href_list["search_f"])
																					var/t1 = input("Search String: (Fingerprint)", "Secure. records", null, null)  as text
																					if ((!( t1 ) || usr.stat || !( src.authenticated ) || usr.restrained() || (!in_range(src, usr)) && (!istype(usr, /mob/living/silicon))))
																						return
																					src.active1 = null
																					src.active2 = null
																					t1 = lowertext(t1)
																					for(var/datum/data/record/R in data_core.general)
																						if (lowertext(R.fields["fingerprint"]) == t1)
																							src.active1 = R
																						else
																							//Foreach continue //goto(3414)
																					if (!( src.active1 ))
																						src.temp = text("Could not locate record [].", t1)
																					else
																						for(var/datum/data/record/E in data_core.security)
																							if ((E.fields["name"] == src.active1.fields["name"] || E.fields["id"] == src.active1.fields["id"]))
																								src.active2 = E
																							else
																								//Foreach continue //goto(3502)
																						src.screen = 4
																				else
																					if (href_list["search"])
																						var/t1 = input("Search String: (Name or ID)", "Secure. records", null, null)  as text
																						if ((!( t1 ) || usr.stat || !( src.authenticated ) || usr.restrained() || !in_range(src, usr)))
																							return
																						src.active1 = null
																						src.active2 = null
																						t1 = lowertext(t1)
																						for(var/datum/data/record/R in data_core.general)
																							if ((lowertext(R.fields["name"]) == t1 || t1 == lowertext(R.fields["id"])))
																								src.active1 = R
																							else
																								//Foreach continue //goto(3708)
																						if (!( src.active1 ))
																							src.temp = text("Could not locate record [].", t1)
																						else
																							for(var/datum/data/record/E in data_core.security)
																								if ((E.fields["name"] == src.active1.fields["name"] || E.fields["id"] == src.active1.fields["id"]))
																									src.active2 = E
																								else
																									//Foreach continue //goto(3813)
																							src.screen = 4
																					else
																						if (href_list["print_p"])
																							if (!( src.printing ))
																								src.printing = 1
																								sleep(50)
																								var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
																								P.info = "<CENTER><B>Security Record</B></CENTER><BR>"
																								if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
																									P.info += text("Name: [] ID: []<BR>\nSex: []<BR>\nAge: []<BR>\nFingerprint: []<BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src.active1.fields["name"], src.active1.fields["id"], src.active1.fields["sex"], src.active1.fields["age"], src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
																								else
																									P.info += "<B>General Record Lost!</B><BR>"
																								if ((istype(src.active2, /datum/data/record) && data_core.security.Find(src.active2)))
																									P.info += text("<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: []<BR>\n<BR>\nMinor Crimes: []<BR>\nDetails: []<BR>\n<BR>\nMajor Crimes: []<BR>\nDetails: []<BR>\n<BR>\nImportant Notes:<BR>\n\t[]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src.active2.fields["criminal"], src.active2.fields["mi_crim"], src.active2.fields["mi_crim_d"], src.active2.fields["ma_crim"], src.active2.fields["ma_crim_d"], src.active2.fields["notes"])
																									var/counter = 1
																									while(src.active2.fields[text("com_[]", counter)])
																										P.info += text("[]<BR>", src.active2.fields[text("com_[]", counter)])
																										counter++
																								else
																									P.info += "<B>Security Record Lost!</B><BR>"
																								P.info += "</TT>"
																								P.name = "paper- 'Security Record'"
																								src.printing = null
	src.add_fingerprint(usr)
	src.updateUsrDialog()

	return



/obj/item/weapon/paper/security
	name = "Security Sentences"
	info = {" <p><b>If you can't find the crime listed in here you need to set up a proper trial</b> Go here: <a href="/index.php/Legal_Standard_Operating_Procedure" title="Legal Standard Operating Procedure">Legal Standard Operating Procedure</a>
</p><p>The time you took for bringing the suspect in and the time you spend questioning are NOT to be calculated into this. This is the pure time someone spends in a cell starring at the wall.<br />
On laggy games first take a look at how quickly the cell timer tick... we don't want people to spend an eternity in jail for staling a pair of gloves. I am sure you have a system clock on your PC that you can keep an eye on.
</p><p><font size="3" color="red"><b>The maximum time someone can be put in jail for is 10 minutes (exceptions are listed below)</b></font><br />
Always remember that when you add crimes together!
</p><p><br />
Note: Compare the ingame version of this found in Security with the version on the wiki regularly. If the ingame version differs, follow the rules on the wiki, since they are easier to update.
Link to the wiki page: <a href="http://wiki.baystation12.co.cc/index.php/Security_Sentences" class="external free" title="http://wiki.baystation12.co.cc/index.php/Security_Sentences" rel="nofollow">http://wiki.baystation12.co.cc/index.php/Security_Sentences</a>
Compare changes here: <a href="http://wiki.baystation12.co.cc/index.php?title=Security_Sentences&amp;action=history" class="external free" title="http://wiki.baystation12.co.cc/index.php?title=Security_Sentences&amp;action=history" rel="nofollow">http://wiki.baystation12.co.cc/index.php?title=Security_Sentences&amp;action=history</a>
</p>
<a name="Minor_Crimes" id="Minor_Crimes"></a><h3> <span class="mw-headline"> Minor Crimes </span></h3>
<table width="1150px" style="text-align:center; background-color:#ffee99;" border="1" cellspacing="0">
<tr>
<th style="background-color:#ffee55;" width="150px">Crime
</th><th style="background-color:#ffee55;" width="500px">Description
</th><th style="background-color:#ffee55;" width="100px">Punishment
</th><th style="background-color:#ffee55;" width="300px">Notes
</th></tr>
<tr>
<td><b>Resisting Arrest</b>
</td><td>Not cooperating with the officer who demands you turn yourself in peacefully. Shouting "No!" or otherwise making the officer have the need to tase you to put handcuffs on.
</td><td> +30 seconds to original time
</td><td> See manhunt if the suspect runs away. Or attack on an officer if he fights back. This is for shouting/swearing and moving around a bit (just so you cant cuff him) only.
</td></tr>
<tr>
<td><b>Petty Theft</b>
</td><td>Stealing non-crucial items from the ship. Items can include anything from toolboxes to metal to insulated gloves. To steal something the person must take it from a place which he doesn't have access to.
</td><td> 60 seconds (Half the time of Theft)
</td><td> Remember to take the items away from them and return them to where they stole them.
</td></tr>
<tr>
<td><b>Theft</b>
</td><td>Stealing of important, dangerous or otherwise crucial items like IDs, weapons or something similar. To steal something the person must take it from a place which he doesn't have access to.
</td><td> 2 minutes (2x the time of Petty Theft)
</td><td> Remember to take the items away from them and return them to where they stole them. Compare Robbery.
</td></tr>
<tr>
<td><b>Robbery</b>
</td><td> Robbery is stealing items from another person's possession. This can be the stealing of ID's, backpack contents or anything else.
</td><td> 1m 30s (3m)
</td><td> Remember to take the stolen items from the person and return them, if you can find the person they've been stolen from. Otherwise put them in a locker in security. Taking the items for yourself is considered stealing!! Remember to double the time if the robbed item was an ID or something else crucial or dangerous. Compare Theft and Petty Theft.
</td></tr>
<tr>
<td><b>Assault</b>
</td><td> To assault means to attack someone without causing them to die and without the intent to kill them.
</td><td> 3m
</td><td> Example: Knocking someone out to take their ID yields: Assault + Robbery
</td></tr>
<tr>
<td><b>Trespassing</b>
</td><td> Trespassing means to be in an area which you don't have access to.
</td><td> Remove from area, if the crime is repeated imprison for 60s
</td><td>
</td></tr>
<tr>
<td><b>Indecent Exposure or being a nuisance</b>
</td><td> Running around the ship naked, yelling at people for no reason (don't arrest someone because they are arguing), throwing around stuff where it could hit someone, etc.
</td><td> 30s
</td><td> Drunks can be keep to sober up, but only if they are badly harassing other crew members. Regular drunks don't get arrested and if they are only a nuisance you keep them for the regular time.
</td></tr></table>
<a name="Medium_Crimes" id="Medium_Crimes"></a><h3> <span class="mw-headline"> Medium Crimes </span></h3>
<table width="1150px" style="text-align:center; background-color:#ffcc99;" border="1" cellspacing="0">
<tr>
<th style="background-color:#ffaa55;" width="150px">Crime
</th><th style="background-color:#ffaa55;" width="500px">Description
</th><th style="background-color:#ffaa55;" width="100px">Punishment
</th><th style="background-color:#ffaa55;" width="300px">Notes
</th></tr>
<tr>
<td><b>Assault with a deadly or dangerous weapon</b>
</td><td> Getting assaulted with a knife or tased without the intention of your attacker killing you.
</td><td> 5m
</td><td> Usual weapons: Stun baton, taser or other gun, wirecutters, knife or scalpel, crowbar or fire extinguisher/oxygen tank.
</td></tr>
<tr>
<td><b>Assault on an officer</b>
</td><td> Assault with whichever weapon or object on an officer. An officer is defined as either a member of the security force (forensic technician included) or one of the heads of staff.
</td><td> 5m
</td><td> Don't abuse him. I know you want to, but don't. At least try not to. You'll get fired. Most likely.
</td></tr>
<tr>
<td><b>Unlawful conduct or negligence resulting in ship damage or harm to crewmen.</b>
</td><td> It's impossible to list everything that can lead up to this. Starting a fire in toxins is one thing, smashing windows and major vandalism is another, as is putting someone else in harms way. If you can't put it somewhere else, bets are good that it is this. If it is still not this, you need a trial.
</td><td> 3m 30s
</td><td> If someone dies directly related to it, add manslaughter.
</td></tr>
<tr>
<td><b>Manslaughter</b>
</td><td> Manslaughter is the unintentional killing of a fellow human being. If you cause a fire in toxins and someone else get's trapped and dies, that's manslaughter.
</td><td> 5m
</td><td> If there is the intention to kill, it's murder.
</td></tr>
<tr>
<td><b>Theft of a high value item</b>
</td><td> Stealing something which we know traitors often want.
</td><td> 3m
</td><td> Theft of a rapid construction device (RCD), Captain's jumpsuit, Hand teleporter, captain's antique laser or other items which the traitors want. Note that they have to be kept in areas which this person doesn't have access to.
</td></tr>
<tr>
<td><b>Threatening Ship Integrity</b>
</td><td> To threaten the ships integrity means to cause mediocre damage to the ships atmosphere, this means to create an air or gas leak that affects a vital part of the ship, or destroying an interior wall.
</td><td> 5m
</td><td> If it wasn't on purpose or if the damage is easily fixed see Unlawful conduct.
</td></tr>
<tr>
<td><b>Threatening Power Supply</b>
</td><td> Cutting power lines, shutting down power storage units, engine's power generators, etc.
</td><td> 4m + remove insulated gloves and wirecutters and anything else that might be related, like engineering access.
</td><td> This does not include blowing up the Engine. See Compromising Ship Integrity further down.
</td></tr>
<tr>
<td><b>Sparking a man-hunt or chase</b>
</td><td> This means the officer needs to chase after you to catch you. It means you actually flee from the scene.
</td><td> +3m to original time
</td><td> This will happen to you often...
</td></tr>
<tr>
<td><b>Escape attempt</b>
</td><td> Attempting to escape from the brig.
</td><td> +2m to current time, this can exceed the maximum jail time.
</td><td> It's the job of the officer to prevent such events.
</td></tr></table>
<a name="Major_Crimes" id="Major_Crimes"></a><h3> <span class="mw-headline"> Major Crimes </span></h3>
<table width="1150px" style="text-align:center; background-color:#ffaa99;" border="1" cellspacing="0">
<tr>
<th style="background-color:#ff8855;" width="150px">Crime
</th><th style="background-color:#ff8855;" width="500px">Description
</th><th style="background-color:#ff8855;" width="100px">Punishment
</th><th style="background-color:#ff8855;" width="300px">Notes
</th></tr>
<tr>
<td><b>Identity Theft</b>
</td><td> Stealing someones ID and/or other objects of identification with the purpose to appear to others as them or to enter into areas where the suspect would normally not have access.
</td><td> 10 minutes
</td><td> The case of impersonation regarding ship equipment(doors, computer terminals, AI, etc) or personnel has to be proven, otherwise see Petty Theft/Robbery. Remember to double the time if the object was an ID or something similar crucial (Compare Petty Theft).
</td></tr>
<tr>
<td><b>Syndicate collaboration</b>
</td><td> Being either a traitor, a syndicate operative or a head revolutionary
</td><td> Until the end of the round <br />(disregard maximum sentence time) <br />or DEATH <br />(if approved by the <a href="/index.php/Captain" title="Captain">Captain</a>)
</td><td> You have two choices: Killing them or permabrigging them. If you choose to kill them, first ask for permission from the <a href="/index.php/Captain" title="Captain">Captain</a>. If permission is given, it is wise to first <a href="/index.php/Adminhelp" title="Adminhelp" class="mw-redirect">Adminhelp</a> your intentions. Adminhelp something like: "I have grounds to believe X is a rev head. I have him locked in the brig and intend to kill him. If you have any objections to this action, please contact me." then wait for about a minute. If no PM comes, proceed to kill him. The other option is to permabrig them. This simply means you put them in the brig and don't ever let them out until your are going to evac. Then cuff them and secure them on one of the pods. (Note that Head Revolutionaries MUST be executed for you to win the round.)
</td></tr>
<tr>
<td><b>Murder</b>
</td><td> Killing someone with the intent to kill.
</td><td> Death Sentence if authorised by the Captain. Otherwise brigging for the rest of the round.
</td><td> Not to be confused with Manslaughter. Hint: Cyborgification is a valid execution method, since he will be bound by laws.
</td></tr>
<tr>
<td><b>Attempted Murder</b>
</td><td> Attempting to kill someone. The victim survives.
</td><td> See Murder
</td><td> Regardless if you succeed or not, if you try to commit murder, the punishment is the same! You have to be sure there was intent to kill though!
</td></tr>
<tr>
<td><b>Compromising Ship Integrity</b>
</td><td> Compromising a large part of the Ships atmosphere or integrity.
</td><td> 10m (You are going to evac anyway. Cuff him and secure him on a pod.)
</td><td> Blowing up the <a href="/index.php/Engine" title="Engine">Engine</a> is included here.
</td></tr></table>
<a name="Parole_Circumstances" id="Parole_Circumstances"></a><h3> <span class="mw-headline"> Parole Circumstances </span></h3>
<p>Okay, we've covered all the punishments. Now for the parole circumstances. These circumstances will shorten your prisoner's time in jail.
</p><p>Note that all of these add up to a maximum of <b>33%</b>!!
</p>
<table width="1150px" style="text-align:center; background-color:#aaffaa;" border="1" cellspacing="0">
<tr>
<th style="background-color:#55ff55;" width="150px">Crime
</th><th style="background-color:#55ff55;" width="500px">Description
</th><th style="background-color:#55ff55;" width="100px">Benefit
</th><th style="background-color:#55ff55;" width="300px">Notes
</th></tr>
<tr>
<td><b>Good behavior</b>
</td><td> Behaving well, not attempting any problems or causing riots or screaming and yelling.
</td><td> -20% of original time
</td><td> It sounds like a good deal... but few will actually take it.
</td></tr>
<tr>
<td><b>Reeducation</b>
</td><td> Getting de-converted from revolutionary, renouncing traitoring (must be arranged with admins), etc. (most of these must be arranged with admins)
</td><td> -15% of original time
</td><td>
</td></tr>
<tr>
<td><b>Cooperation with prosecution or security</b>
</td><td> Being helpful to the members of security, revealing things during questioning or providing names of head revolutionaries.
</td><td> -10%
</td><td> In the case of revealing a head revolutionary: Immediate release
</td></tr>
<tr>
<td><b>Surrender</b>
</td><td> Coming to the brig, confessing what you've done and taking the punishment.
</td><td> -25%
</td><td> Getting arrested without putting a fuss is not surrender. For this, you have to actually come to the brig yourself.
</td></tr>
<tr>
<td><b>Immediate threat to the prisoner</b>
</td><td> Call for evac, atmospheric problems in the <a href="/index.php/Brig" title="Brig">Brig</a> or <a href="/index.php/SecHQ" title="SecHQ" class="mw-redirect">SecHQ</a> area, threat of being overrun by revolutionaries, etc
</td><td> Immediately move the prisoner.<br /> If that is not possible: Immediate Release!
</td><td> Keep in mind the time until they get released. Exception is if the person is a <i>CONFIRMED</i> traitor, syndicate operative or head of revolutionary. In those cases you can leave them to die.
</td></tr>
<tr>
<td><b>Medical reasons</b>
</td><td> The person needs immediate medical attention
</td><td> Immediate escort to medbay
</td><td> The sentence timer continues to tick while he's at medbay, it's not paused.
</td></tr></table>
"}