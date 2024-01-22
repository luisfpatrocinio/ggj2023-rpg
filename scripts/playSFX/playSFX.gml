global.sfxON = true;
global.volumeSFX = 1;

function playSFX(snd, emitter = undefined){	
	if (global.sfxON) {
		// Tocando sem emitter definido.
		if (is_undefined(emitter)) {
			var _audio = audio_play_sound(snd, 10, false, global.volumeSFX);
		} else {
		// Tocando a partir de um emitter
			var _audio = audio_play_sound_on(emitter, snd, false, 10, global.volumeSFX);
		}
		return _audio;
	} else {
		return -1;
	}
}