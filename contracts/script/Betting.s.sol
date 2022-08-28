// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Betting} from "../src/Betting.sol";

import "forge-std/Script.sol";

contract BettingScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new Betting();
    }
}
