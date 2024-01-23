/**
 * 타입 변환
 * Type Coversion
 * 
 * 1)명시적
 * 2)암묵적
 */

let age = 32;

let stringAge = age.toString();

console.log(typeof stringAge, stringAge);

let test = age + '';
console.log(typeof test, test);

console.log('98'+2); //982
console.log('98'*2); //196
console.log('98'-2); //96

/**
 * 명시적 변환 몇가지 더 배우기
 */
console.log(typeof (99).toString(), (99).toString());
console.log(typeof (true).toString());

/**
 * Boolean 타입으로의 변환
 */
console.log(!!'x');
/**
 * 1)아무 글자도 없는 String
 * 2) 값이 없는 경우
 * 3) 0
 * 
 * 모두 false를 반환
 */
