const { takeScreenshot } = require('../../utils/screenshot.helper');
const { typeInto, hideKeyboardSafe } = require('../../utils/input.helper');
const { waitFor, tap, performLogin } = require('../../utils/flow.helper');
const { isAndroid, isIOS } = require('../../utils/platform.helper');

describe('Full Transfer Flow', () => {
    afterEach(async function () {
        if (this.currentTest.state === 'failed') {
            await takeScreenshot(`full-flow-failed-${Date.now()}`);
        }
    });

    it('should complete a transfer flow successfully', async () => {
        await waitFor('login_email_input');
        await takeScreenshot('full-flow-login');

        await performLogin();

        await takeScreenshot('full-flow-home');

        await tap('home_items_button');
        await browser.pause(1000);
        await waitFor('items_list_title', 15000);
        await takeScreenshot('full-flow-list');

        await tap('item_card_1');
        await waitFor('detail_title');
        await takeScreenshot('full-flow-detail');

        await tap('detail_continue_button');
        await waitFor('form_name_input');
        await takeScreenshot('full-flow-form');

        await typeInto('form_name_input', 'Rodrigo Test');
        await typeInto('form_amount_input', '1500');
        await typeInto('form_description_input', 'Appium E2E transfer test');
        await hideKeyboardSafe();

        await tap('form_submit_button');
        await waitFor('confirmation_title', 15000);
        await takeScreenshot('full-flow-confirmation');

        if (isIOS()) {
            await waitFor('confirmation_summary', 15000);
            const summaryText = await $('~confirmation_summary').getText();
            expect(summaryText).toMatch(/Rodrigo Test/);
            expect(summaryText).toMatch(/1500/);
        } else if (isAndroid()) {
            const summary = await $('android=new UiSelector().descriptionContains("Rodrigo Test")');
            await summary.waitForDisplayed({ timeout: 15000 });
            await expect(summary).toBeDisplayed();
        }

        await waitFor('confirmation_back_home_button', 15000);
        await tap('confirmation_back_home_button');
        await waitFor('home_title', 15000);
    });
});
