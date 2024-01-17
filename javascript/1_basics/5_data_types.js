/**
 * Data Types
 *
 * 여섯개의 Primitive Type 과
 * 한개의 오브젝트 타입이 있다.
 *
 * 1) Number (숫자)
 * 2) String (문자열)
 * 3) Boolean (불리언)
 * 4) undefined (언디파인드)
 * 5) null (널)
 * 6) Symbol (심볼)
 *
 * 7) Object (객체)
 *      Function
 *      Array
 *      Object
 */
const age = 32;
const tempature = -10;
const pi = 3.14;

console.log(typeof age);
console.log(typeof tempature);
console.log(typeof pi);
console.log("----------");

const infinity = Infinity;
const nInfunity = -Infinity;

console.log(typeof infinity);
console.log(typeof nInfunity);

/**
 * StringType
 */
const codeFactory = "코드팩토리";
console.log(typeof codeFactory);

const ive = "'아이브' 안유진";
console.log(ive);

/**
 * Symbol 타입
 *
 * 유일무이한 값을 생성할 때 사용한다.
 * 다른 프리미티브 값들과 다르게 Symbol 함수를 호출해서 사용한다.
 */

const test1 = "1";
const test2 = "1";
console.log(test1 === test2);

const symbol1 = Symbol("1");
const symbol2 = Symbol("1");
console.log(symbol1 === symbol2);

/**
 * Obhect 타입
 *
 * Map
 * 키: 벨류의 쌍으로 이루어져 있다.
 * key:value
 */

const dictionary = {
  red: "빨간색",
  orrange: "주황색",
  yellow: "노란색",
};

console.log(dictionary);
console.log(dictionary['red']);

const Member  = [
    '유진',
    '가을',
];
console.log(Member);

console.log(Member[1]);

/**
 * static = 변수 선언시 어떤 어떤 타입의 변수를 선언할지 명시
 * dynamic = 변수타입을 명시적으로 선언하지 않고 값에 따라 타입을 추론함.
 */