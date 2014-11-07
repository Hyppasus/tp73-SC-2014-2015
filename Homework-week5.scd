{ Ringz.ar(Dust.ar(2, 0.3), 600, 2) }.play;
{ Klank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;
{ Formlet.ar(Impulse.ar(4, 0.9), LFTri.ar(1).range(300,600), 0.006, 0.1) }.play;
(
{
var chime, freqSpecs, burst, harmonics = 10;
var burstEnv, burstLength = 0.001;

freqSpecs = `[
	{rrand(100, 1200)}.dup(harmonics), //freq array
	{rrand(0.3, 1.0)}.dup(harmonics).normalizeSum, //amp array
	{rrand(2.0, 4.0)}.dup(harmonics)]; //decay rate array

burstEnv = Env.perc(0, burstLength); //envelope times
burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(1))*0.3); //Noise burst

Klank.ar(freqSpecs, burst)
}.play;
);


(
{
var chime, freqSpecs, burst, harmonics = 10;
var burstEnv, burstLength = 0.001;

freqSpecs = `[
	{rrand(100, 1200)}.dup(harmonics), //freq array
	{rrand(0.3, 1.0)}.dup(harmonics).normalizeSum, //amp array
	{rrand(2.0, 4.0)}.dup(harmonics)]; //decay rate array

burstEnv = Env.perc(0, burstLength); //envelope times
burst = PinkNoise.ar(EnvGen.kr(burstEnv, gate: Impulse.kr(1))*0.3); //Noise burst

Klank.ar(freqSpecs, burst)
}.render("/Users/Tenuria/Downloads/homework-week" ++ ".wav",
						duration:10,
						fadeTime:0.1,
						sampleRate:44100,
						headerFormat: "WAV",
						sampleFormat: "int16")
)


(
{ Ringz.ar(Dust.ar(2, 0.3), 600, 2) }.render("/Users/Tenuria/Downloads/homework-2week" ++ ".wav",
						duration:10,
						fadeTime:0.1,
						sampleRate:44100,
						headerFormat: "WAV",
						sampleFormat: "int16");
);
(
{ Klank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.render("/Users/Tenuria/Downloads/homework-week3" ++ ".wav",
						duration:10,
						fadeTime:0.1,
						sampleRate:44100,
						headerFormat: "WAV",
						sampleFormat: "int16");
);
(
{ Formlet.ar(Impulse.ar(4, 0.9), LFTri.ar(1).range(300,600), 0.006, 0.1) }.render("/Users/Tenuria/Downloads/homework-4week" ++ ".wav",
						duration:10,
						fadeTime:0.1,
						sampleRate:44100,
						headerFormat: "WAV",
						sampleFormat: "int16");
)