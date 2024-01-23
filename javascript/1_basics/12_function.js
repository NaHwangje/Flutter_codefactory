/**
 * function -> 함수
 */

/**
 * 만약에 2라는 숫자에 * 10/2 % 3 스트링으로 변환해서 변환받고 싶다면 어떻게 해야할까?
 */

console.log((((2 * 10) / 2) % 3).toString());

/**
 * DRY
 * D -> Don't
 * R -> Repeat
 * Y -> Yourself
 */
function calculate() {
  console.log((((2 * 10) / 2) % 3).toString());
}

// calculate();

function calculate(number) {
  console.log((((number * 10) / 2) % 3).toString());
}
/**
 * 함수에서 입력받는 값에 대한 정의를 Parameter 라고 한다
 *
 * 실제 입력하는 값은 argument라고 한다.
 */
calculate(3);
calculate(5);
calculate(4);

function multiply(x, y) {
  console.log(x * y);
}
multiply(3, 5);

function multiply(x, y = 3) {
  console.log(x * y);
}

multiply(3);
console.log("---------------");
/**
 * 반환 받기
 */

function multiply(x, y) {
  return x * y;
}

const result1 = multiply(2, 4);
console.log(result1);

/**
 * Arrow 함수
 */
const multiply2 = (x, y) => {
  return x * y;
};
console.log(multiply(2, 4));

const multiply3 = (x, y) => x * y;
console.log(multiply3(2, 4));

const multiply4 = (x) => x * 2;

console.log(multiply4(2));

const multiply5 = (x) => (y) => (z) => `x: ${x}, y: ${y}, z: ${z}`;
console.log(multiply5(2)(5)(7));

function multiply6(x) {
  return function (y) {
    return function (z) {
      return `x: ${x}, y: ${y}, z: ${z}`;
    };
  };
}
// immediately invoked function
(function(x,y){
    console.log(4*5);
})()

