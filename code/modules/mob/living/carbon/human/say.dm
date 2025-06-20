/mob/living/carbon/human/say_mod(input, message_mode)
	verb_say = dna.species.say_mod
	if(slurring)
		return "slurs"
	else
		. = ..()

/mob/living/carbon/human/GetVoice()
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/radio(message, message_mode, list/spans, language)
	. = ..()
	if(. != 0)
		return .

	switch(message_mode)
		if(MODE_HEADSET)
			if (ears)
				ears.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE

		if(MODE_DEPARTMENT)
			if (ears)
				ears.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE

	if(message_mode in GLOB.radiochannels)
		if(ears)
			ears.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE

	return 0

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return "Unknown [(gender == FEMALE) ? "Woman" : "Man"]"

/mob/living/carbon/human/proc/forcesay(list/append) //this proc is at the bottom of the file because quote fuckery makes notepad++ cri
	if(stat == CONSCIOUS)
		if(client)
			var/virgin = 1	//has the text been modified yet?
			var/temp = winget(client, "input", "text")
			if(findtextEx(temp, "Say \"", 1, 7) && length(temp) > 5)	//"case sensitive means

				temp = replacetext(temp, ";", "")	//general radio

				if(findtext(trim_left(temp), ":", 6, 7))	//dept radio
					temp = copytext_char(trim_left(temp), 8)
					virgin = 0

				if(virgin)
					temp = copytext_char(trim_left(temp), 6)	//normal speech
					virgin = 0

				while(findtext(trim_left(temp), ":", 1, 2))	//dept radio again (necessary)
					temp = copytext_char(trim_left(temp), 3)

				if(findtext(temp, "*", 1, 2))	//emotes
					return

				var/trimmed = trim_left(temp)
				if(length(trimmed))
					if(append)
						temp += pick(append)

					say(temp)
				winset(client, "input", "text=[null]")

/mob/living/carbon/human/send_speech(message, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, message_mode, original_message)
	. = ..()
	if(message_mode != MODE_WHISPER)
		send_voice(message)

/*
/mob/living/carbon/human/proc/send_voice(message, skip_thingy)
	if(!message || !length(message))
		return
	var/numessage = message
//	if(ranger)
//		erange = ranger-7
	if(!skip_thingy)
		numessage = replacetext(message, " ", "")
		numessage = sanitize_hear_message(message)
	spawn()
		var/freq2use = get_emote_frequency()
		freq2use += rand(-100,100)
		for(var/i=1, i<=min(length(numessage),20), i++)
			var/ascii_char = text2ascii(numessage,i)
			var/text_char
			switch(ascii_char)
				// A  .. Z
				if(65 to 90)			//Uppercase Letters
					text_char=ascii2text(ascii_char)
				// a  .. z
				if(97 to 122)			//Lowercase Letters
					text_char=ascii2text(ascii_char)
				// 0  .. 9
//				if(48 to 57)			//Numbers
//					text_char="bebebese"
			if(text_char)
				var/path = "sound/vo/female/spch/[text_char].ogg"
				if(gender == MALE)
					path = "sound/vo/male/spch/[text_char].ogg"
				if(fexists(path))
					playsound(get_turf(src), path, 100, FALSE, -1, frequency = freq2use)
			sleep(1)
*/

/mob/living/carbon/human/proc/send_voice(message, skip_thingy)
	if(!message || !length(message))
		return
	if(dna.species)
		dna.species.send_voice(src)

/datum/species/proc/send_voice(mob/living/carbon/human/H)
	playsound(get_turf(H), 'sound/misc/talk.ogg', 100, FALSE, -1)
