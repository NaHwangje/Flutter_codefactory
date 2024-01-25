/**
 * Inheritence
 */

class IdolModel{
    name;
    year;

    constructor(name, year){
        this.name = name
        this.year = year
    }
}

class FemaleIdoleModel extends IdolModel{
    dance(){
        return `여자 아이돌이 춤을 춥니다.`
    }
}

class MaleIdoleModel extends IdolModel{
    sing(){
        return `남자 아이돌이 노래를 부릅니다.`
    }
}

const yuJin = new FemaleIdoleModel('안유진', 2003);
console.log(yuJin);
console.log(yuJin.dance());
console.log(yuJin.year);

const jiMin = new MaleIdoleModel('지민', 1995);
console.log(jiMin);
console.log(jiMin.sing());
console.log(jiMin.name);


const cf = new IdolModel('코팩', 1992);
console.log(cf);

console.log(yuJin instanceof IdolModel);
console.log(yuJin instanceof FemaleIdoleModel);
console.log(yuJin instanceof MaleIdoleModel);

console.log('````````');
console.log(jiMin instanceof IdolModel);
console.log(jiMin instanceof FemaleIdoleModel);
console.log(jiMin instanceof MaleIdoleModel);

console.log('````````');
console.log(cf instanceof IdolModel);
console.log(cf instanceof FemaleIdoleModel);
console.log(cf instanceof MaleIdoleModel);


