var app = angular.module("mortgageApp", []);

app.service('sharedProp', function(){
    return {
        calc : function(){
            if ($scope.formData.mortgage_type === true){
                $scope.formData.number_of_payments = 360;
            };

            if ($scope.formData.down_type == "2"){
                $scope.formData.downpayment = (($scope.formData.downpayment / 100 ) * $scope.formData.total_price)
            };

            $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;

            nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
            denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;
            $scope.total_monthly_payment = nominator / denominator;
            return $scope.total_monthly_payment;
            }
        };

});

mortgageCtrl = function($scope){
    console.log('in da controller');

    $scope.formData = {};

    $scope.balance_progression = [];

    $scope.monthly_interest_rate = (($scope.formData.annual_interest_rate / 12) / 100);

    $scope.calculateMortgage = function(){      

        if ($scope.formData.mortgage_type === true){
            $scope.formData.number_of_payments = 360;
        };

        if ($scope.formData.down_type == "2"){
            $scope.formData.downpayment = (($scope.formData.downpayment / 100 ) * $scope.formData.total_price)
        };
 
        $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;

        nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;
        $scope.total_monthly_payment = nominator / denominator;
        return $scope.total_monthly_payment;

    };


    $scope.calculateMortgageProgression = function(house_balance){
        if (typeof house_balance == "undefined"){ house_balance = $scope.formData.total_price };
        console.log(house_balance);
        $scope.remaining_balance = house_balance;
        console.log('remaining/house balance is ...');
        console.log($scope.remaining_balance);
        $scope.remaining_interest = $scope.remaining_balance * ($scope.formData.annual_interest_rate / 12);
        console.log('remaining interest is ...');
        console.log($scope.remaining_interest);
        pay = $scope.calculateMortgage();
        console.log('monthly payment is ...');
        console.log(pay);
        $scope.remaining_balance =  pay - $scope.remaining_interest; 
        console.log($scope.remaining_balance);

        if ($scope.remaining_balance > 0){
            console.log('before recursion ...');
            $scope.calculateMortgageProgression($scope.remaining_balance);
            console.log('after recursion ...');
            console.log($scope.remaining_balance);
            }
        else{
            console.log('finish!');
            return $scope.remaining_balance};
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };

  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 