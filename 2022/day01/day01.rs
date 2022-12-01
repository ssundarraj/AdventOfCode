use std::fs;

fn main() {
    let data = fs::read_to_string("./input.txt").expect("Unable to read input.txt.");
    let mut lines = data.lines();
    let mut top_values: [i32; 3] = [0, 0, 0];
    let mut curr_sum = 0;
    while let Some(line) = lines.next() {
        if line.len() == 0 {
            if curr_sum > top_values[2] {
                top_values[2] = curr_sum;
            }
            if top_values[2] > top_values[1] {
                (top_values[2], top_values[1]) = (top_values[1], top_values[2]);
            }
            if top_values[1] > top_values[0] {
                (top_values[1], top_values[0]) = (top_values[0], top_values[1]);
            }
            curr_sum = 0;
            continue;
        }
        let value = line.parse::<i32>().unwrap();
        curr_sum += value;
    }
    println!("{:?}", top_values);
    println!("{:?}", top_values.iter().sum::<i32>());
}
