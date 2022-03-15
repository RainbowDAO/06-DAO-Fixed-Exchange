<template>
  <div class="createExchange rainbow-panel">
    <div class="panel-title">
      Token Exchange Factory
    </div>
    <div class="sub-title">
      Create a Token Factory
    </div>
    <div class="progress-box">
      <div class="item animate__animated animate__fadeIn" :class="{'active':activeIndex>=0}">
        1
      </div>
      <div class="item animate__animated animate__fadeIn" :class="{'active':activeIndex>=1}">
        2
      </div>
      <div class="item animate__animated animate__fadeIn" :class="{'active':activeIndex>=2}">
        3
      </div>
      <div class="item animate__animated animate__fadeIn" :class="{'active':activeIndex>=3}">
        4
      </div>
    </div>
    <div class="step1 animate__animated animate__fadeIn" v-show="activeIndex==0">
      <div class="sub-title">
        Basic Information
      </div>

      <div class="input-box">
        <div class="name">
          Factory Name
        </div>
        <input type="text" placegolder="Name" v-model="factoryForm.name">
      </div>
      <div class="input-box">
        <div class="name">
          Factory Logo
        </div>
        <input type="text" placegolder="Enter" v-model="factoryForm.logo">
      </div>
      <div class="input-box">
        <div class="name">
          Factory Introduction
        </div>
        <input type="text" placegolder="Enter" v-model="factoryForm.info">
      </div>


      <div class="tip">
        In this token exchange factory, only one-way exchange is supported. (For example: there is an initial token RRB
        in the exchange pool. According to the agreement of the creator of the exchange pool, only RRA is allowed to
        exchange for RHC. The exchanger can only exchange the RRB in his wallet for the RRA in the pool, and cannot
        exchange RRA for the RRA in the pool. RRB)
      </div>
      <div class="tip" style="display: flex;align-items: center;user-select: none" @click="isChecked=!isChecked">
        <input type="checkbox" v-model="isChecked"> I have understood
      </div>

      <div class="rainbow-button next-btn" @click="next">
        NEXT
      </div>
    </div>
    <div class="step2 animate__animated animate__fadeIn" v-show="activeIndex==1">
      <div class="sub-title">
        Token Settings
      </div>
      <div class="step2-content">
        <div class="left">
          <div class="input-box">
            <div class="name">
              Initial exchange pool token contract address
            </div>
            <input type="text" placeholder="address" v-model="tokenForm._token1">
          </div>
          <div class="input-box">
            <div class="name">
              Token Name
            </div>
            <input type="text" v-model="tokenForm._name1" placeholder="ABT">
          </div>
          <div class="input-box">
            <div class="name">
              Token Symbol
            </div>
            <input type="text" v-model="tokenForm._symbol1" placeholder="ABT">
          </div>
          <div class="input-box">
            <div class="name">
              Circulation
            </div>
            <input type="text" v-model="tokenForm._circulation1" placeholder="100,000,000">
          </div>
        </div>
        <div class="right">
          <div class="input-box">
            <div class="name">
              Initial exchange pool token contract address
            </div>
            <input type="text" placeholder="address" v-model="tokenForm._token2">
          </div>
          <div class="input-box">
            <div class="name">
              Token Name
            </div>
            <input type="text" placeholder="ABT" v-model="tokenForm._name2">
          </div>
          <div class="input-box">
            <div class="name">
              Token Symbol
            </div>
            <input type="text" placeholder="ABT" v-model="tokenForm._symbol2">
          </div>
          <div class="input-box">
            <div class="name">
              Circulation
            </div>
            <input type="text" placeholder="100,000,000" v-model="tokenForm._circulation2">
          </div>
        </div>
      </div>
      <div class="button-box">
        <div class="rainbow-button next-btn" @click="activeIndex--">
          BACK
        </div>
        <div class="rainbow-button next-btn" @click="next">
          NEXT
        </div>
      </div>
    </div>
    <div class="step3 animate__animated animate__fadeIn" v-show="activeIndex==2">
      <div class="sub-title">
        Exchange Settings
      </div>
      <div class="select-box">
        <div class="select-title">
          Set exchange rate
        </div>
        <select v-model="exchangeForm.number" @change="getSelected">
          <option selected value="1"> The exchange rate of the agreed amount</option>
          <option value="2"> Depositor's Authorization to Claim</option>
        </select>
      </div>
      <div v-show="exchangeForm.number==1">
        <div class="exchange-input-box">
          <div class="left">
            <div class="name">
              Initial Token
            </div>
            <div class="symbol">
              ETH
            </div>
            <input type="text" v-model="exchangeForm.token1">
          </div>
          <div class="right">
            <div class="name">
              Exchange Token
            </div>
            <div class="symbol">
              BTC
            </div>
            <input type="text" v-model="exchangeForm.token2">
          </div>
        </div>
        <div class="tip">
          rates:{{ parseInt(exchangeForm.token1 / exchangeForm.token2) }}
        </div>
        <div class="tip">
          Regardless of the actual market value of the two tokens, a fixed exchange ratio is directly agreed. Once
          determined, the ratio cannot be changed.
        </div>
      </div>
      <div v-show="exchangeForm.number==2">
        <div class="methods">
          <div class="inline">
            <div class="radio">
              <input type="radio" value="1" v-model="rateMethod"/>
              All use the price of the oracle to determine the exchange ratio
            </div>
          </div>
        </div>
        <div class="methods">
          <div class="inline">
            <input type="radio" value="2" v-model="rateMethod"/>
            The tokens in the initial exchange pool use the price of the oracle machine, and the tokens are exchanged
            for the specified price.
          </div>
          <div class="inline">
            Exchange token price <input class="input" type="text">
          </div>
        </div>
        <div class="methods">
          <div class="inline">
            <div class="radio">
              <input type="radio" value="2" v-model="rateMethod"/>
              The tokens in the initial exchange pool specify the price, and the exchange tokens use the oracle price.
            </div>
          </div>
          <div class="inline">
            Token price in the initial exchange pool <input class="input" type="text">
          </div>
        </div>
        <div class="methods">
          <div class="inline">
            <div class="radio">
              <input type="radio" value="2" v-model="rateMethod"/>
              All specified prices.
            </div>
          </div>
          <div class="inline">
            Exchange token price<input class="input" type="text">
          </div>
          <div class="inline">
            Token price in the initial exchange pool<input class="input" type="text">
          </div>
        </div>
      </div>

      <div class="input-box">
        <div class="name">
          <strong>
            Release period
          </strong>
        </div>
        <input style="width: 100px;margin-right: 10px" type="text" v-model="exchangeForm._releasePeriod">Months
      </div>
      <div class="tip">
        Regardless of the actual market value of the two tokens, a fixed exchange ratio is directly agreed. Once
        determined, the ratio cannot be changed.
      </div>
      <div class="sub-title">
        Exchange to Receive
      </div>
      <div class="select-box">
        <div class="select-title">
          Collection Method
        </div>
        <select v-model="isLock" @change="getSelected">
          <option selected value="0"> No limit, get it directly</option>
          <option value="1"> Specify the lock-up period.</option>
        </select>
      </div>
      <div class="lock-info-box" v-show="isLock==1">
        <div class="part1">
          1. Total closure period:
          <input type="text" v-model="exchangeForm._closePeriod"> <span style="margin: 0 10px">Months.</span>
          Not withdrawn during the full closure period.
        </div>
        <!--        <div class="part2">-->
        <!--          2. Release ratio per month (30 days) during the release period:-->
        <!--          <input type="text">-->
        <!--        </div>-->
        <div class="tip">
          Release period is 12 months
        </div>
        <div class="part3">
          Whether to release by day:
          <label class="switch">
            <input type="checkbox" v-model="isChooseDay">
            <div class="slider round"></div>
          </label>
          Release 1% per day
        </div>
      </div>
      <div class="button-box">
        <div class="rainbow-button next-btn" @click="activeIndex--">
          BACK
        </div>
        <div class="rainbow-button next-btn" @click="next">
          NEXT
        </div>
      </div>
    </div>
    <div class="step4" v-show="activeIndex==3">
      <div class="sub-title">
        Inject tokens
      </div>
      <div class="input-box">
        <div class="name">
          Inject tokens
        </div>
        <div class="input">{{ tokenForm._name2 }}</div>
      </div>
      <div class="input-box">
        <div class="name">
          Wallet Balance
        </div>
        <div class="input">{{ myBalance }}</div>
      </div>
      <div class="input-box">
        <div class="name">
          The amount injected into the exchange pool
        </div>
        <input type="text" v-model="injectNumber">
      </div>
      <div class="button-box">
        <div class="rainbow-button next-btn" @click="activeIndex--">
          BACK
        </div>
        <div class="rainbow-button next-btn" @click="approve">
          Approve
        </div>
        <div class="rainbow-button next-btn" @click="injectToken">
          COMPLETE
        </div>
      </div>

    </div>
  </div>
