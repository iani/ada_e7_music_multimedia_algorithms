// 250331 Playing audio files.
//:1 Load an audio file into a buffer.
(
~birdcarman = Buffer.read(
	Server.default,
	"/Users/iani/audiofiles/lyra.wav");

)

~birdcarman;
~birdcarman.play;
(
{ PlayBuf.ar(1, ~birdcarman) }.play;
)

(
{ PlayBuf.ar(1, b, MouseX.kr(0.25, 5)) }.play;
)


b = ~birdcarman;


b.play;
//:-------------------------------
// ------ Granular synthesis with TGrains -------
// IMPORTANT:
// TGrains only works on files with one channel
// Your files should have one audio channel only (not stereo!)

(
{
    var trate, dur, rate;
    trate = MouseY.kr(2,200,1);
    dur = 4 / trate;
    rate = Dseq([10, 1, 1, 0.5, 0.5, 0.2, 0.1], inf);
    TGrains.ar(2, Impulse.ar(trate), b, rate, MouseX.kr(0,BufDur.kr(b)), dur, Dseq([-1, 1], inf), 0.1, 2);
}.play;
)

(
{
    var trate, dur, clk, pos, pan;
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    TGrains.ar(2, clk, b, 1, pos, dur, pan, 0.1);
}.play(zoom: 4);
)



