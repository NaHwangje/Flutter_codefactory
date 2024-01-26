/**
 * Property Attribute
 *
 * 1) 데이터 프로퍼티 - 키와 값으로 형성된 실질적을 ㅗ값을 갖고 있는 프로퍼티
 * 2) 엑세서 프로퍼티 - 자체적으로 값을 갖고 있지 않지만 다른 값을 가져오거나
 *                     설정할때 호출되는 함수로 구성된 프로퍼티
 *                     예를들면 getter와 setter
 */
const yuJin = {
  name: "안유진",
  year: 2003,
};

console.log(Object.getOwnPropertyDescriptor(yuJin, 'year'));

/**
 * 1)value - 실제 프로퍼티의 값
 * 2) writable - 값을 수정할수 있는지 여부, false로 설정하면 프로퍼티 값을 수정할 수 없다.
 * 3) enumerable - 열거가 가능한지 여부이다. for...in 룹 등을 사용할 수 있으면 true를 반환한다.
 * 4) configurable - 프로퍼티 어트리뷰트의 재정의가 가능한지 여부를 판단한다.;
 *                   false일 경우 프로퍼티 삭제나 어트리뷰트 변경이 금지된다. 
 *                   단, writable이 true인 경우 값 변경과 writable을 변경하는건 가능하다.
 */
console.log(Object.getOwnPropertyDescriptor(yuJin, 'name'));
console.log(Object.getOwnPropertyDescriptors(yuJin));

const yuJin2 = {
    name: "안유진",
    year: 2003,

    get age(){
        return new Date().getFullYear() -this.year;
    },

    set age(age){
        this.year = new Date().getFullYear()-age;
    }
  };

  console.log(yuJin2);
  console.log(yuJin2.age);

  yuJin2.age = 32;
  console.log(yuJin2.age);
  console.log(yuJin2.year);

  console.log(Object.getOwnPropertyDescriptors(yuJin2, 'age'));

  yuJin2.height = 172
  console.log(yuJin2);