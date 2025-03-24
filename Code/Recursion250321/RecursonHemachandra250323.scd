// Implementation of Hemachandran's proof / algorithm for
// generating all words of n lenght composed of syllables of
// 1 and 2 beats:
//: (From chatgpt)

// The following is wrong.
// Function to recursively generate the sequences
~generateSequences = { | n, sequence, result |
	sequence ?? { sequence = [] };
	result ?? { result = [] };
    if (n == 0) {
        result = result.copy.add(sequence.copy);
    } {
        if (n >= 1) {
            result = ~generateSequences.(n - 1, sequence.add(1), result);
            sequence = sequence.drop(-1); // remove last added element
        };
        if (n >= 2) {
            result = ~generateSequences.(n - 2, sequence.add(2), result);
            sequence = sequence.drop(-1);
        };
    };
    result;
};

//: Example usage:
(
var n = 4;
var sequences = ~generateSequences.(n);
sequences.do { |seq| seq.postln };
)
//:Test
~generateSequences.(3);
//:Wrong answer produced
//[ [ 1, 1, 1 ], [ 2 ], [ 2, 1 ] ]
// it should be:
[ [ 1, 1, 1 ], [ 1, 2 ], [ 2, 1 ] ]
//:
//
//Another test
~generateSequences.(4);
//wrong answer again:
// [ [ 1, 1, 1, 1 ], [ 1, 1, 1, 2 ], [ 2, 1 ], [ 2, 1, 1 ], [ 2 ] ]



//:------------ Try modifying:
(
~generateSequences2 = { | n, sequence, result |
	sequence ?? { sequence = [] };
	result ?? { result = [] };
    if (n == 0) {
        result = result.copy.add(sequence.copy);
    } {
        if (n >= 1) {
            result = ~generateSequences2.(n - 1, sequence.add(1), result);
			// sequence = sequence.drop(-1); // remove last added element
        };
        if (n >= 2) {
            result = ~generateSequences2.(n - 2, sequence.add(2), result);
			// sequence = sequence.drop(-1);
        };
    };
    result;
};
)
//:
~generateSequences2.(3);
//:
~generateSequences2.(4);

//------------------------------------------------------------
//: Rewriting this based on the chatgpt python pseudocode output
// def generate_sequences(n, current_sequence=[]):
//     if n == 0:
//         print(current_sequence)  # or yield if needed
//         return
//     if n >= 1:
//         generate_sequences(n - 1, current_sequence + [1])
//     if n >= 2:
//         generate_sequences(n - 2, current_sequence + [2])
f = { | n, current_sequence = #[] |
	current_sequence = current_sequence.copy; // make it mutable
	postln("n" + n + "current sequence" + current_sequence);
	if ( n == 0) {
		postln("result:" + current_sequence);
		current_sequence;
	}{
	if (n >= 1) {
		thisFunction.(n - 1, (current_sequence add: 1).postln);
	}{
		if (n >= 2) {
			thisFunction.(n - 2, (current_sequence add: 2).postln);
		}
	};
	current_sequence;
	}
}
//:
f.(4)
//:============================================================:
//python code for collecting all sequences
def generate_sequences(n, current_sequence=[], all_sequences=[]):
    if n == 0:
        all_sequences.append(current_sequence)
        return
    if n >= 1:
        generate_sequences(n - 1, current_sequence + [1], all_sequences)
    if n >= 2:
        generate_sequences(n - 2, current_sequence + [2], all_sequences)

def get_all_sequences(n):
    all_sequences = []
    generate_sequences(n, [], all_sequences)
    return all_sequences
//:Attempt for sclang code: --- wrong
g = { | n, current_sequence, all_sequences |
	current_sequence ?? { current_sequence = List() };
	all_sequences ?? { all_sequences = List() };

	if (n == 0) {
		all_sequences.add(current_sequence);
		all_sequences;
	}{
		if (n >= 1) {
			thisFunction.(n - 1, current_sequence.add(1), all_sequences);
		};
		if (n >= 2) {
			thisFunction.(n - 2, current_sequence.add(2), all_sequences);
		};
	}
};
h = { | n |
	var all_sequences;
	all_sequences = List();
	g.(n, List(), all_sequences);
	all_sequences;
}
//: test the error:
h.(5) do: { | i | i.postln; }
//==================================================
//: code from chat gpt
// Recursive function to collect all permutations
~generateSequences = { |n, currentSequence, allSequences|
    if (n == 0) {
        // Base case: valid sequence complete
        allSequences = allSequences.add(currentSequence.copy);
    } {
        if (n >= 1) {
            allSequences = ~generateSequences.(n - 1, currentSequence.add(1), allSequences);
            currentSequence = currentSequence.drop(-1);  // Undo append
        };
        if (n >= 2) {
            allSequences = ~generateSequences.(n - 2, currentSequence.add(2), allSequences);
            currentSequence = currentSequence.drop(-1);  // Undo append
        };
    };
    allSequences;
};

