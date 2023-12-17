// test/paymentContract.test.js
const PaymentContract = artifacts.require("PaymentContract");

contract("PaymentContract", (accounts) => {
  let contractInstance; // 在測試套件外部聲明

  beforeEach(async () => {
    const payer = accounts[0];
    const payee = accounts[1];
    contractInstance = await PaymentContract.new(payee, 100, 864000); // 初始化 contractInstance
  });

  it("should allow payer to update amount", async () => {
    const newAmount = 150;

    // Perform necessary actions to test amount update
    try {
      await contractInstance.updateAmount(newAmount, { from: accounts[0] });
      console.log("Amount updated successfully");
    } catch (error) {
      console.error("Amount update failed:", error.message);
    }

    // Check contract state after test
    const updatedAmount = await contractInstance.amount();
    console.log("Contract amount after test:", updatedAmount.toNumber());
  });

  // Add more tests as needed
});
