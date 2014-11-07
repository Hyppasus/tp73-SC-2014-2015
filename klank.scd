{Klank.ar(`[rrand(440, 1200).dup(2),1.dup(2), 1.dup(2)],Impulse.ar(1))}.play

SynthDef(\rand,{var son = Klank.ar(`[rrand(440, 1200).dup(2),1.dup(2), 1.dup(2)],Impulse.ar(1));
	Out.ar(0, son)
}).add;

s.sendMsg(\s_new, "rand", 1010, 1, 1);
s.sendMsg(\n_set, 1010, \freq, 100)

(
SynthDef(\rand,{var son = Klank.ar(`[Rand(440, 1200).dup(2),1.dup(2), 1.dup(2)],Impulse.ar(1));
	Out.ar(0, son)
}).add;
);


(
SynthDef(\rand,{arg freq=440;var son = Klank.ar(`[Rand(4, 12).dup(2),1.dup(2), 1.dup(2)],Impulse.ar(1),freq);
	Out.ar(0, son)
}).add;
);




2.dup(4)
{rrand(3, 5.0)}.dup(4)







(
{
	var exc = Impulse.ar(1), pan = Pan2.ar,

}

)



(
SynthDef(\notreDame,
{
		arg rep = 1, amp=1;
var chime, freqSpecs, burst, harmonics = 10, burstEnv, burstLength = 0.001;

freqSpecs = `[
	{rrand(400, 1200)}.dup(harmonics), //freq array
	//{rrand(0.3, 1.0)}.dup(harmonics).normalizeSum, //amp array
			harmonics.reciprocal.dup(harmonics),
			{rrand(2.0, 4.0)}.dup(harmonics)]; //decay rate array

burstEnv = Env.perc(0, burstLength); //envelope times
burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(rep))*0.1); //Noise burst

		Out.ar(0, Klank.ar(freqSpecs, burst)*amp);


	};
).add
)

s.sendMsg(\s_new, "notreDame", 1010, 1, 1);
s.sendMsg(\n_set, 1010, \rep, 2);
s.sendMsg(\n_set, 1010, \amp, 0.25);

{PinkNoise.ar(EnvGen.ar(Env.perc(0, 0.001),Impulse.kr(1)))}.play



(
SynthDef(\notreDame,
{
		arg rep = 1, amp=1, gate=1;
var chime, freqSpecs, burst, harmonics = 10, burstEnv, burstLength = 0.001, envAmp;

freqSpecs = `[
	{Rand(400, 1200)}.dup(harmonics), //freq array
	{Rand(0.3, 1.0)}.dup(harmonics).normalizeSum, //amp array
			//harmonics.reciprocal.dup(harmonics),
	{Rand(2.0, 4.0)}.dup(harmonics)]; //decay rate array

burstEnv = Env.perc(0, burstLength); //envelope times
burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(rep))*0.1); //Noise burst
		envAmp = EnvGen.ar(Env.asr(0.1,1,1),gate,doneAction:2);
		Out.ar(0, Klank.ar(freqSpecs, burst)*amp*envAmp);


	};
).add
)

s.sendMsg(\s_new, "notreDame", 1010, 1, 1);
s.sendMsg(\n_set, 1010, \gate, -2);
s.sendBundle(0.2, [\s_new, "notreDame", 1010, 1, 1]);
s.sendBundle(0.2, [\n_set, 1010, \gate, -2]);

(
~player =
{
var i = s.nextNodeID;
	s.sendBundle(0.2, [\s_new, "notreDame", i, 1, 1]);
1.wait;
	s.sendBundle(0.2, [\n_set, i, \gate, -2])
}

);



(
~player =
{
var i = s.nextNodeID;
	s.sendMsg(\s_new, "notreDame", i, 1, 1);
	1.wait;
	s.sendMsg(\n_set, i, \gate, -2);
}

);
~player.fork;

OSCdef(\klank1, { |msg, time| ~player.fork;}, "/ButtonV_1");
OSCdef(\klank2, { |msg, time| ~player.fork;}, "/ButtonV_2");
OSCdef(\klank3, { |msg, time| ~player.fork;}, "/ButtonV_3");
OSCdef(\klank4, { |msg, time| ~player.fork;}, "/ButtonV_4");
OSCdef(\klank5, { |msg, time| ~player.fork;}, "/ButtonV_5");
OSCdef(\klank6, { |msg, time| ~player.fork;}, "/ButtonV_6");


(
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
).add
);

s.sendMsg(\s_new, "notreDame", 1010, 1, 1);
s.sendMsg(\n_set, 1010, \gate, 1, \rep, 1);
s.sendMsg(\n_set, 1010, \gate, -2);


MIDIClient.init;
MIDIIn.connectAll;
MIDIIn.connect; // 1 port midi interface
MIDIClient.destinations;




(
//MIDIIn.connect();    // init for one port midi interface
// register functions:
~noteOff = { arg src, chan, num, vel;    ["noteOff: ", src,chan,num,vel / 127].postln; };
~noteOn = { arg src, chan, num, vel;    ["noteOff: ", src,chan,num,vel / 127].postln; };
~polytouch = { arg src, chan, num, vel;    ["polyTouch: ", src,chan,num,vel / 127].postln; };
~control = { arg src, chan, num, val;    ["control: ", src,chan,num,val].postln; };
~program = { arg src, chan, prog;        ["program: ", src,chan,prog].postln; };
~touch = { arg src, chan, pressure;    ["touch: ", src,chan,pressure].postln; };
~bend = { arg src, chan, bend;        ["bend: ", src,chan,bend - 8192].postln; };
~sysex = { arg src, sysex;        sysex.postln; };
~sysrt = { arg src, chan, val;        [src,chan,val].postln; };
~smpte = { arg src, chan, val;        [src,chan,val].postln; };
MIDIIn.addFuncTo(\noteOn, ~noteOn);
MIDIIn.addFuncTo(\noteOff, ~noteOff);
MIDIIn.addFuncTo(\polytouch, ~polytouch);
MIDIIn.addFuncTo(\control, ~control);
MIDIIn.addFuncTo(\program, ~program);
MIDIIn.addFuncTo(\touch, ~touch);
MIDIIn.addFuncTo(\bend, ~bend);
MIDIIn.addFuncTo(\sysex, ~sysex);
MIDIIn.addFuncTo(\sysrt, ~sysrt);
MIDIIn.addFuncTo(\smpte, ~smpte);
);
(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
MIDIIn.removeFuncFrom(\polytouch, ~polytouch);
MIDIIn.removeFuncFrom(\control, ~control);
MIDIIn.removeFuncFrom(\program, ~program);
MIDIIn.removeFuncFrom(\touch, ~touch);
MIDIIn.removeFuncFrom(\bend, ~bend);
MIDIIn.removeFuncFrom(\sysex, ~sysex);
MIDIIn.removeFuncFrom(\sysrt, ~sysrt);
MIDIIn.removeFuncFrom(\smpte, ~smpte);
);

MIDIFunc.noteOn({arg vel, note, ch;[vel, note, ch].postln},nil,0,1248792042);

MIDIFunc.noteOn({arg vel, note, ch;s.sendMsg(\n_set, 1010, \gate, 1, \rep, note.linlin(40,127,0.1,2),\amp, vel.linlin(0,127,0,1.0));},nil,0,1248792042);

MIDIFunc.noteOff({arg vel, note, ch;s.sendMsg(\n_set, 1010, \gate, -2, \rep, note.linlin(40,127,0.1,2));},nil,0,1248792042);




