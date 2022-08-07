// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Playlist.sol";
import "forge-std/console2.sol";

contract ContractScript is Script {
    function run() public {
        vm.startBroadcast();
        string[] memory uris = new string[](2);
        uris[0] = "ipfs://QmYVsw73haPgm9jK9BopsuKtzuxLANjYn75xeHLpht13D5/5";
        uris[1] = "ipfs://QmYVsw73haPgm9jK9BopsuKtzuxLANjYn75xeHLpht13D5/5";
        Playlist pl = new Playlist("RAD NEW PLAY LIST", "RNPL", uris);
        console2.logAddress(address(pl));
        vm.stopBroadcast();
    }
}
