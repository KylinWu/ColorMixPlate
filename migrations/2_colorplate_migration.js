var ColorPlate = artifacts.require("./ColorPlate.sol");

module.exports = function(deployer) {
  deployer.deploy(ColorPlate, 'ColorMixPlate', 'CMP');
};
