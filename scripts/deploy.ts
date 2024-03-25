import hre from "hardhat";
import { prepareDiamondLoupeFacet } from './prepareFacets/prepareDiamondLoupeFacet';
import { prepareOwnershipFacet } from './prepareFacets/prepareOwnershipFacet';
import { prepareERC20Facet } from './prepareFacets/prepareERC20Facet';
import { prepareERC3643Facet } from './prepareFacets/prepareERC3643Facet';
import { deployDiamond } from './deployDiamond';



async function main(): Promise<void> {
    const accounts = await hre.viem.getWalletClients();
    const contractOwner = accounts[0].account.address;

    // Deploy each facet individually
    const diamondLoupeFacetCut = await prepareDiamondLoupeFacet(contractOwner);
    const ownershipFacetCut = await prepareOwnershipFacet(contractOwner);
    const erc20FacetCut = await prepareERC20Facet(contractOwner);
    const erc3643FacetCut = await prepareERC3643Facet(contractOwner);

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