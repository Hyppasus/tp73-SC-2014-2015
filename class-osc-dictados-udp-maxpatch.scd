{SinOsc.ar(440,0,0.1)}.play;
{SinOsc.ar(330)}.play;

//Frequency modulation
{SinOsc.ar(LFSaw.kr(4,0,200,400),0,0.7)}.play;

{WhiteNoise.ar(0.1)}.play;

{WhiteNoise.ar(LPF 1000(0.1)}.play;


Filtering Noise
{LPF.ar(WhiteNoise.ar(0.1),440,1,0);}.play // hello!

{LPF.ar(WhiteNoise.ar(0.1),MouseX.kr(20,2000))}.play;//Using a controller

{LPF.ar(WhiteNoise.ar(0.1),LFTri.kr(0.5).range(20,2000))}.play; //range 20,2000 takes the frequency to open and close the filter

{HPF.ar(WhiteNoise.ar(0.1),LFTri.kr(0.5).range(20,2000))}.play;
// the sound source
{LPF.ar(WhiteNoise.ar(0.1),2000);}.play;
// please add the envelope
{LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.kr(Env.perc(0.005, 0.4), doneAction:2)}.play;
// second alternative
({
    var env=Env([0,1,0],[0.005, 0.4]);
    LPF.ar(WhiteNoise.ar(0.1),2000)*EnvGen.kr(env);
}.play
)
// This is the envelope
EnvGen.kr(Env.perc(0.005, 0.4), doneAction:2)


// add iterations
{
10.do{
{LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.ar(Env.perc(0.005, 0.4), doneAction:2)}.play;
1.wait;
};
}.fork

//add reverb
{FreeVerb.ar(
LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.kr(Env.perc(0.005, 0.4), doneAction:2),1,1,0)}.play;

{
var source, filter, rev, env;
source = WhiteNoise.ar(0.5);
filter = LPF.ar(source, 2000);
rev = FreeVerb.ar(filter,1,0,0);
env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);

rev * env;

}.play;


(
SynthDef(\revattack,
{arg amp=1, cutFreq=2000;/Object

Synth(\revattack)

var source, filter, rev, env;
source = WhiteNoise.ar(amp);
filter = LPF.ar(source, cutFreq);
rev = FreeVerb.ar(filter,1,0,0);
env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);


Out.ar(0, rev * env);

}).add

);


(
SynthDef(\revattack,{arg amp=1, cutFreq=2000;
    var source, filter, rev, env;
    source = WhiteNoise.ar(amp);
    filter = LPF.ar(source, cutFreq);
    rev = FreeVerb.ar(filter,1,0,0);
    env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);
    Out.ar(0, rev * env);

}).writeOnce;

)



(
SynthDef(\mySine, {arg freq=440, amp=1;
    var sound = SinOsc.ar(freq, 0, amp);
    Out.ar(0, sound)
}
).add;

)

//
s.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
s.sendMsg(\n_set, 1101, \freq, 200)



//Object

Synth(\revattack)
    x = Synth(\mySine);
    x.set(\freq, 1200);
    x.set(\amp, 0.01);



(
SynthDef(\mySine, {arg freq=440, amp=1;
    var sound = SinOsc.ar(freq, 0, amp);
    Out.ar(0, sound)
}
).add;

)

//Messages
s.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
s.sendMsg(\n_set, 1101, \freq, 200)

s.sendMsg("\s_new \mySine 1101 1 1".cs.interpret)


//Object

Synth(\revattack)
    x = Synth(\mySine);
    x.set(\freq, 1200);
    x.set(\amp, 0.01);


Server.local.addr;

s.boot;


s=Server("ana", NetAddr("169.254.115.214", 57110));
Server.default = s;
s.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
s.sendMsg(\n_set, 1101, \freq, 200);
{100.do{|i|s.sendMsg(\n_set, 1101, \freq, rrand(200, 1200));1.wait;}}.fork



t=Server("ale", NetAddr("169.254.37.39", 57110));
t.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
{100.do{|i|t.sendMsg(\n_set, 1101, \freq, rrand(200, 1200));1.wait;}}.fork


s = Server.local
s.boot

s.sendMsg(\g_new, 2)
s.sendMsg(\s_new, \mySine, 1101, 1, 2, \freq, 1200);
s.sendMsg(\s_new, \mySine, 1102, 1, 1, \freq, 1200);

NetAddr.langPort;    // retrieve the current port SC is listening to
NetAddr.localAddr;   // retrieve the current IP and port
OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off

OSCdef(\print, { |msg, time| msg.postln}, \print);//basic osc listen function
OSCdef(\button, { |msg, time| msg.postln}, \button);


