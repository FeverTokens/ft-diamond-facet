import hre from 'hardhat';
import { expect } from 'expect';
import { readFileSync } from 'fs';
import { join } from 'path';
import { prepareERC3643Facet } from '../scripts/prepareFacets/prepareERC3643Facet'; // Adjust the path as necessary
import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';
import { FacetCutAction } from '../scripts/libraries/diamond'; 
import { ERC3643Facet } from '../typechain-types';

describe("ERC3643Facet Preparation Tests", function () {
    let ERC3643Facet: ERC3643Facet;

    this.beforeEach(async function () {
        const erc3643FacetAbi = JSON.parse(readFileSync(join(__dirname, '../artifacts/contracts/facets/erc3643Package/ERC3643Facet.sol/ERC3643Facet.json'), 'utf8')).abi;    

         // Create a viem client
        
         const accounts = await hre.viem.getWalletClients();
         const contractOwner = accounts[0].account.address;

        ERC3643Facet = await prepareERC3643Facet(contractOwner,erc3643FacetAbi);

    })
    it("should prepare the ERC3643Facet correctly", async function () {
        try {

            const erc3643FacetAbi = JSON.parse(readFileSync(join(__dirname, '../artifacts/contracts/facets/erc3643Package/ERC3643Facet.sol/ERC3643Facet.json'), 'utf8')).abi;    

            // // Create a viem client
            // const client = createPublicClient({
            //     chain: mainnet,
            //     transport: http()
            // });

            // Get the first account from the client
          
            const accounts = await hre.viem.getWalletClients();
            const contractOwner = accounts[0].account.address;

            

            // Prepare the ERC3643Facet
            const facetCut = await prepareERC3643Facet(contractOwner,erc3643FacetAbi);

            // Check if the facet cut is correctly prepared
            expect(facetCut).toBeDefined();
            expect(facetCut.action).toEqual(FacetCutAction.Add);
            expect(facetCut.facetAddress).toBeDefined();
            expect(facetCut.functionSelectors).toBeDefined();
            expect(facetCut.functionSelectors.length).toBeGreaterThan(0);
        } catch (error) {
            console.error('Error during ERC3643Facet preparation test:', error);
            throw error; // Rethrow the error to fail the test
        }
    });

    it("should handle contract deployment failure", async function () {
        try {
            // Attempt to deploy the contract with invalid parameters
            // await prepareERC3643Facet('invalidContractOwner',erc3643FacetAbi);
        } catch (error) {
            // Expect an error to be thrown
            expect(error).toBeDefined();
            // Optionally, check for a specific error message
            expect((error as Error).message).toMatch(/expected error message/);
        }
    });

    // it("should add an agent and check if it's an agent", async function () {
    //     const agentAddress = "0xe4476Ca098Fa209ea457c390BB24A8cfe90FCac4"; // Replace with a valid address
       
    //     // Add an agent
    //     await ERC3643Facet.addAgent(agentAddress);
       
    //     // Check if the agent is added
    //     const isAgent = await ERC3643Facet.isAgent(agentAddress);
    //     expect(isAgent).toBe(true);
    //    });
});


