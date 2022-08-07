// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/Playlist.sol";
import "openzeppelin-contracts/contracts/interfaces/IERC2981.sol";

abstract contract HelperContract {
    Playlist pl;
    struct Track {
        string name;
        string symbol;
        string tokenUri;
    }
}

contract BaseTest is Test {
    // 0x5dad7600c5d89fe3824ffa99ec1c3eb8bf3b0501 alice
    // 0x5dad7600C5D89fE3824fFa99ec1c3eB8BF3b0501 checksummed alice
    function mkaddr(string memory name) public returns (address) {
        address addr =
            address(uint160(uint256(keccak256(abi.encodePacked(name)))));
        vm.label(addr, name);
        return addr;
    }
}

contract ContractTest is BaseTest, HelperContract {
    function setUp() public {
        string[] memory uris = new string[](2);
        uris[0] = "https://c.tenor.com/mo16QnVaYfEAAAAS/frank-reynolds-iasip.gif";
        uris[1] = "ipfs://QmYVsw73haPgm9jK9BopsuKtzuxLANjYn75xeHLpht13D5/5";
        pl = new Playlist("SPINLIST", "SPIN", uris);
    }

    function testName() public {
        assertEq(pl.name(), "SPINLIST");
    }

    function testSymbol() public {
        assertEq(pl.symbol(), "SPIN");
    }

    function testBalances() public {
        assertEq(pl.balanceOf(address(pl)), 2);
        string memory uri = pl.tokenURI(0);
        assertEq(uri,  "https://c.tenor.com/mo16QnVaYfEAAAAS/frank-reynolds-iasip.gif");
    }

    function testSupports() public {
        // bool supportsErc721 = pl.supportsInterface(type(IERC721A).interfaceId); // 0x80ac58cd
        bool supportsSoulBound = pl.supportsInterface(0xb45a3c0e); // 0xb45a3c0e

        // assertEq(supportsErc721, true);
        assertEq(supportsSoulBound, true);
    }

    function testDestroy() public {
        pl.destroy();
    }

}
