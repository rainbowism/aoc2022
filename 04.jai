main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("04.txt");
    lines := split(text, CRLF);

    score_a: int;
    score_b: int;

    for line: lines {
        found_line, left, right := split_from_left(line, #char ",");
        found_left, left_low_text, left_high_text := split_from_left(left, #char "-");
        found_right, right_low_text, right_high_text := split_from_left(right, #char "-");
        left_low := string_to_int(left_low_text);
        left_high := string_to_int(left_high_text);
        right_low := string_to_int(right_low_text);
        right_high := string_to_int(right_high_text);

        score_a += cast(s8) ((left_low <= right_low && left_high >= right_high) || (left_low >= right_low && left_high <= right_high));
        score_b += cast(s8) (left_high >= right_low && left_low <= right_high);
    }

    print("1: %\n", score_a);
    print("2: %\n", score_b);
}

#import "Basic";
#import "String";
#import "File";
