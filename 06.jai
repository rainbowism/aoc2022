main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("input/06.txt");

    print("1: %\n", find_match(4, text));
    print("2: %\n", find_match(14, text));
}

find_match :: inline ($substring_length: s64, text: string) -> s64 {
    substring: string = ---;
    substring.data  = text.data;
    substring.count = substring_length;
    while outer := true {
        for x: 0..substring_length-1 {
            for y: x+1..substring_length-1 {
                if substring[x] == substring[y] {
                    substring.data += x+1;
                    continue outer;
                }
            }
        }
        break;
    }
    return substring.data - text.data + substring_length;
}

#import "Basic";
#import "String";
#import "File";
