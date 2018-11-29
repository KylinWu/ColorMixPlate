pragma solidity ^0.4.22;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Metadata.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract ColorPlate is ERC721, ERC721Metadata {

    struct ColorCan {
        uint256 red;
        uint256 green;
        uint256 blue;
        uint256 volume;
    }
    uint256 public id;
    mapping (uint256 => ColorCan) public colorCans;
    mapping (uint256 => bool) public refillable;

    constructor(string name, string symbol) ERC721Metadata(name, symbol) public {
        id = 0;
    }

    function register() public {
        require(balanceOf(msg.sender) == 0, "This accound already registered before.");
        colorCans[id] = ColorCan(255, 0, 0, 100);
        refillable[id] = true;
        _mint(msg.sender, id++);
        colorCans[id] = ColorCan(0, 255, 0, 100);
        refillable[id] = true;
        _mint(msg.sender, id++);
        colorCans[id] = ColorCan(0, 0, 255, 100);
        refillable[id] = true;
        _mint(msg.sender, id++);
        colorCans[id] = ColorCan(0, 0, 0, 100);
        refillable[id] = true;
        _mint(msg.sender, id++);
        colorCans[id] = ColorCan(255, 255, 255, 100);
        refillable[id] = true;
        _mint(msg.sender, id++);
    }

    function mixColor(uint256 canId_1, uint256 volume_1, uint256 canId_2, uint256 volume_2) public {
        require(msg.sender == ownerOf(canId_1) && msg.sender == ownerOf(canId_2), "You are not color can owner.");
        require(colorCans[canId_1].volume >= volume_1, "First color volume is insufficient");
        require(colorCans[canId_2].volume >= volume_2, "Second color volume is insufficient");

        uint256 red;
        uint256 green;
        uint256 blue;
        uint256 diff;
        uint256 totalVolume = SafeMath.add(volume_1, volume_2);
        /*Subtracting can volume */
        colorCans[canId_1].volume = SafeMath.sub(colorCans[canId_1].volume, volume_1);
        colorCans[canId_2].volume = SafeMath.sub(colorCans[canId_2].volume, volume_2);
        /*Calculating RGB*/
        if (colorCans[canId_1].red > colorCans[canId_2].red) {
            diff = SafeMath.sub(colorCans[canId_1].red, colorCans[canId_2].red);
            red = SafeMath.sub(colorCans[canId_1].red, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        } else {
            diff = SafeMath.sub(colorCans[canId_2].red, colorCans[canId_1].red);
            red = SafeMath.add(colorCans[canId_1].red, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        }

        if (colorCans[canId_1].green > colorCans[canId_2].green) {
            diff = SafeMath.sub(colorCans[canId_1].green, colorCans[canId_2].green);
            green = SafeMath.sub(colorCans[canId_1].green, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        } else {
            diff = SafeMath.sub(colorCans[canId_2].green, colorCans[canId_1].green);
            green = SafeMath.add(colorCans[canId_1].green, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        }

        if (colorCans[canId_1].blue > colorCans[canId_2].blue) {
            diff = SafeMath.sub(colorCans[canId_1].blue, colorCans[canId_2].blue);
            blue = SafeMath.sub(colorCans[canId_1].blue, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        } else {
            diff = SafeMath.sub(colorCans[canId_2].blue, colorCans[canId_1].blue);
            blue = SafeMath.add(colorCans[canId_1].blue, SafeMath.div(SafeMath.mul(diff, volume_2), totalVolume));
        }
        colorCans[id] = ColorCan(red, green, blue, totalVolume);
        _mint(msg.sender, id++);
    }

    function refillCan(uint256 canId) public {
        require(msg.sender == ownerOf(canId), "You are not color can owner.");
        require(refillable[canId] == true, "This color can is non-refillable.");
        require(colorCans[canId].volume < 100, "This color can is full.");
        colorCans[canId].volume = 100;
    }
}
