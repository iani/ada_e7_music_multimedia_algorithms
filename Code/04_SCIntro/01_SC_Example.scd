Server.default.boot;
//

SynthDescLib.default.gui;


//:

(
SynthDef(\250102, {
    arg freq = 60, index = 1000,
    tRate = 5, aRate = 100, rate = 10,
    out = 0;

    var t_trig = LFPulse.kr(0.5 / tRate, 0.5);
    var noise = Hasher.ar(LFNoise0.ar(rate));
    var sig = Saw.ar(
        freq + (noise * index),
        Decay.kr(Impulse.kr(aRate), noise * 0.01)
    ).tanh;

    FreeSelf.kr(t_trig);

    sig = Pan2.ar(sig, noise.range(-0.8, 0.8));
    sig = FreeVerb.ar(sig, 0.4);

    Out.ar(out, sig);
}).load;
)

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
