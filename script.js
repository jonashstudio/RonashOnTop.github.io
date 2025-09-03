// Roblox hub script (points to script.lua in your repo)
const robloxScript = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/jonashstudio/RonashOnTop.github.io/refs/heads/main/script.lua"))()';

// Copy script to clipboard
function copyScript() {
    const copyBtn = document.querySelector(".script-box button");

    navigator.clipboard.writeText(robloxScript)
        .then(() => {
            copyBtn.textContent = "✔ Copied!";
            copyBtn.disabled = true;

            setTimeout(() => {
                copyBtn.textContent = "Copy";
                copyBtn.disabled = false;
            }, 2000);
        })
        .catch(err => alert("Failed to copy: " + err));
}
