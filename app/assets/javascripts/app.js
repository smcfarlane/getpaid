(function(){
  angular.module('getPaid', ['templates', 'ui.router', 'ngAnimate', 'ngMaterial'])
    .config(function($mdThemingProvider) {
      $mdThemingProvider.theme('default')
      .primaryPalette('light-blue')
      .accentPalette('amber')
      .warnPalette('red')
      .backgroundPalette('grey');
  })
  .config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('home', {
        url: "/",
        templateUrl: "guest_home.html",
        controller: function() {
          console.log('home route');
        }
      })
      .state('about', {
        url: "/about",
        templateUrl: "guest_about.html",
        controller: function() {
          console.log('about route');
        }
      })
      .state('features', {
        url: "/features",
        templateUrl: "guest_features.html",
        controller: function() {
          console.log('features route');
        }
      })
    });
})();
