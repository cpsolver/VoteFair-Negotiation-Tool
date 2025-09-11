#-----------------------------------------------
#-----------------------------------------------
#            log_write
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that writes the log information
#  to a log file.
#  After the first execution of this subroutine,
#  additional log information is appended to
#  the log file.

sub log_write
{

    my ( $line ) ;
    my ( $text_of_line ) ;
    my ( $remaining_tag_text ) ;
    my ( $case_or_none ) ;
    my ( @log_lines ) ;


#-----------------------------------------------
#  If requested, don't write the log file.

    if ( $global_write_log_file == $global_false )
    {
        return ;
    }


#-----------------------------------------------
#  Allow for repeated use of this subroutine.

    $global_write_output_counter ++ ;


#-----------------------------------------------
#  Specify the log output filename, based on the
#  starting date and time.

    if ( $global_case_number > 0 )
    {
        $case_or_none = sprintf( "%d" , $global_case_number ) ;
    } else
    {
        $case_or_none = "nocase" ;
    }
    $global_log_output_filename = "log-" . $case_or_none . "-" . $global_starting_date_hour_minute_second ;
    if ( $global_error_message =~ /[^ \n\r]/ )
    {
        $global_log_output_filename .= "-ERROR" ;
    }
    $global_log_output_filename .= $global_extra_filename_string ;
    $global_log_output_filename .= "-" . $global_action_request ;
    $global_log_output_filename =~ s/[^a-z0-9\-]+/\-/gi ;
    $global_log_output_filename .= ".txt" ;
    $global_log_output_filename = $global_log_directory_prefix . $global_log_output_filename ;


#-----------------------------------------------
#  Open the output file.

    close( LOGOUT ) ;
    if ( open ( LOGOUT , ">>" . $global_log_output_filename ) )
    {


#-----------------------------------------------
#  Indicate the segmented nature of the log file.

        print LOGOUT "<segment>Beginning of segment " . $global_write_output_counter . " of log file.<\/segment>\n" ;


#-----------------------------------------------
#  Detect an endless loop.

        $global_endless_loop_counter ++ ;
        $global_log_output .= "<logwrite>Endless loop counter = " . $global_endless_loop_counter . "<\/logwrite>" ;
        if ( $global_endless_loop_counter > $global_endless_loop_counter_limit )
        {
            $global_error_message .= "ERROR: Endless loop encountered!\n" ;
            $global_log_output =~ s/(<\/[a-z0-9_-]+>)/$1\n/sg ;
            print LOGOUT $global_log_output . "\n" ;
            print $global_possible_cgi_heading ;
            $global_html_code = &dashrep_get_replacement( "html-endless-loop-error-page" ) ;
            print $global_html_code ;
            die ;
        }


#-----------------------------------------------
#  If there has been a warning, insert it into
#  the beginning of this portion of the log file.
#  (In case it was not directly put into the log file.)

        if ( $global_warning_message =~ /[^ ]/ )
        {
            print LOGOUT "\n\n" . $global_dashes . "\n\n" . "Warning message: " . $global_warning_message . "\n\n" . $global_dashes . "\n\n" ;
        }


#-----------------------------------------------
#  Insert line breaks.

        $global_log_output =~ s/(<\/[a-z0-9_-]+>)/$1\n/sg ;


#-----------------------------------------------
#  Print the log-file content.

        print LOGOUT $global_log_output . "\n" ;


#-----------------------------------------------
#  Close the output file.

        close( LOGOUT ) ;


#-----------------------------------------------
#  Indicate an error if the file could not be
#  created.

    } else
    {
        $global_log_output .= "<logwrite>Failure opening file named: " . $global_log_output_filename . "<\/logwrite>" ;
        $global_log_output .= "<logwrite>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/logwrite>" ;
    }


#-----------------------------------------------
#  Allow for repeated use of this subroutine.

    $global_log_output = "" ;


#-----------------------------------------------
#  All done.

}


