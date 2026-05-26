const { isIOS } = require('./platform.helper');

/**
 * Platform-aware text input for Flutter Semantics fields.
 * Android: click + mobile: type (UiAutomator2)
 * iOS: click + setValue (XCUITest), with safe fallbacks
 */
async function typeInto(target, value) {
    const element = typeof target === 'string'
        ? await $(`~${target}`)
        : target;

    await element.waitForDisplayed({ timeout: 10000 });
    await element.click();

    if (isIOS()) {
        try {
            await element.clearValue();
        } catch {
            // Semantics wrappers may not support clearValue.
        }

        try {
            await element.setValue(value);
            return;
        } catch {
            await element.addValue(value);
            return;
        }
    }

    try {
        await driver.execute('mobile: type', { text: value });
    } catch {
        await element.setValue(value);
    }
}

async function hideKeyboardSafe() {
    try {
        await driver.hideKeyboard();
    } catch {
        // Keyboard may already be hidden or unsupported on this screen.
    }
}

module.exports = { typeInto, hideKeyboardSafe };
