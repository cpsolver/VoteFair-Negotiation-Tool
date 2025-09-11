#-----------------------------------------------
#-----------------------------------------------
#        access_id_convert_to_case_and_user_id
#-----------------------------------------------
#-----------------------------------------------
#  Translate the user's access ID into a case
#  number and user ID.


sub access_id_convert_to_case_and_user_id
{

    my ( $alias ) ;
    my ( $copy_of_accessid ) ;
    my ( $case_access_word ) ;
    my ( $input_line ) ;
    my ( $saved_error_message ) ;
    my ( $definitions_filename_saved ) ;
    my ( $definition_name ) ;


#-----------------------------------------------
#  Initialization.

    $global_question_count = 0 ;


#-----------------------------------------------
#  Indicate the supplied Access ID.

    $global_log_output .= "<convertcaseuser>Supplied Access ID: " . &dashrep_get_replacement( "input-accessid" ) . "<\/convertcaseuser>" ;


#-----------------------------------------------
#  Unpack the Access ID number.
#  It reveals the case number and userid.



# ... (code removed)



    $global_log_output .= "<convertcaseuser>Case number is " . $global_case_number . "<\/convertcaseuser>" ;


#-----------------------------------------------
#  Make the user ID available.

    &dashrep_define( "parameter-user-id" , $global_user_id ) ;
    $global_log_output .= "<convertcaseuser>User ID number is " . $global_user_id . "<\/convertcaseuser>" ;


#-----------------------------------------------
#  Pass the Access ID to the next web page.

    if ( &dashrep_get_replacement( "input-accessid" ) =~ /[0-9]/ )
    {
        &dashrep_define( "parameter-access-id" , &dashrep_get_replacement( "input-accessid" ) ) ;
    } else
    {
        &dashrep_define( "parameter-access-id" , "unknown" ) ;
    }


#-----------------------------------------------
#  End of subroutine.

    $global_log_output .= "<convertcaseuser>Access ID = " . &dashrep_get_replacement( "input-accessid" ) . "<\/convertcaseuser>" ;
    $global_log_output .= "<convertcaseuser>Case number = " . $global_case_number . "<\/convertcaseuser>" ;

}

