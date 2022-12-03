main :: () {
    LF : u8 : #char "\n";
    text := read_entire_file(".txt");
    lines := split(text, LF);
}

#import "Basic";
#import "String";
#import "File";
