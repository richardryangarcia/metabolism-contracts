// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/PlaylistFactory.sol";
import "forge-std/console2.sol";

contract PlaylistScript is Script {
    function run() public {
        vm.startBroadcast();
        PlaylistFactory pl = new PlaylistFactory();
        console2.logAddress(address(pl));
        vm.stopBroadcast();
    }
}