<template>
  <div class="manager rainbow-panel">
    <div class="panel-title">
      Manage
    </div>
    <div class="rainbow-single-list">
      <div class="list-header">
        <div class="item">
          ID
        </div>
        <div class="item">
          Authorized address
        </div>
        <div class="item">
          Proportion
        </div>
        <div class="item">
          pause
        </div>
        <div class="item">
          termination
        </div>
      </div>
      <div class="list-content">
        <div class="list-item" v-for="(item,index) in manageList" :key="index">
          <div class="id">
            {{item}}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "manager",
  data(){
    return{
      manageList:[]
    }
  }
}
</script>

<style scoped>

</style>
