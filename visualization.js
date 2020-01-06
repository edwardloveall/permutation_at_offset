// Made for https://algorithm-visualizer.org

const {
  Tracer,
  Array1DTracer,
  Layout,
  LogTracer,
  VerticalLayout,
  HorizontalLayout,
} = require("algorithm-visualizer");

const logTracer = new LogTracer("Walkthrough");
const indexesTracer = new Array1DTracer("Indexes");
const itemSetTracer = new Array1DTracer("Item Set");
const resultSetTracer = new Array1DTracer("Resulting Permutation");

const itemSet = ["A", "B", "C", "D"];
const result = [];
let indexes = Array(itemSet.length).fill(" ");
const offset = 11;

const permutationAtOffset = (set, offset) => {
  const initialSetSize = set.length;
  const permutationSizes = [...Array(initialSetSize + 1).keys()].slice(1);

  const indexes = permutationSizes.reverse().map((setSize, indexesIndex) => {
    const permutationCount = factorial(setSize);
    logTracer.print(
      `A set of ${setSize} items has ${permutationCount} permutations\n`,
    );
    Tracer.delay();

    const wrappedOffset = offset % permutationCount;
    logTracer.print(
      `The equivalent offset for that number of permutations is ${wrappedOffset}\n`,
    );
    Tracer.delay();

    const sectionSize = factorial(setSize - 1);
    logTracer.print(`Each section has ${sectionSize} permutations\n`);
    Tracer.delay();

    const index = parseInt(wrappedOffset / sectionSize);
    logTracer.print(
      `${wrappedOffset} / ${sectionSize} = ${index} (integer division)\n`,
    );
    logTracer.print(
      `The offset points to section (and therefore index) ${index}\n\n`,
    );
    indexesTracer.patch(indexesIndex, index);
    Tracer.delay();

    indexesTracer.depatch(indexesIndex);

    return index;
  });

  logTracer.print(`The final indexes are ${indexes}\n\n`);
  Tracer.delay();

  let setCopy = set.slice(0);
  return indexes.map((itemIndex, index) => {
    itemSetTracer.select(itemIndex);
    indexesTracer.select(index);
    const item = setCopy.splice(itemIndex, 1);
    result.push(item);
    logTracer.print(`Item at index ${itemIndex} is ${item}. `);
    logTracer.print(`Remove ${item} from the set.\n`);
    Tracer.delay();

    itemSetTracer.set(setCopy);
    resultSetTracer.set(result);
    indexesTracer.deselect(index);

    return item;
  });
};

const factorial = (number, result = 1) => {
  while (number > 0) result *= number--;
  return result;
};

(function main() {
  const grids = new HorizontalLayout([
    indexesTracer,
    itemSetTracer,
    resultSetTracer,
  ]);
  Layout.setRoot(new VerticalLayout([logTracer, grids]));
  itemSetTracer.set(itemSet);
  indexesTracer.set(indexes);
  logTracer.print(`The initial set of items is ${itemSet}\n`);
  logTracer.print(
    `Hit play on the left to calculate the permutation for offset ${offset} (zero indexed)\n\n`,
  );
  Tracer.delay();
  const result = permutationAtOffset(itemSet, offset);
  logTracer.print(`\n\nPermutation at offset ${offset} is ${result}`);
})();
