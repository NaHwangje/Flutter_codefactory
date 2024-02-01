/**
 * Async / Await
 */

const getPromise = (timeout) =>
  new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve('완료');
    //   reject("r거절");
    }, timeout * 1000);
  });

async function runner() {
  try {
    const result1 = await getPromise(1);
    console.log(result1);
    const result2 = await getPromise(1);
    console.log(result2);
    const result3 = await getPromise(1);
    console.log(result3);
  } catch (e) {
    console.log("---error---");
    console.log(e);
  } finally {
    console.log("---finally---");
  }
  const result1 = await getPromise(1);
  console.log(result1);
}
runner();
