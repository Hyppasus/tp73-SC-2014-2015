//Resources
"http://doc.sccode.org/Help.html"
"http://doc.sccode.org/Guides/SCIde.html"
"http://sccode.org/"
"http://supercollider.github.io/"
"http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/"
//for this unit
"open http://en.wikipedia.org/wiki/Object-oriented_programming".unixCmd;
"open http://doc.sccode.org/Overviews/Operators.html".unixCmd;
"open http://doc.sccode.org/Reference/Literals.html".unixCmd;

// this is a comment
/* this is also a comment*/

/* DATA TYPES */
//Numbers

1; //integers
1.2; //decimal numbers
0; //zero
-2; //negative numbers
pi; //mathematical constants
(3/4); // fractions
1e10; //scientific notation
2e-2;
2r01000; //binary numbers
9r1234; //other radices
16rA9FF;
2s; //scale degrees s for sharp b for bemol
2b;
2ss;
2bbbb;


//unary operations

2.neg;
-2.abs;
2.reciprocal; //(1/x)
2.sqrt; //or sqrt(2);
2.squared;
2.cubed;
2.exp;
3.sin;
2.3.rand;
2.3.rand2;
2.log;
2.log10;
2.log2;
120.midicps; // midi to Hz
440.cpsmidi;
1.ampdb;
-6.dbamp;
2.sqrt.tanh.sin; // several Methods in a row

//binary operations

2 + 2;
2 - 2;
2 * 3;
2 / 3;
2 ** 3;
2.pow(3);
2 % 1;
//comparaisons
2 > 2;
2 < 2;
2 == 2;
2 <= 2;
2 >= 2;
2 != 2;
// more
3.hypot(4);
2,ring(1);
rrand(2, 3.0);
2.rrand(3.0);
2.wrap2(1.2);

2 + (3 * 3);// there is no priority to multiplication

// text characthers
"hi".postln;
"1 2 3".postln;
"1, 2, 3, 4, 5, 6".postcs; //for long posts
" 1 + 2".interpret;
"hi" + "Ale"; // concatenation
"hi" ++ "Ale";
"one line";
"hi welcome".speak; //only in mac

"/Users/path/to/your/sounds/noise.wav"; // a path for a file, you can drag and drop from the finder window to this window
//paths used by supercollider
Platform.resourceDir;
Platform.systemAppSupportDir;
Platform.systemExtensionDir;
Platform.userAppSupportDir;
Platform.userConfigDir;
Platform.userExtensionDir;
Platform.userHomeDir;

//Symbols
'this is a symbol';
\thisIsAlsoASymbol;

// Characters
$A
$\t //tab
$\n //new line
$\r //return
$\\ //backslash

// Class names are always writen starting with capital letter
Point
SinOsc


//local variables
a = "kjfhg.dafjkgh ";
a
d
f
s //variable

// Arrays
[]
[440, 660] //one dimension
[[1,2,3],[1,2,3]] //multi dimensional
#[] //literal array
#[1, 2, 3]//Literal Arrays must be used as is and may not be altered at run time;
#[hi, 2]//In literal Arrays names are interpreted as symbols.

// Functions
{}
x = {2 + 2};
x.value;
x = {arg val1 = 2; 3 + val1};
x = {arg whatever = 0; 3 + whatever};
x.value;
x.value(4);
x = {arg freq = 440, amp = 1.0; [freq, amp].postln}
x.value;
x.value(1200, 10);

// Pythagoras a to the power of two plus b to the power of two equal to hypothenuse to the power of two;
(
~hypo = {arg sideA = 2, sideB = 2;
	var hypotenuse = 	((sideA ** 2) + (sideB ** 2)).sqrt;
	//var me = "me";
	hypotenuse;

};
);
~hypo.value;
~hypo.value(3,4);
"hi".postln;
8.sqrt;
~hypo.value(sideB:4);
s = 2;
s.boot; // if you evaluate the line before this gives an error because "s" is not anymore the Server
s = Server.local;
s.boot;
s.quit;

ServerOptions // check the help
Server.local.options.sampleRate;
Server.local.options.sampleRate = 48000; //change the sample rate or anyother option BEFORE booting the server
Server.local.options.inDevice;

// Make sounds
{SinOsc.ar(1200,0,1,0)}.play;
{Saw.ar(440) * 0.01}.play;
{SinOsc.ar(SinOsc.kr(1,0,100,440))*0.1}.play;


// modulate freq
{ SinOsc.ar(XLine.kr(200, 2000), 0, 0.5) }.play;
{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play;








