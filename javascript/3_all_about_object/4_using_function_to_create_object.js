/**
 * Usitng function to create objects
 */

function IdolModel(name, year){
    if (!new.target) { // new 키워드가 없어도 실행 가능 하도록 만드는 것!
        return new IdolModel(name, year);
    }

    console.log(new.target)
    this.name = name;
    this.year = year;

    this.dance = function(){
        return `${this.name}이 춤을 춥니다.`
    }
}

const yuJin = new IdolModel('안유진', 2003);
// console.log(yuJin);
// console.log(yuJin.dance());

const yuJin2 =  IdolModel('안유진', 2003);
// console.log(yuJin2);
// console.log(global.name);