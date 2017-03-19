#-----------------------------------------------
#-----------------------------------------------
#          get_id_numbers
#-----------------------------------------------
#-----------------------------------------------
#  Get the ID numbers for all the participants.
#  proposals, and aliases.
#  Also get the ID numbers of participant who
#  are allowed to vote, and count these voters.

sub get_id_numbers
{

    $global_log_output .= "<getidnumbers>Entering get-id-numbers subroutine<\/getidnumbers>" ;


#-----------------------------------------------
#  Get all the proposal ID numbers.

#  Later, add code that can optionally ignore
#  proposals that are not yet approved by an
#  administrator.

    $text_list_of_id_numbers = &dashrep_get_replacement( "case-info-idlistproposals" ) ;
#    $global_log_output .= "<getidnumbers>List of all proposal IDs: " . $text_list_of_id_numbers . "<\/getidnumbers>" ;
    @global_list_of_all_proposal_ids = &split_delimited_items_into_array( $text_list_of_id_numbers ) ;
    $global_log_output .= "<getidnumbers>All proposal ID numbers: " . join( "," , @global_list_of_all_proposal_ids ) . "<\/getidnumbers>" ;


#-----------------------------------------------
#  Get all the alias ID numbers.

    $text_list_of_id_numbers = &dashrep_get_replacement( "case-info-idlistaliass" ) ;
#    $global_log_output .= "<getidnumbers>List of all alias IDs: " . $text_list_of_id_numbers . "<\/getidnumbers>" ;
    @global_list_of_all_alias_ids = &split_delimited_items_into_array( $text_list_of_id_numbers ) ;
    $global_log_output .= "<getidnumbers>All alias ID numbers: " . join( "," , @global_list_of_all_alias_ids ) . "<\/getidnumbers>" ;


#-----------------------------------------------
#  Get all the participant ID numbers.

    $text_list_of_id_numbers = &dashrep_get_replacement( "case-info-idlistparticipants" ) ;
#    $global_log_output .= "<getidnumbers>List of all participant IDs: " . $text_list_of_id_numbers . "<\/getidnumbers>" ;
    @global_list_of_all_participant_ids = &split_delimited_items_into_array( $text_list_of_id_numbers ) ;
    $global_log_output .= "<getidnumbers>All participant ID numbers: " . join( "," , @global_list_of_all_participant_ids ) . "<\/getidnumbers>" ;


#-----------------------------------------------
#  Get the ID numbers of participants who can
#  vote, and count the number of voters.
#  Also list the participant ID numbers of
#  non-voters.
#  Also, set flags that reveal which participant
#  ID applies to the current user.

    @global_list_of_all_voter_participant_ids = ( ) ;
    @list_of_all_non_voters = ( ) ;
    foreach $participant_id ( @global_list_of_all_participant_ids )
    {
        $permission_category = &dashrep_get_replacement( "participant-permissioncategory-for-participantid-" . $participant_id ) ;
        $global_log_output .= "<getidnumbers>Participant " . $participant_id . " is in permission category " . $permission_category . "<\/getidnumbers>" ;
        if ( &dashrep_get_replacement( "can-vote-category-" . $permission_category ) =~ /y/i )
        {
            push( @global_list_of_all_voter_participant_ids , $participant_id  ) ;
            $global_log_output .= "<getidnumbers>Participant " . $participant_id . " is a voter<\/getidnumbers>" ;
        } else
        {
            push( @list_of_all_non_voters , $participant_id  ) ;
            $global_log_output .= "<getidnumbers>Participant " . $participant_id . " is a non-voter<\/getidnumbers>" ;
        }
        if ( $participant_id == $global_user_participant_id )
        {
            &dashrep_define( "self-yes-no-for-participant-" . $participant_id , "self-yes" ) ;
        } else
        {
            &dashrep_define( "self-yes-no-for-participant-" . $participant_id , "self-no" ) ;
        }
    }
    $global_number_of_voters = $#global_list_of_all_voter_participant_ids + 1 ;
    &dashrep_define( "number-of-voters" , $global_number_of_voters ) ;
    &dashrep_define( "list-of-all-voters" , join( "," , @global_list_of_all_voter_participant_ids ) ) ;
    $global_log_output .= "<getidnumbers>Participant ID numbers of all " . $global_number_of_voters . " voters: " . &dashrep_get_replacement( "list-of-all-voters" ) . "<\/getidnumbers>" ;
    &dashrep_define( "list-of-non-voters" , join( "," , @list_of_all_non_voters ) ) ;


#-----------------------------------------------
#  End of subroutine.

}

