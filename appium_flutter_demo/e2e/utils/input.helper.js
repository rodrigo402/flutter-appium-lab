/**
 * Platform-aware text input for Flutter Semantics fields.
 * Android: click + mobile: type (UiAutomator2)
 * iOS: click + setValue (XCUITest)
 */
async function typeInto(element, value) {
    const platform = (driver.capabilities.platformName || '').toLowerCase();

    await element.click();

    if (platform === 'ios') {
        try {
            await element.clearValue();
        } catch {
            // Semantics wrappers may not support clearValue.
        }
        await element.setValue(value);
        return;
    }

    await driver.execute('mobile: type', { text: value });
}

module.exports = { typeInto };
