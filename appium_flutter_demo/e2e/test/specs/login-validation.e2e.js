const { takeScreenshot } = require('../../utils/screenshot.helper');
const { typeInto, hideKeyboardSafe } = require('../../utils/input.helper');
const { waitFor, tap } = require('../../utils/flow.helper');

describe('Login Validation', () => {
    afterEach(async function () {
        if (this.currentTest.state === 'failed') {
            await takeScreenshot(`login-validation-failed-${Date.now()}`);
        }
    });

    it('should show error text for invalid credentials', async () => {
        const emailInput = await $('~login_email_input');
        await emailInput.waitForDisplayed({ timeout: 10000 });
        await typeInto(emailInput, 'wrong@email.com');

        const passwordInput = await $('~login_password_input');
        await passwordInput.waitForDisplayed({ timeout: 10000 });
        await typeInto(passwordInput, 'wrongpass');

        await hideKeyboardSafe();

        const loginButton = await $('~login_button');
        await loginButton.waitForDisplayed({ timeout: 10000 });
        await loginButton.click();
        await browser.pause(2000);

        const errorText = await $('~login_error_text');
        await errorText.waitForDisplayed({ timeout: 15000 });
        await expect(errorText).toBeDisplayed();

        const homeTitle = await $('~home_title');
        await expect(homeTitle).not.toBeDisplayed();
    });

    it('should not navigate to home when fields are empty', async () => {
        await waitFor('login_email_input');
        await tap('login_button');
        await browser.pause(1500);

        const homeTitle = await $('~home_title');
        await expect(homeTitle).not.toBeDisplayed();

        const emailInput = await $('~login_email_input');
        await expect(emailInput).toBeDisplayed();
    });
});
