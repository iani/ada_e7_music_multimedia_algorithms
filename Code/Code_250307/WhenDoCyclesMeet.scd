/*
An exercise: At what time interval do 2 or more metronomes beat together at
the exact same time point again?

Mathematical answer: 2 or more metronomes beat again together at the
Least Common Multiple (LCM) of the ratio of the durations of all beats.

Examples:
If the durations are 2 and 1, the
*/

//:Empirical Illustrations:
//Metronomes with a beat ratio of 2/1 beat together every 2 beats
//of the shortes beat duration:
//: 60 and 120 bpm
/*
	Ratio of of 60 and 120 is 1/2. The least common multiple of
*/
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