main :: () {
    CRLF  :: "\r\n";
    SPACE : u8 : #char " ";
    text := read_entire_file("input/05.txt");
    lines := split(text, CRLF);

    // I'm not going to worry about allocator characteristics here
    //  ...but you probably shouldn't use dynamic arrays like this.
    stacks_a, next_line := parse_stacks(lines);
    // I'm lazy and I'll just parse it again for part 2 instead of
    //  copying the original parsed data.
    stacks_b := parse_stacks(lines);

    for next_line..lines.count-1 {
        instruction := split(lines[it], SPACE);
        move   := string_to_int(instruction[1]);
        source := string_to_int(instruction[3]) - 1;
        dest   := string_to_int(instruction[5]) - 1;

        // Copy characters 1 at a time, in reverse from source to dest.
        for 0..move-1 {
            stacks_a[dest].count += 1;
            stacks_a[dest][stacks_a[dest].count - 1] = stacks_a[source][stacks_a[source].count - 1];
            stacks_a[source].count -= 1;
        }

        // Copy characters `move` number of characters from source to dest.
        stacks_b[dest].count += move;
        memcpy(*stacks_b[dest][stacks_b[dest].count - move], *stacks_b[source][stacks_b[source].count - move], move);
        stacks_b[source].count -= move;
    }
    write_string("1: ");
    for stacks_a  print_character(it[it.count - 1]);
    write_string("\n");

    write_string("2: ");
    for stacks_b  print_character(it[it.count - 1]);
    write_string("\n");
}

parse_stacks :: (lines: [] string) -> [..] [..] u8, s64 {
    // Find the number of stacks.
    num_stacks:   s64 = -1;
    stack_height: s64 = -1;
    for 0..lines.count-1 {
        if lines[it+1].count > 0  continue;
        num_stacks   = (lines[it].count + 2) / 4;
        stack_height = it;
        break;
    }

    // The stacks going from left to right.
    stacks: [..] [..] u8;
    for stack_it: 0..num_stacks-1 {
        stack: [..] u8;
        // No stack can ever exceed the number of items in this area.
        array_reserve(*stack, num_stacks * stack_height);
        array_add(*stacks, stack);
        char_index := stack_it * 4 + 1;
        for < line_it: stack_height-1..0 {
            character := lines[line_it][char_index];
            if character == #char " "  break;
            array_add(*stacks[stack_it], character);
        }
    }

    // Add 2 to the stack_height to get the first instruction.
    return stacks, stack_height + 2;
}

#import "Basic";
#import "String";
#import "File";
