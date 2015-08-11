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
    $scope.nominator = {};
    $scope.denominator = {};

    $scope.monthly_interest = (($scope.formData.annual_interest_rate / 12) / 100);

    $scope.calculateMortgage = function(){
        $scope.total = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments))) / (( Math.pow(1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1 )  ;
        $scope.nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        $scope.denominator = (( Math.pow(1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1 );
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };

  }


 app.controller("MortgageCtrl", ['$scope', '$http', '$window', 'mortgageCalc', mortgageCtrl] )











 