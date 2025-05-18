// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console } from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMeTest is Test {
     FundMe fundMe;
     address user= makeaddr("USER");
     uint256 constant SEND_VALUE = 10e18;
     uint256 contant  STARTING_BALANCE = 10 ether;
     uint256 constant GAS_PRICE = 1;



    function setUp() external{
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(user, STARTING_BALANCE);

    }

    function testMinimumDollarIsFive() public {
      assertEq(fundMe.MINIMUM_USD(), 5e18);
     }
     function testOwnerIsMsgSender() public {
        console.log(fundMe.getOwner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
     }
  function testPriceFeedVersionIsAccurate() public {
    if (block.chainid == 11155111) {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    } else if (block.chainid == 1) {
        uint256 version = fundMe.getVersion();
        assertEq(version, 6);
    }
}

function testFundMeFailWithoutEnoughEth() public {
    vm.expectRevert();
    fundMe.fund();
}
function testFundUpdatedFundedData() public {
vm.prank(user);
    fundMe.fund{value: 10e18} ();
    uint256 amountFunded = fundMe.getAddressToAmountFunded(user);
    assertEq(amountFunded, SEND_VALUE);
}
function  testArrayOfFunders() public {
    vm.prank(user);
    fundMe.fund{value: SEND_VALUE}();
    address funder = fundMe.getFunder(0);
    assertEq(funder, user);
}

modifier funded() {
    vm.prank(user);
    fundMe.fund{value: SEND_VALUE}();
    _;
}
function testOnlyOwnerCanWithdraw() public funded {
    vm.expectRevert();
    fundMe.withdraw();

}
function testWithdrawWithASingleFunder() public funded{
   // the arrange, Act and Assert methodology of working with tests.
   uint256 startingOwnerBalance= fundme.getOwner().balance;
    uint256 startingFundMeBalance = address(fundMe).balance;
    //act
    vm.prank(fundMe.getOwner());
    fundMe.withdraw();
    
    //assert
    // check the balance of the fundMe contract
    uint256 endingOwnerBalance = fundMe.getOwner().balance;
    uint256 endingFundMeBalance = address(fundMe).balance;
    assertEq(endingFundMeBalance, 0);
    assertEq(endingOwnerBalance, startingOwnerBalance + startingFundMeBalance);
    // assertEq(endingOwnerBalance, startingOwnerBalance + startingFundMeBalance);


}
function testWithdrawWithMultipleFunders() public funded {
    //arrange
    uint160 numberOfFunders = 10;
    uint160 startingFunderIndex = 2;

    for (uint256 i = startingFunderIndex; i < numberOfFunders; i++) {
        //vm.prank the address
        //vm.deal new address
        // fund the fundme
        hoax(<address(i)>, SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();
    }
    uint256 startingFundMeBalance = address(fundMe).balance;
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    //act
    vm.startprank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopprank();
    //assert
    assert(address(fundMe).balance == 0);
    assert(fundMe.getOwner().balance == startingOwnerBalance + startingFundMeBalance);
};


function testPrintStorageData() public {
    for (uint256 i = 0; i < 3; i++) {
        bytes32 value = vm.load(address(fundMe), bytes32(i));
        console.log("Value at location", i, ":");
        console.logBytes32(value);
    }
    console.log("PriceFeed address:", address(fundMe.getPriceFeed()));

}

function testCheaperWithdrawWithMultipleFunders() public funded {
    //arrange
    uint160 numberOfFunders = 10;
    uint160 startingFunderIndex = 2;

    for (uint256 i = startingFunderIndex; i < numberOfFunders; i++) {
        //vm.prank the address
        //vm.deal new address
        // fund the fundme
        hoax(<address(i)>, SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();
    }
    uint256 startingFundMeBalance = address(fundMe).balance;
    uint256 startingOwnerBalance = fundMe.getOwner().balance;
    //act
    vm.startprank(fundMe.getOwner());
    fundMe.cheaperWithdraw();
    vm.stopprank();
    //assert
    assert(address(fundMe).balance == 0);
    assert(fundMe.getOwner().balance == startingOwnerBalance + startingFundMeBalance);  
}