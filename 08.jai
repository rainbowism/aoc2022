main :: () {
    CRLF :: "\r\n";
    text := read_entire_file("input/08.txt");
    lines := split(text, CRLF);

    size := lines[0].count;
    visible: [] bool;
    visible.count = size * size;
    visible.data  = alloc(visible.count);
    defer free(visible.data);
    memset(visible.data, 0, visible.count);
    memset(*visible.data[0], 1, size);
    memset(*visible.data[visible.count-size], 1, size);
    for 1..size-2 {
        visible.data[size*it] = true;
        visible.data[size*it+size-1] = true;
    }

    for line_it: 1..size-2 {
        left  := lines[line_it][0];
        right := lines[line_it][size-1];
        up    := lines[0][line_it];
        down  := lines[size-1][line_it];

        for 1..size-2 {
            if lines[line_it][it] > left {
                left = lines[line_it][it];
                visible[line_it * size + it] = true;
            }
            if lines[line_it][size-it-1] > right {
                right = lines[line_it][size-it-1];
                visible[line_it * size + size-it-1] = true;
            }
            if lines[it][line_it] > up {
                up = lines[it][line_it];
                visible[it * size + line_it] = true;
            }
            if lines[size-it-1][line_it] > down {
                down = lines[size-it-1][line_it];
                visible[(size-it-1) * size + line_it] = true;
            }
        }
    }

    visible_count: s64;
    for visible  visible_count += cast,no_check(u8) it;

    scenic_view: s64;
    for x: 0..size-1 {
        for y: 0..size-1 {
            score := calculate_score(lines, x, y);
            if score > scenic_view  scenic_view = score;
        }
    }

    print("1: %\n", visible_count);
    print("2: %\n", scenic_view);
}

calculate_score :: (lines: [] string, x: s64, y: s64) -> s64 {
    left, right, up, down: s64;

    current_tree_height := lines[y][x];
    for < x-1..0 {
        left += 1;
        if current_tree_height <= lines[y][it]  break;
    }
    for x+1..lines.count-1 {
        right += 1;
        if current_tree_height <= lines[y][it]  break;
    }
    for < y-1..0 {
        up += 1;
        if current_tree_height <= lines[it][x]  break;
    }
    for y+1..lines.count-1 {
        down += 1;
        if current_tree_height <= lines[it][x]  break;
    }

    return left * right * up * down;
}

#import "Basic";
#import "String";
#import "File";
