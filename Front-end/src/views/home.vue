<template>
  <div class="home rainbow-panel">
    <div class="panel-title">
      Exchange Pool
      <div class="rainbow-button" @click="$router.push({name:'createExchange'})">
        CREATE
      </div>
    </div>
    <div class="sub-title-box">
      <div class="sub-icon">
        <img src="../assets/sub-icon.png" alt="">
      </div>
      <div class="name">
        My Pool
      </div>
      <div class="number">
        {{ vaultList.length }}
      </div>
    </div>
    <vaultList :vault-list="vaultList" @chooseItem="toDetail"></vaultList>
    <div class="sub-title-box">
      <img class="sub-icon" src="../assets/sub-icon.png" alt="">

      <div class="name">
        All Pool
      </div>
      <div class="number">
        {{ vaultList.length }}
      </div>
    </div>
    <vaultList :vault-list="vaultList"></vaultList>
  </div>
</template>

<script>
import vaultList from "../components/vaultList";
import moment from "moment";
import {mapGetters} from "vuex";

export default {
  name: "home",
  components: {
    vaultList
  },
  data() {
    return {
      vaultList: []
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
    this.getData()
  },
  methods:{
    toDetail(params){
      this.$router.push({name:"exchangeFactory",params: {factoryInfo:params}})
    },
    list5(index){
      this.$store.dispatch("tokenExchangeFactory/list5",{param0:index}).then(res=>{
        console.log(res)
        res.withdrawalTime = moment( parseInt(res.withdrawalTime)*1000).format('MMMM Do YYYY, h:mm:ss a');
        this.vaultList.push(res)
      }).catch(err=>{
        console.log(err)
      })
    },
    async getData(){
      if(this.isConnected){
        this.getPoolList()
      }
    },
    getPoolList(){
      this.withdrawalList = []
      this.$store.dispatch("tokenExchangeFactory/index").then(length=>{
        console.log(length)
        for (let i =0;i<length;i++){
          this.list5(i)
        }
      })
    },
  }
}
</script>

<style lang="scss" scoped>
.home {
  .panel-title {
    display: flex;
    justify-content: space-between;
    .rainbow-button {
      width: 100px;
      height: 46px;
    }
  }
}
</style>
