main :: () {
    LF : u8 : #char "\n";
    text := read_entire_file("01.txt");
    lines := split(text, LF);
    sum: int;
    largest: [3] int;
    for line: lines {
        if line.count <= 1 {
            if sum > largest[0] {
                largest[2] = largest[1];
                largest[1] = largest[0];
                largest[0] = sum;
            } else if sum > largest[1] {
                largest[2] = largest[1];
                largest[1] = sum;
            } else if sum > largest[2] {
                largest[2] = sum;
            }
            sum = 0;
            continue;
        }
        sum += string_to_int(line);
    }
    print("1: %\n", largest[0]);
    print("2: %\n", largest[0] + largest[1] + largest[2]);
}

#import "Basic";
#import "String";
#import "File";
