const path = require('path');
const fs = require('fs');

const SCREENSHOTS_DIR = path.resolve(__dirname, '../screenshots');

async function takeScreenshot(name) {
    if (!fs.existsSync(SCREENSHOTS_DIR)) {
        fs.mkdirSync(SCREENSHOTS_DIR, { recursive: true });
    }

    const filePath = path.join(SCREENSHOTS_DIR, `${name}.png`);

    await browser.saveScreenshot(filePath);

    console.log(`📸 Screenshot saved: ${filePath}`);
}

module.exports = { takeScreenshot, SCREENSHOTS_DIR };
