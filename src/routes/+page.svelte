<script>
  import GobBoard from "./GobBoard.svelte";
  import "./styles.css";
</script>

<svelte:head>
  <title>Home Home</title>
  <meta name="description" content="Gobsweepers" />
</svelte:head>

<main>
  <h1>Hello, World!</h1>
  <h2>你好，世界！</h2>

  <GobBoard />
</main>

<style>
  main {
    margin: auto;
    width: fit-content;
    font-family: sans-serif;
  }
</style>
