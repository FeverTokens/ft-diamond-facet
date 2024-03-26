import hre from 'hardhat';
import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';
import { prepareDiamondLoupeFacet } from '../scripts/prepareFacets/prepareDiamondLoupeFacet';
import { prepareOwnershipFacet } from '../scripts/prepareFacets/prepareOwnershipFacet';
import { prepareERC3643Facet } from '../scripts/prepareFacets/prepareERC3643Facet';
import { deployDiamond } from '../scripts/deployDiamond';

describe("ERC3643Facet Tests", function () {
    let client: any;
    let contractOwner: string;
    let diamondLoupeFacetCut: any;
    let ownershipFacetCut: any;
    let erc3643FacetCut: any;
    let diamond: any;

    before(async function () {
        client = createPublicClient({
            chain: mainnet,
            transport: http() // Use the default HTTP transport
        });

        // Get the first account from the client
        const account = await hre.viem.getWalletClients();
        const contractOwner = account[0].account.address;
       

        // Deploy each facet individually
        diamondLoupeFacetCut = await prepareDiamondLoupeFacet(contractOwner);
        ownershipFacetCut = await prepareOwnershipFacet(contractOwner);
        erc3643FacetCut = await prepareERC3643Facet(contractOwner);

        // Combine all facet cuts into a single array
        const cut = [
            diamondLoupeFacetCut,
            ownershipFacetCut,
            erc3643FacetCut
        ];

        // Deploy the Diamond contract with the combined facet cuts
        diamond = await deployDiamond(cut); // Assuming deployDiamond now accepts a client as an argument
    });

    it("should deploy ERC3643Facet correctly", async function () {
        // Assuming deployDiamond returns the deployed diamond contract instance
        // You can add assertions here to verify the deployment
        expect(diamond).toBeDefined();
        expect(diamond.address).toBeDefined();
    });

    // Add more tests here to verify the functionality of ERC3643Facet
    // For example, you can test the ERC3643Facet's functions by calling them through the diamond contract
});