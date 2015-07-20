(function(){
  angular.module('getPaid', ['templates', 'ui.router', 'ipCookie', 'ng-token-auth', 'ngResource', 'ngAnimate', 'ngMaterial'])
    .config(function($mdThemingProvider) {
      $mdThemingProvider.theme('default')
      .primaryPalette('teal',{
          'default': '400', // by default use shade 400 from the teal palette for primary intentions
          'hue-1': '100', // use shade 100 for the <code>md-hue-1</code> class
          'hue-2': '600', // use shade 600 for the <code>md-hue-2</code> class
          'hue-3': 'A100' // use shade A100 for the <code>md-hue-3</code> class
        })
      .accentPalette('blue-grey', {
          'default': '200' // use shade 200 for default, and keep all other shades the same
        })
      .warnPalette('red')
      .backgroundPalette('grey');
  })
  .config(function($authProvider) {
    $authProvider.configure({
      apiUrl: 'http://localhost:3000'
    });
  })
  .config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('guest',{
        templateUrl: "guest/guest.html",
        controller: function() {
          console.log('home route');
        }
      })
      .state('guest.home', {
        url: "/",
        templateUrl: "guest/home.html",
        controller: function() {
          console.log('home route');
        }
      })
      .state('guest.about', {
        url: "/about",
        templateUrl: "guest/about.html",
        controller: function() {
          console.log('about route');
        }
      })
      .state('guest.features', {
        url: "/features",
        templateUrl: "guest/features.html",
        controller: function() {
          console.log('features route');
        }
      })

      .state('auth', {
        url: '/auth',
        templateUrl: 'auth/auth.html'
      })
      .state('auth.sign_up', {
        url: '/auth/sign_up',
        templateUrl: 'auth/sign_up.html',
        controller: 'SignUpCtrl as vm'
      })
      .state('auth.sign_in', {
        url: 'auth/sign_in',
        templateUrl: 'auth/sign_in.html',
        controller: 'SignInCtrl as vm'
      })

      .state('a', {
        url: '/a',
        abstract: true,
        template: '<ui-view/>',
        resolve: {
          auth: function ($auth) {
            return $auth.validateUser();
          }
        }
      })

      .state('a.dashboard',{
        url: '/dashboard',
        templateUrl: 'dashboard/index.html',
        controller: 'DashboardCtrl as vm'
      })

      .state('a.clients', {

      })
    });
})();
