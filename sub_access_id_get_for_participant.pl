#-----------------------------------------------
#-----------------------------------------------
#            access_id_get_for_participant
#-----------------------------------------------
#-----------------------------------------------
#  Get the Access ID for the participant specified
#  in the "global_participant_id" variable.


sub access_id_get_for_participant
{

    my ( $access_id ) ;


#-----------------------------------------------
#  Preserve the actual user ID and access ID
#  number.

    $stored_actual_user_id = $global_user_id ;
    $stored_actual_access_id = &dashrep_get_replacement( "input-accessid" ) ;


#-----------------------------------------------
#  Log the participant ID number, which is
#  different from the user ID number.

    $global_log_output .= "<getparticipantid>Input specifies participant ID " . $global_participant_id . "<\/getparticipantid>" ;
    &log_write ;


#-----------------------------------------------
#  Initialization.

    &access_id_packing_bit_sequence ;
    &log_write ;


#-----------------------------------------------
#  Get the participant's user ID number.

    $replacement_name = "participant-userid-for-participantid-" . $global_participant_id ;
    if ( &dashrep_get_replacement( $replacement_name ) =~ /[1-9]/ )
    {
        $global_user_id = &dashrep_get_replacement( $replacement_name ) ;
        $global_log_output .= "<getparticipantid>Based on replacement info, participant's USER ID number is " . $global_user_id . "<\/getparticipantid>" ;
        &log_write ;
    } elsif ( $global_participant_id == $global_user_participant_id )
    {
        $global_user_id = $stored_actual_user_id ;
        $global_log_output .= "<getparticipantid>User is participant, participant's USER ID number is " . $global_user_id . "<\/getparticipantid>" ;
        &log_write ;
    } else
    {
        $global_user_id = 0 ;
        $global_log_output .= "<getparticipantid>Using participant USER ID number of zero<\/getparticipantid>" ;
        &log_write ;
    }
    $global_log_output .= "<getparticipantid>Participant's USER ID number is " . $global_user_id . "<\/getparticipantid>" ;
    &log_write ;


#-----------------------------------------------
#  Calculate the access ID number.

    &access_id_pack ;
    $access_id = $global_access_id ;
    &log_write ;


#-----------------------------------------------
#  Restore the actual user ID and access ID
#  numbers, and their associated replacements.

    $global_user_id = $stored_actual_user_id ;
    $global_access_id = $stored_actual_access_id ;
    &dashrep_define( "output-access-id" , $global_access_id ) ;
    &dashrep_define( "input-accessid" , $global_access_id ) ;


#-----------------------------------------------
#  Put the generated access ID into a replacement.

    &dashrep_define( "access-id-for-participantid-" . $global_participant_id , $access_id ) ;
    $global_log_output .= "<getparticipantid>Participant's access ID number is " . $access_id . "<\/getparticipantid>" ;
    &log_write ;


#-----------------------------------------------
#  End of subroutine.

    return

}

