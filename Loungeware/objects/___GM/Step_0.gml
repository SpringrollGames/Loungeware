___state_handler();


// fade timer bar
if (gb_timerbar_visible) gb_timerbar_alpha = min(1, gb_timerbar_alpha + gb_timerbar_fadespeed) 
else gb_timerbar_alpha = max(0, gb_timerbar_alpha - gb_timerbar_fadespeed);

// -----------------------------------------------------------
// STATE | PLAYING_MICROGAME
// -----------------------------------------------------------
if (state == "playing_microgame"){
	
	if (state_begin){
		gb_timerbar_visible = true;
		transition_circle_rad = 0;
		prompt_alpha = 1;
		prompt_sprite = ___prompt_sprite_create(microgame_current_metadata);
		substate = 0;
	}
	
	// animate circle intro
	if (substate == 0){
		transition_circle_rad = min(transition_circle_rad_max, transition_circle_rad + (transition_circle_speed*2));
		if (transition_circle_rad >= transition_circle_rad_max){
			substate++;
			exit;
		}
	}
	
	if (substate == 1){
		if (microgame_timer == 0){
		
			if (!microgame_won){
				larold_index = 2;
			} else {
				larold_index = 1;
			}
		
			if (!microgame_music_auto_stopped){
				microgame_music_auto_stopped = true;
				audio_pause_all();
				audio_resume_sound(microgame_music);
				var _fadeout_time = (microgame_end_transition_time/2);
				microgame_music_stop(_fadeout_time * 16.66);

			}
			gb_timerbar_visible = false;
			larold_alpha = 1//; - gb_timerbar_alpha;
			// pixelate
			transition_appsurf_zoomscale = max(0.1, transition_appsurf_zoomscale - (1/microgame_end_transition_time));
			// close circle animation (loony tunes am i right)
			transition_circle_rad = max(0, transition_circle_rad - transition_circle_speed);

			if ((transition_circle_rad <= 0) && (gb_timerbar_alpha <= 0)){
				___state_change("microgame_result");
				___microgame_end();
			
			}
		}
	}
	
	microgame_timer = max(microgame_timer - 1, 0);
	
}


// -----------------------------------------------------------
// STATE | MICROGAME RESULT
// -----------------------------------------------------------
if (state == "microgame_result"){

}


