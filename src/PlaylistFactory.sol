// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Playlist.sol";


contract PlaylistFactory  {
    address[] public playlists;
    /**
     * @dev Emitted when playlist has been created.
     */
    event PlaylistCreated(address indexed creator, address indexed playlist, uint256 indexed length);
    function createClone(string memory _name, string memory _symbol, string[] memory _tracks) public {
        Playlist pl = new Playlist(_name, _symbol, _tracks);
        playlists.push(address(pl));
        emit PlaylistCreated(msg.sender, address(pl), _tracks.length);
    }

    /**
        @notice anyone can call this cuz im out of hackathon time lol
     */
    function destroy() public {
        selfdestruct(payable(0));
    }
}