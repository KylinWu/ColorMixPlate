const CMP = artifacts.require('ColorPlate');
const catchRevert = require('./exceptions').catchRevert;

contract('Test ColorPlate contract', async accounts => {

    let instance;

    before('Create instance', async () => {
        instance = await CMP.deployed();
    });

    it('should got name ColorMixPlate and symbol CMP', async () => {
        let name = await instance.name();
        let symbol = await instance.symbol();
        assert.equal(name, 'ColorMixPlate');
        assert.equal(symbol, 'CMP');
    });

    it('should get 5 default color can after call register()', async () => {
        await instance.register();
        let colorCans = await instance.balanceOf(accounts[0]);
        assert.equal(colorCans.toNumber(), 5);
    });

    it('should revert transaction when call register() that account already registered before', async () => {
        await catchRevert(instance.register());
    });

});