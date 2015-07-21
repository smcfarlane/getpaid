(function(){
  angular.module('getPaid')
    .controller('ClientsCtrl', ['$state', 'Clients', function($state, Clients){
      var vm = this;

      vm.clientList = {};
      Clients.getAll
        .success(function(data){
          vm.clientList = data;
          console.log('clientList', vm.clientList);
        })
        .error(function(){
          console.log('failed to get clients')
        });
  }]);

  angular.module('getPaid')
    .controller('ClientCtrl', ['$state', 'Clients', function($state, Clients){
      var vm = this;


      
    }]);
})();