Server.default.waitForBoot{

SynthDef(\notreDame,
{
		arg rep = 1, amp=1, gate=0;
var chime, freqSpecs, burst, harmonics = 10, burstEnv, burstLength = 0.001, envAmp;

freqSpecs = `[
	{rrand(400, 1200)}.dup(harmonics), //freq array
	{rrand(0.3, 1.0)}.dup(harmonics).normalizeSum, //amp array
			//harmonics.reciprocal.dup(harmonics),
	{rrand(2.0, 4.0)}.dup(harmonics)]; //decay rate array

burstEnv = Env.perc(0, burstLength); //envelope times
burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(rep))*0.1); //Noise burst
		envAmp = EnvGen.ar(Env.asr(0.1,1,1),gate,doneAction:0);
		Out.ar(0, Klank.ar(freqSpecs, burst)*amp*envAmp);


	};
).add;


s.sync;

	s.sendMsg(\s_new, "notreDame", 1010, 1, 1);

	// The midi initialization will be better to move it to another file that set the whole software
	MIDIClient.init;
	s.sync;
	MIDIIn.connectAll;
	s.sync;


	// this can be here
	MIDIFunc.noteOn({arg vel, note, ch;s.sendMsg(\n_set, 1010, \gate, 1, \rep, note.linlin(40,127,0.1,2),\amp, vel.linlin(0,127,0,1.0));},nil,0,1248792042);

	//change the last three arguments following the channel and numeber of your machine, or leave it with the defaults if you only have one controller connected.
	//to see the number of your machine evaluate
	//o=MIDIFunc.noteOn({arg vel, note, ch, src;[vel, note, ch, src].postln});
	//is the lastone
	//then
	//o.free;


	MIDIFunc.noteOff({arg vel, note, ch;s.sendMsg(\n_set, 1010, \gate, -2, \rep, note.linlin(40,127,0.1,2));},nil,0,1248792042);
//the note off function, samething with the arguments use yours.


}

/*
Save the above patch in the Desktop (or somewhere where you can provide the full path) as myFirstSynth.scd
"/Users/your-user/Desktop/myFirstSynth.scd".loadPaths;
*/
