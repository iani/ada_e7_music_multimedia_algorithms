/*
An exercise: At what time interval do 2 or more metronomes beat together at
the exact same time point again?

Mathematical answer: 2 or more metronomes beat again together at the
Least Common Multiple (LCM) of the ratio of the durations of all beats.

Examples:
If the durations are 2 and 1, the
*/

//:metronome SynthDef needed for the examples below:

SynthDef(\metronome, { |freq = 440, amp = 0.01, decay = 0.02, pan = 0|
	var env = EnvGen.kr(Env.perc(0.001, decay), doneAction: 2); // Envelope for short tick
	var signal = SinOsc.ar(freq) * env * amp; // Sound generation
	Out.ar(0, Pan2.ar(signal, pan)); // Output with panning
}).add

//:Empirical Illustrations:
//Metronomes with a beat ratio of 2/1 beat together every 2 beats
//of the shortes beat duration:
//: 60 and 120 bpm
/*
	Ratio of of 60 and 120 is 1/2. The least common multiple of
	2 and 1 is 2, so the beats meet every 2 beats of 120bpm.
	Note that a beat at 120 bpm (0.5 sec) has a shorter duration
 	than one at 60 bpm (1 sec). So the metronomes meet every
	2 x 0.5 sec = 1.0 sec.
*/
//:
Synth(\metronome, [amp: 2]);
//:
Synth(\metronome, [freq: 800, amp: 2]);
//:
{
	loop {
		Synth(\metronome, [freq: 800, amp: 1]);
		1.wait;
	}
}.fork
//:
[5, 6].reciprocal do: { | dur, i |
	{
		// (i * 0.1).wait;
		loop {
			Synth(\metronome, [freq: 330 * (i+1/5 + 1), amp: 0.5, decay: 0.2]);
			(dur).wait;
		}
	}.fork;
}
//:
//:
[60, 120] do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//:
[60, 90] do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//:
[90, 120] do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//:
[60, 90, 120] do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//:
[60, 90, 100, 120] do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//:
[6, 9, 10, 12] * 10 do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//: 60, 70, 80, 90, 100, 110, 120:
(6..12) * 10 do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//: [60, 61, 62 ... 160]:
(60..160) do: { | i |
    {
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            (i/60).reciprocal.wait; // convert bpm to beat duration...
        };
    }.fork
}
//: [60, 61, 62 ... 160], with random beat durations between 60 and 160 bpm:
(60..160) do: { | i |
    {
		var dur;
		dur = (160/60).reciprocal rrand: (60/60).reciprocal;
        loop {
            Synth(\metronome, [freq: 330 * (i+1/50 + 1), decay: 0.2]);
            dur.wait; // convert bpm to beat duration...
        };
    }.fork
}

//------------------------------------------------------------
// Redoing the piece with the same parameter values as in the
// port by Ali Balighi
// The parameters are:
/*
        var numMetronomes = 100; // Number of metronomes
        var bpmMin = 80; // Minimum BPM
        var bpmMax = 240; // Maximum BPM
        var freqMin = 440; // Minimum frequency
        var freqMax = 880; // Maximum frequency
        var beatsPerMetronome = 50; // Number of beats for each metronome to play
*/
//:create set of parameters, then use them
(1..100).collect({
	[
		80 rrand: 240, // bpm
		440 rrand: 880, // freq
	]
}) do: { | parameters |
	var bpm, freq, dur;
	#bpm, freq = parameters;
	dur = (bpm/60).reciprocal;
	{
		50 do: {
			Synth(\metronome, [freq: freq, decay: 0.1]);
			dur.wait; // convert bpm to beat duration...
		};
	}.fork;
}

//:Same algorithm, with 200 beats for each metronome.
(1..100).collect({
	[
		80 rrand: 240, // bpm
		440 rrand: 880, // freq
	]
}) do: { | parameters |
	var bpm, freq, dur;
	#bpm, freq = parameters;
	dur = (bpm/60).reciprocal;
	{
		200 do: {
			Synth(\metronome, [freq: freq, decay: 0.1]);
			dur.wait; // convert bpm to beat duration...
		};
	}.fork;
}
