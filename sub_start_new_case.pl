#-----------------------------------------------
#-----------------------------------------------
#            start_new_case
#-----------------------------------------------
#-----------------------------------------------
#  Start a new case.


sub start_new_case
{


#-----------------------------------------------
#  Create a user ID number that identifies the
#  administrator.

    &generate_user_id ;

    $global_user_id = $global_new_user_id ;
    &dashrep_define( "user-id" , $global_user_id ) ;

    $global_administrator_user_id = $global_user_id ;
    &dashrep_define( "administrator-user-id" , $global_new_user_id ) ;

    $global_log_output .= "<newcase>User id = " . $global_user_id . "<\/newcase>" ;


#-----------------------------------------------
#  Create a new case identification number, and
#  an associated case filename that has not yet
#  been used.



# ... (code removed)



#-----------------------------------------------
#  Create the file.

    if ( open ( OUTFILE , ">" . $global_case_info_filename ) )
    {
        $global_log_output .= "<newcase>Created new info file named " . $global_case_info_filename . "<\/newcase>" ;

    } else
    {
        $global_error_message .= &dashrep_get_replacement( "error-message-unable-to-create-file" ) ;
        $global_log_output .= "<newcase>Failure creating file named " . $global_case_info_filename . "<\/newcase>" ;
        $global_log_output .= "<newcase>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/newcase>" ;
        return ;
        &log_write ;
    }
    close( OUTFILE ) ;


#-----------------------------------------------
#  Generate the Access ID number ...



# ... (code removed)



#-----------------------------------------------
#  Specify the default XML code, which uses
#  default values.

#  It includes the administrator's user ID number,
#  which is removed when exporting XML.

    &dashrep_define( "language-specific-case-title" , &dashrep_get_replacement( "default-case-title" ) ) ;
    &dashrep_define( "admin-user-id" , $global_administrator_user_id ) ;
    $xml_replacement_name = "xml-for-new-case" ;
    $new_replacement_value = &dashrep_expand_parameters( "new-case-xml") . "\n" ;
#    $global_log_output .= $global_temporary_log_output ;
    $new_replacement_value =~ s/<eol *\/>/\n/gs ;
    $new_replacement_value =~ s/^ +//gs ;
    &dashrep_define( $xml_replacement_name , $new_replacement_value ) ;
    $global_case_info_file_type = "main" ;
    &dashrep_define( "list-of-xml-code-of-type-" . $global_case_info_file_type , &dashrep_get_replacement( "list-of-xml-code-of-type-" . $global_case_info_file_type ) . $xml_replacement_name . "," ) ;
    $global_log_output .= "<newcase>Info named " . $xml_replacement_name . " to be added: " . &dashrep_get_replacement( $xml_replacement_name ) . "<\/newcase>" ;


#-----------------------------------------------
#  Write an empty statement for the administrator.

    $xml_replacement_name = "xml-for-empty-statement" ;
    $new_replacement_value = &dashrep_expand_parameters( "new-case-xml-empty-statement" ) . "\n" ;
#    $global_log_output .= $global_temporary_log_output ;
    $new_replacement_value =~ s/<eol *\/>/\n/gs ;
    $new_replacement_value =~ s/^ +//gs ;
    &dashrep_define( $xml_replacement_name , $new_replacement_value ) ;
    $global_case_info_file_type = "statements" ;
    &dashrep_define( "list-of-xml-code-of-type-" . $global_case_info_file_type , &dashrep_get_replacement( "list-of-xml-code-of-type-" . $global_case_info_file_type ) . $xml_replacement_name . "," ) ;
    $global_log_output .= "<newcase>Info named " . $xml_replacement_name . " to be added: " . &dashrep_get_replacement( $xml_replacement_name ) . "<\/newcase>" ;



#-----------------------------------------------
#  Write the new XML tagged definitions
#  to the main case file.

    &xml_write_new ;


#-----------------------------------------------
#  End of subroutine.

}
