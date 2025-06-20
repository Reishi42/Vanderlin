/**
	* # asset_cache_item
	*
	* An internal datum containing info on items in the asset cache. Mainly used to cache md5 info for speed.
**/
/datum/asset_cache_item
	var/name
	var/hash
	var/resource
	var/ext = ""
	var/legacy = FALSE //! Should this file also be sent via the legacy browse_rsc system when cdn transports are enabled?
	var/namespace = null //! used by the cdn system to keep legacy css assets with their parent css file. (css files resolve urls relative to the css file, so the legacy system can't be used if the css file itself could go out over the cdn)
	var/namespace_parent = FALSE //! True if this is the parent css or html file for an asset's namespace

/datum/asset_cache_item/New(name, file)
	if (!isfile(file))
		file = fcopy_rsc(file)
	hash = md5(file)
	if (!hash)
		hash = md5(fcopy_rsc(file))
		if (!hash)
			CRASH("invalid asset sent to asset cache")
		debug_world_log("asset cache unexpected success of second fcopy_rsc")
	src.name = name
	var/extstart = findlasttext(name, ".")
	if (extstart)
		ext = ".[copytext_char(name, extstart+1)]"
	resource = file


/datum/asset_cache_item/vv_edit_var(var_name, var_value)
	return FALSE

/datum/asset_cache_item/CanProcCall(procname)
	return FALSE