s.sendMsg(\s_new, \mySine, 1100, 1,1);
s.sendMsg(\s_new, \mySine, 1101, 1,1);
OSCdef(\print, { |msg, time| s.sendMsg(\n_set, 1100, \freq, msg[1].linlin(0,1.0, 20,2000))}, "/1/multixy1/1");
OSCdef(\print2, { |msg, time| s.sendMsg(\n_set, 1101, \freq, msg[1].linlin(0,1.0, 20,2000))}, "/1/multixy1/2");


// This is the max patch. Copy it and paste it in a max patch document
{
    "patcher" :     {
        "fileversion" : 1,
        "appversion" :         {
            "major" : 5,
            "minor" : 1,
            "revision" : 9
        }
,
        "rect" : [ 1518.0, 34.0, 864.0, 480.0 ],
        "bglocked" : 0,
        "defrect" : [ 1518.0, 34.0, 864.0, 480.0 ],
        "openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
        "openinpresentation" : 0,
        "default_fontsize" : 10.0,
        "default_fontface" : 0,
        "default_fontname" : "Arial",
        "gridonopen" : 0,
        "gridsize" : [ 15.0, 15.0 ],
        "gridsnaponopen" : 0,
        "toolbarvisible" : 1,
        "boxanimatetime" : 200,
        "imprint" : 0,
        "enablehscroll" : 1,
        "enablevscroll" : 1,
        "devicewidth" : 0.0,
        "boxes" : [             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-20",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 488.0, 286.0, 32.5, 16.0 ],
                    "presentation_rect" : [ 488.0, 286.0, 0.0, 0.0 ],
                    "text" : "me"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-19",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 206.0, 285.0, 119.0, 16.0 ],
                    "presentation_rect" : [ 206.0, 285.0, 0.0, 0.0 ],
                    "text" : "/s_new mySine 1101 1 1"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-18",
                    "maxclass" : "newobj",
                    "numinlets" : 1,
                    "numoutlets" : 0,
                    "patching_rect" : [ 399.0, 316.0, 30.0, 18.0 ],
                    "text" : "print"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-17",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 392.0, 283.0, 32.5, 16.0 ],
                    "text" : "2 4"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-13",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 763.0, 228.0, 96.0, 16.0 ],
                    "presentation_rect" : [ 763.0, 228.0, 0.0, 0.0 ],
                    "text" : "/n_set 1101 freq $1"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-14",
                    "maxclass" : "newobj",
                    "numinlets" : 6,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 763.0, 207.0, 101.0, 18.0 ],
                    "text" : "scale 0 127 20 2000"
                }

            }
,             {
                "box" :                 {
                    "id" : "obj-15",
                    "maxclass" : "slider",
                    "numinlets" : 1,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 763.0, 48.0, 20.0, 140.0 ],
                    "presentation_rect" : [ 763.0, 48.0, 0.0, 0.0 ]
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-12",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 660.0, 232.0, 98.0, 16.0 ],
                    "presentation_rect" : [ 676.0, 232.0, 0.0, 0.0 ],
                    "text" : "/n_set 1101 amp $1"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-11",
                    "maxclass" : "newobj",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "float" ],
                    "patching_rect" : [ 660.0, 211.0, 36.0, 18.0 ],
                    "text" : "/ 127."
                }

            }
,             {
                "box" :                 {
                    "id" : "obj-10",
                    "maxclass" : "slider",
                    "numinlets" : 1,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 660.0, 52.0, 20.0, 140.0 ]
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-9",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 504.0, 170.0, 96.0, 16.0 ],
                    "presentation_rect" : [ 427.0, 173.0, 0.0, 0.0 ],
                    "text" : "/n_set 1101 freq $1"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-8",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 427.0, 140.0, 101.0, 16.0 ],
                    "presentation_rect" : [ 427.0, 140.0, 0.0, 0.0 ],
                    "text" : "/n_set 1101 freq 120"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-7",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 426.0, 117.0, 107.0, 16.0 ],
                    "text" : "/n_set 1101 freq 1200"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-5",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 316.0, 126.0, 66.0, 16.0 ],
                    "text" : "/n_free 1101"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-3",
                    "maxclass" : "message",
                    "numinlets" : 2,
                    "numoutlets" : 1,
                    "outlettype" : [ "" ],
                    "patching_rect" : [ 163.0, 107.0, 119.0, 16.0 ],
                    "text" : "/s_new mySine 1101 1 1"
                }

            }
