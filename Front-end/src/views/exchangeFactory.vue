<template>
<div class="exchangeFactory">
    <pageHeaderInfo :info="factoryInfo" @joinVault="joinVault"></pageHeaderInfo>
  <div class="rainbow-panel" style="margin-top: 20px">
    <div class="sub-title-box">
      <img class="sub-icon" src="../assets/sub-icon.png"/>
      <div class="name">
        VAULT FUNDS
      </div>
    </div>
    <div class="vault-balance">
      <div class="funds">
        <div class="item">
          <div class="name">
            Current Initial Token Amount
          </div>
          <div class="value-box">
            <img class="icon" src="../assets/sub-icon.png" alt="">
            <div class="value">
              {{ token1Balance }} <span>
              {{ exchangeInfo.name1 }}

            </span>
            </div>
          </div>
        </div>
        <div class="item">
          <div class="name">
            Current Number of Exchange Tokens
          </div>
          <div class="value-box">
            <img class="icon" src="../assets/sub-icon.png" alt="">
            <div class="value">
              {{ token2Balance }} <span>
                   {{ exchangeInfo.name2 }}
            </span>
            </div>
          </div>
        </div>
      </div>
      <div class="btn-box">
        <div class="rainbow-button" @click="isShowExchangeDialog= true">
          EXCHANGE
        </div>
        <div class="rainbow-button" @click="isShowWithdrawDialog= true">
          WITHDRAW
        </div>
      </div>
    </div>
    <div class="sub-title-box">
      <img class="sub-icon" src="../assets/sub-icon.png"/>
      <div class="name">
        DEPOSIT INFO
      </div>
    </div>
    <div class="deposit-info-list">
      <div class="item">
        <div class="name">
          Token Exchange Factory Address
        </div>
        <div class="value">
          {{ exchangeInfo.contracts }}
        </div>
      </div>
      <div class="item">
        <div class="name">
          Initial Token
        </div>
        <div class="value">
          {{ exchangeInfo.name1 }}
        </div>
      </div>
      <div class="item">
        <div class="name">
          Initial Token Contract Address
        </div>
        <div class="value">
          {{ token1Info.token }}
        </div>
      </div>
      <div class="item">
        <div class="name">
          Exchange Tokens
        </div>
        <div class="value">
          {{ exchangeInfo.name2 }}
        </div>
      </div>
      <div class="item">
        <div class="name">
          Exchange Token Contract Address
        </div>
        <div class="value">
          {{ token2Info.token }}
        </div>
      </div>
    </div>
    <div class="withdrawal-title">
      Withdrawal Records
    </div>
    <div class="rainbow-single-list">
      <div class="list-header">
        <div class="item" style="width: 50px">
          ID
        </div>
        <div class="item" style="width: 50px">
          Amount
        </div>
        <div class="item"  style="width: 400px">
          Withdrawal address
        </div>
        <div class="item"  style="width: 160px">
          Withdrawal time
        </div>

      </div>
      <div class="list-content">
        <div class="list-item" v-for="(item,index) in withdrawalList" :key="index">
          <div class="id" style="width: 50px">
            {{index}}
          </div>
          <div class="id"  style="width: 50px">
            {{item.amount}}
          </div>
          <div class="id"  style="width:  360px">
            {{item.user}}

          </div>
          <div class="id"  style="width: 160px">
            {{item.withdrawalTime}}
          </div>

        </div>
        <div class="no-data" v-show="withdrawalList.length==0">
          <img src="../assets/no-data.png" alt="">
        </div>
      </div>
    </div>
    <div class="withdrawal-title">
      Deposit Records
    </div>
    <div class="rainbow-single-list">
      <div class="list-header">
        <div class="item" style="width: 50px">
          ID
        </div>
        <div class="item" style="width: 50px">
          Amount
        </div>
        <div class="item"  style="width: 400px">
          Deposit address
        </div>
        <div class="item"  style="width: 160px">
          Deposit time
        </div>

      </div>
      <div class="list-content">
        <div class="list-item" v-for="(item,index) in exchangeList" :key="index">
          <div class="id" style="width: 50px">
            {{index}}
          </div>
          <div class="id"  style="width: 50px">
            {{item.amount}}
          </div>
          <div class="id"  style="width:  360px">
            {{item.user}}

          </div>
          <div class="id"  style="width: 160px">
            {{item.withdrawalTime}}
          </div>

        </div>
        <div class="no-data" v-show="exchangeList.length==0">
          <img src="../assets/no-data.png" alt="">
        </div>
      </div>
    </div>
  </div>

  <div class="rainbow-dialog-box" v-show="isShowWithdrawDialog">
    <div class="mask" @click="isShowWithdrawDialog=false"></div>
    <div class="rainbow-dialog">
      <div class="dialog-title">
        Withdraw
      </div>
      <div class="dialog-subtitle">
        Withdrawal Address
      </div>
      <div class="value">
        {{ token1Info.token }}
      </div>
      <div class="input-box">
        <div class="name">
          Extractable quantity
        </div>
        <div>{{ token1Balance }}</div>
      </div>
      <div class="input-box">
        <div class="name">
          Extract quantity
        </div>
        <div class="right">
          <input type="text" v-model="exchangeForm.amount"  placeholder="Enter">
          <div class="rainbow-button">
            ALL
          </div>
        </div>
      </div>

      <div class="rainbow-button withdraw-btn" @click="exchangeToken">
        WITHDRAW
      </div>
    </div>
  </div>

  <div class="rainbow-dialog-box" v-show="isShowExchangeDialog">
    <div class="mask" @click="isShowExchangeDialog=false"></div>
    <div class="rainbow-dialog">
      <div class="dialog-title">
        Exchange
      </div>
      <div class="input-box">
        <div class="name">
          Sale Token Name
        </div>
        <input type="text" placeholder="RBD">
      </div>

      <div class="input-box">
        <div class="name">
          Sale Token Amount
        </div>
        <div class="right">
          <input type="text" placeholder="Enter">
        </div>
      </div>
      <div class="input-box">
        <div class="name">
          Exchange Token Name
        </div>
        <input type="text" placeholder="RBD">
      </div>
      <div class="input-box">
        <div class="name">
          Exchange Token Amount
        </div>
        <div>{{ token1Balance }}</div>
      </div>
      <div class="input-box">
        <div class="name">
          Amount of sale tokens you want to exchange
        </div>
        <input type="text" placeholder="Enter">
      </div>
      <div class="rainbow-button withdraw-btn" @click="exchangeToken">
        EXCHANGE
      </div>
    </div>
  </div>