</template>

<script>
import abiUtil from "../abi/index.js"
import {mapGetters} from "vuex";

export default {
  name: "createExchange",
  data() {
    return {
      myBalance: 0,
      injectNumber: 0,
      rateMethod: 1,
      recipientList: [{}],
      isChooseDay: false,
      tokenForm: {},
      activeIndex: 0,
      selectIndex: 0,
      isLock: 0,
      recipientNumber: 1,
      factoryForm: {},
      exchangeForm: {
        way: 0,
        number: 1,
        rates: 1,
        _closePeriod: 0,
        chooseDay: 3
      },
      isChecked: false
    }
  },
  computed: {
    ...mapGetters([
      'isConnected',
      'account'
    ]),
  },
  methods: {
    approve() {
      this.$store.dispatch("erc20/approve", {
        spender: abiUtil.getContractAddress("TokenExchangeFactory"),
        amount: "1000000000000000000000000000000",
        coinAddress: this.tokenForm._token2
      })
    },
    injectToken() {
      this.$store.dispatch("tokenExchangeFactory/deposit", {
        amount: this.injectNumber,
        token2: this.tokenForm._token2
      }).then(() => {
        this.$router.push({name: 'home'})
      }).catch((err) => {
        alert(err)
      })
    },
    addToken() {
      this.$store.dispatch("tokenExchangeFactory/addToken", {
        ...this.tokenForm,
      }).then(res => {
        console.log(res)
        this.activeIndex++
      }).catch((err) => {
        alert(err)
      })
    },
    setExchangeRate() {
      if (this.isLock == 1) {
        if (this.isChooseDay) {
          this.exchangeForm.chooseDay = 2
        }
      }
      if (this.exchangeForm.number == 1) {
        this.exchangeForm.way = 0
      }

      this.exchangeForm.rates = parseInt(this.exchangeForm.token1 / this.exchangeForm.token2)
      this.$store.dispatch("tokenExchangeFactory/setExchangeRate", {
        ...this.exchangeForm,
      }).then(res => {
        console.log(res)
        this.activeIndex++
      }).catch((err) => {
        alert(err)
      })
    },
    cteateFactory() {
      this.$store.dispatch("tokenExchangeFactory/cteateFactory", this.factoryForm).then(res => {
        console.log(res)
        this.activeIndex++
      }).catch((err) => {
        alert(err)
      })
    },
    next() {
      if (this.activeIndex == 0) {
        this.cteateFactory()
      } else if (this.activeIndex == 1) {
        this.addToken()
      } else if (this.activeIndex == 2) {
        this.balanceOf()
        this.setExchangeRate()
      } else {
        this.activeIndex++
      }
    },
    balanceOf() {
      return this.$store.dispatch("erc20/balanceOf", {
        account: this.account,
        coinAddress: this.tokenForm._token2
      }).then(res => {
        this.myBalance = res
      })
    },
    getSelected() {

    },
    addAddr() {
      this.recipientNumber++
      this.recipientList.push({})
    }
  }
}
</script>

