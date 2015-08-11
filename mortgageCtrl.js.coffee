var app = angular.module("mortgageApp", []);


mortgageCtrl = function($scope){
    console.log('in da controller');

    $scope.formData = {};


    $scope.monthly_interest_rate = (($scope.formData.annual_interest_rate / 12) / 100);

    $scope.calculateMortgage = function(){

        $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;

        nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;
        $scope.total_monthly_payment = nominator / denominator;
        $scope.total_monthly_interest = $scope.total_monthly_payment - ($scope.formData.total_price / $scope.formData.number_of_payments);
        $scope.total_monthly_principal = $scope.total_monthly_payment - $scope.total_monthly_interest;
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };

  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 