</div>
</template>

<script>
import {mapGetters} from "vuex"
import moment from "moment"
export default {
  name: "exchangeFactory",
  data(){
    return{
      isShowWithdrawDialog:false,
      vaultBalance:0,
      exchangeInfo:{},
      token1Balance:0,
      token2Balance:0,
      token2Info:{},
      token1Info:{},
      withdrawalList:[],
      exchangeList:[],
      isShowExchangeDialog:false,
      factoryInfo:{},
      exchangeForm:{
        token:"",
        number:1
      }
    }
  },

  computed:{
    ...mapGetters([
      'isConnected',
      'account'
    ]),
  },
  watch:{
    isConnected(){
      this.getData()
    }
  },
  created() {
    console.log( this.$route.params.factoryInfo)
    this.factoryInfo = this.$route.params.factoryInfo
    this.factoryInfo.logo =  this.factoryInfo.factoryLogo
    this.factoryInfo.name =  this.factoryInfo.factoryName
    // eslint-disable-next-line no-self-assign
    this.factoryInfo.factoryIntroduction =  this.factoryInfo.factoryIntroduction
    if(this.isConnected){
      this.getData()
    }
  },
  methods:{
    getFactoryInfo(){
      this.$store.dispatch("tokenExchangeFactory/factoryLogo").then(res=>{
        this.factoryInfo.logo = res
      })
      this.$store.dispatch("tokenExchangeFactory/factoryName").then(res=>{
        this.factoryInfo.name = res
      })
      this.$store.dispatch("tokenExchangeFactory/factoryIntroduction").then(res=>{
        this.factoryInfo.des = res
      })
    },
    balanceOf(account,coinAddress){
      return this.$store.dispatch("erc20/balanceOf",{account,coinAddress})
    },
    exchangeToken(){
      this.exchangeForm.token = this.token1Info.token
      this.$store.dispatch("tokenExchangeFactory/exchangeToken",this.exchangeForm).then(res=>{
        console.log(res)
        this.isShowWithdrawDialog = false
        this.getData()
      })
    },
    getUserinfo(){
      this.$store.dispatch("tokenExchangeFactory/userinfo").then(res=>{
        console.log(res)
        this.withdrawalList = res
      })
    },
    getToken1Info(){
      this.$store.dispatch("tokenExchangeFactory/Token1Info").then(async res=>{
        console.log(res)
        this.token1Info = res
        this.token1Balance = await this.balanceOf(this.exchangeInfo.contracts, res.token)
        console.log(this.token2Balance)
      })
    },
     getToken2Info(){
      this.$store.dispatch("tokenExchangeFactory/Token2Info").then(async res=>{
        console.log(res)
        this.token2Info = res
        this.token2Balance = await this.balanceOf(this.exchangeInfo.contracts, res.token)

      })
    },
    async getData(){
      this.getFactoryInfo()
      await this.poollist2()
      this.getToken1Info()
      this.getToken2Info()
      this.getWithdrawList()
      this.getExchangeList()
      setTimeout(()=>{
        this.withdrawalList.sort((a,b)=>{
          return a.time - b.time
        })
        this.exchangeList.sort((a,b)=>{
          return a.time - b.time
        })
      },3000)
    },
    joinVault(){

    },
    getExchangeList(){
      this.exchangeList = []
      this.$store.dispatch("tokenExchangeFactory/index3").then(length=>{
        for (let i =0;i<length;i++){
          this.list6(i)
        }

      })
    },
    getWithdrawList(){
      this.withdrawalList = []
      this.$store.dispatch("tokenExchangeFactory/index2").then(length=>{
        for (let i =0;i<length;i++){
          this.list3(i)
        }

      })
    },
    list3(index){
      this.$store.dispatch("tokenExchangeFactory/list3",{param0:index}).then(res=>{
        console.log(res)
        res.time = res.withdrawalTime
        res.withdrawalTime = moment( parseInt(res.depositTime)*1000).format('MMMM Do YYYY, h:mm:ss a');
        this.exchangeList.push(res)
      })
    },
    list6(index){
      this.$store.dispatch("tokenExchangeFactory/list6",{param0:index}).then(res=>{
        res.time = res.withdrawalTime
        res.withdrawalTime = moment( parseInt(res.withdrawalTime)*1000).format('MMMM Do YYYY, h:mm:ss a');
        this.withdrawalList.push(res)
      })
    },
    async poollist2(){
      await this.$store.dispatch("tokenExchangeFactory/poollist2").then(res=>{
        console.log(res)
        this.exchangeInfo = res
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.rainbow-dialog{
  width: 700px;
  .dialog-title{
    font-size: 26px;
    font-weight: 700;
    color: #333333;
    padding-bottom: 20px;
  }
  .value{
    width: 640px;
    height: 38px;
    background: #f6f5fa;
    border: 1px solid #eaeaea;
    border-radius: 10px;
    color: #FF1F84;
    line-height: 38px;
    padding: 0 10px;
    margin-top: 10px;
  }
  .input-box{
    width: 100% !important;
    padding: 10px 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    .name{

    }
    .right{
      display: flex;
      .rainbow-button{
        width: 60px;
      }
    }
  }
  .withdraw-btn{
    margin: 60px auto 0;
    width: 300px;
    height: 50px;
  }
}
.withdrawal-title{
  font-size: 24px;
  font-weight: 700;
  color: #333333;
  line-height: 60px;
}

.exchangeFactory{
  .vault-balance{
    padding: 10px 0;
    display: flex;
    justify-content: space-between;
    .btn-box{
      display: flex;
    }
    .funds{
      display: flex;
      .item{
        width: 380px;
        height: 140px;
        background: #f6f5fa;
        border-radius: 10px;
        padding: 20px;
        margin-right: 10px;
        .name{
          width: 163px;
          font-size: 16px;
          font-weight: 500;
          text-align: left;
          color: #999999;
          line-height: 30px;
        }
        .value-box{
          display: flex;
          padding: 10px 0;
          align-items: center;
          .icon{
            width: 22px;
            height: 22px;
          }
          .value{
            padding: 0 10px;
            font-size: 26px;
            font-weight: 700;
            text-align: left;
            color: #ec1676;
            line-height: 35px;
            span{
              font-size: 20px;
            }
          }
        }
      }

    }
    .balance{
      font-size: 30px;
      font-weight: 700;
      text-align: left;
      color: #ec1676;
      line-height: 35px;
    }
    .rainbow-button{
      margin-left: 10px;
      width: 120px;
      height: 50px;
    }
  }
  .deposit-info-list{
    padding: 20px 0;
    .item{
      display: flex;
      margin-top: 10px;
      align-items: center;
      .name{
        min-width: 220px;
      }
      .value{
        width: 430px;
        height: 34px;
        padding: 0 10px;
        background: #f6f5fa;
        border-radius: 10px;
        color: #F96AAF;
        line-height: 34px;


      }
    }
  }
}
</style>