<style lang="scss" scoped>
.button-box {
  display: flex;

  .rainbow-button {
    margin-right: 20px;
  }
}

.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.input-box {
  .input {
    width: 300px;
    height: 36px;
    line-height: 36px;
    background: #f6f5fa;
    border: 1px solid #eaeaea;
    border-radius: 10px;
    padding: 0 10px;
  }
}

.inline {
  width: 500px;
  justify-content: space-between;
  padding: 10px 0;
  display: flex;
  align-items: center;

  .input {
    width: 243px;
    height: 36px;
    background: #f6f5fa;
    border: 1px solid #eaeaea;
    border-radius: 10px;
    padding: 0 6px;
  }
}

.switch input {
  display: none;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

.inline {
  display: flex;
  margin-top: 10px;

  .name {
    min-width: 300px;
  }
}

.lock-info-box {
  input {
    width: 80px;
    height: 38px;
    background: #f6f5fa;
    border: 1px solid #eaeaea;
    border-radius: 10px;
  }

  .part1, .part2, .part3 {
    padding: 10px 0;
    display: flex;
    align-items: center;
  }
}

.exchange-input-box {
  display: flex;
  justify-content: space-between;
  width: 400px;
  padding: 20px 0;

  .name {
    font-size: 14px;
  }

  .symbol {
    line-height: 30px;
    font-weight: bold;
  }

  .right {
    text-align: right;
  }

  input {
    width: 160px;
    height: 38px;
    background: #f6f5fa;
    border: 1px solid #eaeaea;
    border-radius: 10px;
    text-align: center;
  }
}

.step2-content {
  width: 1000px;
  display: flex;
  justify-content: space-between;

  .left, .right {
    width: 50%;
  }

  .input-box {
    width: 100%;
  }
}

.address-box {

  .address-list {
    .item {
      display: flex;
      padding: 10px 0;

      input {
        width: 100%;
        height: 50px;
        background: #f6f5fa;
        border: 1px solid #eaeaea;
        border-radius: 10px;
        padding: 0 10px;
      }

      .address {
        width: 446px;
      }

      .ratio {
        margin-left: 10px;
        width: 184px;
      }

      .add-btn {
        width: 60px;
        height: 36px;
      }
    }
  }
}

.next-btn {
  margin-top: 100px;
  width: 200px;
  height: 42px;
}

.tip {
  margin-top: 30px;
  width: 640px;
  opacity: 0.6;
  font-size: 14px;
  font-weight: 500;
  text-align: justify;
  color: #ff1f84;
  line-height: 24px;
}

p {
  width: 640px;
}

.sub-title {
  font-size: 24px;
  font-weight: 500;
  text-align: left;
  color: #333333;
  line-height: 38px;
}

.value {
  margin-top: 10px;
  width: 640px;
  padding: 8px 10px;
  background: rgba(255, 31, 132, 0.10);
  border-radius: 10px;
  line-height: 26px;
  color: #FF1F84;
}

.progress-box {
  display: flex;
  padding: 30px 0;

  .item {
    margin-right: 66px;
    position: relative;
    width: 30px;
    height: 30px;
    background: linear-gradient(135deg, #12c2e9, #c471ed 53%, #f64f59);
    -webkit-background-clip: text;
    color: transparent;
    border: 1px solid rgba(255, 31, 132, 0.20);
    border-radius: 50%;
    text-align: center;
    line-height: 30px;
    font-weight: bold;

    &:after {
      content: '';
      width: 60px;
      height: 1px;
      background: #FF1F84;
      position: absolute;
      top: 50%;
      left: 32px;
    }

    &.active {
      background: linear-gradient(135deg, #12c2e9, #c471ed 53%, #f64f59);
      color: #fff;
    }
  }

  .item:last-child {
    margin-right: 0;

    &:after {
      visibility: hidden;
    }
  }
}
</style>
