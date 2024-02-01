/**
 * Callback
 */
function waitAndRun() {
  setTimeout(() => {
    console.log("끝");
  }, 2000);
}

// waitAndRun();

function waitAndRun2() {
  setTimeout(() => {
    console.log("1번 콜백 끝");

    setTimeout(() => {
      console.log("2번 콜백 끝");

      setTimeout(() => {
        console.log("3번 콜백 끝");
      }, 2000);
    }, 2000);
  }, 2000);
}

// waitAndRun2();

/**
 * Promise
 */
const timeoutPormise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("완료");
  }, 2000);
});

// timeoutPormise.then((res) => {
//   console.log("-----then------");
//   console.log(res);
// });

const getPromise = (second) =>
  new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve("에러");
    }, second * 1000);
  });

getPromise(1)
  .then((res) => {
    console.log("---first then---");
    console.log(res);
  }).catch(
    (res) =>{
        console.log("---first catch---");
    console.log(res);
    }
  ).finally(()=>{
    console.log(`finally`);
  })

  Promise.all([
    getPromise(1),
    getPromise(2),
    getPromise(1),
  ]).then((res)=>{
    console.log(res);
  })
  main