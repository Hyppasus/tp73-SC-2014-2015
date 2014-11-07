{

		SinOsc.ar(
			LFNoise1.kr(0.01).exprange(100,{exprand(300,10000)}!120)
					).mean


}.play;

{

		SinOsc.ar(
		{LFNoise1.kr(0.01).exprange(100,exprand(300,10000))}! 120
					).mean


}.play;


{SoundIn.ar([0,1]).wrap}.scope;



[ +, -, *, /, div, %, **, min, max, ring1, ring2, ring3, ring4, difsqr, sumsqr, sqrdif, absdif, amclip, scaleneg, clip2, excess, <! ]





(
x = Signal.sineFill(512, [0, 0, 0, 1]);
[x, x.neg, x.abs, x.sign, x.squared, x.cubed, x.asin.normalize, x.exp.normalize, x.distort].flop.flat
    .plot(numChannels: 9);
)

{x=Saw.ar;[x,x.neg, x.abs, x.sign, x.squared, x.cubed, x.sqrt, x.exp, x.log, x.sin, x.cos, x.tan, x.asin, x.acos, x.atan, x.sinh, x.cosh, x.tanh, x.distort, x.softclip]}.plot;



2.abs
-2.abs

{var sin = SinOsc.ar(320);[sin.log.tanh,sin]}.scope

-0.1.log;

-0.2.log.softclip

[1,2,34].normalize;
[1,2,34].wrap2(1)

















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




























