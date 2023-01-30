// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { IMagicNum } from "ethernaut/18-magic-number/IMagicNum.sol";

contract Solver {
    error ContractCreationFailed();

    constructor(address _magicNum) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address solverAddr;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            solverAddr := create(0, add(bytecode, 0x20), 0x13)
        }

        if (solverAddr == address(0)) {
            revert ContractCreationFailed();
        }

        IMagicNum(_magicNum).setSolver(solverAddr);
    }
}
