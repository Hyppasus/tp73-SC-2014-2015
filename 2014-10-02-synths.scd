"open http://en.wikibooks.org/wiki/Designing_Sound_in_SuperCollider".unixCmd;

(
Ndef(\pedestrian,  {
	SinOsc.ar(2500, 0, 0.2) * LFPulse.ar(5);
}).play
);

{WhiteNoise.ar(LFNoise2.kr(1).squared)}.play;
{HPF.ar(WhiteNoise.ar, 1000) * LFNoise2.kr(1).squared.squared}.play;
{WhiteNoise.ar * Line.ar(1, 0, 0.02, doneAction: 2)}.play;
(
~firegen = {
	var trigs, durscale, resfreq;
	var noise, hissing, crackles, lapping;
	// A common noise source
	noise = WhiteNoise.ar;
	// Hissing
	hissing = HPF.ar(noise, 1000) * LFNoise2.kr(1).squared.squared;
	// Crackle
	trigs = Dust.kr(1);
	durscale = TRand.kr(1, 1.5, trigs); // vary duration between default 20ms and 30ms
	resfreq = TExpRand.kr(100, 1000, trigs); // different resonant frequency for each one
	crackles = noise * EnvGen.ar(Env.perc(0, 0.02, curve: 0), trigs, timeScale: durscale);
	crackles = crackles + BPF.ar(crackles, resfreq, 20);
	// Flame
	lapping = LeakDC.ar(LeakDC.ar(BPF.ar(noise, 30, 0.2) * 50).clip2(0.9)) * 0.5;
	// Combine them:
	([crackles, hissing, lapping] * [0.1, 0.3, 0.6]).sum * 3
};
~firegen.play
);

(
{
var humSource, noise, comb;

humSource = Clip.ar(LFSaw.ar([99.8, 100.2], 1, 0.5, 0.5).sum - 1, -0.5, 0.5);

noise = LPF.ar(LPF.ar(WhiteNoise.ar,2),2);
noise = noise * noise * 500;

humSource = humSource * noise;

// fig 39.2: Comb unit
comb = DelayC.ar(InFeedback.ar(10), delaytime: (noise+20)/1000);
OffsetOut.ar(10, (humSource + OnePole.ar(comb * 0.2, exp(-2pi * (3000 * SampleDur.ir)))));

comb!2 ;

}.play;
);


(
SynthDef(\fm00, {|out= 0, gate= 1, freq0= 400, amp0= 100, freq1= 500, amp1= 200, freq2= 600, amp2= 300, freq3= 700, amp= 0.5, atk= 0.1, rel= 1, cur= -4, pan= 0|
	var e= EnvGen.kr(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
	var a= SinOsc.ar(freq0, 0, amp0);
	var b= SinOsc.ar(a+freq1, 0, amp1);
	var c= SinOsc.ar(b+freq2, 0, amp2);
	var d= SinOsc.ar(c+freq3, 0, amp);
	Out.ar(out, Pan2.ar(d*e, pan));
}).add;
)
Ndef(\fm00, \fm00).play.gui(8)


{SinOsc.ar(440+SinOsc.ar(1000,0,100),0,0.5)}.play;
{SinOsc.ar(440+SinOsc.kr(1000,0,100),0,0.5)}.play;
{SinOsc.ar(Line.kr(440,1200,4,1,0,2),0,0.5)}.play

100.do{|i|{SinOsc.ar(Line.kr(440,rrand(100,1200),rrand(4,12),1,0,2),pi.rand,[0.01,0.01])}.play}

{SinOsc.ar(EnvGen.ar(Env.new([440, 1200, 400],[1,1],\exp),doneAction:2),0,0.5)}.play;

{SinOsc.ar(EnvGen.ar(Env.new([440, 1200, 400],[1,1],\exp),timeScale:0.1),0,EnvGen.kr(Env.linen(0.01,1,1),1,1,0,0.1))}.play;

{arg ts=1;SinOsc.ar(EnvGen.ar(Env.new([440, 1200, 400],[1,1],\exp),timeScale:ts),0,EnvGen.kr(Env.linen(0.01,1,1),1,1,0,ts))}.play;

100.do{{var ts=rrand(10,100);SinOsc.ar(EnvGen.ar(Env.new(Array.rand(10,200,1200),Array.rand(9,0.1,1),\exp),timeScale:ts,doneAction:2),0,0.1)}.play};

// http://twitter.com/#!/alln4tural/status/99846300173991936
// http://soundcloud.com/tengototen/esoteric-tweet

h=[5,7,8].choose*(2**(2..8).choose);

fork{loop{h=[5,7,8].choose*(2**(2..8).choose);play{Splay.ar({SinOsc.ar(exprand(h,h+(h/64)),0,0.1)}!64)*LFGauss.ar(9,1/4,0,0,2)};2.wait}};

// really i wanted to do this:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 5).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};4.wait}};
// or more like a constant drone:
fork{loop{h=([33,38,40].choose.midicps)*(2**((0 .. 4).choose));play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!8)*LFGauss.ar(19,1/4,0,0,2)};0.25.wait}};
// primes
fork{loop{h=(4 .. 100).choose.nthPrime*(2**(0..3).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/256),h+(h/256)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}};
// Fibonacci
fork{loop{h=(List.fib(15).choose)*(2**(0..4).choose);play{Splay.ar({SinOsc.ar(exprand(h-(h/64),h+(h/64)),0,0.1)}!64)*LFGauss.ar(19,1/4,0,0,2)};2.wait}};

