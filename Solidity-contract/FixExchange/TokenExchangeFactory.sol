pragma solidity ^0.8.0;
import '../interface/IERC20.sol';
import '../TransferHelper.sol';
contract tokenExchangeFactory{
    // string public factoryName;
    // string public factoryLogo;
    // string public factoryIntroduction;
    uint public time;
    uint public releasePeriod;
    uint public closePeriod;
    uint public  chooseDay;
    uint public extractableRate;
    uint public circulation1;
    uint public index;
    uint public index2;
    uint public index3;
    //pool[] public list4;
    mapping(uint=>info)fixedExchangeInfo;
    struct info{
        string information;
        uint rate;
    }
    string public appointExchangeInfo;
    struct Token1{
        address token;
        string  name;
        string  symbol;
        uint    price;
        uint   circulation;
    }
    Token1[] public list1;
    Token2[] public list2;
    //token2[] private list2;
    struct Token2{
        address  token;
        string   name;
        string   symbol;
        uint     price;
        uint     circulation;
    }
    struct userInfo{
        //uint id;
        uint amount;
        address user;
        //uint time;
        uint depositTime;
    }
    userInfo []public list3;
    struct pool{
        uint index;
        string  name1;
        string  name2;
        address owner;
        address contracts;
    }
    pool []public list4;
    struct factoryInfo{
        string factoryName;
        string factoryLogo;
        string factoryIntroduction;
    }
    factoryInfo [] public list5;
    
     struct userInfo2{
        //uint id;
        uint amount;
        address user;
       // uint time;
        uint withdrawalTime;
    }
    userInfo2 []public list6;
    
    uint public rate;

    // function cteateFactory(string memory name ,string memory logo,string memory info)public{
    //     index=index+1;
    //     factoryInfo memory info=factoryInfo({
    //     factoryName :name,
    //     factoryLogo:logo,
    //     factoryIntroduction:info
    //     });
    //     list5.push(info);
    // }

    function addToken(address _token1,string memory _name1, string memory _symbol1,uint _circulation1,address _token2,string memory _name2, string memory _symbol2,uint _circulation2)public{
        circulation1=_circulation1;
        Token1 memory token1Info=Token1({
            token:_token1,
            name:_name1,
            symbol:_symbol1,
            price:100,
            circulation:_circulation1
        });
        list1.push(token1Info);
        Token2 memory token2Info=Token2({
            token:_token2,
            name:_name2,
            symbol:_symbol2,
            price:50,
            circulation:_circulation2
        });
        list2.push(token2Info);
        index=index+1;
        pool memory poolInfo=pool({
            index:index,
            name1:_name1,
            name2:_name2,
            owner:msg.sender,
            contracts:address(this)
        });
        list4.push(poolInfo);
    }

    function setExchangeRate(uint number,uint rates,uint way ,uint _releasePeriod,uint _closePeriod ,uint chooseDay)public{
        closePeriod=_closePeriod*2592000;
        releasePeriod=_releasePeriod*2592000;
        uint32 blockTime=uint32(block.timestamp % 2 ** 32);
        if (number==1){
            fixedExchangeInfo[number].information="fixed exchange rate";
            fixedExchangeInfo[number].rate=rates;
            rate=rates;
            if (chooseDay==1){
                extractableRate=86400/releasePeriod;
               //extractableRate=((blockTime-time-closePeriod)/86400)/releasePeriod;
            }
            if(chooseDay==2){
                extractableRate=(86400/releasePeriod)*30;
                //extractableRate=((blockTime-time-closePeriod)/releasePeriod)*30;
            }
            if(chooseDay==3){
                extractableRate=1;
            }
        }
        else if(number==2){
            appointExchangeInfo="the exchange rate of agreed amount";  
            if(way==1){
                rate =list1[index-1].price/list2[0].price;
                 if (chooseDay==1){
                    extractableRate=86400/releasePeriod;
                     //extractableRate=((blockTime-time-closePeriod)/86400)/releasePeriod;
                 }
                if(chooseDay==2){
                    extractableRate=(86400/releasePeriod)*30;
                //extractableRate=((blockTime-time-closePeriod)/releasePeriod)*30;
                }
                if(chooseDay==3){
                    extractableRate=1;
                }
            }
            if(way==2){
                rate=list1[index-1].price/50;
                if (chooseDay==1){
                    extractableRate=86400/releasePeriod;
                 }
                if(chooseDay==2){
                    extractableRate=(86400/releasePeriod)*30;
                }
                if(chooseDay==3){
                    extractableRate=1;
                }
            }
            if(way==3){
                rate=100/list2[index-1].price;
                if (chooseDay==1){
                    extractableRate=86400/releasePeriod;
                 }
                if(chooseDay==2){
                    extractableRate=(86400/releasePeriod)*30;
                }
                if(chooseDay==3){
                    extractableRate=1;
                }
            }
            if(way==4){
                rate=100/50;
                if (chooseDay==1){
                    extractableRate=86400/releasePeriod;
                     //extractableRate=((blockTime-time-closePeriod)/86400)/releasePeriod;
                 }
                if(chooseDay==2){
                    extractableRate=(86400/releasePeriod)*30;
                //extractableRate=((blockTime-time-closePeriod)/releasePeriod)*30;
                }
                if(chooseDay==3){
                    extractableRate=1;
                }
            }
        }
        //emit SetExchangeRate(rates,_releasePeriod,_closePeriod);
    }
    function deposit(address token2,uint amount)public{
        index2=index2+1;
        uint32 blockTime=uint32(block.timestamp % 2 ** 32);
        time=blockTime;
        require(amount<list2[index2-1].circulation,"over circulation");
        TransferHelper.safeTransferFrom(token2 ,msg.sender,address(this), amount);
        userInfo memory userinfo=userInfo({
            //id: id,
            amount:amount,
            user:msg.sender,
            //time:blockTime,
            depositTime:time
        });
        list3.push(userinfo);
        //emit Deposit(token2,amount);
    }
    function exchangeToken(address token,uint number,uint amount )public{
        index3=index3+1;
        //require(msg.sender==list3[0].user,"does not comply with exchange rules");
        uint32 blockTime=uint32(block.timestamp % 2 ** 32);
        require(blockTime>time+closePeriod,"Complete sealing period can not be extracted");
        //require(amount<=list3[index2-1].amount);
        list3[index2-1].amount=list3[index2-1].amount-amount;
        if(number==1){
            IERC20(token).transfer(msg.sender,amount);
            list3[index2-1].amount-amount;
            userInfo2 memory userinfo=userInfo2({
            amount:list3[index2-1].amount,
            user:msg.sender,
            //time:blockTime,
            withdrawalTime:blockTime
        });
        list6.push(userinfo);
           
        }
        if (number==2){
            uint amounts= list3[index-1].amount*(((blockTime-time-closePeriod)/86400)*extractableRate)/rate;
            require(amount<=amounts,"excess release limit");
            IERC20(token).transfer(msg.sender,amount);
            userInfo2 memory userinfo=userInfo2({
            amount:list3[index2-1].amount-amount,
            user:msg.sender,
            //time:blockTime,
            withdrawalTime:blockTime
        });
        list6.push(userinfo);
        }
    }
    
    function balanceOfToken1()public view returns(uint){
        return circulation1;
        
    }
    
    function balanceOfToken2()public view returns(uint){
        return list3[0].amount;
    }
    
    function Token1Info()public view returns(Token1 memory){
        return list1[0];
    }
    
     function Token2Info()public view returns(Token2 memory){
        return list2[0];
    }
    function userinfo()public view returns(userInfo memory){
        return list3[0];
    }
    
    function poollist2()public view returns(pool memory){
        for(uint i=0;i<index;i++){
            return list4[i];
        }
        
    }

}