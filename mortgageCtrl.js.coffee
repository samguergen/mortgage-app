var app = angular.module("mortgageApp", []);


mortgageCtrl = function($scope){
    console.log('in da controller');

    $scope.formData = {};

    $scope.infos = [];

    $scope.balance_progression = {'house_balance': [], 'monthly_interest': [], 'monthly_principal': []};
    $scope.bal = [[],[],[]];


    $scope.calculateNumPayments = function(){

        if ($scope.formData.mortgage_type === true){
            $scope.formData.number_of_payments = 360;
        };    
        console.log($scope.formData.number_of_payments);
        return $scope.formData.number_of_payments
    };

    $scope.calculateMortgage = function(){

        num_payments = $scope.calculateNumPayments();

        if ($scope.formData.down_type == 1){
            $scope.formData.downpayment = (($scope.formData.downpayment / 100 ) * $scope.formData.total_price)
        }
        else if($scope.formData.down_type == 2){
            $scope.formData.downpayment = $scope.formData.downpayment
        };
        
        $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment;


        nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;
        $scope.total_monthly_payment = nominator / denominator;

        return $scope.total_monthly_payment;

    };


    $scope.calculateMortgageProgression = function(){
        month_payment = $scope.calculateMortgage();

        num_payments = $scope.calculateNumPayments();

        console.log(num_payments);

        $scope.pay_index = 1;

        $scope.remaining_balance = $scope.formData.loan_amount;

        for (var x=0; x < num_payments ; x++) {

            $scope.monthly_interest = $scope.remaining_balance * ($scope.formData.annual_interest_rate / 12)/100;

            $scope.monthly_principal = month_payment - $scope.monthly_interest; 

            $scope.infos.push({
                'pay_index': $scope.pay_index,
                'leftover_balance': $scope.remaining_balance - $scope.monthly_principal,
                'month_interest': $scope.monthly_interest,
                'month_principal': $scope.monthly_principal,

        });

            $scope.remaining_balance -= $scope.monthly_principal;
            $scope.pay_index += 1;
            
        };
        
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };

  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 