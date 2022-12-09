use std::fs;

fn parse_input() -> Vec<((u32, u32), (u32, u32))> {
    // fn parse_input() {
    let input: String = fs::read_to_string("input.txt").expect("Unable to read input.txt.");
    input
        .lines()
        .map(|line| {
            let pair_of_ranges: Vec<&str> = line.split(",").collect();
            let left_range: Vec<&str> = pair_of_ranges[0].split("-").collect();
            let right_range: Vec<&str> = pair_of_ranges[1].split("-").collect();
            (
                (
                    left_range[0].parse::<u32>().unwrap(),
                    left_range[1].parse::<u32>().unwrap(),
                ),
                (
                    right_range[0].parse::<u32>().unwrap(),
                    right_range[1].parse::<u32>().unwrap(),
                ),
            )
        })
        .collect()
}

fn range_contains(range0: (u32, u32), range1: (u32, u32)) -> bool {
    range0.0 <= range1.0 && range0.1 >= range1.1
}

fn is_contained(input: ((u32, u32), (u32, u32))) -> bool {
    let range0 = input.0;
    let range1 = input.1;
    range_contains(range0, range1) || range_contains(range1, range0)
}

fn range_overlapping(range0: (u32, u32), range1: (u32, u32)) -> bool {
    range0.0 >= range1.0 && range0.0 <= range1.1 || range0.1 >= range1.0 && range0.1 <= range1.1
}

fn is_overlapping(input: ((u32, u32), (u32, u32))) -> bool {
    let range0 = input.0;
    let range1 = input.1;
    range_overlapping(range0, range1) || range_overlapping(range1, range0)
}

fn main() {
    println!("Hello, world!");
    let inputs = parse_input();
    // println!("{:?}", inputs);
    // let count = inputs.into_iter().map(is_contained).filter(|v| v.clone()).count();
    // println!("{:?}", count);
    let count1 = inputs
        .into_iter()
        .map(is_overlapping)
        .filter(|v| v.clone())
        .count();
    println!("{:?}", count1);
}
