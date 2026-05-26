const { takeScreenshot } = require('../../utils/screenshot.helper');
const { typeInto } = require('../../utils/input.helper');

describe('Login E2E', () => {
    afterEach(async function () {
        if (this.currentTest.state === 'failed') {
            await takeScreenshot(`login-failed-${Date.now()}`);
        }
    });

    it('should login successfully', async () => {
        const emailInput = await $('~login_email_input');
        await emailInput.waitForDisplayed({ timeout: 10000 });
        await takeScreenshot('login-screen');

        await typeInto(emailInput, 'demo@appium.com');

        const passwordInput = await $('~login_password_input');
        await passwordInput.waitForDisplayed({ timeout: 10000 });
        await typeInto(passwordInput, '123456');

        try {
            await driver.hideKeyboard();
        } catch {
            // Keyboard may already be hidden on some devices.
        }

        const loginButton = await $('~login_button');
        await loginButton.waitForDisplayed({ timeout: 10000 });
        await loginButton.click();

        await browser.pause(1500);

        const homeTitle = await $('~home_title');
        await homeTitle.waitForDisplayed({ timeout: 15000 });

        await expect(homeTitle).toBeDisplayed();
        await takeScreenshot('home-screen');
    });
});
