main :: () {
    LF : u8 : #char "\n";
    text := read_entire_file("03.txt");
    lines := split(text, LF);

    score_a: int;
    score_b: int;
    match: s64;

    LOWER_DELTA :: #char "z" - 26;
    UPPER_DELTA :: #char "Z" - 52;

    for line: lines {
        left:  string = ---;
        left.data  = line.data;
        left.count = line.count / 2;
        right: string = ---;
        right.data  = left.data + left.count;
        right.count = left.count;

        match = find_matches(2, left, right);

        if match >= #char "a" && match <= #char "z" {
            score_a += match - LOWER_DELTA;
        } else { // if match >= #char "A" && match >= #char "Z"
            // if the above doesn't match, it must be uppercase
            score_a += match - UPPER_DELTA;
        }
    }

    for 0..lines.count/3-1 {
        left   := lines[it * 3];
        middle := lines[it * 3 + 1];
        right  := lines[it * 3 + 2];
        left.count   -= 1;
        middle.count -= 1;
        right.count  -= 1;
        match = find_matches(3, left, middle, right);

        if match >= #char "a" && match <= #char "z" {
            score_b += match - LOWER_DELTA;
        } else { // if match >= #char "A" && match >= #char "Z"
            // if the above doesn't match, it must be uppercase
            score_b += match - UPPER_DELTA;
        }
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

find_matches :: inline ($N: int, inputs: .. string) -> s64 {
    CHARS :: #char "z" - #char "A" + 1;
    seen: [N] [CHARS] bool;
    for input_it: 0..N-1 {
        input := inputs[input_it];
        for char: 0..input.count-1 {
            seen[input_it][input[char] - #char "A"] = true;
        }
    }
    for char: 0..CHARS-1 {
        success := true;
        for input_it: 0..N-1 {
            if seen[input_it][char]  continue;
            success = false;
            break;
        }
        if success  return char + #char "A";
    }
    assert(false, "We shouldn't ever reach this condition.");
    return 0;
}

#import "Basic";
#import "String";
#import "File";
