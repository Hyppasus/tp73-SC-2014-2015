(
SynthDef(\fmsynth, {arg freq=440, carPartial=1, modPartial=1, index=3, amp=0.2, ts=10, decayTime=4;
	var mod, car, env, sig;
	// modulator frequency
	mod = SinOsc.ar(freq * modPartial, 0, freq * index );
	// carrier frequency
	car = SinOsc.ar((freq * carPartial) + mod, 0, amp );
	// envelope
	env = EnvGen.ar( Env.perc(0.01, 1), doneAction: 2, timeScale: ts);
	sig = car * env;
	// reverb
	//40.do({sig = AllpassN.ar(sig, 0.040, [0.04.rand, 0.04.rand], decayTime)});
	GVerb.ar(sig,100,10,0,0.15,100,0.5);
	Out.ar( 0, sig!2)
}).add;
);



(
p=Pbind(
	\instrument, "fmsynth",
	//\degree, Pseries(0,1,12),
	//\freq, Pseries(200, 100, 12),
	\freq, Pxrand((10..60),inf),
	\index, Pbrown(0.01,10,0.001,inf),
	\carPartial, Pwhite(0.1,10,inf),
	\modPartial, Pwhite(0.1,10,inf),
	\ts, Pwrand((1..5)*2,Array.exprand(5,0.1,1).normalizeSum, inf),
	//\dur, 0.25
	//\dur, Place([1, [0.3, 0.25], [0.15, 0.25, 0.5]],inf)
	//\dur, Place([1, [0.3, 0.25], [0.15, 0.25, 0.5]]*0.5,inf)
	\dur, Pxrand(Array.exprand(100,0.1,10),inf)
).play
);



(
p=Pbind(
	\instrument, "fmsynth",
	//\degree, Pseries(0,1,12),
	//\freq, Pseries(200, 100, 12),
	\freq, Pxrand((10..100),inf),
	\index, Pbrown(0.01,1,0.001,inf),
	\carPartial, Pwhite(0.1,5 ,inf),
	\modPartial, Pwhite(0.1,6,inf),
	\ts, Pwrand((1..5)*2,Array.exprand(5,0.1,1).normalizeSum, inf),
	\dur, 0.25
	//\dur, Place([1, [0.3, 0.25], [0.15, 0.25, 0.5]],inf)
	//\dur, Place([1, [0.3, 0.25], [0.15, 0.25, 0.5]]*0.5,inf)
	//\dur, Pxrand(Array.exprand(100,0.1,10),inf)
).play
);

{s.sendMsg(\s_new, "fmsynth", 1010, 1, 1, \freq, rrand(240,660), \carPartial, rrand (0.01, 1), \modPartial, rrand (0.01, 1), \index, rrand (1, 10.0), \amp, 0.2, \ts, 4, \decayTime, rrand (1, 4.0))}.play
{s.sendMsg(\s_new, "fmsynth", 1010, 1, 1)}.play

OSCdef(\print2, { |msg, time| s.sendMsg(\n_set, 1101, \freq, msg[1].linlin(0,1.0, 20,2000))}, "/ButtonV_5");