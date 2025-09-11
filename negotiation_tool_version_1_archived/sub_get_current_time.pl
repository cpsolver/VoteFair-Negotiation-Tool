#-----------------------------------------------
#-----------------------------------------------
#              get_current_time
#-----------------------------------------------
#-----------------------------------------------

sub get_current_time
{

    my ( @MonthNames ) ;
    my ( $Second ) ;
    my ( $Minute ) ;
    my ( $Hour ) ;
    my ( $DayOfMonth ) ;
    my ( $MonthIndex ) ;
    my ( $YearFrom1900 ) ;
    my ( $DayOfWeek ) ;
    my ( $DayOfYear ) ;
    my ( $DST ) ;
    my ( $MonthName ) ;

    @MonthNames = ( "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ) ;

    ( $Second, $Minute, $Hour, $DayOfMonth, $MonthIndex, $YearFrom1900, $DayOfWeek, $DayOfYear, $DST ) = localtime( time ) ;

    $MonthName = $MonthNames[ $MonthIndex ] ;

    $global_year_number = 1900 + $YearFrom1900 ;
    $global_date = $global_year_number . "-" . $MonthName . "-" . $DayOfMonth ;

    $global_hour = sprintf( "%02d", $Hour ) ;
    $global_minute = sprintf( "%02d", $Minute ) ;
    $global_second = sprintf( "%02d", $Second ) ;

    $global_hour_minute = $Hour . ":" . $global_minute ;
    $global_hour_minute_second = $global_hour . $global_minute . $global_second ;

    $global_date_hour_minute_second = $global_date . "  " . $global_hour_minute . ":" . $global_second ;

    &dashrep_define( "date-here" , $global_date ) ;
    &dashrep_define( "time-here" , $global_hour_minute ) ;

    &dashrep_define( "xml-date" , $global_date ) ;
    &dashrep_define( "xml-time" , $global_hour_minute ) ;

    $global_date_and_time_in_xml = "<date>" . $global_date . "<\/date>" . "\n" . "<time>" . $global_hour_minute . "<\/time>" . "\n" ;

    $global_day_of_year = sprintf( "%03d", $DayOfYear ) ;
    $global_votefair_year_count = sprintf( "%d",  $global_year_number - 2003 ) ;

    $global_log_output .= "<gettime>Time: " . $global_date_hour_minute_second . "<\/gettime>" ;
    $global_log_output .= "<epochseconds>" . time( ) . "<\/epochseconds>" ;

}


