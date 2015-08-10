app = angular.module "mortgageApp"

app.controller "MortgageCtrl" , ['$scope', '$http', '$window', mortgageCtrl]

mortgageCtrl ($scope, $http, $window) ->

	$scope.empty = {}
	
	$scope.reset = ->
		$scope.user = angular.copy($scope.empty)


	$scope.calculateMortgage = (user) ->
		$scope.empty = angular.copy(user)