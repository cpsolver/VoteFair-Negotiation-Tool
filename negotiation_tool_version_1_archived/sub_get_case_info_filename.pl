#-----------------------------------------------
#-----------------------------------------------
#         get_case_info_filename
#-----------------------------------------------
#-----------------------------------------------
#  Based on a case identification number,
#  determine the appropriate case description filename.


sub get_case_info_filename
{

    $global_access_id_is_valid = $global_false ;

    if ( ( $global_case_number + 0 ) < 1 )
    {
        return ;
    }

    $global_case_description_filename = $global_case_filename_prefix . $global_case_number . "-" . $global_case_info_file_type_main . $global_case_filename_suffix ;

    $global_case_description_filename =~ s/ +//g ;

    if ( -e $global_case_description_filename )
    {
        $global_access_id_is_valid = $global_true ;
        $global_log_output .= "<getcaseinfofilename>Case description file exists: " . $global_case_description_filename . "<\/getcaseinfofilename>" ;

    } else
    {
        $global_error_message .= "Unable to access the information for this Access ID." ;
        $global_log_output .= "<getcaseinfofilename>Invalid case description filename: " . $global_case_description_filename . "<\/getcaseinfofilename>" ;

    }

}

