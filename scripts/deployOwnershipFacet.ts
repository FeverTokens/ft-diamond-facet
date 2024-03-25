import hre from "hardhat";

import { prepareOwnershipFacet } from './prepareFacets/prepareOwnershipFacet';
import { deployDiamond } from './deployDiamond';



async function main(): Promise<void> {
    const accounts = await hre.viem.getWalletClients();
    const contractOwner = accounts[0].account.address;

    
    // Deploy the ERC3643 facet individually
    const ownershipFacetCut = await prepareOwnershipFacet(contractOwner);

    // facet cut
    const cut = ownershipFacetCut;
  

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