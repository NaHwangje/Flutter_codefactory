/**
 * 객체 /Object
 */

// key : value pair
let yuJin = {
  name: "안유진",
  group: "아이브",
  dance: function () {
    return `${this.name}춤을 춥니다.`;
  },
};
console.log(yuJin);
console.log(yuJin.name);
console.log(yuJin["name"]);

const namekey = "name";
const nameValue = "안유진";

const groupKey = "group";
const groupValue = "아이브";

const yuJin2 = {
  [namekey]: nameValue,
  [groupKey]: groupValue,
  dance: function () {
    return `${this.name}이 춤을 춥니다.`;
  },
};

console.log(yuJin[namekey]);
console.log(yuJin.dance());

/**
 * 객체의 특징
 *
 * 1) const로 선언할ㄹ 경우 객체 자체를 변경 할 수는 없다
 * 2) 객체 안의 프로퍼티나 메서드는 변경할 수 있다.
 */
const wongYung = {
  name: "장원영",
  group: "아이브",
};
console.log(wongYung);
// wongYung = {};
wongYung["group"] = "코팩";
console.log(wongYung);

/**
 * 모든 키값 다 가져오기
 */
console.log(Object.keys(wongYung));

/**
 * 모든 벨류값 다 가져오기
 */
console.log(Object.values(wongYung));

const name = "안유진";

const yuJin3 = {
  name: name,
  name,
};
console.log(yuJin3);
