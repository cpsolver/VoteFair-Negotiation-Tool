#-----------------------------------------------
#-----------------------------------------------
#          get_aliased_titles
#-----------------------------------------------
#-----------------------------------------------
#  For the specified participant, get the aliased
#  proposal titles being used by this participant.


sub get_aliased_titles
{


#-----------------------------------------------
#  Initialization.

    $global_log_output .= "<getaliased>Entered get-aliased-title subroutine<\/getaliased>" ;


#-----------------------------------------------
#  Identify the information passed to this
#  subroutine.

    $global_log_output .= "<getaliased>Considering participant ID: " . $global_input_participant_id . "<\/getaliased>" ;
    $global_log_output .= "<getaliased>Considering proposal ID: " . $global_input_proposal_id . "<\/getaliased>" ;
    $global_log_output .= "<getaliased>All proposal ID numbers: " . join( "," , @global_list_of_all_proposal_ids ) . "<\/getaliased>" ;


#-----------------------------------------------
#  Get the default alias titles, and initialize
#  the proposal titles to use the default alias
#  ID numbers.

    foreach $proposal_id ( @global_list_of_all_proposal_ids )
    {
        $alias_id = &dashrep_get_replacement( "proposal-aliasid-for-proposalid-" . $proposal_id ) ;
        &dashrep_define( "aliased-title-for-proposalid-" . $proposal_id , "alias-aliastitle-for-aliasid-" . $alias_id ) ;
#        $global_log_output .= "<getaliased>Proposal " . $proposal_id . " uses alias " . $alias_id . " as the default<\/getaliased>" ;
#        $global_log_output .= "<getaliased>Default proposal title is " . &dashrep_get_replacement( "aliased-title-for-proposalid-" . $proposal_id ) . "<\/getaliased>" ;
        if ( $proposal_id == $global_input_proposal_id )
        {
            &dashrep_define( "chosen-alias-id" , $alias_id ) ;
        }
    }


#-----------------------------------------------
#  Get the case-specific aliasusage information.

    $collected_aliasusage_xml_code = &dashrep_get_replacement( "case-info-aliasusage" ) ;


#-----------------------------------------------
#  Begin a loop that parses the information in
#  each <aliasusage> XML tag pair.

#    $global_log_output .= "<getaliased>Collected aliasusage info: " . $collected_aliasusage_xml_code . "<\/getaliased>" ;
    while ( $collected_aliasusage_xml_code =~ /^.*?<aliasusage>(.*?)<\/aliasusage>(.*)$/ )
    {
        $xml_code = $1 ;
        $collected_aliasusage_xml_code = $2 ;
#        $global_log_output .= "<getaliased>aliasusage XML code: " . $xml_code . "<\/getaliased>" ;
#        $global_log_output .= "<getaliased>Collected aliasusage info: " . $collected_aliasusage_xml_code . "<\/getaliased>" ;
        if ( $xml_code =~ /<participantid>([^<]+)<\/participantid>[^<]*<proposalid>([^<]+)<\/proposalid>[^<]*<aliasid>([^<]+)<\/aliasid>/ )
        {
            $participant_id = $1 ;
            $proposal_id = $2 ;
            $alias_id = $3 ;
#            $global_log_output .= "<getaliased>Participant " . $participant_id . " , proposal " . $proposal_id . " alias " . $alias_id . "<\/getaliased>" ;


#-----------------------------------------------
#  If it applies to the specified participant,
#  identify which aliased proposal title to use.

            if ( $participant_id == $global_input_participant_id )
            {
                &dashrep_define( "aliased-title-for-proposalid-" . $proposal_id , &dashrep_get_replacement( "alias-aliastitle-for-aliasid-" . $alias_id ) ) ;
#                $global_log_output .= "<getaliased>Aliased proposal title is " . &dashrep_get_replacement( "aliased-title-for-proposalid-" . $proposal_id ) . "<\/getaliased>" ;


#-----------------------------------------------
#  If it also applies to the specified proposal,
#  save the alias ID.

                if ( $proposal_id == $global_input_proposal_id )
                {
                    $alias_id_for_specified_participant_and_proposal = $alias_id ;
                    &dashrep_define( "chosen-alias-id" , $alias_id_for_specified_participant_and_proposal ) ;
#                    $global_log_output .= "<getaliased>Alias ID for specified participant and proposal is " . $alias_id_for_specified_participant_and_proposal . "<\/getaliased>" ;
                }
            }


#-----------------------------------------------
#  Repeat the loop for the next <aliasusage>
#  tag pair.

        }
    }


#-----------------------------------------------
#  In case they are needed, create lists of alias
#  IDs for the specified proposal ID.
#  Create one list that includes all those alias
#  IDs, and another list that excludes the
#  currently chosen alias ID.

    if ( $global_input_proposal_id > 0 )
    {
        foreach $alias_id ( @global_list_of_all_alias_ids )
        {
            $proposal_id = &dashrep_get_replacement( "alias-proposalid-for-aliasid-" . $alias_id ) ;
#            $global_log_output .= "<getaliased>Alias ID " . $alias_id . " applies to proposal ID " . $proposal_id . "<\/getaliased>" ;
            if ( $proposal_id == $global_input_proposal_id )
            {
                $temporary_replacement_name = "list-of-alias-ids-for-proposalid-" . $proposal_id ;
                &dashrep_define( $temporary_replacement_name , &dashrep_get_replacement( $temporary_replacement_name ) . $alias_id . "," ) ;
                if ( $alias_id != &dashrep_get_replacement( "chosen-alias-id" ) )
                {
                    &dashrep_define( "list-of-unchosen-alias-ids-for-proposalid-" . $proposal_id , &dashrep_get_replacement( "list-of-unchosen-alias-ids-for-proposalid-" . $proposal_id ) . $alias_id . "," ) ;
                }
            }
        }
        $global_log_output .= "<getaliased>For proposal ID " . $proposal_id . ", all relevant alias ID numbers: " . &dashrep_get_replacement( "list-of-alias-ids-for-proposalid-" . $proposal_id ) . "<\/getaliased>" ;
        $global_log_output .= "<getaliased>For proposal ID " . $proposal_id . ", unchosen alias ID numbers: " . &dashrep_get_replacement( "list-of-unchosen-alias-ids-for-proposalid-" . $proposal_id ) . "<\/getaliased>" ;
    }


#-----------------------------------------------
#  End of subroutine.

}

