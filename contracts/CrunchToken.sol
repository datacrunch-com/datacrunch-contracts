// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts@4.3.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.3.0/token/ERC20/extensions/ERC20Burnable.sol";

contract CrunchToken is ERC20, ERC20Burnable {
    constructor() ERC20("Crunch Token", "CRUNCH") {
        _mint(msg.sender, 10765163 * 10 ** decimals());
    }
}
