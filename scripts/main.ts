import hre from "hardhat";
import { deployFacets } from './deployFacets';
import { deployDiamond } from './deployDiamond';

async function main(): Promise<void> {
    const accounts = await hre.viem.getWalletClients();
    const contractOwner = accounts[0].account.address;

    const cut = await deployFacets(contractOwner);
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