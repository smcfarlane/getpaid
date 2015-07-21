(function(){
  angular.module('getPaid').controller('UserCtrl', ['User', '$http', '$state', function(User, $http, $state){
    var vm = this;

    vm.newUser = {account_id: User.currentAccount.id};

    vm.clickSubmitNewUser = function(){
      vm.newUser.account_id = User.currentAccount.id;
      $http.post('/users', vm.newUser)
        .success(function(){
          $state.go('a.user.yourOrg');
          User.currentUser.firstName = vm.newUser.first_name;
          User.currentUser.lastName = vm.newUser.last_name;
        })
        .error(function(data, status, headers, config){
          console.log(status, headers, config);
        });
    };

    vm.yourOrg = {partner_type: 'your organization'};

    vm.clickSubmitYourOrg = function(){
      $http.post('/organizations', vm.yourOrg)
        .success(function(data){
          User.currentUserOrg = data;
          $state.go('a.dashboard');
        })
        .error(function(data, status, headers, config){
          console.log(status, headers, config);
        })
    }

  }]);
})();