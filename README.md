figbass
=======

figbass is a command-line application that generates a random figured bass chord within a specified key

Setup
------
Once figbass.hs has been compiled into an executable using:

    ~$ ghc -o figbass figbass.hs

Use
------
then figbass can be called with a specified key, with syntax:

    ~$ ./figbass {key}

where {key} can be any of the following keys: C, c, C#, c#, D, d, Eb, eb, E, e, F, f, F#, f#, G#, g#, A, a, Ab, ab, Bb, bb, B, or b, with an uppercase letter denoting a major key and a lowercase letter denoting a minor key

For example:

    ~$ ./figbass Eb

could generate:

    F  
    7

or:

    Eb  
    6  
    4

figbass currently allows for triads and seventh chords in all inversions.

Recommended Use
------
It is recommended to run:

    ~$ watch -n{number of seconds between calls} ./figbass {key}

for extended practice in a key.  For example:

    ~$ watch -n3 ./figbass D

will display a new chord in the key of D every 3 seconds. 
