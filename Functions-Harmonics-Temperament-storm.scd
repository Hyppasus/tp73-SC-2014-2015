// Write a function to calculate an arbitrary number of harmonics from a fundamental frequency
//Athanasios solution
(

h = {arg freq=440, no_harm=10;
	//g=[];
	freq.postln;
	no_harm.postln;
	g=[];
	for(1,no_harm,{arg counter; g =  g ++ (counter*freq);});
	"done".postln;
	g
	}
)

h.value(400,10);
g;
g.at(5); == g[5]; //accesing the diferent harmonics
g.size;
g.at(9);
g.last;

s.boot;
x = {arg freq=100; Saw.ar(freq, 0.5)}.play; //create a synth when the Server is running
x.set(\freq, g[4]); // set the frequencies while the synth is playing
x.set(\freq, g[5]);

/*how for works*/
"open http://doc.sccode.org/Reference/Control-Structures.html".unixCmd;
for (3, 7, { arg i; i.postln }); // prints values 3 through 7

// Tuomas Solution
(
var harmonics;

harmonics = { arg fundamental = 440, times = 4;

	var harmonic = fundamental;

	times.do ({ arg index;
		if (index == 0) {
			"Fundamental: ".post;
		} {
			index.post;
			". harmonic: ".post;
			harmonic = fundamental * (index + 1);
		};
		harmonic.postln;
	});
};

harmonics.value(220, 50);
)
// from Mike contribution
(
~harmonics={arg n=1, freq=100;
	Array.fill(n,{arg counter;
		(counter*freq).postln})
}
);
~harmonics.value(100,120);



// create a function that can calculate frequencies for arbitrary equal temperaments and a fundamental frequency
// for example the code below play half tones in the equal temperament of 12 semitones
/* 12-tone equal temperament is a form of meantone tuning in which the diatonic and chromatic semitones are exactly the same. Each semitone is equal to one twelfth of an octave */
2 ** (1/12); // ratio in two adjacent notes in equal temperament
2 ** (1/12) * 440; //frequency of "Bb3"
2.sqrt; 2 ** (1/2); //two equivalent notations


x = {arg freq=440; Saw.ar(freq, 0.5)}.play;
x.set(\freq, (2**(1/12)*440));
x.set(\freq, (2**(2/12)*440));
x.set(\freq, (2**(3/12)*440));
x.set(\freq, (2**(4/12)*440));
x.set(\freq, (2**(1/12)*(2**(1/12)*440)));

(

~temperament = {arg freq=440, amount=12, divisions=12;
	var counter = (0..amount);
	2**(counter/divisions)*freq;
}
);

~temperament.value(440, 12, 12);​ //"normal" 12 notes by octave
~temperament.value(440, 13, 13); //13 notes by octave
~temperament.value(120, 3, 3);​ //3 notes by octave

g = ~temperament.value(440, 13, 13); //g holds the array
g.size;
g[0]
g[1]
g[2]

x = {arg freq=440; Saw.ar(freq, 0.5)}.play;
x.set(\freq, g[0]);
x.set(\freq, g[1]);
x.set(\freq, g[2]);
x.set(\freq, g[3]);

g = ~temperament.value(440, 24, 24);​
x = {arg freq=440; Saw.ar(freq, 0.5)}.play;
{25.do{|i|x.set(\freq, g[i]);0.5.wait;};x.free}.fork; //sequencing, what is this?

// this code is equivalent "arg i;" and "|i|"

12.do{|i|{Saw.ar(g[i], 0.1)}.play;}; // Chord

//On the Arrays
g = [];
g = g ++ 2; g
g = Array.new;
g = g.add(2);
g = [2];
Array.fib(100, 2, 2);
Array.rand(10, 1, 100);
h = Array.series(10, 2, 1);
g = Array.geom(10, 2, 3);
h + g;
(4..10);
(..10).do{arg counter; counter.postln};
(..10).collect{arg counter, item; (item ** 2).postln}
Array.exprand(10, 1, 12);


// what are the differences?
().play;
[].play;
{}.play;

// using variables, local, global
a = "hi"
a + "ale";
(var harmonic = 20; 2 + harmonic);
~harmonic = "hi Alex";
~harmonic.speak;


/*##############################################################################################################################################################################################################################################################################################*/

//Build a sonic scape of somebody walking under the rain

//rain
{WhiteNoise.ar(0.5)}.play;
{PinkNoise.ar(0.5)}.play;
{BrownNoise.ar(0.5)}.play;
{BRF.ar(PinkNoise.ar(0.5), 1200)}.play

//walking
{Pulse.ar(1, 0.5, 0.5)}.play;
{Blip.ar(440,20,0.1)}.play;
{Blip.ar(2,400)}.play;
{Blip.ar(PinkNoise.ar(0.5) + 2, 400)}.play;

// rain and walking
{BrownNoise.ar(0.5) + Pulse.ar(1, 0.5, 0.5)}.play;
{[BrownNoise.ar(0.5), Pulse.ar(1, 0.5, 0.5)]}.play;
{(BrownNoise.ar(0.5) + Pulse.ar(1, 0.5, 0.5)).dup}.play;//for stereo, duplicate the signals
{(BrownNoise.ar(0.5) + Pulse.ar(1, 0.5, 0.5)) !2}.play;//same that above

{BRF.ar(PinkNoise.ar(0.5) + Blip.ar(PinkNoise.ar(0.5) + 2, 400), 150, 2)}.play;

// storm
{Dust.ar(1)}.play
{BrownNoise.ar(0.5) * Dust.ar(10) }.play;
{LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60) }.play; //very quite
{FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000) }.play;

// First try
(
{
	BRF.ar(
		PinkNoise.ar(0.5) + Blip.ar(PinkNoise.ar(0.5) + 2, 400),
		150, 2)
	+
	FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000)
!2 // for two channels
}.play
);
// whitout filtering the steps
(
{
	BRF.ar(	PinkNoise.ar(0.5), 150, 2)
	+
	Blip.ar(BrownNoise.ar(0.5) + 2, 400)
	+
	FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000)
!2
}.play
);

// Four channels
(
{
[	BRF.ar(	BrownNoise.ar(0.5), 120, 2),
	BRF.ar(	BrownNoise.ar(0.5), 150, 2) + Blip.ar(BrownNoise.ar(0.5) + 2, 400)
	,
	Blip.ar(BrownNoise.ar(0.5) + 2, 400)
	,
	FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000)
	]
}.play
);

// compare
(
{
	BRF.ar(	PinkNoise.ar(0.5), 150, 2)
	+
	Blip.ar(2, 400)
	+
	FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000)
!2
}.play
);

(
{
	BRF.ar(	PinkNoise.ar(0.5), 150, 2)
	+
	Pulse.ar(1, 0.5, 0.5)
	+
	FreeVerb.ar(LPF.ar(BrownNoise.ar(0.5) * Dust.ar(10),60),1,2,0.2,1000)
!2
}.play
)


