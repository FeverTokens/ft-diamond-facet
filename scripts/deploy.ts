import hre from "hardhat";
import { deployDiamondLoupeFacet } from './deployFacets/deployDiamondLoupeFacet';
import { deployOwnershipFacet } from './deployFacets/deployOwnershipFacet';
import { deployERC20Facet } from './deployFacets/deployERC20Facet';
import { deployERC3643Facet } from './deployFacets/deployERC3643Facet';
import { deployDiamond } from './deployDiamond';
// import { getDiamondStorage } from './diamondStorage'; // Import the getDiamondStorage function

async function main(): Promise<void> {
    const accounts = await hre.viem.getWalletClients();
    const contractOwner = accounts[0].account.address;

    // Deploy each facet individually
    const diamondLoupeFacetCut = await deployDiamondLoupeFacet(contractOwner);
    const ownershipFacetCut = await deployOwnershipFacet(contractOwner);
    const erc20FacetCut = await deployERC20Facet(contractOwner);
    const erc3643FacetCut = await deployERC3643Facet(contractOwner);

    // Combine all facet cuts into a single array
    const cut = [
        diamondLoupeFacetCut,
        ownershipFacetCut,
        erc20FacetCut,
        erc3643FacetCut
    ];

    // Deploy the Diamond contract with the combined facet cuts
    await deployDiamond(cut);

  
}

if (require.main === module) {
    main()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}