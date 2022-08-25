// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Storage} from "../src/Storage.sol";

import "forge-std/Script.sol";

contract ContractScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new Storage();
    }
}
