var app = angular.module("mortgageApp", ['ui.slider','chart.js']);


mortgageCtrl = function($scope){

    console.log('in da controller');
    $scope.formData = {};
    $scope.years = [];
    $scope.num_of_payments = 360;
    $scope.formData.total_price = 0;
    $scope.formData.downpayment = 0;
    $scope.formData.annual_interest_rate = 0;

    $scope.seriesInterest = [];
    $scope.seriesPrincipal = [];
    
    $scope.yearCalc = function(){
        num_years = ($scope.num_of_payments) /12;
        startdate = new Date();
        startyear = startdate.getFullYear();
        endyear = startyear + 30;
        for (var i=startyear; i<endyear+1; i++){
            $scope.years.push(i);
        };
        return $scope.years;
    };

    $scope.calculateNumPayments = function(){

        if ($scope.formData.mortgage_type === true){
            $scope.formData.number_of_payments = $scope.num_of_payments;
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

        $scope.infos = [];
        $scope.principal_cumul_count = 0;
        $scope.interest_cumul_count = 0;

        $scope.month_payment = $scope.calculateMortgage();
        num_payments = $scope.calculateNumPayments();
        $scope.remaining_balance = $scope.formData.loan_amount;
        $scope.interest_cumul_count = 0;
        principal_cumul_count = 0;        

        for (var x=0; x < num_payments ; x++) {

            $scope.monthly_interest = $scope.remaining_balance * ($scope.formData.annual_interest_rate / 12)/100;
            $scope.monthly_principal = $scope.month_payment - $scope.monthly_interest; 

            $scope.interest_cumul_count += $scope.monthly_interest;
            $scope.principal_cumul_count += $scope.monthly_principal;          

            $scope.infos.push({
                'pay_index': x+1,
                'leftover_balance': $scope.remaining_balance - $scope.monthly_principal,
                'month_interest': $scope.monthly_interest,
                'month_principal': $scope.monthly_principal,
                'cumul_interest': $scope.interest_cumul_count,
                'cumul_principal': $scope.principal_cumul_count
            });

            $scope.remaining_balance -= $scope.monthly_principal;

            if (x > 0){
                $scope.addPointInterest($scope.infos[x].cumul_interest );
                $scope.addPointPrincipal($scope.infos[x].cumul_principal );
            }  

        };

        Array.prototype.push.apply($scope.data[0], $scope.seriesInterest);
        Array.prototype.push.apply($scope.data[1], $scope.seriesPrincipal);

        // console.log('Data obj is ');
        // console.log($scope.data);

        // console.log('Data obj for cumul int is ');
        // console.log($scope.data[0]);
        // console.log('Data obj for cumul principal is ');
        // console.log($scope.data[1]);        

    };

    $scope.range =  function(start, count) {
        return Array.apply(0, Array(count))
                    .map(function (element, index) { 
                             return index + start;  
                         });
    };

    $scope.reset = function(){
        $scope.formData = "";
    };

    $scope.chartLabel = function(){
        $scope.labelStore = [];
        years = $scope.yearCalc();
        num_payments = $scope.num_of_payments;
        for (var x=0; x<num_payments; x++){
            if (x==0 || x % 12 == 0) {
                $scope.labelStore.push(years[0]);
                years.shift();
            }
            else {
                $scope.labelStore.push('');
            };
        };
        
        return $scope.labelStore;
    };


    $scope.series = ['Cumulative Interest', 'Cumulative Principal'] ;

    $scope.labels = $scope.chartLabel();

    $scope.data = [ [], [] ] ;

    $scope.colours = [{
        fillColor: 'rgb(136, 184, 176)',
        strokeColor: 'rgb(118, 116, 116)',
    }];    


    // $scope.onClick = function (points, evt) {
    // console.log(points, evt);
    // };


    $scope.addPointInterest = function (info_array) {
        $scope.seriesInterest = $scope.seriesInterest.concat(info_array);
        return $scope.seriesInterest;
    };


    $scope.addPointPrincipal = function (info_array) {
        $scope.seriesPrincipal = $scope.seriesPrincipal.concat(info_array);
        return $scope.seriesPrincipal;
    };


    $scope.$watch('[formData]', function () {
        $scope.calculateMortgageProgression();

    }, true);


  }



 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 