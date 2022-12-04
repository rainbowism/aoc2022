main :: () {
    CRLF :: "\r\n";
    text := read_entire_file(".txt");
    lines := split(text, CRLF);
}

#import "Basic";
#import "String";
#import "File";
