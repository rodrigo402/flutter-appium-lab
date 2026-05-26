function isAndroid() {
    return (driver.capabilities.platformName || '').toLowerCase() === 'android';
}

function isIOS() {
    return (driver.capabilities.platformName || '').toLowerCase() === 'ios';
}

module.exports = { isAndroid, isIOS };