// but they were too long.
// __________________________
// inspired by http://sctweets.tumblr.com/post/8379573991/sinosc
// (http://soundcloud.com/rukano)



x=[];
x=x.add(rrand(0,1.0));
x= #[440, 460, 1200]
x = x.add(2400);
x.put(1600, 2);

#[freq, amp]
{arg freq, amp; SinOsc.ar(freq, 0, amp)}

{25.do{|i|x.set(\freq, g[i]);0.5.wait;};x.free}.fork; //sequencing, what is this?

a={arg freq=440;SinOsc.ar(freq)*0.5!2}.play
a.set(\freq, 1200);
a= 2;
s.queryAllNodes;
s.sendMsg(\n_set, 1000, \freq, 100);
s.sendMsg(\n_free, 1000)

a.free;



{
	4.wait;

	10.reverseDo{arg counter;
		counter.postln;
		1.wait;
		};

	5.wait;

	"ready to play!!!".postln

}.fork;



2.pow(10);
 /*#######################################################*/

{SinOsc.ar(XLine.kr(100,1000,10,1,0,2), 0, 1)}.play

{SinOsc.ar(XLine.kr(100,1000,10,1,0,2), 0, Line.kr(0,1,10))}.play

(
{SinOsc.ar(
	XLine.kr(100,1000,10,1,0,2),
	0,
	EnvGen.kr(Env([0,1,0],[5,5]))
)}.play
);

{SinOsc.ar * EnvGen.kr(Env([0,1,0],[5,5]),doneAction:2)}.play

{SinOsc.ar(EnvGen.kr(Env([1000,120,1200],[1,1]),doneAction:2)) * EnvGen.kr(Env([0,1,0],[2,2]))}.play




{SinOsc.ar(
	EnvGen.kr(Env([440,1200,100],[1,5]),doneAction:2))}.play
(
{
var freq, times, n=10;
freq = Array.rand(n, 100, 1200);
times = Array.rand(n-1, 1, 10);
	SinOsc.ar(
		EnvGen.kr(Env(freq, times),timeScale:0.05,doneAction:2),
		0,
		0.1
	)
}.play
);

(
//var freq, times,
n=10;
~freq = Array.rand(n, 100, 1200);
~times = Array.rand(n-1, 1, 10);
~times.sum;

{	SinOsc.ar(
		EnvGen.kr(Env(~freq, ~times,[0,-1,1,0,-1,1,0,-1,1]),
		timeScale:1,doneAction:2))
}.play
);

Env([0, 100, 0.7, 0],[1,1,1],[0,10,-10]).plot
Env(Array.rand(100,110,1200),Array.rand(99,0.0,1),Array.rand(99,-10,10)).plot;
Env(Array.fib(10,100,120).scramble,Array.fib(9,0.9,1.0).scramble).plot

(
{
	SinOsc.ar(440, pi,
	EnvGen.kr(
			Env([0,1,0],[0.001,0.5]),
		Impulse.kr(2))
	)
}.play
)




[1,2,3,40].normalizeSum;

(
2.do{
	{var freq, times, curves, n=10, ts=1;
	freq = Array.rand(n, 100, 1200);
	times = Array.rand(n-1, 1, 10);
	curves = Array.rand(n-1, -10, 10);
		SinOsc.ar(
			EnvGen.kr(
					Env(freq, times, curves),
				timeScale:ts,doneAction:2),
		0,
		0.1
			)

	}.play

}
);


































