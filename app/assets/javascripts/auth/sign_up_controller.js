(function(){
  angular.module('getPaid')
    .controller('SignUpCtrl', ['$auth', '$state', function($auth, $state){
      var vm = this;

      vm.registrationForm = {email: '', password: '', password_confirmation: ''};

      vm.handleRegBtnClick = function() {
        console.log(vm.registrationForm);
        $auth.submitRegistration(vm.registrationForm)
          .then(function(resp) {
            console.log('User Sign Up Success', resp);
            vm.signInUser();
            // handle success response
          })
          .catch(function(resp) {
            console.log('User Sign Up Fail', resp);
            // handle error response
          });
      };

      vm.signInUser = function() {
        $auth.submitLogin({email: vm.registrationForm.email, password: vm.registrationForm.password})
          .then(function(resp) {
            console.log('User Sign In Success', resp);
            $state.go('a.user.new');
            // handle success response
          })
          .catch(function(resp) {
            console.log('User Sign In Fail', resp);
            // handle error response
          });
      };
  }])
})();