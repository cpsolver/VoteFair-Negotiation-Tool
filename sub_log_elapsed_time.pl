#-----------------------------------------------
#-----------------------------------------------
#         log_elapsed_time
#-----------------------------------------------
#-----------------------------------------------
#  For debugging, put into the log the elapsed
#  time.


sub log_elapsed_time
{

    $global_elapsed_time = $global_starting_time - time ;
    $global_log_output .= "<elapsedtime>Elapsed time: " . $global_elapsed_time . "<\/elapsedtime>" ;

}


