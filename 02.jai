main :: () {
    text := read_entire_file("02.txt");
    lines := split(text, LF);
}

#import "Basic";
#import "String";
#import "File";
