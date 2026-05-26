const path = require('path');
const { takeScreenshot } = require('./utils/screenshot.helper');

const RUNNER_APP = path.resolve(__dirname, '../build/ios/iphonesimulator/Runner.app');
const BUNDLE_ID = 'com.example.appiumFlutterDemo';

exports.config = {
    runner: 'local',
    hostname: 'localhost',
    port: 4723,

    specs: ['./test/specs/login.e2e.js'],
    exclude: [],
    maxInstances: 1,

    capabilities: [{
        platformName: 'iOS',
        'appium:automationName': 'XCUITest',
        'appium:deviceName': 'iPhone 17 Pro',
        'appium:platformVersion': '26.5',
        'appium:app': RUNNER_APP,
        'appium:bundleId': BUNDLE_ID,

        // Reuse existing Simulator + WDA for faster local execution.
        'appium:noReset': true,
        'appium:fullReset': false,
        'appium:enforceAppInstall': false,
        'appium:useNewWDA': false,

        'appium:newCommandTimeout': 300,

        'appium:autoAcceptAlerts': true,
        'appium:connectHardwareKeyboard': false,

        // Flutter nunca alcanza "quiescence" — evita cuelgues al crear sesión.
        'appium:waitForQuiescence': false,
        'appium:waitForIdleTimeout': 0,

        'appium:wdaLaunchTimeout': 120000,
        'appium:wdaConnectionTimeout': 120000,
        'appium:simulatorStartupTimeout': 300000,

        'appium:showXcodeLog': true,
    }],

    logLevel: 'info',
    bail: 0,
    waitforTimeout: 15000,
    // Primera sesión iOS compila WebDriverAgent — puede superar 2 min.
    connectionRetryTimeout: 600000,
    connectionRetryCount: 1,

    services: [],

    framework: 'mocha',
    reporters: ['spec'],

    mochaOpts: {
        ui: 'bdd',
        timeout: 180000,
    },

    onPrepare() {
        console.log('');
        console.log('🍎 iOS E2E (XCUITest) — fast local mode');
        console.log(`   App: ${RUNNER_APP}`);
        console.log('   Requisitos: Simulator abierto + Appium en http://localhost:4723');
        console.log('   Modo: reutiliza Simulator, WDA y app instalada (noReset).');
        console.log('   Nota: la primera ejecución compila WebDriverAgent; las siguientes son rápidas.');
        console.log('');
    },

    // Relaunch app without reinstalling — keeps login flow deterministic with noReset.
    before: async function () {
        try {
            await driver.terminateApp(BUNDLE_ID);
        } catch {
            // App may not be running on first launch.
        }
        await driver.activateApp(BUNDLE_ID);
    },

    afterTest: async function (test, context, { error }) {
        if (error) {
            await takeScreenshot(`failed-${Date.now()}`);
        }
    },
};
