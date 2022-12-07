Directory :: struct {
    name: string;
    parent: *Directory;
    total_size: s64;
    subdirectories: [..] Directory;
}

main :: () {
    CRLF :: "\r\n";
    SPACE : u8 : #char " ";
    text := read_entire_file("input/07.txt");
    lines := split(text, CRLF);

    root_directory: Directory;
    root_directory.name = "/";
    current_directory: *Directory = *root_directory;
    for line: lines {
        if line[0] == #char "$" {
            command := advance(line, 2);
            if command[0] != #char "c"  continue;
            target_directory := advance(command, 3);
            if target_directory[0] == {
            case #char ".";
                current_directory = current_directory.parent;
                continue;
            case #char "/";
                current_directory = *root_directory;
                continue;
            }
            new_directory := array_add(*current_directory.subdirectories);
            new_directory.name = target_directory;
            new_directory.parent = current_directory;
            current_directory = new_directory;
            continue;
        }

        if line[0] == #char "d"  continue; // skip if the line starts with dir
        found, value_text, file_name := split_from_left(line, SPACE);
        file_size := string_to_int(value_text);

        next_directory := current_directory;
        while next_directory != null {
            next_directory.total_size += file_size;
            next_directory = next_directory.parent;
        }
    }

    directories_to_visit: [..] Directory;
    array_add(*directories_to_visit, root_directory);
    size_sum: s64;
    // Calculate the delta of current free space to the required free space.
    target_remove_size := root_directory.total_size - (70_000_000 - 30_000_000);
    largest_directory_to_free: s64 = 70_000_000;
    // Walk along all the available directories.
    while directories_to_visit.count > 0 {
        current_directory := directories_to_visit[directories_to_visit.count - 1];
        directories_to_visit.count -= 1;
        array_add(*directories_to_visit, .. current_directory.subdirectories);
        if current_directory.total_size <= 100000  size_sum += current_directory.total_size;
        if current_directory.total_size > target_remove_size && current_directory.total_size < largest_directory_to_free {
            largest_directory_to_free = current_directory.total_size;
        }
    }

    print("1: %\n", size_sum);
    print("2: %\n", largest_directory_to_free);
}

#import "Basic";
#import "String";
#import "File";
