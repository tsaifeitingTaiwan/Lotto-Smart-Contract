
const lotto = artifacts.require("lotto");

module.exports = function(deployer) {
  deployer.deploy(lotto,5);
};
