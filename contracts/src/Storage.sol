// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

// cool I can import using remappings
import "solmate-utils/SafeCastLib.sol";

error Unauthorized();

contract Storage {
    uint256 number;
    address public immutable owner;

    event Retrieved(address indexed from, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        _;
    }

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public returns (uint256) {
        emit Retrieved(msg.sender, number);
        return number;
    }
}

// import "forge-std/Test.sol";

// contract StorageTest is Test {
//     Storage storageContract;

//     function setUp() public {
//         storageContract = new Storage();
//     }

//     function testRetrieve() public {
//         assertEq(storageContract.retrieve(), 0);
//         storageContract.store(5);
//         uint256 result = storageContract.retrieve();
//         assertEq(result, 5);
//         assertEq(storageContract.retrieve(), 5);
//         storageContract.store(2);
//         storageContract.store(3);
//         assertEq(storageContract.retrieve(), 3);
//     }

//     function testStore() public {
//         assertEq(storageContract.retrieve(), 0);
//         storageContract.store(2);
//         uint256 result = storageContract.retrieve();
//         assertEq(result, 2);
//         storageContract.store(66);
//         assertEq(storageContract.retrieve(), 66);
//     }

//     // not sure what the stdError would be yet
//     // function testCannotStoreNegative() public {
//     //     vm.expectRevert(stdError, "Cannot store negative number");
//     //     storageContract.store(-2);
//     // }

//     function testStoreAsNotOwner() public {
//         vm.expectRevert(Unauthorized.selector);
//         vm.prank(address(0));
//         storageContract.store(2);
//     }
// }

// contract EmitStorageTest is Test {
//     event Retrieved(address indexed from, uint256 amount);

//     // Storage storageContract;

//     // function setUp() public {
//     //     storageEmitter = new Storage();
//     // }

//     function testExpectEmit() public {
//         Storage storageEmitter = new Storage();
//         storageEmitter.store(2);
//         vm.prank(address(1337));
//         vm.expectEmit(true, true, false, true);
//         emit Retrieved(address(1337), 2);
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
