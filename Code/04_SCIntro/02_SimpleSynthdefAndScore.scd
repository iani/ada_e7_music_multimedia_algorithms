//
//:

(
SynthDef(\basicsine, {
	arg freq = 440, amp = 0.1;
	var src;
	src = SinOsc.ar(freq, 0, amp);
	Out.ar(0, src);
}).add;
)

a = Synth(\basicsine);

a.free;
//:
a = Synth(\basicsine, [freq: 660]);
//:
a = Synth(\basicsine);

a.set(\freq, 880);
//:
b = Bus.control;
c = Bus.control;

{ Out.kr(b, LFNoise0.kr(5).range(100, 1000)) }.play;

a.map(\freq, b.index);
a.map(\amp, c.index);

{ Out.kr(b, MouseX.kr(100, 2000)) }.play;
{ Out.kr(c, MouseY.kr(0, 1.0)) }.play;

//:

(
SynthDef(\simplesine, {
    arg freq = 440, amp = 0.1, dur = 1, gate = 1;
	var src, env;
	src = SinOsc.ar(freq, 0, amp);
	env = Env.adsr().kr(2, gate);
    Out.ar(0, src * env);
}).add;
)

a = Synth(\simplesine);


a.release;

a.release(7);

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, 330, 440, 660, 770, 440, 330]),
).play
)

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, 330, 440, 660, 770, 440, 330], 2),
).play
)

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, 330, 440, 660, 770, 440, 330], 10),
	\dur, 0.1
).play
)

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, 330, 440, 660, 770, 440, 330], 10)
	+ Pseq([220, 330, 440, 660, 770, 440, 330].stutter(10), 10) ,
	\dur, 0.1
).play
)

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, 330, 440, 660, 770, 440, 330], 10)
	+ Pseq([220, 330, 440, 660, 770, 440, 330].stutter(10), 10) ,
	\dur, Prand([0.1, 0.2, 0.5, 1], inf)
).play
)

(
Pbind(
	\instrument, \simplesine,
	\freq, Pseq([220, [330, 550], 440, 660, 770, [440, 220], 330], 10)
	+ Pseq([220, 330, 440, 660, 770, 440, 330].stutter(10), 10) ,
	\dur, Prand([0.1, 0.2, 0.5, 1], inf)
).play
)

(
Pbind(
	\instrument, \simplesine,
	\degree, Pseq([2, [3, 5], 4, 6, 7, [4, 2], 3], 10)
	+ Pseq([-1, -2, 4, -6, 7, -3, 3].stutter(10), 10) ,
	\dur, Pseq([0.1, 0.1, 0.2, 0.5], inf)
).play
)

[1, 2, 3].stutter(5);


(
Pbind(
    \instrument, \250102,
    \freq, Pfunc({ 2000.rand }),
    \index, Pfunc({ 10000.rand }),
    \rate, Pfunc({ 10.rand }),
    \aRate, Pfunc({ 10.rand }),
    \tRate, 3
).play;
)


(
Pbind(
    \instrument, \250102,
    \freq, 40,
    \index, 2000,
    \rate, 5,
    \aRate, 5,
    \tRate, 3
).play;
)

//:
a = Synth(\250102);

a.free;

a = Synth(\250102, [freq: 32]);
