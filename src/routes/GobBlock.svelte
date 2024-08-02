<script lang="ts">
  export let gobStatus;
  export let positionX;
  export let positionY;

  let isHidden = true;
  let status: string = "";
  let stepOn = () => {
    isHidden = false;
    status = gobStatus();
  };
</script>

<div class="gob-block" style="grid-row: {positionX}; grid-column: {positionY}">
  <button
    class={isHidden ? "gob-button hidden" : "gob-button"}
    style={isHidden ? "" : "pointer-events: none;"}
    on:click={stepOn}>{status}</button
  >
</div>

<style>
  .gob-block {
    background-color: rgb(242, 215, 251);
    color: #715573;
    margin: 0.5px;
    display: flex;
    text-align: center;
    justify-content: center;
    align-content: center;
    flex-direction: column;
    user-select: none;
  }

  .gob-button {
    height: 100%;
    padding: 1.5px;
  }

  .hidden {
    background-color: rgb(220, 220, 220);
    color: #604462;
  }
</style>
