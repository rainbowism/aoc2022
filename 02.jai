main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("02.txt");
    lines := split(text, CRLF);

    score_a: int;
    score_b: int;

    loss :: inline (x: u8) -> u8 { return x % 3 + 1; }
    tie  :: inline (x: u8) -> u8 { return x - 64; }
    win  :: inline (x: u8) -> u8 { return (x + 2) % 3 + 1; }

    for line: lines {
        // This wraps the modulo result of the rock-paper-scissors from being
        //            [win, loss, tie] to being [loss, tie, win]
        // ...then we can multiply that result by 3 to get the score from the result.
        // `line[2] - #char "W"` will map the action to [1, 2, 3], for the extra points.
        score_a += (((line[2] - line[0] + 2) % 3) * 3) + (line[2] - #char "W");

        // `loss`, `tie`, and `win` wrap result vector of [rock, paper, scissors]
        //  into the coresponding action for the opponent's action.
        score_b += ((line[2] - #char "X") * 3);
        if (line[2] - #char "X") == {
        case 0; score_b += loss(line[0]);
        case 1; score_b += tie(line[0]);
        case 2; score_b += win(line[0]);
        }
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

#import "Basic";
#import "String";
#import "File";