// Helper function to initialize and start recursion
~getAllSequences = { |n|
    var allSequences = List.new;
    ~generateSequences.(n, List.new, allSequences);
};

//: Example usage:
(
var n = 4;
var sequences = ~getAllSequences.(n);
sequences.do { |seq| seq.postln };
)
//:============================================================
//:fixed algorithm for sclang by chatgpt
// Corrected recursive function
~generateSequences = { |n, currentSequence, allSequences|
    if (n == 0) {
        allSequences.add(currentSequence);
    } {
        if (n >= 1) {
            // Create a new copy of currentSequence with 1 added
            ~generateSequences.(n - 1, currentSequence.copy.add(1), allSequences);
        };
        if (n >= 2) {
            // Create a new copy of currentSequence with 2 added
            ~generateSequences.(n - 2, currentSequence.copy.add(2), allSequences);
        };
    };
};

// Wrapper function to collect all sequences
~getAllSequences = { |n|
    var allSequences = List.new;
    ~generateSequences.(n, List.new, allSequences);
    allSequences;
};

//: Example usage
(
var n = 5;
var sequences = ~getAllSequences.(n);
sequences.do { |seq| seq.postln };
)
/* Explanation and trace of how the algorithm works (from chatgpt)

Could you delineate or explain how this algorithm works by tracing the first steps in the generation of the first few sequences produced for a small initial n input?
ChatGPT said:
Absolutely! Let's trace the corrected algorithm step by step for a small input — say, n = 3 — to see exactly how the recursion unfolds and sequences build up. This will make clear how the recursive tree grows and produces all valid permutations.

🌱 Recap of the Core Logic
At every recursive call:

If n == 0, the current sequence is complete — save it.

If n >= 1, append 1 (a 1-beat syllable) and recurse with n - 1.

If n >= 2, append 2 (a 2-beat syllable) and recurse with n - 2.

🔎 Manual Trace for n = 3
Calling getAllSequences(3) starts with:


---------
generateSequences(3, [], allSequences)
🔄 Step 1 — Try adding '1' first

---------
generateSequences(2, [1], allSequences)
🔄 Step 1.1 — Try adding another '1'

---------
generateSequences(1, [1, 1], allSequences)
🔄 Step 1.1.1 — Try adding another '1'

---------
generateSequences(0, [1, 1, 1], allSequences)
✅ n == 0, save [1, 1, 1]

🔄 Step 1.1.2 — Try adding '2' at n = 1 → SKIPPED
n >= 2 is false at n = 1, so this branch ends.

🔄 Step 1.2 — Back to n = 2, try adding '2'

---------
generateSequences(0, [1, 2], allSequences)
✅ n == 0, save [1, 2]

🔄 Step 2 — Back to n = 3, try adding '2' instead of '1'

---------
generateSequences(1, [2], allSequences)
🔄 Step 2.1 — Try adding '1'

---------
generateSequences(0, [2, 1], allSequences)
✅ n == 0, save [2, 1]

🔄 Step 2.2 — Try adding '2' — SKIPPED
At n = 1, n >= 2 fails.

✅ Final Collected Sequences for n = 3
The algorithm saves the following valid sequences:

csharp
Copy
Edit
[1, 1, 1]
[1, 2]
[2, 1]
Total: 3 sequences (which is Fibonacci(4) = 3)

🧠 Summary of the Process
The recursion explores all paths by trying both 1 and 2 when possible.

Each recursive call builds a unique sequence branch because .copy.add() is used.

When n hits 0, the branch is complete and stored.

The recursion ensures all valid beat combinations that sum to n are covered.

Would you like a similar step-by-step trace for n = 4 or visualization of the recursion tree next?

*/