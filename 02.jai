main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("02.txt");
    lines := split(text, CRLF);

    score_a: int;
    score_b: int;

    for line: lines {
        // This wraps the modulo result of the rock-paper-scissors from being
        //            [win, loss, tie] to being [loss, tie, win]
        // ...then we can multiply that result by 3 to get the score from the result.
        // `line[2] - #char "W"` will map the action to [1, 2, 3], for the extra points.
        score_a += (((line[2] - line[0] + 2) % 3) * 3) + (line[2] - #char "W");

        score_b += ((line[2] - #char "X") * 3);
        // Same wrapping principle as above.
        score_b += (line[0] + line[2] - #char "X") % 3 + 1;
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

#import "Basic";
#import "String";
#import "File";
