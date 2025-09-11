#-----------------------------------------------
#-----------------------------------------------
#          proposal_ranking_elements_generate
#-----------------------------------------------
#-----------------------------------------------
#  Generate the replacements that contain the
#  proposal-specific information for a ranking
#  table, either the overall or voter-specific
#  type.

sub proposal_ranking_elements_generate
{


#-----------------------------------------------
#  If a "move proposal" page is to be displayed,
#  remove the proposal that is being moved.

    $global_log_output .= "<rankelements>Page name: " . $global_page_name . "<\/rankelements>" ;
    if ( ( $global_page_name eq "page-move-my-proposal" ) || ( $global_page_name eq "page-move-other-voter-proposal" ) || ( $global_page_name eq "page-move-tie-break-proposals" ) )
    {
        $proposal_being_moved = int( &dashrep_get_replacement( "input-validated-proposalid" ) ) ;
        $global_log_output .= "<rankelements>Will remove proposal " . $proposal_id . " from proposal lists<\/rankelements>" ;
        @copy_of_list_of_proposal_ids_ranked_positive = @global_list_of_proposal_ids_ranked_positive ;
        @global_list_of_proposal_ids_ranked_positive = ( ) ;
        foreach $proposal_id ( @copy_of_list_of_proposal_ids_ranked_positive )
        {
            if ( $proposal_id != $proposal_being_moved )
            {
                push( @global_list_of_proposal_ids_ranked_positive , $proposal_id ) ;
                $global_log_output .= "<rankelements>Proposal " . $proposal_id . " retained<\/rankelements>" ;
            } else
            {
                $global_log_output .= "<rankelements>Proposal " . $proposal_id . " removed from proposals ranked positive<\/rankelements>" ;
            }
        }
        @copy_of_list_of_proposal_ids_ranked_negative = @global_list_of_proposal_ids_ranked_negative ;
        @global_list_of_proposal_ids_ranked_negative = ( ) ;
        foreach $proposal_id ( @copy_of_list_of_proposal_ids_ranked_negative )
        {
            if ( $proposal_id != $proposal_being_moved )
            {
                push( @global_list_of_proposal_ids_ranked_negative , $proposal_id ) ;
                $global_log_output .= "<rankelements>Proposal " . $proposal_id . " retained<\/rankelements>" ;
            } else
            {
                $global_log_output .= "<rankelements>Proposal " . $proposal_id . " removed from proposals ranked negative<\/rankelements>" ;
            }
        }
    }


#-----------------------------------------------
#  Create replacements that contain each of the
#  three lists of proposal ID numbers: positive,
#  neutral, and negative.

    &dashrep_define( "list-of-proposal-ids-ranked-positive" , join( "," , @global_list_of_proposal_ids_ranked_positive ) ) ;
    $global_log_output .= "<rankelements>List of proposals ranked positive: " . &dashrep_get_replacement( "list-of-proposal-ids-ranked-positive" ) . "<\/rankelements>" ;

    &dashrep_define( "list-of-proposal-ids-ranked-neutral" , join( "," , @global_list_of_proposal_ids_ranked_neutral ) ) ;
    $global_log_output .= "<rankelements>List of proposals ranked neutral: " . &dashrep_get_replacement( "list-of-proposal-ids-ranked-neutral" ) . "<\/rankelements>" ;

    &dashrep_define( "list-of-proposal-ids-ranked-negative" , join( "," , @global_list_of_proposal_ids_ranked_negative ) ) ;
    $global_log_output .= "<rankelements>List of proposals ranked negative: " . &dashrep_get_replacement( "list-of-proposal-ids-ranked-negative" ) . "<\/rankelements>" ;


#-----------------------------------------------
#  Combine the three lists into a single list of
#  proposal IDs.

    @full_list_of_displayed_proposal_ids = ( @global_list_of_proposal_ids_ranked_positive , @global_list_of_proposal_ids_ranked_neutral , @global_list_of_proposal_ids_ranked_negative ) ;


#-----------------------------------------------
#  Count the total number of proposal IDs in
#  these three lists.

    $number_of_proposals = $#full_list_of_displayed_proposal_ids + 1 ;
    $global_log_output .= "<rankelements>Count of proposals: " . $number_of_proposals . "<\/rankelements>" ;


#-----------------------------------------------
#  Create the needed replacements.
#  Here the ranking levels are the user-viewed
#  convention, with 1 being the highest.
#  (Internal code rankings use the inverse
#  convention.)

    $ranking_level = 1 ;
    $global_log_output .= "<rankelements>Creating needed replacements<\/rankelements>" ;
    for ( $ranking_pointer = 0 ; $ranking_pointer <= $#full_list_of_displayed_proposal_ids ; $ranking_pointer ++ )
    {
        $proposal_id = $full_list_of_displayed_proposal_ids[ $ranking_pointer ] ;
        $global_log_output .= "<rankelements>Next proposal ID: " . $proposal_id . "<\/rankelements>" ;
        &dashrep_define( "ranking-level-for-proposalid-" . $proposal_id , $ranking_level ) ;
        &dashrep_define( "possible-estimated-for-proposalid-" . $proposal_id , "" ) ;
        if ( $ranking_level == 1 )
        {
            &dashrep_define( "possible-words-highest-lowest-for-proposalid-" . $proposal_id , "words-highest-proposal-usage-in-ranking-column" ) ;
        } elsif ( $ranking_level == $number_of_proposals  )
        {
            &dashrep_define( "possible-words-highest-lowest-for-proposalid-" . $proposal_id , "words-lowest-proposal-usage-in-ranking-column" ) ;
        } else
        {
            &dashrep_define( "possible-words-highest-lowest-for-proposalid-" . $proposal_id , "" ) ;
        }
        $ranking_level ++ ;
        &dashrep_define( "overall-ranking-level-for-proposalid-" . $proposal_id , "(?)" ) ;
    }


#-----------------------------------------------
#  Indicate that the ranking numbers for the
#  neutral category are estimated.

    for ( $ranking_pointer = 0 ; $ranking_pointer <= $#global_list_of_proposal_ids_ranked_neutral ; $ranking_pointer ++ )
    {
        $proposal_id = $global_list_of_proposal_ids_ranked_neutral[ $ranking_pointer ] ;
        &dashrep_define( "possible-estimated-for-proposalid-" . $proposal_id , "words-estimated-ranking-usage-in-ranking-column" ) ;
    }

#-----------------------------------------------
#  Indicate the ranking categories for the
#  positive, neutral, and negative categories.
#  This information is used to mark rows with
#  different colors.

    $global_log_output .= "<rankelements>Categorizing the ranking levels<\/rankelements>" ;
    for ( $ranking_pointer = 0 ; $ranking_pointer <= $#full_list_of_displayed_proposal_ids ; $ranking_pointer ++ )
    {
        $proposal_id = $full_list_of_displayed_proposal_ids[ $ranking_pointer ] ;
        $global_log_output .= "<rankelements>Next proposal ID: " . $proposal_id . "<\/rankelements>" ;
        $global_log_output .= "<rankelements>Ranking pointer: " . $ranking_pointer . "<\/rankelements>" ;
        $global_log_output .= "<rankelements>Positive limit: " . $#global_list_of_proposal_ids_ranked_positive . "<\/rankelements>" ;
        $global_log_output .= "<rankelements>Negative limit: " . ( $#global_list_of_proposal_ids_ranked_positive + $#global_list_of_proposal_ids_ranked_neutral ) . "<\/rankelements>" ;
        if ( $ranking_pointer <= $#global_list_of_proposal_ids_ranked_positive )
        {
            &dashrep_define( "positive-neutral-negative-capitalized-for-proposalid-" . $proposal_id , "Positive" ) ;
            $global_log_output .= "<rankelements>Categorized as Positive<\/rankelements>" ;
        } elsif ( $ranking_pointer > $#global_list_of_proposal_ids_ranked_positive + 1 + $#global_list_of_proposal_ids_ranked_neutral )
        {
            &dashrep_define( "positive-neutral-negative-capitalized-for-proposalid-" . $proposal_id , "Negative" ) ;
            $global_log_output .= "<rankelements>Categorized as Negative<\/rankelements>" ;
        } else
        {
            &dashrep_define( "positive-neutral-negative-capitalized-for-proposalid-" . $proposal_id , "Neutral" ) ;
            $global_log_output .= "<rankelements>Categorized as Neutral<\/rankelements>" ;
        }
    }


#-----------------------------------------------
#  In case it's needed, get the most recent
#  overall ranking sequence to display.
#  This enables a comparison of a voter's
#  ranking sequence with the overall result
#  sequence.

    $sequence = &dashrep_get_replacement( "rankoverall-preferencesaccepted" ) . "," . &dashrep_get_replacement( "rankoverall-preferencesunpopular" ) ;
#        $global_log_output .= "<rankelements>Overall sequence: " . $sequence . "<\/rankelements>" ;
    @overall_ranking_sequence = &split_delimited_items_into_array( $sequence ) ;
    $global_log_output .= "<rankelements>List of acceptable and unpopular proposals: " . join( "," , @overall_ranking_sequence ) . "<\/rankelements>" ;
    for ( $pointer = 0 ; $pointer <= $#overall_ranking_sequence ; $pointer ++ )
    {
        $proposal_id = $overall_ranking_sequence [ $pointer ] ;
        $ranking_level = $pointer + 1 ;
        &dashrep_define( "overall-ranking-level-for-proposalid-" . $proposal_id , $ranking_level ) ;
        $global_log_output .= "<rankelements>Proposal " . $proposal_id . " at overall ranking level " . $ranking_level . "<\/rankelements>" ;
    }
    $sequence = &dashrep_get_replacement( "rankoverall-preferencesincompatible" ) ;
    @overall_ranking_sequence = &split_delimited_items_into_array( $sequence ) ;
    $global_log_output .= "<rankelements>List of incompatible proposals: " . join( "," , @overall_ranking_sequence ) . "<\/rankelements>" ;
    for ( $pointer = 0 ; $pointer <= $#overall_ranking_sequence ; $pointer ++ )
    {
        $proposal_id = $overall_ranking_sequence [ $pointer ] ;
        &dashrep_define( "overall-ranking-level-for-proposalid-" . $proposal_id , "words-incompatible-usage-overall-level" ) ;
        $global_log_output .= "<rankelements>Proposal " . $proposal_id . " is in the incompatible category<\/rankelements>" ;
    }


#-----------------------------------------------
#  End of subroutine.

}

