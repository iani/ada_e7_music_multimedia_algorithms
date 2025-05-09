//From: https://sccode.org/1-5ir
/*
Program Note:

This piece is inspired by György Ligeti's Poème Symphonique for 100
Metronomes, a work composed in 1962 that explores the concept of a musical
labyrinth and the auditory perception of infinity. Drawing on Ligeti's idea
of parallel mirrors reflecting endless images, this program replicates the
hypnotic and mesmerizing effect of overlapping independent tempos created by
multiple metronomes.

Using modern digital synthesis, the program simulates the gradual
deceleration and silencing of 100 independent metronomes distributed across
a stereo sound field. Each metronome is set to a unique frequency (spanning
from 440 Hz to 880 Hz), tempo (ranging from 80 to 240 BPM), and stereo
position (panned across the left and right channels). Instead of physical
metronomes placed on resonant surfaces like in Ligeti's original
performance, the digital audio synthesis reproduces their ticking pulses to
emulate the acoustic complexity and variation.

Similar to the original performance instructions:

- Each metronome operates at its own tempo, creating a complex interplay of
  rhythms.

- The performance begins with all metronomes ticking simultaneously, but over
  time, the staggered tempi cause individual ticks to dissolve into silence.

- The spatial panning enhances the sense of physicality and unpredictability
  inherent in the original piece.

Ali Balighi
www.alibalighi.com
© 2025 by Ali Balighi

*/

//:Part 1:
(
// Boot the server and define the SynthDef
s.waitForBoot {
    SynthDef(\metronome, { |freq = 440, amp = 0.01, decay = 0.02, pan = 0|
        var env = EnvGen.kr(Env.perc(0.001, decay), doneAction: 2); // Envelope for short tick
        var signal = SinOsc.ar(freq) * env * amp; // Sound generation
        Out.ar(0, Pan2.ar(signal, pan)); // Output with panning
    }).add;

    // Start playing the pattern
    s.sync;

    // Use a function block to ensure variables are scoped properly
    {
        // Declare and initialize the required variables
        var numMetronomes = 100; // Number of metronomes
        var bpmMin = 80; // Minimum BPM
        var bpmMax = 240; // Maximum BPM
        var freqMin = 440; // Minimum frequency
        var freqMax = 880; // Maximum frequency
        var beatsPerMetronome = 50; // Number of beats for each metronome to play

        // Linearly distributed parameters
        var tempos = Array.fill(numMetronomes, { |i| bpmMin + (bpmMax - bpmMin) * (i / (numMetronomes - 1)) });
        var frequencies = Array.fill(numMetronomes, { |i| freqMin + (freqMax - freqMin) * (i / (numMetronomes - 1)) });
        var pans = Array.fill(numMetronomes, { |i| -1 + 2 * (i / (numMetronomes - 1)) }); // Spread panning between -1 and 1

        // Combine parameters into Pbind and Pseq
        Ppar(
            tempos.collect { |tempo, index|
                Pbind(
                    \instrument, \metronome,                         // Use the \metronome SynthDef
                    \freq, frequencies[index],                     // Assign unique frequency
                    \pan, pans[index],                             // Assign unique stereo position
                    \amp, 0.05,                                    // Set amplitude
                    \dur, Pseq([(60 / tempo)], beatsPerMetronome)   // Duration (tempo) repeated
                )
            }
        ).play;
    }.value; // Call the function block
};
)
//:
