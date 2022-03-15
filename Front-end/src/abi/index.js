import TokenExchangeFactory from "./data/TokenExchangeFactory.json"

import erc20 from "./data/erc20.json"
const CONTRACTS = {
    TokenExchangeFactory:{address:"0x748c8E1B67C3306fE7B0aFC0Bca935438914E3ce",abi:TokenExchangeFactory},
    erc20:{abi:erc20},
};

function getContractByName(name, web3) {
    return new web3.eth.Contract(CONTRACTS[name].abi, CONTRACTS[name].address, {});
}

function getContractByContract(name, address, web3) {
    return new web3.eth.Contract(CONTRACTS[name].abi, address, {});
}

function getContractAddress(name) {
    return CONTRACTS[name].address;
}

export default {
    CONTRACTS,
    getContractByName,
    getContractByContract,
    getContractAddress
};
