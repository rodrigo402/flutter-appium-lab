const { isAndroid, isIOS } = require('./platform.helper');
const { typeInto, hideKeyboardSafe } = require('./input.helper');

const IOS_BUNDLE_ID = 'com.example.appiumFlutterDemo';
const ANDROID_APP_ID = 'com.example.appium_flutter_demo';

async function waitFor(accessibilityId, timeout = 10000) {
    const element = await $(`~${accessibilityId}`);
    await element.waitForDisplayed({ timeout });
    return element;
}

async function tap(accessibilityId) {
    const element = await waitFor(accessibilityId);
    await element.click();
    return element;
}

async function performLogin(
    email = 'demo@appium.com',
    password = '123456',
) {
    await waitFor('login_email_input');
    await typeInto('login_email_input', email);
    await typeInto('login_password_input', password);
    await hideKeyboardSafe();
    await tap('login_button');
    await browser.pause(1500);
    await waitFor('home_title', 15000);
}

async function resetAppToLogin() {
    // terminateApp can invalidate the XCUITest session on iOS — use activateApp only.
    if (isIOS()) {
        await driver.activateApp(IOS_BUNDLE_ID);
    } else if (isAndroid()) {
        try {
            await driver.terminateApp(ANDROID_APP_ID);
        } catch {
            // App may not be running.
        }
        await driver.activateApp(ANDROID_APP_ID);
    }

    await browser.pause(1000);
}

module.exports = { waitFor, tap, performLogin, resetAppToLogin };
