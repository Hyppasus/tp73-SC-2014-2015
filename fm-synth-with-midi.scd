Server.default.waitForBoot{

	s = Server.local;
	~carPartial = 1;
	~modPartial = 1;
	~index = 10;
	~timeScale = 4;
	~decay = 1;
	~panSpeed = 1;
	~reverb = 1;
	~volume = 1;

	//MIDI implementation

	MIDIClient.init;
	MIDIIn.connectAll;

/*
	q=MIDIFunc.cc{arg ...args; args.postln};
	q.free;
	p=MIDIFunc.noteOn{arg ...args; args.postln};
*/


// define cc numbers

	~carPartialCCnum = 16;
	~modPartialCCnum = 17;
	~indexCCnum = 18;
	~timeScaleCCnum = 19;
	~decayCCnum = 85;
	~reverbCCnum = 86;
	~panSpeedCCnum = 77;
	~volumeCCnum = 81;

// FM synth
(
SynthDef(\fmsynth, {arg freq=440, carPartial=1, modPartial=1, index=3, amp=0.2, ts=10, decayTime=1, gate=1, pan=1, reverb=1, volume=1;
	var mod, car, env, sig, dry;
	// modulator frequency
	mod = SinOsc.ar(freq * modPartial, 0, freq * index );
	// carrier frequency
	car = SinOsc.ar((freq * carPartial) + mod, 0, amp );
	// reverb
	dry = car;
	20.do({car = AllpassN.ar(car, 0.04, 0.04.rand, 2)});
	//car = FreeVerb.ar(car, 1, 1, 0.5, 5);
	// mix the reverb with the dry sound
	sig = (car * (1-reverb)) + (dry * reverb);
	// envelope
	env = EnvGen.ar( Env.perc(0.001, decayTime), gate, doneAction: 2, timeScale:ts);
	sig = Pan2.ar(sig, LFDNoise3.ar(pan), env*volume);
	Out.ar(0, sig)
}).add;
);

	s.sync;

/*
// Testing
s.sendMsg(\s_new, "fmsynth", 1020, 1, 1);

s.sendMsg(\s_new, "fmsynth", 1010, 1, 1, \freq, rrand(240,660), \carPartial, rrand(0.01, 1), \modPartial, rrand(0.01, 1), \index, rrand(1, 10.0), \amp, 0.2, \ts, 4, \decayTime, rrand(1, 4.0));// once the synth stop playing try it again

s.sendMsg(\s_new, "fmsynth", s.nextNodeID, 1, 1, \freq, rrand(240,660), \carPartial, rrand (0.01, 1), \modPartial, rrand (0.01, 1), \index, rrand (1, 10.0), \amp, 0.2, \ts, 10, \decayTime, rrand (1, 4.0));// or try simultaneously with another Synth ID

q=MIDIFunc.cc({arg val, num, ch, src;
	~carPartial=val.linexp(0,127,0.001,10.0);
	s.sendMsg(\n_set, ~idGroup, \carPartial, ~carPartial);
	~carPartial.value.postln;
},0);

*/

	s.sendMsg(\g_new, 100, 1, 1);

	s.sync;

	(

	o=MIDIFunc.noteOn({arg vel, note, ch, src;
		//~index = vel.linexp(0,127,1,100);
		s.sendMsg(\s_new, "fmsynth", ~idSynth, 1, 100,
			\freq, note.linexp(0,127,20,20000),
			\carPartial,~carPartial,
			\modPartial, ~modPartial,
			\index, ~index,
			//\ts, vel.linlin(0,127,1,5.0),
			\ts, ~timeScale,
			\decayTime, ~decay,
			\pan, ~panSpeed,
			\reverb, ~reverb,
			\volume, ~volume,
			\gate, 1,
);
	~idSynth = s.nextNodeID;
		//[~carPartial, ~modPartial, ~index].postln
},nil);


q=MIDIFunc.cc({arg val, num, ch, src;~carPartial=val.linexp(0,127,0.001,10.0);s.sendMsg(\n_set, ~idGroup, \carPartial, ~carPartial);},~carPartialCCnum);
r=MIDIFunc.cc({arg val, num, ch, src;~modPartial=val.linexp(0,127,0.001,10.0);s.sendMsg(\n_set, ~idGroup, \modPartial, ~modPartial);},~modPartialCCnum);
t=MIDIFunc.cc({arg val, num, ch, src;~index=val.linexp(0,127,0.001,30.0);s.sendMsg(\n_set, ~idGroup, \index, ~index);},~indexCCnum);
u=MIDIFunc.cc({arg val, num, ch, src;~timeScale=val.linexp(0,127,0.001,10.0);s.sendMsg(\n_set, ~idGroup, \ts, ~timeScale);},~timeScaleCCnum);
v=MIDIFunc.cc({arg val, num, ch, src;~decay=val.linexp(0,127,0.01,10.0);s.sendMsg(\n_set, ~idGroup, \decayTime, ~decay);},~decayCCnum);
w=MIDIFunc.cc({arg val, num, ch, src;~reverb=val.linlin(0,127,0.0,1.0);s.sendMsg(\n_set, ~idGroup, \reverb, ~reverb);},~reverbCCnum);
y=MIDIFunc.cc({arg val, num, ch, src;~panSpeed=val.linlin(0,127,1,10.0);s.sendMsg(\n_set, ~idGroup, \pan, ~panSpeed);},~panSpeedCCnum);
z=MIDIFunc.cc({arg val, num, ch, src;~volume=val.linlin(0,127,0.0,1.0);s.sendMsg(\n_set, ~idGroup, \volume, ~volume);},~volumeCCnum);
);

	"Ready play".postln;

/*
// you may need to increase the memSize before booting
Server.default.options.memSize_(2 ** 20);
// when you are done free the synth and clear the midi mapping
	[q,r,t,u,v,w,y,z].free
*/
}

	