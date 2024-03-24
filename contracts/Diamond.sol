// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {LibDiamond} from "./libraries/LibDiamond.sol";
import {IDiamondCut} from "./interfaces/IDiamondCut.sol";

contract Diamond {

    constructor(
        address _contractOwner,
        address _diamondCutFacet,
        // string memory tokenName,
        // string memory tokenSymbol,
        address facetAddress,
        bytes memory constructData
    ) payable {
        LibDiamond.setContractOwner(_contractOwner);

        // Add the diamondCut external function from the diamondCutFacet
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IDiamondCut.diamondCut.selector;
        cut[0] = IDiamondCut.FacetCut({facetAddress: _diamondCutFacet, action: IDiamondCut.FacetCutAction.Add, functionSelectors: functionSelectors});
        LibDiamond.diamondCut(cut, facetAddress, constructData);
    }

    // // Function to initialize the diamond contract
    // function initialize(
    //     string memory tokenName,
    //     string memory tokenSymbol,
    //     address _contractOwner
    // ) external {
    //     require(msg.sender == LibDiamond.contractOwner(), "Diamond: Must be contract owner");

    //     // Retrieve the facet address from the diamond storage
    //     LibDiamond.DiamondStorage storage ds;
    //     bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
    //     assembly {
    //         ds.slot := position
    //     }
    //     address facetAddress = ds.selectorToFacetAndPosition[msg.sig].facetAddress;

    //     // Use delegatecall to call the initialize function in the ERC20Facet
    //     bytes memory data = abi.encodeWithSignature("initialize(string,string,uint256,address)", tokenName, tokenSymbol, _contractOwner);
    //     (bool success,) = facetAddress.delegatecall(data);
    //     require(success, "Initialization failed");
    // }


    
    // Find facet for function that is called and execute the
    // function if a facet is found and return any value.
    fallback() external payable {
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        address facet = ds.selectorToFacetAndPosition[msg.sig].facetAddress;
        require(facet != address(0), "Diamond: Function does not exist");
        // Execute external function from facet using delegatecall and return any value.
        assembly {
            // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
            // execute function call using the facet
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            // get any return value
            returndatacopy(0, 0, returndatasize())
            // return any return value or error back to the caller
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    receive() external payable {}
}