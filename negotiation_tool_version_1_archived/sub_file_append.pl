#-----------------------------------------------
#-----------------------------------------------
#          file_append
#-----------------------------------------------
#-----------------------------------------------
#  The subroutine appends the specified text
#  ($global_content_to_append_to_file) to the end
#  of the specified file ($global_filename).
#  Afterward, the specified text
#  ($global_content_to_append_to_file) is
#  emptied.


sub file_append
{

#-----------------------------------------------
#  Open the file to which text will be appended.

    if ( open ( OUTFILE , ">>" . $global_filename ) )
    {
        $global_log_output .= "<fileappend>Opened file for appending: " . $global_filename . "<\/fileappend>" ;
    } else
    {
        $global_log_output .= "<fileappend>Failure opening -- for appending -- file named " . $global_filename . "<\/fileappend>" ;
        return ;
    }


#-----------------------------------------------
#  Write the content to the description file.

    print OUTFILE $global_content_to_append_to_file ;


#-----------------------------------------------
#  Finish up.

    close ( OUTFILE ) ;
    $global_log_output .= "<fileappend>Closed file.<\/fileappend>" ;
    $global_content_to_append_to_file = "" ;
    $global_log_output .= "<fileappend>Appending done<\/fileappend>" ;
    &log_write ;


#-----------------------------------------------
#  End of subroutine.

}

