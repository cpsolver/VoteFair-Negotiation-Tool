#-----------------------------------------------
#-----------------------------------------------
#          get_incompatibility_info
#-----------------------------------------------
#-----------------------------------------------
#  Get the incompatibility information, both
#  overall and for a specified participant.
#  A lack of incompatibility voting for a pair of
#  proposals is categorized as "undecided".


sub get_incompatibility_info
{


#-----------------------------------------------
#  Initialization.

    $global_log_output .= "<getincompatibilityinfo>Considering participant ID: " . $global_input_participant_id . " <\/getincompatibilityinfo>" ;
    $global_log_output .= "<getincompatibilityinfo>Considering proposal ID: " . $global_input_proposal_id . " <\/getincompatibilityinfo>" ;
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  If a proposal-specific page is being displayed,
#  initialize the proposal-specific incompatibility
#  information.

    if ( $global_input_proposal_id != 0 )
    {
        $if_proposal = $global_input_proposal_id ;
        foreach $then_not_proposal ( @global_list_of_all_proposal_ids )
        {
            if ( $if_proposal != $then_not_proposal )
            {
#                $global_log_output .= "<getincompatibilityinfo>Then not proposal ID: " . $then_not_proposal . " <\/getincompatibilityinfo>" ;
                &dashrep_define( "basis-of-incompatibility-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , "words-no-votes-usage-incompatibility-basis" ) ;
                &dashrep_define( "basis-of-incompatibility-for-ifproposal-" . $then_not_proposal . "-thennotproposal-" . $if_proposal , "words-no-votes-usage-incompatibility-basis" ) ;
                &dashrep_define( "voteincompatibility-yesnoundecided-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , "no" ) ;
                &dashrep_define( "voteincompatibility-yesnoundecided-for-ifproposal-" . $then_not_proposal . "-thennotproposal-" . $if_proposal , "no" ) ;
                &dashrep_define( "voteincompatibility-yesnoundecided-for-participantid-" . $global_input_participant_id . "-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , "undecided" ) ;
                &dashrep_define( "voteincompatibility-yesnoundecided-for-participantid-" . "99999" . "-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , "undecided" ) ;
           }
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Get the case-specific incompatibility vote
#  information.

    $collected_incompatibility_xml_code = &dashrep_get_replacement( "case-info-voteincompatibility" ) ;
    $collected_incompatibility_xml_code =~ s/[ \n]+//gs ;
#    $global_log_output .= "<getincompatibilityinfo>Collected incompatibility information: " . $collected_incompatibility_xml_code . " <\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Begin a loop that parses the information in
#  each <incompatibilityvote> XML tag pair.

    while ( $collected_incompatibility_xml_code =~ /.*?<voteincompatibility>(.+?)<\/voteincompatibility>(.*)$/s )
    {
        $xml_code = $1 ;
        $collected_incompatibility_xml_code = $2 ;
#        $global_log_output .= "<getincompatibilityinfo>XML: " . $xml_code . " <\/getincompatibilityinfo>" ;

        if ( $xml_code =~ /<participantid>([^<]+)<[^>]*>[^<]*<ifproposal>([^<]+)<[^>]*>[^<]*<thennotproposal>([^<]+)<[^>]*>[^<]*<yesnoundecided>([^<]+)<[^>]*>/s )
        {
            $participant_id = $1 ;
            $if_proposal = $2 ;
            $then_not_proposal = $3 ;
            $yes_no_undecided = $4 ;

            if ( ( $yes_no_undecided eq "yes" ) || ( $yes_no_undecided eq "no" ) || ( $yes_no_undecided eq "undecided" ) )
            {
                &dashrep_define( "voteincompatibility-yesnoundecided-for-participantid-" . $participant_id . "-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , $yes_no_undecided ) ;


#-----------------------------------------------
#  Store this incompatibility vote.
#  Overwrite an earlier vote if the same participant
#  casts another vote for the same pair of
#  proposals.

                $replacement_name = "participant-" . $participant_id . "-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
                $yes_no_undecided_array{ $replacement_name } = $yes_no_undecided ;
                $global_log_output .= "<getincompatibilityinfo>" . $replacement_name . " = " . $yes_no_undecided . " <\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  If the participant has authorization to declare
#  an incompatibility, or lack thereof, use that
#  value regardless of what the votes are.

                if ( int( $participant_id ) == 99999 )
                {
                    $yes_no_replacement_name = "voteincompatibility-yesnoundecided-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
                    &dashrep_define( $yes_no_replacement_name , $yes_no_undecided ) ;
                    $basis_replacement_name = "basis-of-incompatibility-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
                    if ( ( $yes_no_undecided eq "yes" ) || ( $yes_no_undecided eq "no" ) )
                    {
#  If text in next line is changed, also change elsewhere in subroutine.
                        &dashrep_define( $basis_replacement_name , "words-judgement-by-administrator" ) ;
                    } else
                    {
#  If text in next line is changed, also change elsewhere in subroutine.
                        &dashrep_define( $basis_replacement_name , "words-no-votes-usage-incompatibility-basis" ) ;
                    }
                    $global_log_output .= "<getincompatibilityinfo>" . $basis_replacement_name . " = " . &dashrep_get_replacement( $basis_replacement_name ) . " <\/getincompatibilityinfo>" ;
                    if ( $if_proposal == $global_input_proposal_id )
                    {
                        $yes_no_vote_none_incompatibility_for_proposal_id[ $then_not_proposal ] = $yes_no_undecided ;
                    }
                }


#-----------------------------------------------
#  If this incompatibility vote is from the
#  participant whose incompatibility votes are
#  being collected, put the vote into a replacement
#  value.

                if ( $participant_id == $global_input_participant_id )
                {
                    &dashrep_define( "yes-no-undecided-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal , $yes_no_undecided ) ;
                }


#-----------------------------------------------
#  Repeat the loop for the next <incompatibilityvote>
#  tag.

            }
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Calculate how many (voting) participants must
#  agree on incompatibility in order for it to be
#  regarded as incompatible.

    $global_log_output .= "<getincompatibilityinfo>Number of voters is " . $global_number_of_voters . " <\/getincompatibilityinfo>" ;
    $threshold_percentage = int( &dashrep_get_replacement( "case-info-incompatibiitypercentage" ) ) ;
    $global_log_output .= "<getincompatibilityinfo>Threshold percentage: " . $threshold_percentage . " <\/getincompatibilityinfo>" ;
    if ( $threshold_percentage > 0 )
    {
        $threshold_count_decimal = $threshold_percentage * $global_number_of_voters / 100 ;
        $threshold_count = int( $threshold_count_decimal ) ;
        while ( $threshold_count < $threshold_count_decimal )
        {
            $threshold_count ++ ;
        }
    } else
    {
        $threshold_count = $global_number_of_voters ;
    }
    if ( $threshold_count < 1 )
    {
        $threshold_count = 1 ;
    }
    $global_log_output .= "<getincompatibilityinfo>Threshold count: " . $threshold_count . " <\/getincompatibilityinfo>" ;
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Tally the counts, and keep track of whether
#  the threshold is exceeded.

    foreach $parameters ( keys( %yes_no_undecided_array ) )
    {
        $yes_no_undecided = $yes_no_undecided_array{ $parameters } ;
        $global_log_output .= "<getincompatibilityinfo>" . $parameters . " = " . $yes_no_undecided . " <\/getincompatibilityinfo>" ;
        if ( $parameters =~ /participant-([0-9]+)-ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
        {
            $participant_id = $1 ;
            $if_proposal = $2 ;
            $then_not_proposal = $3 ;
            $basis_replacement_name = "basis-of-incompatibility-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
            $global_log_output .= "<getincompatibilityinfo>" . $basis_replacement_name . " = " . &dashrep_get_replacement( $basis_replacement_name ) . " <\/getincompatibilityinfo>" ;
            $yes_no_replacement_name = "voteincompatibility-yesnoundecided-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
            if ( $participant_id == 99999 )
            {
                if ( $basis_check{ $basis_replacement_name } ne "words-judgement-by-administrator" )
                {
                    if ( ( $yes_no_undecided eq "yes" ) || ( $yes_no_undecided eq "no" ) )
                    {
                        &dashrep_define( $yes_no_replacement_name , $yes_no_undecided ) ;
                        &dashrep_define( $basis_replacement_name , "words-judgement-by-administrator" ) ;
                        $basis_check{ $basis_replacement_name } = "words-judgement-by-administrator" ;
                        if ( $yes_no_undecided eq "yes" )
                        {
                            push( @list_of_incompatibility_parameters , $yes_no_replacement_name ) ;
                        }
                    }
                    $global_log_output .= "<getincompatibilityinfo>" . $yes_no_replacement_name . " = " . &dashrep_get_replacement( $yes_no_replacement_name ) . " <\/getincompatibilityinfo>" ;
                }
            } elsif ( &dashrep_get_replacement( "participant-permissioncategory-for-participantid-" . $participant_id ) eq "voter" )
            {
                if ( &dashrep_get_replacement( $basis_replacement_name ) ne "words-judgement-by-administrator" )
                {
                    $count_replacement_name = "vote-count-incompatibility-" . $yes_no_undecided . "-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ;
                    &dashrep_define( $count_replacement_name , &dashrep_get_replacement( $count_replacement_name ) + 1 ) ;
                    $global_log_output .= "<getincompatibilityinfo>" . $count_replacement_name . " = " . &dashrep_get_replacement( $count_replacement_name ) . " <\/getincompatibilityinfo>" ;
                    if ( &dashrep_get_replacement( $count_replacement_name ) >= $threshold_count )
                    {
                        if ( &dashrep_get_replacement( $basis_replacement_name ) ne "words-incompatibility-votes-exceed-threshold" )
                        {
                            &dashrep_define( $yes_no_replacement_name , "yes" ) ;
                            &dashrep_define( $basis_replacement_name , "words-incompatibility-votes-exceed-threshold" ) ;
                            push( @list_of_incompatibility_parameters , $yes_no_replacement_name ) ;
                            $global_log_output .= "<getincompatibilityinfo>" . $yes_no_replacement_name . " = " . &dashrep_get_replacement( $yes_no_replacement_name ) . " <\/getincompatibilityinfo>" ;
                        }
                    } else
                    {
                        if ( ( &dashrep_get_replacement( $basis_replacement_name ) ne "words-incompatibility-votes-do-not-exceed-threshold" ) && ( &dashrep_get_replacement( $basis_replacement_name ) ne "words-incompatibility-votes-exceed-threshold" ) )
                        {
                            &dashrep_define( $yes_no_replacement_name , "no" ) ;
                            &dashrep_define( $basis_replacement_name , "words-incompatibility-votes-do-not-exceed-threshold" ) ;
                            push( @list_of_maybe_incompatibility_parameters , $yes_no_replacement_name ) ;
                            $global_log_output .= "<getincompatibilityinfo>" . $yes_no_replacement_name . " = " . &dashrep_get_replacement( $yes_no_replacement_name ) . " <\/getincompatibilityinfo>" ;
                        }
                    }
                }
            }
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Create a summary that lists "yes" incompatibilities.

    foreach $yes_no_replacement_name ( sort( @list_of_incompatibility_parameters ) )
    {
        $yes_no_undecided = &dashrep_get_replacement( $yes_no_replacement_name ) ;
        $global_log_output .= "<getincompatibilityinfo>" . $yes_no_replacement_name . " = " . &dashrep_get_replacement( $yes_no_replacement_name ) . " <\/getincompatibilityinfo>" ;
        if ( $yes_no_undecided eq "yes" )
        {
            if ( $yes_no_replacement_name =~ /ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
            {
                $if_proposal = $1 ;
                $then_not_proposal = $2 ;
                $replacement_name = "list-of-yes-incompatibility-proposal-ids-for-if-proposal-" . $if_proposal ;
                if ( &dashrep_get_replacement( $replacement_name ) ne "" )
                {
                    &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . ", " ) ;
                }
                &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . $then_not_proposal ) ;
                $global_log_output .= "<getincompatibilityinfo>" . $replacement_name . " = " . &dashrep_get_replacement( $replacement_name ) . " <\/getincompatibilityinfo>" ;
#                $global_log_output .= "<getincompatibilityinfo>Yes proposal " . $if_proposal . " is incompatible with proposal " . $then_not_proposal . " <\/getincompatibilityinfo>" ;
                if ( $if_proposal == $global_input_proposal_id )
                {
                    $yes_no_vote_none_incompatibility_for_proposal_id[ $then_not_proposal ] = "yes" ;
                }
            }
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  Create a summary that lists "at-least-one-yes"
#  (but not completely yes) incompatibilities.

    foreach $yes_no_replacement_name ( sort( @list_of_maybe_incompatibility_parameters ) )
    {
        $yes_no_undecided = &dashrep_get_replacement( $yes_no_replacement_name ) ;
        $global_log_output .= "<getincompatibilityinfo>" . $yes_no_replacement_name . " = " . $yes_no_undecided . " <\/getincompatibilityinfo>" ;
        if ( $yes_no_replacement_name =~ /ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
        {
            $if_proposal = $1 ;
            $then_not_proposal = $2 ;
            if ( &dashrep_get_replacement( "voteincompatibility-yesnoundecided-for-ifproposal-" . $if_proposal . "-thennotproposal-" . $then_not_proposal ) ne "yes" )
            {
                $replacement_name = "list-of-maybe-incompatibility-proposal-ids-for-if-proposal-" . $if_proposal ;
                if ( &dashrep_get_replacement( $replacement_name ) ne "" )
                {
                    &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . ", " ) ;
                }
                &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . $then_not_proposal ) ;
                $global_log_output .= "<getincompatibilityinfo>" . $replacement_name . " = " . &dashrep_get_replacement( $replacement_name ) . " <\/getincompatibilityinfo>" ;
#                $global_log_output .= "<getincompatibilityinfo>Maybe, proposal " . $if_proposal . " could be incompatible with proposal " . $then_not_proposal . " <\/getincompatibilityinfo>" ;
                if ( $if_proposal == $global_input_proposal_id )
                {
                    $yes_no_vote_none_incompatibility_for_proposal_id[ $then_not_proposal ] = "vote" ;
                }
            }
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  For the list-incompatibility-details page,
#  create separate lists of proposals for the
#  different kinds of incompatibilities (for
#  the specified proposal ID).

    if ( $global_input_proposal_id != 0 )
    {
        foreach $then_not_proposal ( @global_list_of_all_proposal_ids )
        {
            if ( $then_not_proposal != $global_input_proposal_id )
            {
                $yes_no_vote_none = $yes_no_vote_none_incompatibility_for_proposal_id[ $then_not_proposal ] ;
                if ( ( $yes_no_vote_none ne "yes" ) && ( $yes_no_vote_none ne "no" ) && ( $yes_no_vote_none ne "vote" ) )
                {
                    $yes_no_vote_none = "none" ;
                }
                $replacement_name = "list-of-" . $yes_no_vote_none . "-incompatibile-proposal-ids" ;
                if ( &dashrep_get_replacement( $replacement_name ) ne "" )
                {
                    &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . ", " ) ;
                }
                &dashrep_define( $replacement_name , &dashrep_get_replacement( $replacement_name ) . $then_not_proposal ) ;
            }
        }
        foreach $yes_no_vote_none ( "yes" , "no" , "vote" , "none" )
        {
            $replacement_name = "list-of-" . $yes_no_vote_none . "-incompatibile-proposal-ids" ;
            $global_log_output .= "<getincompatibilityinfo>" . $replacement_name . " = " . &dashrep_get_replacement( $replacement_name ) . " <\/getincompatibilityinfo>" ;
        }
    }
    $global_log_output .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;


#-----------------------------------------------
#  End of subroutine.

}

