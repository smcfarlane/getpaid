(function(){
  angular.module('getPaid').controller('AppCtrl', ['$mdSidenav', function(){
    var vm = this;
    vm.menuItems = ['Home', 'About', 'Features', 'Clients & Vendors', 'Projects', 'Invoices', 'Sign In', 'Sign Up'];
  }]);
})();


