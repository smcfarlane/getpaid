(function(){
  angular.module('getPaid')
    .controller('SignInCtrl', ['$auth', '$state', function($auth, $state){
      var vm = this;
      vm.loginForm = {email: '', password: ''};

      vm.handleLoginBtnClick = function() {
        $auth.submitLogin(vm.loginForm)
          .then(function(resp) {
            console.log('User Sign In Success', resp);
            $state.go('a.dashboard');
            // handle success response
          })
          .catch(function(resp) {
            console.log('User Sign In Fail', resp);
            // handle error response
          });
      };
    }])
})();