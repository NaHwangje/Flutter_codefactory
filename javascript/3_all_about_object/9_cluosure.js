/**
 * Closure
 * 
 * A closure is the combination of a function 
 * and the lexical enviroment within which that function was declared
 * 
 * 클로저는 어떤 함수와 해당 함수가 선언된 렉시컬 환경의 조합이다.
 * 
 * 상위 함수보다 하위함수가 더 오래 살아있는 경우를 closure라고 한다.
 */
function name(params) {
var number = 5;

function innerGetNumber(){
    return number;
}

return innerGetNumber();
}

//console.