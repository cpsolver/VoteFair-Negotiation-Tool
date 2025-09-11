#-----------------------------------------------
#-----------------------------------------------
#            error_force
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine -- for debugging -- that forces an
#  error so the log file contents can be viewed
#  when the program otherwise exits without
#  saving the log file.

sub error_force
{
    $global_error_message = &dashrep_get_replacement( "error-message-forced-exit" ) . " " . $global_error_message ;
    &error_check ;
}


