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

        score_a += find_matches(2, left, right);
    }

    for 0..lines.count/3-1 {
        left   := lines[it * 3];
        middle := lines[it * 3 + 1];
        right  := lines[it * 3 + 2];
        left.count   -= 1;
        middle.count -= 1;
        right.count  -= 1;
        score_b += find_matches(3, left, middle, right);
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

find_matches :: inline ($N: int, inputs: .. string) -> s64 {
    CHARS :: #char "z" - #char "A" + 1;
    seen: [N] s64;
    for input_it: 0..N-1 {
        input := inputs[input_it];
        for char: 0..input.count-1 {
            seen[input_it] |= 1 << (input[char] - #char "A");
        }
    }
    result: s64 = seen[0];
    for 1..N-1 {
        result &= seen[it];
    }
    result = bit_scan_forward(result);
    if result >= 27 {
        return result - 32;
    }
    return result + 26;
}

#import "Basic";
#import "String";
#import "File";
#import "Bit_Operations";
