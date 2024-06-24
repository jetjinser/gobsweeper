<script lang="ts">
  export let gobStatus;
  export let positionX;
  export let positionY;
</script>

<div class="gob-block" style="grid-row: {positionX}; grid-column: {positionY}">
  <!-- <button class="gob-button" style="display: none;">{gobStatus}</button> -->
  <button class="gob-button">{gobStatus}</button>
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
</style>
