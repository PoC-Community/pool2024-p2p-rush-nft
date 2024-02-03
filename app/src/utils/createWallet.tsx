import { createWalletClient, createPublicClient, custom, http } from 'viem';
import { sepolia } from 'viem/chains';

const isWindowEthereumAvailable = typeof window !== 'undefined';

// Create walletClient only if window.ethereum is available
export const walletClient = isWindowEthereumAvailable
? createWalletClient({
    chain: sepolia,
    transport: custom(window.ethereum!),
    })
: null;

export const publicClient = createPublicClient({
    chain: sepolia,
    transport: http()
})