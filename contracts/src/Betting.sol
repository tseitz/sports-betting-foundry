// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

error Unauthorized();

contract Betting {
    address owner;
    uint256 poolId;
    mapping(address => Pool) pools;
    // mapping(address => uint256) onTheLine;

    event BetMade(address better, uint256 amount, uint256 total);

    struct Pool {
        // uint256 id;
        // string description;
        // address creator;
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

    // function createPool(string memory title, string memory description) public {
    //     poolId++;
    //     Pool storage p = pools[poolId];
    //     p.id = poolId;
    //     p.creator = msg.sender;
    //     p.description = description; // royals vs. cardinals
    //     emit PoolCreated(p.creator, p.description, p.id);
    // }

    function bet(address pool, uint256 amount) public {
        Pool storage p = pools[pool];
        p.onTheLine[msg.sender] += amount;
        emit BetMade(msg.sender, amount, p.onTheLine[msg.sender]);
    }

    function end() public onlyOwner {
        // pull in the result
        // distribute the money
    }

    function getBetAmount(address pool) public view returns (uint256) {
        Pool storage p = pools[pool];
        return p.onTheLine[msg.sender];
    }
}

import "forge-std/Test.sol";

contract BettingTest is Test {
    Betting betContract;

    function setUp() public {
        betContract = new Betting();
    }

    function testBet() public {
        betContract.bet(address(1337), 5);
        assertEq(betContract.getBetAmount(address(1337)), 5);
    }
}

// contract EmitBetTest is Test {
//     event BetMade(address better, uint256 amount, uint256 total);

//     function testExpectEmit() public {
//         Betting bettingEmitter = new Betting();
//         betContract.bet(address(1337), 5);
//         // vm.prank(address(1337));
//         vm.expectEmit(true, true, false, true);
//         emit BetMade(address(1337), 2);
//         storageEmitter.retrieve();
//     }

//     function testExpectEmitNoCheckData() public {
//         Storage storageEmitter = new Storage();
//         vm.prank(address(1337));
//         vm.expectEmit(true, true, false, false);
//         emit Retrieved(address(1337), 6);
//         storageEmitter.retrieve();
//     }
// }
