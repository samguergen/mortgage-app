var app = angular.module("mortgageApp", ["highcharts-ng"]);


mortgageCtrl = function($scope){
    console.log('in da controller');

    $scope.formData = {};

    $scope.infos = [];


    $scope.calculateNumPayments = function(){

        if ($scope.formData.mortgage_type === true){
            $scope.formData.number_of_payments = 360;
        };    
        return $scope.formData.number_of_payments
    };

    $scope.calculateMortgage = function(){

        num_payments = $scope.calculateNumPayments();

        if ($scope.formData.down_type == 1){
            $scope.formData.loan_amount = $scope.formData.total_price - (($scope.formData.downpayment / 100 ) * $scope.formData.total_price)
        }
        else if($scope.formData.down_type == 2){
            $scope.formData.loan_amount = $scope.formData.total_price - $scope.formData.downpayment
        };
        

        monthly_payment_nominator = ((($scope.formData.annual_interest_rate / 12) / 100) * $scope.formData.loan_amount * (Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments)));
        monthly_payment_denominator =  Math.pow((1+ (($scope.formData.annual_interest_rate / 12) / 100)), $scope.formData.number_of_payments) -1;

        $scope.total_monthly_payment = monthly_payment_nominator / monthly_payment_denominator;

        return $scope.total_monthly_payment;

    };


    $scope.calculateMortgageProgression = function(){
        month_payment = $scope.calculateMortgage();

        num_payments = $scope.calculateNumPayments();

        remaining_balance = $scope.formData.loan_amount;

        for (var x=0; x < num_payments ; x++) {

            monthly_interest = remaining_balance * ($scope.formData.annual_interest_rate / 12)/100;

            monthly_principal = month_payment - monthly_interest; 

            $scope.infos.push({
                'pay_index': x+1,
                'leftover_balance': remaining_balance - monthly_principal,
                'month_interest': monthly_interest,
                'month_principal': monthly_principal,
        });

            remaining_balance -= monthly_principal;
           
        };

        $scope.addSeries($scope.infos.pay_index);


        console.log($scope.infos[3].leftover_balance);
    
        for (var i=0; i< $scope.infos.length; i++){
            console.log($scope.infos[i].month_principal);
            $scope.addSeries(($scope.infos[i].month_principal));
            
        }
        
    };

    
    $scope.reset = function(){
        $scope.formData = "";
    };


    $scope.returnData = function(){

    };


    $scope.chartConfig = {
        options: {
            chart: {
                type: 'area'
            }
        },
        series: [{
            // data: [10, 15, 12, 8, 7]
            data: $scope.infos.leftover_balance
        }],
        title: {
            text: 'Cumulative Principal and Interest Payments Chart'
        },

        loading: false
    };

    $scope.addSeries = function(info){
        $scope.chartConfig.series.push({
            data: info
        })

};



  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 