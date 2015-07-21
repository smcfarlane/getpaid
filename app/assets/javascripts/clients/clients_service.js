(function(){
  angular.module('getPaid').factory('Clients', ['$resource', '$http', function($resource, $http){
    var resource = $resource('clients/:id', null, {
      update: {method: 'PUT'}
    });

    var getAll = $http.get('/clients');

    return {
      resource: resource,
      getAll: getAll
    };
  }]);
})();