const path = require('path');
const { takeScreenshot } = require('./utils/screenshot.helper');

exports.config = {
    runner: 'local',
    port: 4723,

    specs: ['./test/specs/login.e2e.js'],
    exclude: [],
    maxInstances: 1,

    capabilities: [{
        platformName: 'Android',
        'appium:deviceName': 'emulator-5554',
        'appium:platformVersion': '16',
        'appium:automationName': 'UiAutomator2',
        'appium:app': path.resolve(__dirname, '../build/app/outputs/flutter-apk/app-debug.apk'),
        'appium:noReset': false,
        'appium:fullReset': true,
        'appium:newCommandTimeout': 300,
    }],

    logLevel: 'info',
    bail: 0,
    waitforTimeout: 15000,
    connectionRetryTimeout: 120000,
    connectionRetryCount: 3,

    services: [],

    framework: 'mocha',
    reporters: ['spec'],

    mochaOpts: {
        ui: 'bdd',
        timeout: 120000,
    },

    afterTest: async function (test, context, { error }) {
        if (error) {
            await takeScreenshot(`failed-${Date.now()}`);
        }
    },
};
