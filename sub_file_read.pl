#-----------------------------------------------
#-----------------------------------------------
#          file_read
#-----------------------------------------------
#-----------------------------------------------
#  The subroutine reads the specified file --
#  into the variable named:
#  $global_content_read_from_file


sub file_read
{


#-----------------------------------------------
#  Initialization.

    $global_content_read_from_file = "" ;


#-----------------------------------------------
#  Open the file to be read.

    if ( open ( INFILE , "<" . $global_filename ) )
    {
        $global_log_output .= "<fileread>Opened file for reading: " . $global_filename . "<\/fileread>" ;
    } else
    {
        $global_error_message .= "Could not open file for reading." ;
        $global_log_output .= "<fileread>Failure opening input file named " . $global_filename . "<\/fileread>" ;
        return ;
    }


#-----------------------------------------------
#  Read the contents.

    while( $input_line = <INFILE> )
    {
        chomp( $input_line ) ;
        $global_content_read_from_file .= $input_line . "\n" ;
    }


#-----------------------------------------------
#  Finish up.

    close ( INFILE ) ;
    $global_log_output .= "<fileread>Closed input file.<\/fileread>" ;


#-----------------------------------------------
#  End of subroutine.

}

