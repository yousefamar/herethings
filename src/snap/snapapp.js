var snapSoundURL = require('./snap.wav');

var SnapApp = function(){};

SnapApp.prototype.init = function() {
	var onFailSoHard = function(e) {};

	$('#contentBoxOverlay').fadeOut('fast');
	var video = document.querySelector('video');

	navigator.getUserMedia({video: true, audio: false}, function(localMediaStream) {
		var video = document.querySelector('video');
		video.src = window.URL.createObjectURL(localMediaStream);
		g_localMediaStream = localMediaStream;

	}, onFailSoHard);
}

SnapApp.prototype.snapPhoto = function() {
	if (g_localMediaStream) {
		var video = document.getElementById('contentBox');
		var canvas = document.getElementById('canvas');
		var context = canvas.getContext('2d');
		var videoWidth = video.videoWidth, videoHeight = video.videoHeight;

		$('#canvas').show();
		canvas.width = videoWidth;
		canvas.height = videoHeight;
		var top = 600 / 2 - videoHeight / 2;
		canvas.style.top = top + 'px';

		context.drawImage(video, 0, 0, videoWidth, videoHeight);

		var snapshot = document.getElementById('snapshot');
		snapshot.src = canvas.toDataURL('image/webp');

		snapshot.style.top = top + 'px';
		snapshot.style.width = '600px'; // videoWidth + 'px'
		snapshot.style.height = 'auto'; // videoHeight + 'px';
		snapshot.style.borderTop = '14px solid rgb(234,234,234)';
		snapshot.style.borderBottom = '14px solid rgb(234,234,234)';
		$('#snapshot').show();
		$('#canvas').hide();
	}

	var thisSound = new Audio(snapSoundURL);
	thisSound.play();
	$('#closeButton').show();
	$('#snapOverlay').show();
	$('#snapOverlay').fadeOut('fast');
	$('#snapButton').hide();
	// $('#countdown').hide();
}

SnapApp.prototype.clearPhoto = function() {
	var canvas = document.getElementById('canvas');
	var context = canvas.getContext('2d');
	context.clearRect(0, 0, canvas.width, canvas.height);
	$('#closeButton').hide();
	$('#snapshot').fadeOut('fast');
	$('#snapButton').show();
	// $('#countdown').show();
	// g_startCountdown();
}

exports.SnapApp = SnapApp;
