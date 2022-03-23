# staking_test

## install: npm install
## install ganache locally - npm install ganache 
this could be troublesome under windows, due to that it is not in package.json, but additional step;
if ganache installed - next step will work
## run:  npm start or 'node test.js'
Staking contract is tested via script with use of ganache, see test.js for details.
No ganache running is needed, script uses node.js ganache object.

Staking contract allows to configure deposit conditions by admin
(lock term, yearly APY, i.e. 3 months - 20%, 6 months - 25%.

Users can stake tokens agains different deposit conditions (similar open bank deposits according
to specific conditions)

Users can view status, withdraw deposits, withdraw rewards only.

It is possible to stop staking globally, it is possible to ensure 'end-date' for specific deposit conditions.

For testing purposes it is possible to set contract day to, say 5 minutes, to test reward calculation.

Contract ABI:

[
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "CANNOT_TRANSFER_TO_ZERO_ADDRESS",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "NOT_CURRENT_OWNER",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "apy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "minLockTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "canJoin",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "dpEndDate",
				"type": "uint256"
			}
		],
		"name": "addDepositProfile",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "userWallet",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "depositIndex",
				"type": "uint256"
			}
		],
		"name": "amountForUserDeposit",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "depositProfileId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositExtractableAmount",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "customersDeposits",
		"outputs": [
			{
				"internalType": "address",
				"name": "customer",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "depositsNumber",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "customersDepositsLength",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			},
			{
				"internalType": "uint32",
				"name": "profileId",
				"type": "uint32"
			}
		],
		"name": "deposit",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "userWallet",
				"type": "address"
			},
			{
				"internalType": "uint32",
				"name": "depositId",
				"type": "uint32"
			}
		],
		"name": "depositDays",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositId",
				"type": "uint256"
			}
		],
		"name": "depositIsExtractable",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "depositProfiles",
		"outputs": [
			{
				"internalType": "uint32",
				"name": "id",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "apy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "minLockTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "canJoin",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "endDate",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "depositProfilesLength",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositId",
				"type": "uint256"
			}
		],
		"name": "depositReward",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getBaseToken",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getContractDay",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "getCustomersDepositsItem",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "id",
				"type": "uint32"
			}
		],
		"name": "getDepositProfileById",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "apy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "minLockTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "canJoin",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "dpEndDate",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getEndDate",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getManager",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "isActive",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "userWallet",
				"type": "address"
			}
		],
		"name": "numberOfUserDeposits",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "userDepositsNumber",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "ownAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "tokenAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "realAmountTokens",
				"type": "uint256"
			}
		],
		"name": "ownerWithdrawTokens",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "pauseContract",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "id",
				"type": "uint32"
			}
		],
		"name": "removeDepositProfileAtId",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "index",
				"type": "uint32"
			}
		],
		"name": "removeDepositProfileAtIndex",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "id",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "apy",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "minLockTime",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "canJoin",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "dpEndDate",
				"type": "uint256"
			}
		],
		"name": "replaceDepositProfileAtId",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "userWallet",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "depositIndex",
				"type": "uint256"
			}
		],
		"name": "rewardForUserDeposit",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "depositProfileId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "rewardForDeposit",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "extractableRewardForDeposit",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newBaseTokenAddress",
				"type": "address"
			}
		],
		"name": "setBaseToken",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "period",
				"type": "uint256"
			}
		],
		"name": "setContractDay",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newEndDate",
				"type": "uint256"
			}
		],
		"name": "setEndDate",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newstakingManager",
				"type": "address"
			}
		],
		"name": "setManagerRight",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "startContract",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "userWallet",
				"type": "address"
			},
			{
				"internalType": "uint32",
				"name": "depositId",
				"type": "uint32"
			}
		],
		"name": "viewCustomerDeposit",
		"outputs": [
			{
				"internalType": "uint32",
				"name": "depositProfileId",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositId",
				"type": "uint256"
			}
		],
		"name": "viewCustomerDepositByIndex",
		"outputs": [
			{
				"internalType": "uint32",
				"name": "depositProfileId",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "depositAmount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "depositDate",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "accumulatedReward",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "implyLock",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "depositId",
				"type": "uint32"
			},
			{
				"internalType": "uint256",
				"name": "withdrawAmount",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "whole",
				"type": "bool"
			}
		],
		"name": "withdrawDepositById",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint32",
				"name": "depositId",
				"type": "uint32"
			}
		],
		"name": "withdrawDepositRewardById",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"stateMutability": "payable",
		"type": "receive"
	}
]
