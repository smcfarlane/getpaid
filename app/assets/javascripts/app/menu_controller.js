(function(){
  angular.module('getPaid').controller('MenuCtrl', ['$auth', '$rootScope', '$state', function($auth, $rootScope, $state){
    var vm = this;
    vm.checkAuthStatus = function(){
      console.log('The user is?', $auth.validateUser());
    };
    vm.menuItems = {
      guest: [
              [
                ['Home', 'guest.home'],
                ['About', 'guest.about'],
                ['Features', 'guest.features']
              ],
              [
                ['Sign In', 'auth.sign_in'],
                ['Sign Up', 'auth.sign_up']
              ]
             ],
      login: [
               [
                 ['Clients & Vendors', 'orgs.index'],
                 ['Projects', 'projects.index'],
                 ['Invoices', 'invoices.index']
               ],
               [
                 ['Manage User', 'users.index'],
                 ['Reports', 'reports.index']
               ]
             ]
    };

    vm.showSignOut = false;

    vm.menu = vm.menuItems.guest;

    vm.signOut = function(){
      $auth.signOut()
        .then(function(resp){
          console.log('Sign Out Successful', resp);
          vm.showSignOut = false;
          vm.menu = vm.menuItems.guest;
          $state.go('guest.home');
        })
        .catch(function(resp){
          console.log('Sign Out Failed', resp);
        });
    };

    $rootScope.$on('auth:validation-success', function(e, user){
      console.log('auth:validation-success event');
      vm.menu = vm.menuItems.login;
      vm.showSignOut = true;
    });

    $rootScope.$on('auth:login-success', function(e, user){
      console.log('auth:login-success event');
      vm.menu = vm.menuItems.login;
      vm.showSignOut = true;
    });
  }]);
})();