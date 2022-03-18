# Submission for the ETHDenver 2022 Virtual BUIDLathon

## 1.Project name

DAO Fixed Exchange System

## 2.Elevator pitch

Through this system, a fixed exchange ratio of one token and another token can be agreed, so that the two tokens can be exchanged according to the agreed ratio, instead of Use an automated market maker algorithm to exchange based on the liquidity in the pool.

## 3.Team Name

RainbowCity Foundation

## 4.Submission links

In this ETHDenver 2022 Virtual BUIDLathon event, RainbowCity Foundation submitted a total of 10 projects, which is the  address directory of the 10 projects. We are continuing to refine the details of each project.

Submission address directory:
http://www.rainbowdao.io/ETHDanver2022

Project demo website:
https://fixedexethdanver.rainbowdao.io/

GitHub repository :
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange

Solidity-Version-contract (GitHub):
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/tree/main/Solidity-contract

Frontend code (GitHub):
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/tree/main/Front-end

Picture (GitHub):
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/tree/main/PIC

## 5.Recorded video demo

https://youtu.be/ZPMZH6jTj5c

## 6.Testnet Deployment Information

Network Name: Rinkeby Test Network
RPC URL: https://rinkeby.infura.io/v3/

Contract deployment address

TokenExchangeFactory:
0x4fB00f393Afd29F24770D5Eb04E39f2eAaAc9E9d

RBD:
0x095C37882D52bce538F804DD7ba4A3714f7De34f

RBE:
0x59b5B6A7aa8E95746225fE969c2D280D75A2C83e

Frontend docs:
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/blob/main/Front-end/README.md

Contract  docs:
https://github.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/blob/main/Solidity-contract/README.md

## 7.Project social media:

RainbowDAO website: http://www.rainbowdao.io

Rainbowcity website: https://www.rainbowcity.io

Twitter:    https://twitter.com/RainbowDAOio

Discord:     https://discord.gg/vbnvFEeYRr

Telegram: https://t.me/RainbowDAO

Medium:   https://medium.com/rainbowcity

Github:    https://github.com/RainbowDAO

Email: Rainbowcitydao@gmail.com

#  Project Story

## 1.Inspiration

In the crypto world, token exchange is the most common application scenario, especially various decentralized exchanges, which can realize the free exchange between two different tokens.

However, in addition to the free exchange of tokens, in many cases, we also need to set some fixed proportions of exchange, which is the system we are developing now, the DAO fixed exchange system, which is suitable for some special application scenarios.

## 2.What it does

Through this system, we can build a smart contract . In this smart contract , a fixed exchange ratio of one token and another token can be agreed, so that the two tokens can be exchanged according to the agreed ratio, instead of Use an automated market maker algorithm to exchange based on the liquidity in the pool.

Our system is mainly used when there are multiple tokens in an ecosystem, the exchange of different tokens is carried out according to the agreed rules, or the tokens of different ecosystems are exchanged according to certain rules.

For example, we establish a DAO organization and issue two tokens, one is the governance token RBD, and the other is the ecological incentive token RBE. Ecological incentive tokens are distributed to ecological members for free based on ecological contributions. Ecological members can use the incentive token RBE to exchange for the governance token RBD for free. This exchange ratio is not based on free market exchange, and can be exchanged at a certain ratio. In this way, different tokens can undertake different functions and can be exchanged with each other according to certain rules.

## 3.How we built it

![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/logic-diagram.png)

First of all, we need to initialize a system and establish a token fixed exchange factory system according to the contract parameters. Anyone can initially build such a system. There are two main steps here. The first setting step is to agree on the exchange ratio, and the second setting step is to agree on the exchange and withdrawal process:

⑴ The exchange ratio is determined:

① Fixed exchange ratio: In this case, the actual market value of the two tokens is not considered, and a fixed exchange ratio is directly agreed.

For example, in this exchange pool, 1 RBT can be exchanged for 5 RBE. The project party can deposit 1 million RBTs into this pool, and anyone can exchange RBTs from this pool at a fixed ratio of 5 RBEs to 1 RBT. The exchange ratio is not linked to the real-time value of the two tokens.

Initialization setting of exchange time: For example, the exchange time is 24 months. During these 24 months, the depositor cannot remove the RBD from the pool. After the exchange time, if there is remaining RBD, the depositor can transfer the remaining RBD. RBD take away. There are no restrictions on depositors withdrawing RBE.

② The exchange ratio of the agreed amount: This kind of exchange is exchanged according to the real-time agreed value of the two tokens. There are two cases here, one is to read the price of the oracle directly, the other is to follow the specified price, and the two prices can be mixed. Thus, there are four different situations:

Token 1RBD: Oracle Price             Token 1RBD: Oracle Price
Token2RBE: Oracle price              Token2RBE: Specified price
Token 1RBD: Specified price          Token 1RBD: Specified price
Token2RBE: Oracle price              Token2RBE: Specified price

For example, the incentive token RBE issued in our ecology, as long as it operates in the ecology, it can always be calculated at a fixed price of 0.05u, and we can distribute this incentive token for free according to this standard. Those who get RBE can exchange RBT from this pool for free at a fixed price of 0.05u. The price of this RBT can be calculated by taking the actual market price of the oracle machine.

⑵ Redemption and collection process:

After the exchange, the tokens received for exchange can be divided into two different situations.

① No restrictions on direct collection: the exchanger directly exchanges the tokens from the pool without any restrictions;

② Lock and withdraw according to the agreed period: that is, the exchanger cannot immediately take out the exchanged tokens after the exchange, but must lock and withdraw according to the initially agreed lock-up period.

The agreed time has two periods, one is the complete closing period, during which the lock is completely locked and cannot be released; the second is the release period, which is released in proportion: for example, the complete closing period is 12 months, within these 12 It cannot be withdrawn within a month. After 12 months, the monthly release ratio is 10%, that is, it takes 10 months to fully withdraw, and 10% can be withdrawn every month.

There are two ways to release:

① Release on a monthly basis, that is, once a month, you can receive it on a monthly basis;

② Release on a daily basis, that is, once a day, you can receive it on a daily basis, and 30 days is a month.

Whether it is a monthly release or a daily release, the initialization is set according to the month, and the specific contract is refined into the corresponding block time.

#  Project UI

## 1-Basic-Information

![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/1-Basic-Information.png)


## 2-Token-Settings


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/2-Token-Settings.png)


## 3-Exchange-Settings-1


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/3-Exchange-Settings-1.png)


## 4-Exchange-Settings-2


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/4-Exchange-Settings-2.png)


## 5-Inject-tokens


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/5-Inject-tokens.png)


## 6-Home


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/6-Home.png)


## 7-Info


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/7-Info.png)


## 8-Exchange


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/8-Exchange.png)


## 9-Withdraw-1


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/9-Withdraw-1.png)


## 10-Withdraw-2


![image](https://raw.githubusercontent.com/RainbowDAO/07-ETHDenver2022-DAO-Fixed-Exchange/main/PIC/10-Withdraw-2.png)
