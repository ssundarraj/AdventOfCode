use counter::Counter;
use std::fs;

fn parse_input() -> Vec<String> {
    let input: String = fs::read_to_string("input.txt").expect("Unable to read input.txt.");
    return input.lines().map(String::from).collect();
}

fn common_char(s1: &String, s2: &String) -> char {
    let left_char_counts = s1.chars().collect::<Counter<_>>();
    let right_char_counts = s2.chars().collect::<Counter<_>>();
    let intersection = left_char_counts & right_char_counts;
    intersection.most_common_ordered()[0].0
}

fn get_value(c: char) -> u32 {
    if c.is_uppercase() {
        c as u32 - 'A' as u32 + 27
    } else {
        c as u32 - 'a' as u32 + 1
    }
}

fn main() {
    let input = parse_input();
    let mut priority = 0;
    let mut count = -1;
    let mut intersection = "".chars().collect::<Counter<_>>();
    for sack in input.iter() {
        count += 1;
        // let (left, right) = sack.split_at(sack.len() / 2);
        // priority += get_value(common_char(&String::from(left), &String::from(right)));
        if count % 3 == 0 {
            if count != 0 {
                priority += get_value(intersection.most_common_ordered()[0].0);
            }
            intersection = sack.chars().collect::<Counter<_>>();
        } else {
            intersection = intersection & sack.chars().collect::<Counter<_>>();
        }
    }
    priority += get_value(intersection.most_common_ordered()[0].0);
    println!("{:?}", priority);
}
