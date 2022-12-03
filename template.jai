main :: () {
    text := read_entire_file(".txt");
    lines := split(text, LF);
}

#import "Basic";
#import "String";
#import "File";
