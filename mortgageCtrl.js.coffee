var app = angular.module("mortgageApp", ["chart.js"]);


mortgageCtrl = function($scope){

    console.log('in da controller');
    $scope.formData = {};
    $scope.infos = [];
    $scope.labelStore = [];
    $scope.months = ['January', 'February','March', 'April','May','June', 'July', 'August','September','October', 'November','December'];

    $scope.years = function(){
        // num_years = ($scope.calculateNumPayments / 12);
        num_years = 360 /12;
        console.log('Mortgage years are ' + num_years);
        present = new Date();
        console.log('Present date is '+ present);
        present = present.getFullYear();
        console.log('Present year is '+ present);
        // return present;
        endyear = present + 30;
        console.log(endyear);
    };

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
        interest_cumul_count = 0;
        principal_cumul_count = 0;        

        for (var x=0; x < num_payments ; x++) {

            monthly_interest = remaining_balance * ($scope.formData.annual_interest_rate / 12)/100;
            monthly_principal = month_payment - monthly_interest; 

            interest_cumul_count += monthly_interest;
            principal_cumul_count += monthly_principal;           

            $scope.infos.push({
                'pay_index': x+1,
                'leftover_balance': remaining_balance - monthly_principal,
                'month_interest': monthly_interest,
                'month_principal': monthly_principal,
                'cumul_interest': interest_cumul_count,
                'cumul_principal': principal_cumul_count
            });

            remaining_balance -= monthly_principal;

            if (x > 0){
                $scope.addPointInterest($scope.infos[x].cumul_interest );
                $scope.addPointPrincipal($scope.infos[x].cumul_principal );
            }   

           
        };


    };

      $scope.range =  function(start, count) {
        return Array.apply(0, Array(count))
                    .map(function (element, index) { 
                             return index + start;  
                         });
    }



    $scope.reset = function(){
        $scope.formData = "";
    };

    $scope.chartLabel = function(){
        for (var x=0; x<360; x++){
            if (x==0 || x % 12 == 0) {
                $scope.labelStore.push($scope.months[0]);
                $scope.months.shift();
            }
            else {
                x = x.toString();
                $scope.labelStore.push(x);
            };
        };
        console.log($scope.labelStore);
        return $scope.labelStore;
    };


    $scope.series = ['Cumulative Interest', 'Cumulative Principal'] ;

    $scope.labels = $scope.chartLabel();

    $scope.data = [ [], [] ] ;

    $scope.colours = [{
        fillColor: 'rgb(140,174,149)',
        strokeColor: 'rgba(47, 132, 71, 0.8)',
        // highlightFill: 'rgb(140,174,149)',
        // highlightStroke: 'rgba(47, 132, 71, 0.8)'
    }];    


    // $scope.onClick = function (points, evt) {
    // console.log(points, evt);
    // };


    $scope.addPointInterest = function (info_array) {
        var seriesArray = $scope.data;
        seriesArray[0] = seriesArray[0].concat(info_array);
    };


    $scope.addPointPrincipal = function (info_array) {
        var seriesArray = $scope.data; 
        seriesArray[1] = seriesArray[1].concat(info_array);
    };



console.log($scope.years());

  }



 app.controller("MortgageCtrl", ['$scope', mortgageCtrl] );















 