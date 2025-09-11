#-----------------------------------------------
#-----------------------------------------------
#          file_overwrite
#-----------------------------------------------
#-----------------------------------------------
#  The subroutine erases the specified file
#  ($global_filename) and overwrites it with the
#  specified text ($global_content_to_append_to_file).
#  Afterward, the specified text
#  ($global_content_to_append_to_file) is
#  emptied.


sub file_overwrite
{

#-----------------------------------------------
#  Open the file that will be overwritten.

    if ( open ( OUTFILE , ">" . $global_filename ) )
    {
        $global_log_output .= "<fileoverwrite>Opened file for overwriting: " . $global_filename . "<\/fileoverwrite>" ;
    } else
    {
        $global_log_output .= "<fileoverwrite>Failure opening -- for overwriting -- file named " . $global_filename . "<\/fileoverwrite>" ;
        return ;
    }


#-----------------------------------------------
#  Write the content to the description file.

    print OUTFILE $global_date_and_time_in_xml ;
    print OUTFILE $global_content_to_append_to_file ;


#-----------------------------------------------
#  Finish up.

    close ( OUTFILE ) ;
    $global_log_output .= "<fileoverwrite>Closed file.<\/fileoverwrite>" ;
    $global_content_to_append_to_file = "" ;
    $global_log_output .= "<fileoverwrite>Overwriting done<\/fileoverwrite>" ;


#-----------------------------------------------
#  End of subroutine.

}


