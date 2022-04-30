class CanaryAbi {
  List<String> abi = [
    "function getRights(uint256, uint256) external payable",
    "function depositNFT(address, uint256 , uint256, uint256, uint256) external",
    "function withdrawRoyalties(uint256 , address[], uint256[], uint256[]) external",
    "function withdrawNFT(uint256, uint256) external",
    "function setAvailability(uint256 , bool, uint256) external",
    "function withdrawTreasury() external",
    "function currentTreasury() external view returns (uint256)",
    "function dailyPriceOf(uint256) external view returns (uint256)",
    "function maxRightHoldersOf(uint256) external view returns (uint256)",
    "function maxPeriodOf(uint256) external view returns (uint256)",
    "function rightsPeriodOf(uint256 , address) external view returns (uint256)",
    "function rightsOf(address) external view returns (uint256[] memory)",
    "function getAvailableNFTs() external view returns (uint256[] memory)",
    "function rightHoldersOf(uint256) external view returns (address[] memory)",
    "function holderDeadline(uint256, address) external view returns (uint256)",
    "function ownerOf(uint256) external view returns (address)",
    "function propertiesOf(address) external view returns (bytes32[])",
    "function availabilityOf(uint256) external view returns (bool)",
    "function originOf(uint256) external view returns (bytes32[] memory)",
    "function rightURI(uint256) external view returns (string memory)"
  ];

  List<String> e721abi = [
    "function approve(address, uint256) external payable",
    "function tokenURI(uint256) external view returns (string)",
    "function name() external view returns (string _name)",
    "function symbol() external view returns (string _symbol)"
  ];

  String auxabi = '''
    [
	{
		"inputs": [],
		"name": "getAvailableNFTs",
		"outputs": [
			{
				"internalType": "bytes32[]",
				"name": "",
				"type": "bytes32[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_holder",
				"type": "address"
			}
		],
		"name": "holderDeadline",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "ownerOf",
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
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "rightHoldersOf",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
  ''';

  List<String> diamondLoupeNames = [
    "facets()",
    "facetFunctionSelectors(address)",
    "facetAddresses()",
    "facetAddress(bytes4)",
    "supportsInterface(bytes4)"
  ];

  List<String> ownershipNames = ["transferOwnership(address)", "owner()"];

  List<String> canaryNames = [
    "getRights",
    "depositNFT",
    "withdrawRoyalties",
    "withdrawNFT",
    "setAvailability",
    "dailyPriceOf",
    "maxRightHoldersOf",
    "maxPeriodOf",
    "rightsPeriodOf",
    "rightsOf",
    "propertiesOf",
    "getAvailableNFTs",
    "rightHoldersOf",
    "holderDeadline",
    "ownerOf",
    "availabilityOf"
  ];

  List<String> initNames = ["init"];

  String initAbi = '''
    [
      {
        "inputs": [],
        "name": "init",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]
  ''';

  String diamondLoupAbi = '''
    [
      {
        "inputs": [
          {
            "internalType": "bytes4",
            "name": "_functionSelector",
            "type": "bytes4"
          }
        ],
        "name": "facetAddress",
        "outputs": [
          {
            "internalType": "address",
            "name": "facetAddress_",
            "type": "address"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [],
        "name": "facetAddresses",
        "outputs": [
          {
            "internalType": "address[]",
            "name": "facetAddresses_",
            "type": "address[]"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "_facet",
            "type": "address"
          }
        ],
        "name": "facetFunctionSelectors",
        "outputs": [
          {
            "internalType": "bytes4[]",
            "name": "facetFunctionSelectors_",
            "type": "bytes4[]"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [],
        "name": "facets",
        "outputs": [
          {
            "components": [
              {
                "internalType": "address",
                "name": "facetAddress",
                "type": "address"
              },
              {
                "internalType": "bytes4[]",
                "name": "functionSelectors",
                "type": "bytes4[]"
              }
            ],
            "internalType": "struct IDiamondLoupe.Facet[]",
            "name": "facets_",
            "type": "tuple[]"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "bytes4",
            "name": "_interfaceId",
            "type": "bytes4"
          }
        ],
        "name": "supportsInterface",
        "outputs": [
          {
            "internalType": "bool",
            "name": "",
            "type": "bool"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      }
    ]
  ''';

  String ownershipAbi = '''
    [
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
        "name": "owner",
        "outputs": [
          {
            "internalType": "address",
            "name": "owner_",
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
            "name": "_newOwner",
            "type": "address"
          }
        ],
        "name": "transferOwnership",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]
  ''';

  String canaryabi = '''
    [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "DepositedNFT",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "_period",
				"type": "uint256"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "_who",
				"type": "address"
			}
		],
		"name": "GetRight",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "availabilityOf",
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
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "biggerDeadlineOf",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "dailyPriceOf",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_dailyprice",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_maxperiod",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_maxrightbuyers",
				"type": "uint256"
			}
		],
		"name": "depositNFT",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getAvailableNFTs",
		"outputs": [
			{
				"internalType": "bytes32[]",
				"name": "",
				"type": "bytes32[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_period",
				"type": "uint256"
			}
		],
		"name": "getRights",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_holder",
				"type": "address"
			}
		],
		"name": "holderDeadline",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "maxPeriodOf",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "maxRightHoldersOf",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "ownerOf",
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
				"name": "_owner",
				"type": "address"
			}
		],
		"name": "propertiesOf",
		"outputs": [
			{
				"internalType": "bytes32[]",
				"name": "",
				"type": "bytes32[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			}
		],
		"name": "rightHoldersOf",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_rightsHolder",
				"type": "address"
			}
		],
		"name": "rightsOf",
		"outputs": [
			{
				"internalType": "bytes32[]",
				"name": "",
				"type": "bytes32[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_holder",
				"type": "address"
			}
		],
		"name": "rightsPeriodOf",
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
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "bool",
				"name": "_available",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "_nftindex",
				"type": "uint256"
			}
		],
		"name": "setAvailability",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_nftIndex",
				"type": "uint256"
			}
		],
		"name": "withdrawNFT",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc721",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_nftid",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_deadlinelist",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_roindexes",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_whrindexes",
				"type": "uint256[]"
			}
		],
		"name": "withdrawRoyalties",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
  ''';
}
