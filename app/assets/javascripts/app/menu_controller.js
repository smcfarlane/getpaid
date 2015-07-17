(function(){
  angular.module('getPaid').controller('MenuCtrl', [function(){
    var vm = this;
    vm.menuItems = {
      guest: [
              [
                ['Home', 'home'],
                ['About', 'about'],
                ['Features', 'features']
              ],
              [
                ['Sign In', 'auth.sign_in'],
                ['Sign Up', 'auth.sign_up']
              ]
             ],
      login: [['Clients & Vendors', 'Projects', 'Invoices'], ['Manage User', 'Reports'], ['Sign out']]
    }
  }]);
})();