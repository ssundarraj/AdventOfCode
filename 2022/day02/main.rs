#[macro_use]
extern crate lazy_static;

use std::collections::HashMap;
use std::fs;

#[derive(Eq, PartialEq, Hash, Debug)]
enum Option {
    ROCK,
    PAPER,
    SCISSORS,
}

lazy_static! {
    static ref LOSING: HashMap<Option, Option> = HashMap::from([
        (Option::ROCK, Option::PAPER),
        (Option::PAPER, Option::SCISSORS),
        (Option::SCISSORS, Option::ROCK),
    ]);
    static ref WINNING: HashMap<Option, Option> = HashMap::from([
        (Option::PAPER, Option::ROCK),
        (Option::SCISSORS, Option::PAPER),
        (Option::ROCK, Option::SCISSORS),
    ]);
    static ref SHAPE_TO_POINTS: HashMap<Option, u32> =
        HashMap::from([(Option::ROCK, 1), (Option::PAPER, 2), (Option::SCISSORS, 3),]);
    static ref LMAP: HashMap<String, Option> = HashMap::from([
        (String::from("A"), Option::ROCK),
        (String::from("B"), Option::PAPER),
        (String::from("C"), Option::SCISSORS),
    ]);
    static ref RMAP: HashMap<String, Option> = HashMap::from([
        (String::from("X"), Option::ROCK),
        (String::from("Y"), Option::PAPER),
        (String::from("Z"), Option::SCISSORS),
    ]);
}

fn parse_input() -> Vec<Vec<&'static Option>> {
    let input: String = fs::read_to_string("input.txt").expect("Unable to read input.txt.");

    return input
        .lines()
        .map(|line| {
            let input_vec: Vec<String> = line.split_whitespace().map(str::to_string).collect();
            let output_vec: Vec<&Option> = Vec::from([
                LMAP.get(&input_vec[0]).unwrap(),
                RMAP.get(&input_vec[1]).unwrap(),
            ]);
            return output_vec;
        })
        .collect();
}

fn part1(input: Vec<Vec<&'static Option>>) -> u32 {
    let mut points = 0;
    for pair in input.iter() {
        points += SHAPE_TO_POINTS.get(pair[1]).unwrap();
        let losing_shape = LOSING.get(pair[0]).unwrap();
        if pair[0] == pair[1] {
            points += 3;
        } else if losing_shape == pair[1] {
            points += 6;
        }
    }
    points
}

fn part2(input: Vec<Vec<&'static Option>>) -> u32 {
    let mut points = 0;
    for pair in input.iter() {
        // hacky lol
        if pair[1] == &Option::ROCK { // lose
            let selected_shape = WINNING.get(pair[0]).unwrap();
            points += SHAPE_TO_POINTS.get(selected_shape).unwrap();
        } else if pair[1] == &Option::PAPER { // draw
            let selected_shape = pair[0];
            points += SHAPE_TO_POINTS.get(selected_shape).unwrap();
            points += 3;
        } else if pair[1] == &Option::SCISSORS { // win
            let selected_shape = LOSING.get(pair[0]).unwrap();
            points += SHAPE_TO_POINTS.get(selected_shape).unwrap();
            points += 6;
        }
    }
    points
}

fn main() {
    let input = parse_input();
    // let part1 = part1(input);
    // println!("{:?}", part1);
    let part2 = part2(input);
    println!("{:?}", part2);
}
