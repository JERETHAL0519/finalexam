// migrations/2_deploy_contracts.js
const PaymentContract = artifacts.require("PaymentContract");

module.exports = function (deployer) {
    deployer.deploy(PaymentContract, '0x1234567890123456789012345678901234567890', 100, 86400);
};
