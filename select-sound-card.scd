//Steps to change your sound card
// first be sure to quit the server
s.quit;
//second verify that your sound card is recognised by sc
ServerOptions.devices;
x=ServerOptions.devices;
x.size;
x.do{|i| i.postln;"";}
x[4];
// assign the selection to be the device in supercollider either by name or from the array of devices
Server.local.options.device = "C-Media USB Audio Device   ";
Server.local.options.device = x[4];
// start the server
s.boot;
// try it
a= {SinOsc.ar([400,440],0,0.5)}.play


// Second METHOD
s.quit;
// select the card as the system sound card in the system preferences and start theserver


// verify it
o=Server.local.options;
o.device;
o.inDevice;
o.outDevice;

Server.local.options.sampleRate;
Server.local.options.sampleRate = 22000;
