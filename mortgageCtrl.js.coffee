var app = angular.module("mortgageApp", ["highcharts-ng"]);


mortgageCtrl = function($scope){
    console.log('in da controller');

    $scope.formData = {};

    $scope.infos = [];

    $scope.cumulative_infos = [];


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



        $scope.cumulative_infos = $scope.infos;

        for (var i=1; i< num_payments; i++){
            $scope.cumulative_infos[i].month_interest = $scope.cumulative_infos[i].month_interest + $scope.cumulative_infos[i-1].month_interest;
            $scope.cumulative_infos[i].month_principal = $scope.cumulative_infos[i].month_principal + $scope.cumulative_infos[i-1].month_principal;
            $scope.cumulative_infos[i].leftover_balance = $scope.cumulative_infos[i].leftover_balance + $scope.cumulative_infos[i-1].leftover_balance;                        
            console.log($scope.cumulative_infos[i].month_interest);             
        };



        
        for (var i=0; i< num_payments; i++){
            $scope.addPointInterest(i, $scope.cumulative_infos[i].month_interest );
            $scope.addPointPrincipal(i, $scope.cumulative_infos[i].month_principal );
        };

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
            name: "Cumulative Interest",
            data: []
        },
        {
            name: "Cumulative Principal",
            data: []
        }

        ],
        title: {
            text: 'Cumulative Principal and Interest Payments Chart'
        },

        loading: false
    };

    $scope.addPointInterest = function (pay_index, info_array) {
        var seriesArray = $scope.chartConfig.series
        console.log('info_array parameter is ');
        console.log(info_array);
        console.log('Series array[0] inside addPointer is ');
        console.log(seriesArray[0]);     

        seriesArray[0].data = seriesArray[0].data.concat(info_array);

        console.log('Series array[0].data inside addPointer is ');
        console.log(seriesArray[0].data);
    };


    $scope.addPointPrincipal = function (pay_index, info_array) {
        var seriesArray = $scope.chartConfig.series   

        seriesArray[1].data = seriesArray[1].data.concat(info_array);

        // console.log('Series array[0].data inside addPointer is ');
        // console.log(seriesArray[0].data);
    };


  }


 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 