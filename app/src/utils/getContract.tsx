import { getContract } from 'viem'
import {ContratAddress} from '../conf'
import { publicClient, walletClient } from './createWallet'
import {Abi} from './NftAbi'

export async function mint() {
    const [account] = await walletClient.requestAddresses();
    const { request } = await publicClient.simulateContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'mint',
        account,
        args: ["name"],
      })
      const hash = await walletClient.writeContract(request)
}

export async function getAllNFTs() {
    const [account] = await walletClient.requestAddresses();
    const { request } = await publicClient.simulateContract({
        address: ContratAddress,
        abi: Abi,
        functionName: 'getAllNFTs',
        account,
        args: [],
    })
    const hash = await walletClient.writeContract(request)
}