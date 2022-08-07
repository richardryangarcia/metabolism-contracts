// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";
import "./Sbt.sol";
import "ERC721A/ERC721A.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";


contract Playlist is ERC721A, ReentrancyGuard, IERC5192, Ownable  {
    uint MAX_MINT;

    mapping(uint256 => string) tokenURIs;
    mapping(uint256 => bool) tokenLockStatuses;
    constructor(string memory _name, string memory _symbol, string[] memory _tracks) 
    ERC721A(_name, _symbol)
    {
        MAX_MINT = _tracks.length;
        batchMint(_tracks.length);
        for (uint i = 0; i < _tracks.length; i++) {
            tokenURIs[i] = _tracks[i];
            tokenLockStatuses[i] = true;
        }
    }

    function batchMint(uint256 quantity) internal onlyOwner {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(address(this), quantity);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721A)
        returns (bool)
    {
        return
            interfaceId == 0xb45a3c0e || // soulbound
            super.supportsInterface(interfaceId);
    }

    function locked(uint256 tokenId) external view returns (bool) {
        return tokenLockStatuses[tokenId];
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(tokenLockStatuses[tokenId] == false, "Token is boundeth to le soul of thine playlist");
        super.transferFrom(from, to, tokenId);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(tokenLockStatuses[tokenId] == false, "Token is boundeth to le soul of thine playlist");
        super.safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual override {
        require(tokenLockStatuses[tokenId] == false, "Token is boundeth to le soul of thine playlist");
        super.safeTransferFrom(from, to, tokenId, data);
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        // _requireMinted(tokenId);
        return tokenURIs[tokenId];
    }

    /**
        @notice anyone can call this cuz im out of hackathon time lol
     */
    function destroy() public {
        selfdestruct(payable(0));
    }
    
}