// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Tootlip

preload = new Image(100,25); 
preload.src="/images/tooltip.png";

var first = true

function showTooltip(id) {
	document.getElementById(id + '_tooltip').style.height = "auto"; // fixes height issue when with hiding tooltip and autocomplete at the same time
	if (first == true) { 
		new Effect.BlindDown(id + '_tooltip', { duration: 1.4, transition: Effect.Transitions.spring });
		first = false;
	} else {
		new Effect.BlindDown(id + '_tooltip', { duration: .3, transition: Effect.Transitions.sinoidal });
	}
}
function hideTooltip(id) {
	new Effect.BlindUp(id + '_tooltip', { duration: .2 });
}
function showImageField(number) {
	document.getElementById('image-field-'+number).style.display='block'
}
function showFileField(number) {
	document.getElementById('file-field-'+number).style.display='block'
}

// Progress Overlay

function showProgressOverlay() {
	new Effect.Appear('progress_overlay', { duration: .3 });
	new Effect.Appear('progress_patience', { duration: 2.5, delay: 1.5 })
}