,             {
                "box" :                 {
                    "fontname" : "Arial",
                    "fontsize" : 10.0,
                    "id" : "obj-1",
                    "maxclass" : "newobj",
                    "numinlets" : 1,
                    "numoutlets" : 0,
                    "patching_rect" : [ 208.0, 235.0, 123.0, 18.0 ],
                    "text" : "udpsend 127.0.0.1 57110"
                }

            }
 ],
        "lines" : [             {
                "patchline" :                 {
                    "destination" : [ "obj-11", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-10", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-12", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-11", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-12", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-13", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-13", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-14", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-14", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-15", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-18", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-17", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-18", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-19", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-3", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-5", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-7", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-8", 0 ]
                }

            }
,             {
                "patchline" :                 {
                    "destination" : [ "obj-1", 0 ],
                    "hidden" : 0,
                    "midpoints" : [  ],
                    "source" : [ "obj-9", 0 ]
                }

            }
 ]
    }

}



	//
	{SinOsc.ar(333)}.play;
{SinOsc.ar(440,0,0.1)}.play;
{ SinOsc.ar(LFSaw.kr(4, 0, 200, 400), 0, 0.7) }.play;
{ SinOsc.ar(SinOsc.kr(4, 0, 200, 400), 0, 0.7) }.play;
{ SinOsc.ar(LFSaw.kr(4, 0, 600, 800), 0, 0.7) }.play;
LFSaw.kr(1)

{SinOsc.ar(LFSaw.kr(4,0,300,400),0,0.7)}.play;


(
fork{
	100.do({
		{LPF.ar(WhiteNoise.ar(1), 2000)
			* EnvGen.ar(Env.perc(0.001,0.5), doneAction:2)}.play;
		1.wait;
	});
}
);

{LPF.ar(WhiteNoise.ar(0.1),440)}.play;
{LPF.ar(WhiteNoise.ar(0.1),MouseX.kr(20,2000))}.play;

{LPF.ar(WhiteNoise.ar(0.1),LFTri.kr(0.5).range(20,2000))}.play;

{HPF.ar(WhiteNoise.ar(0.1),LFTri.kr(0.5).range(20,2000))}.play;


{LPF.ar(WhiteNoise.ar(0.1),2000);}.play;

(
{

    var env=Env([0,1,0],[0.005, 0.4]);
    LPF.ar(WhiteNoise.ar(0.1),2000)*EnvGen.kr(env);

}.play //Modulate the amplitude to triangular
);

{LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.kr(Env.perc(0.005, 0.4), doneAction:2)}.play;

(
{
10.do{
{LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.ar(Env.perc(0.01, 0.4), doneAction:2)}.play;
1.wait;
};
}.fork
);

{FreeVerb.ar(LPF.ar(WhiteNoise.ar(0.5),2000) * EnvGen.kr(Env.perc(0.005, 4), doneAction:0),1,1,0)}.play;

{
var source, filter, rev, env;
source = WhiteNoise.ar(0.5);
filter = LPF.ar(source, 2000);
rev = FreeVerb.ar(filter,1,0,0);
env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);

rev * env;

}.play



{arg amp=1, cutFreq=2000;
var source, filter, rev, env;
source = WhiteNoise.ar(amp);
filter = LPF.ar(source, cutFreq);
rev = FreeVerb.ar(filter,1,0,0);
env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);


Out.ar(0, rev * env);

}.play


(
SynthDef(\revattack,{arg amp=1, cutFreq=2000;
	var source, filter, rev, env;
	source = WhiteNoise.ar(amp);
	filter = LPF.ar(source, cutFreq);
	rev = FreeVerb.ar(filter,1,0,0);
	env = EnvGen.ar(Env.perc(0.001,5),doneAction:2);
	Out.ar(0, rev * env);

}).writeOnce;

)



(
SynthDef(\mySine, {arg freq=440, amp=1;
	var sound = SinOsc.ar(freq, 0, amp);
	Out.ar(0, sound)
}
).add;

)

//Messages
s.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
s.sendMsg(\n_set, 1101, \freq, 200)

s.sendMsg("\s_new \mySine 1101 1 1".cs.interpret)


//Object

Synth(\revattack)
	x = Synth(\mySine);
	x.set(\freq, 1200);
	x.set(\amp, 0.01);


Server.local.addr;

s.boot;


s=Server("ana", NetAddr("169.254.115.214", 57110));
Server.default = s;
s.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
s.sendMsg(\n_set, 1101, \freq, 200);
{100.do{|i|s.sendMsg(\n_set, 1101, \freq, rrand(200, 1200));1.wait;}}.fork



t=Server("ale", NetAddr("169.254.37.39", 57110));
t.sendMsg(\s_new, \mySine, 1101, 1, 1, \freq, 1200);
{100.do{|i|t.sendMsg(\n_set, 1101, \freq, rrand(200, 1200));1.wait;}}.fork


s = Server.local
s.boot

s.sendMsg(\g_new, 2)
s.sendMsg(\s_new, \mySine, 1101, 1, 2, \freq, 1200);
s.sendMsg(\s_new, \mySine, 1102, 1, 1, \freq, 1200);














	
