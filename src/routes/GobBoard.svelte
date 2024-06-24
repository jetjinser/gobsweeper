<script lang="ts">
  import init, { gobIsMine } from "$lib/gslib";
  import GobBlock from "./GobBlock.svelte";

  const promise = init();

  const boardSize = 9;

  const status = (x: number, y: number) => {
    if (gobIsMine(x, y)) {
      return "💥";
    } else {
      return "_";
    }
  };
</script>

{#await promise then}
  <div class="gob-board">
    {#each Array(boardSize) as _, x}
      {#each Array(boardSize) as _, y}
        <GobBlock gobStatus={status(x, y)} positionX={x + 1} positionY={y + 1} />
      {/each}
    {/each}
  </div>
{/await}

<style>
  .gob-board {
    --size: 9;
    margin: 1em 0;
    display: grid;
    grid-template-columns: repeat(var(--size), 2.5em);
    grid-template-rows: repeat(var(--size), 2.5em);
    background-color: #ffffff;
    width: min-content;
    box-shadow: 0 0 1em;
    border-radius: 1em;
    padding: 0.5em;
  }
</style>
