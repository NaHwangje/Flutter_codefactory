/**
 * Array Function
 */
let iveMembers = ["안유진", "가을", "레이", "장원영", "리즈", "이서"];
console.log(iveMembers);

iveMembers.push("코드팩토리");
console.log(iveMembers);
//join()
console.log(iveMembers.join());
console.log(iveMembers.join("/"));
console.log(iveMembers.join(", "));

//sort() <> reverse()
//오름차순
iveMembers.sort();
console.log(iveMembers);

let numbers = [9, 1, 7, 5, 3];
numbers.sort((a, b) => a < b ?1:-1);
console.log(numbers);
