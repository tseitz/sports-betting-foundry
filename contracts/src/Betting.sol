// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

error Unauthorized();

contract Betting {
    address owner;
    uint256 poolId;
    mapping(uint256 => Pool) pools;
    mapping(address => uint256) onTheLine;

    event PoolCreated(address creator, string description, uint256 id);

    struct Pool {
        uint256 id;
        string description;
        address creator;
        // uint256 blocknumber; do I need to tack this or is it automatic?
        mapping(address => uint256) onTheLine;
    }

    struct Bet {
        uint256 amount;
        address person;
    }

    constructor() {
        owner = msg.sender;
        poolId = 0;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        _;
    }

    // modifier onlyCreator() {
    //     // TODO: idk work on this
    //     if (msg.sender != Pool.creator) {
    //         revert Unauthorized();
    //     }
    //     _;
    // }

    function hello(string memory output) public pure returns (string memory) {
        return output;
    }

    function createPool(string memory title, string memory description) public {
        poolId++;
        Pool storage p = pools[poolId];
        p.id = poolId;
        p.creator = msg.sender;
        p.description = description; // royals vs. cardinals
        emit PoolCreated(p.creator, p.description, p.id);
    }

    function bet(uint256 amount) public {
        // pool += amount;
        // onTheLine[msg.sender] += amount;
    }

    function end() public onlyOwner {
        // pull in the result
        // distribute the money
    }
}
