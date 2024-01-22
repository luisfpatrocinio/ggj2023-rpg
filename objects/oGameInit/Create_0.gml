/// @description 
instance_create_depth(0, 0, 0, oControl);

#macro DEBUG_MODE	false
#macro Debug:DEBUG_MODE true
if (DEBUG_MODE) instance_create_depth(0, 0, 0, oDebug);

room_goto_next();