main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("03.txt");
    lines := split(text, CRLF);

    score_a: int;
    score_b: int;

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
        score_b += find_matches(3,
            lines[it * 3],
            lines[it * 3 + 1],
            lines[it * 3 + 2],
        );
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

find_matches :: inline ($N: int, inputs: .. string) -> s64 {
    // Convert the strings into bitmasks where
    //  bits 1-26 are A-Z and bits 32-58 are a-z.
    seen: [N] s64;
    for 0..N-1 {
        input := inputs[it];
        for char: 0..input.count-1 {
            seen[it] |= 1 << (input[char] - #char "A");
        }
    }
    // Squish the bitmasks down to find the matching bit.
    result: s64 = seen[0];
    for 1..N-1  result &= seen[it];
    result = bit_scan_forward(result);
    // The lowercase are offset by 32, so subtract 32.
    if result >= 27  return result - 32;
    // ...and the uppercase need 26 more points.
    return result + 26;
}

#import "Basic";
#import "String";
#import "File";
#import "Bit_Operations";
