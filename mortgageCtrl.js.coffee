var app = angular.module("mortgageApp", []);


app.service('mortgageCalc', function(){
	this.nominator = function(total_price, downpayment, annual_interest_rate, loan_amount, number_of_payments){ 
		return (monthly_interest * loan_amount * (Math.pow((1+ monthly_interest), number_of_payments)) )
	};
	this.denominator = function(total_price, downpayment, annual_interest_rate, loan_amount, number_of_payments){ 
		return ( Math.pow((1+ monthly_interest), number_of_payments) -1 ) 
	};
	this.monthly_payment = function(){return (this.nominator/this.denominator)};
});


mortgageCtrl = function($scope, $http, $window, mortgageCalc){
    console.log('in da controller');

    $scope.formData = {};

    $scope.total = {};

    $scope.nominator = function(){
        $scope.total = $scope.formData.loan_amount + $scope.formData.downpayment ;
    };

    $scope.demoninator = {};
    
    $scope.reset = function(){
        $scope.formData = "";
    };


    $scope.calculateMortgage = function(){
    	nom_answer = mortgageCalc.nominator($scope.formData.total_price, $scope.formData.downpayment, $scope.formData.annual_interest_rate, $scope.formData.loan_amount, $scope.formData.number_of_payments) ;
    	$scope.denom_answer = mortgageCalc.denominator($scope.formData.total_price, $scope.formData.downpayment, $scope.formData.annual_interest_rate, $scope.formData.loan_amount, $scope.formData.number_of_payments) ; ;
        console.log(nom_answer);
    };
  }


 app.controller("MortgageCtrl", ['$scope', '$http', '$window', 'mortgageCalc', mortgageCtrl] )











 