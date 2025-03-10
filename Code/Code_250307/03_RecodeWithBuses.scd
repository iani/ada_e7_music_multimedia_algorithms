//Recoding the Ligeti Metronome piece using busses to
//transfer the triggering pulses to the synths.
//This allows much greater timing accuracy, since the beat duration
//is calculated in the server instead of sclang.
//------------------------------------------------------------
//
//: Isolate the woodblock sound
(
SynthDef(\wdblk, { | dt = 1, frqwd = 850,  wdv = 1 |
	var trig, src;
	trig = LFSaw.ar(dt);
	src = Resonz.ar(trig, frqwd, 0.04, wdv);
	Out.ar(0, src);
}).add

)
//:Try out one woodblock
Synth(\wdblk);
//:Try out several woodblocks
{
	Synth(\wdblk, [dt: 1.5, frqwd: 850]);
	0.25.wait;
	Synth(\wdblk, [dt: 1, frqwd: 850 / 2]);
	0.1.wait;
	Synth(\wdblk, [dt: 2, frqwd: 850 / 3]);
}.fork
//: Try Impulse instead of LFSaw as plectrum
(
SynthDef(\wd1, { | dt = 1, frqwd = 850,  wdv = 10 |
	var trig, src;
	trig = Impulse.ar(dt);
	src = Resonz.ar(trig, frqwd, 0.04, wdv);
	Out.ar(0, src);
}).add
)
//:test w1
Synth(\wd1);
//:Use TDuty instead of Impulse, so as to retrigger and reset at any point
(
SynthDef(\wd2, { | dt = 1, frqwd = 850,  vol = 10, t_reset = 0 |
	var trig, src;
	trig = TDuty.ar(dt, t_reset);
	src = Resonz.ar(trig, frqwd, 0.04, vol);
	Out.ar(0, src);
}).add
)
//: test w2
a = Synth(\wd2, [dt: 2]);
//: Test vol parameter
a.set(\vol, 15)
//:reset
a.set(\t_reset, 1);
//--------------------------------------------------------------------------------
//:Separating the trigger synth from the sound synth
(
// Trigger SynthDef, control rate.
SynthDef(\t1, { | out = 0, freq = 1, t_reset = 0 |
	var trig;
	trig = TDuty.kr(freq.reciprocal, t_reset);
	Out.kr(out, trig);
}).add;
// Audio Synthdef
SynthDef(\w1, { | in = 0, freq = 850, vol = 10 |
	var src;
	src = Resonz.ar(K2A.ar(In.kr(in)), freq, 0.04, vol);
	Out.ar(0, src);
}).add;
)
//:Test
a = Synth(\t1, [out: 0]);
b = Synth(\w1, [in: 0]);
//:
a.set(\freq, 3);
//:
a.set(\freq, 0.3);
//:
a.set(\t_reset, 1);
//:
b.set(\freq, 900);
//:------------------------------------------------------------
//playing multiple triggers, each with its own control, in one SynthDef
//: Trigger SynthDef, control rate.
SynthDef(\mt0, { | out = 0, bpm = 60, t_reset = 0 |
	var trig;
	trig = TDuty.kr((bpm/60).reciprocal, t_reset);
	Out.kr(out, trig);
}).add;
//: Audio Synthdef
SynthDef(\m0, { | in = 0, freq = 850, vol = 10 |
	var src;
	src = Resonz.ar(K2A.ar(In.kr(in)), freq, 0.04, vol);
	Out.ar(0, src);
}).add
//:Metronome click synth
m = Synth(\m0, [in: 0]);
//:Metronome beats trigger synth
t = Synth(\mt0); // t: trigger
//:Set bpm in trigger synth to 120
t.set(\bpm, 120);
//:Set bpm in trigger synth to 160
t.set(\bpm, 160);
//:Multiple metronome beats triger synthdef
SynthDef(\mmt0, {
	[\out, \bpm, \t_reset, \vol].symcollect(
		{ | i, out, bpm, reset, vol |
			var trig;
			trig = TDuty.kr(
				bpm.kr(60+i/60).reciprocal,
				reset.kr(0)
			);
			Out.kr(out.kr(i - 1), trig * vol.kr(1));
		},
		50
	);
}).add;
//:Look at the pattern of beats in a control bus scope
m = Synth(\mmt0, [in: 0]);
//:open scope to see bus channels
Server.default.scope(rate: \control, numChannels: 50);
//:Test multiple metronome beats trigger synthdef
m = Synth(\m0, [in: 0]);
t = Synth(\mmt0); // t: trigger
