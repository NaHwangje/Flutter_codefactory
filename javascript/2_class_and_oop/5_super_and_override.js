/**
 * Super and Override
 */
class IdolModel {
  name;
  year;

  constructor(name, year) {
    this.name = name;
    this.year = year;
  }
  sayHello() {
    return `안녕하세요 ${this.name}입니다.`;
  }
}

class FemaleIdoleModel extends IdolModel {
  //노래 / 춤
  part;

  constructor(name, year, part) {
    super(name, year);
    this.part = part;
  }
  sayHello(){
    // return `안녕하세요 ${this.name}입니다. ${this.part}을 맡고 있습니다.`
    return `${super.sayHello()} ${this.part}을 맡고 있습니다.`
  }
}

const yuJin = new FemaleIdoleModel("안유진", 2003, "보컬");
console.log(yuJin);

const wongYung = new IdolModel("장원영", 2004);
console.log(wongYung);
console.log(wongYung.sayHello());
console.log(yuJin.sayHello());
