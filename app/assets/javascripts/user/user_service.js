(function(){
  angular.module('getPaid').factory('User', ['$resource', function($resource){
    return {
      resource: $resource(
        'users/:id', null,{
          update: {method: 'PUT'}
        }),
      currentAccount: {},
      currentUser: {},
      currentUserOrg: {}
      }
  }]);
})();