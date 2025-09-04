function copyScript() {
  const scriptText = document.getElementById("script-text").innerText;
  navigator.clipboard.writeText(scriptText).then(() => {
    alert("✅ Script copied!");
  });
}
