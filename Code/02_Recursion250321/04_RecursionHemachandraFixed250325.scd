// Implementation of Hemachandran's proof / algorithm for
// generating all words of n lenght composed of syllables of
// 1 and 2 beats
//:Finalized implementation
~generateSequences = { |n, currentSequence, allSequences|
    if (n == 0) {
        allSequences.add(currentSequence);
    } {
        if (n >= 1) {
            thisFunction.(n - 1, currentSequence.copy.add(1), allSequences);
        };
        if (n >= 2) {
            thisFunction.(n - 2, currentSequence.copy.add(2), allSequences);
        };
    };
};

// Wrapper function to collect all sequences
~getAllSequences = { |n|
    var allSequences = List.new;
    ~generateSequences.(n, List.new, allSequences);
    allSequences.array collect: _.array; // return Array, not List
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