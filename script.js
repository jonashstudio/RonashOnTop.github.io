// Roblox hub script
const robloxScript = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/jonashstudio/Ronashhub/refs/heads/main/Ronash%20hub"))()';

// Load the script dynamically
function loadScript() {
    const script = document.createElement('script');
    script.src = 'https://raw.githubusercontent.com/jonashstudio/Ronashhub/refs/heads/main/Ronash%20hub';
    document.body.appendChild(script);
    alert('Script loaded successfully!');
}

// Copy the script to clipboard
function copyScript() {
    navigator.clipboard.writeText(robloxScript)
        .then(() => alert('Script copied to clipboard!'))
        .catch(err => alert('Failed to copy script: ' + err));
}
