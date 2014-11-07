// Mix four signals in one channel
(
{
	var sine1, sine2, noise, bass;
	sine1= SinOsc.ar(400, 0, 0.2);
	sine2= SinOsc.ar(404, 0, 0.2);
	noise= BrownNoise.ar(0.025);
	bass= Saw.ar(50, 0.2);
	//your code comes here
	//sine1 + sine2 + noise + bass;
	//Mix.new([sine1, sine2, noise, bass]);
	[sine1, sine2, noise, bass].mean
}.play

);

// How to modulate the amplitude of a signal

({
	var source, modulator;
	source= SinOsc.ar(400, 0, 0.4);
	modulator= LFNoise2.ar(1);
	source * modulator;
	//your code comes here
}.play
);

{SinOsc.ar(440,0,Saw.kr(1),WhiteNoise.ar(0.1))}.play

// re-write the following code with variables and arguments

{ CombN.ar( Impulse.ar(2), 0.125, 0.125, 2) }.play;

{arg freq=4;CombN.ar( Impulse.ar(freq), 0.125, 0.125, 2)}.play;
x = {arg freq=4;CombN.ar( Impulse.ar(freq), 0.125, 0.125, 2)}.play;

x.set("freq", 0.5);
x.set(\freq, 1.5);
x.set('freq', 3.5);


(
x={arg freq=4;
	var exc = Impulse.ar(freq);
	var output = CombN.ar( exc, 0.125, 0.125, 2);

	//Pan2.ar(output, LFTri.kr(0.5))
	output;
}.play;
)

// find the mistake and correct it
{ LPF.ar( ClipNoise.ar(0.1), SinOsc.kr(0.5, 0, 500, 600)) }.play;
{ SinOsc.ar(400, 408, 0, 0.1) }.play;
{ SinOsc.ar([400, 408], 0, 0.1) }.play;//mul argument is set to zero probably 400 and 408 refer to two frequencies

// where is the control of the panning speed?
(
{
	Mix(
		Pan2.ar(
			SinOsc.ar( [400, 600, 800, 1000, 1200], 0, 0.1),
			LFSaw.kr(0.1, [0, 0.1, 0.2, 0.3, 0.4]); // in the frequency of the LFSaw
		)
	);
}.play;
);

// when the following code is evaluated the synths still alive on the server, modified the code to free the synth after the envelop has finnished

(x={
	var env;
	env= Env.perc(0.1, 1.5);	//attacktime, releasetime
	EnvGen.kr(env, doneAction:2) * SinOsc.ar(400, 0, 0.1);//add the doneAction to the Envelp Generator
}.play
);

s.queryAllNodes;
s.freeAll;


// The synth has to stop at the end of the envelops and what is the range of each envelop?
({
	var env, freq;
	env= Env.perc(0.01, 0.1);
	freq= EnvGen.kr(env, doneAction:2);// add doneAction
	SinOsc.ar([freq*200+300, freq*70+600], 0, 0.1);//the range for the first is 300Hz - 500Hz, the second 600Hz - 670Hz
}.play
);

// where to add a variable to control the duration of the envelopes?
({var dur = 4;
	Saw.ar(
		EnvGen.kr(Env.new([10000,20],[0.5])),  //frequency input
		EnvGen.kr(Env.new([0.1,0],[dur]),doneAction:2)          //amplitude input
	)
}.play
);


// Modified with a variable the speed of modulation
(x={arg mod =1, gate=1;
SinOsc.ar(
	SinOsc.ar(mod,0,10,440),
	0.0,
	EnvGen.kr(Env.new([0.5,0.0],[100.0]), gate, doneAction:2)
	)
}.play
);
x.set(\mod, 10);
x.set(\mod, 100);
x.set(\mod, 1);
x.set(\gate, -4);


// Analyse and explain this code
{(SinOsc.ar(LFNoise1.kr(0.01).exprange(100,{exprand(300,10000)}!120)).mean)}.play;

// write the code to play a set of sine waves in stereo that use envelops for frequency, amplitude and panning, make shure there are not clicks, so use fades in and out



({
	var dur = 4;
	var amp = 1;
	var envfreq = EnvGen.kr(Env.new([rrand(40, 1200),rrand(120, 200)],[0.5]));
	var envamp = EnvGen.kr(Env.new([0.1,0],[dur]),doneAction:2);
	var envpan = EnvGen.kr(Env.new([-1,1,-1],[dur, dur]),timeScale:dur*0.125);
	var output = Saw.ar([envfreq, envfreq+200], envamp).mean;

	Pan2.ar(output, envpan, amp);

}.play
);


