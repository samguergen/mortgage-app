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

    $scope.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;

    $scope.monthly_interest_rate = (($scope.formData.annual_interest_rate / 12) / 100);

    $scope.calculateMortgage = function(){

        console.log($scope.formData.down_type);      

        if ($scope.formData.mortgage_type === true){
            $scope.formData.number_of_payments = 360;
        };

        if ($scope.formData.down_type == 1){
            $scope.formData.downpayment = (($scope.formData.downpayment / 100 ) * $scope.formData.total_price)
        }
        else if($scope.formData.down_type == 2){
            $scope.formData.downpayment = $scope.formData.downpayment
        };
        console.log('total price is ');
        console.log($scope.formData.total_price);
        console.log('downpayment is ');
        console.log($scope.formData.downpayment);
        
        $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;
        console.log('loan amount is ');
        console.log($scope.formData.loan_amount);

        nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;
        $scope.total_monthly_payment = nominator / denominator;
        console.log('total monthly pay is ');
        console.log($scope.total_monthly_payment);
        return $scope.total_monthly_payment;

    };


    $scope.calculateMortgageProgression = function(house_balance){
        month_payment = $scope.calculateMortgage();
        console.log('monthly payment is ...');
        console.log(month_payment);
        if (typeof house_balance == "undefined"){ house_balance = $scope.formData.loan_amount };
        $scope.remaining_balance = house_balance;
        if ($scope.remaining_balance > 0){
            console.log('house balance/total loan is ...');
            console.log($scope.remaining_balance);
            $scope.monthly_interest = $scope.remaining_balance * ($scope.formData.annual_interest_rate / 12)/100;
            console.log('monthly interest is ...');
            console.log($scope.monthly_interest);
            $scope.monthly_principal = month_payment - $scope.monthly_interest; 
            console.log('monthly principal is...');
            console.log($scope.monthly_principal);
            $scope.remaining_balance = $scope.remaining_balance - $scope.monthly_principal;
            console.log('before recursion');
            $scope.calculateMortgageProgression($scope.remaining_balance);
        };
        return $scope.remaining_balance;
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };

  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 