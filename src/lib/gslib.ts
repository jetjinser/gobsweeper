import { Scheme } from "./reflect"

// eslint-disable-next-line @typescript-eslint/no-explicit-any
let _boardRef: any;
// eslint-disable-next-line @typescript-eslint/no-explicit-any
let _boardSet: any;
// eslint-disable-next-line @typescript-eslint/no-explicit-any
let _uncover: any;

export default async function init() {
  const env = {
    math: {
      random(max: number) { return getRandomIntInclusive(0, max); },
    },
  };

  const [
    boardRef, boardSet, boardUncover
  ] = await Scheme.load_main("gslib.wasm", {}, env);

  _boardRef = boardRef;
  _boardSet = boardSet;
  _uncover = boardUncover;

  console.log("init done");
}

export function gobBoardRef(x: number, y: number): number {
  return Number(_boardRef.call(BigInt(x), BigInt(y)));
}

export function gobBoardSet(x: number, y: number, t: number) {
  _boardSet.call(BigInt(x), BigInt(y), BigInt(t))
}

export function gobUncover(x: number, y: number): number {
  console.log(Number(_uncover.call(BigInt(x), BigInt(y))[0]));
  return Number(_uncover.call(BigInt(x), BigInt(y))[0]);
}

function getRandomIntInclusive(min: number, max: number): number {
  const minCeiled = Math.ceil(min);
  const maxFloored = Math.floor(max);
  // The maximum is inclusive and the minimum is inclusive
  return Math.floor(Math.random() * (maxFloored - minCeiled + 1) + minCeiled);
}
