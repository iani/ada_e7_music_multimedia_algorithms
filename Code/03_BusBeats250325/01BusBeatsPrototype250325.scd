//: Playing cycles of beats in a control bus.
// This approach is more accurate than doing the timing in sclang with "wait".
//: ======= First prototype =====
//: Breakdown into basic components:
//: A: Generate sequence of beats as impulse triggers
//: A1: Simplest case
t = { | durs = #[1], bus |
	//	bus ?? { bus = Bus.control };
	{
		var beats;
		beats = TDuty.ar(Dseq(durs, inf));
		Out.kr(bus, A2K.kr(beats));
	}.play;
};
//:Test the above
b = Bus.control;
t.([1.5, 0.25, 0.25, 0.25, 2.0, 0.1, 0.1], b);
{
	SinOsc.ar(400, 0, 0.1) *
	Decay2.kr(In.kr(b))
}.play;
//:Testing Dseq
{
	var durs;
	var beats;
	durs = [1.5, 0.25, 0.25, 0.25, 2.0, 0.1, 0.1];
	beats = TDuty.ar(Dseq(durs, inf));
	SinOsc.ar(400, 0, 0.1) * Decay2.ar(beats);
}.play;

//: B: Output beats to a bus.
f = { | durs, bus |
	bus ?? { bus = Bus.control };
	{

		Out.kr(bus, )
	}.play;
};
//: Note: The durations