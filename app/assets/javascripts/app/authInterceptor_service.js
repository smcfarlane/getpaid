(function() {
  angular.module('getPaid').factory('authInterceptor', ['$q', 'ipCookie', '$location', '$window', function ($q, ipCookie, $location, $window) {
    return {
      request: function (config) {
        var authVars = JSON.parse($window.localStorage.getItem('auth_headers'));
        config.headers = config.headers || {};
        if (authVars) {
          config.headers['access-token'] = authVars['access-token'];
          config.headers['client'] = authVars['client'];
          config.headers['expiry'] = authVars['expiry'];
          config.headers['uid'] = authVars['uid'];
        }
        return config;
      },
      responseError: function (response) {
        if (response.status === 401) {
          $location.path('/login');
          ipCookie.remove('access-token');
        }
        return $q.reject(response);
      }
    };
  }]);
})();