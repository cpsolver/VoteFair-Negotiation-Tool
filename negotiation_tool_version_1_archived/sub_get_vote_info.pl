#-----------------------------------------------
#-----------------------------------------------
#          get_vote_info
#-----------------------------------------------
#-----------------------------------------------
#  For the voters listed in
#  @global_list_of_vote_info_participant_ids
#  and the proposals listed in
#  @global_list_of_vote_info_proposal_ids,
#  get the sequences that indicate voter
#  rankings.
#
#  Put their equivalent non-overlapping
#  preference-level numbers into a one-dimensional
#  array that functions like a two-dimensional
#  array.
#
#  Also set up pointer arrays that associate
#  proposal ID numbers with consecutive proposal
#  count numbers.
#
#  Also, using only positive rankings -- without
#  neutrality (tie-resolution) and negative
#  rankings -- count how many voters support each
#  proposal.

sub get_vote_info
{


#-----------------------------------------------
#  Initialization.

    @global_vote_count_positive_only_for_proposal_id = ( ) ;
    @global_vote_count_negative_only_for_proposal_id = ( ) ;
    $global_log_output .= "<getvoteinfo>Entered get-vote-info subroutine<\/getvoteinfo>" ;


#-----------------------------------------------
#  Log which participants and which proposals are
#  considered.

    $global_log_output .= "<getvoteinfo>Considering participant IDs: " . join( "," , @global_list_of_vote_info_participant_ids ) . "<\/getvoteinfo>" ;
    $global_log_output .= "<getvoteinfo>Considering proposal IDs: " . join( "," , @global_list_of_vote_info_proposal_ids ) . "<\/getvoteinfo>" ;


#-----------------------------------------------
#  Identify which proposal ID numbers are considered.
#  (All other proposals are ignored.)

    foreach $proposal_id ( @global_list_of_vote_info_proposal_ids )
    {
        $true_considering_proposal_id[ $proposal_id ] = $global_true ;
    }


#-----------------------------------------------
#  Get the default tie-resolution ranking, which
#  is used for voter-unranked proposals.

    $global_log_output .= "<getvoteinfo>Getting sort-tie ranking<\/getvoteinfo>" ;
    &sort_tie_resolution_ranking ;
    $global_log_output .= "<getvoteinfo>Done getting sort-tie ranking<\/getvoteinfo>" ;

    &log_write ;
    &error_check ;


#-----------------------------------------------
#  Create offset pointers into the proposal info.
#  These arrays associate proposal ID numbers
#  with consecutive proposal count numbers.
#  Also count the proposals being considered.

    $proposal_count = 0 ;
    $global_proposal_count_for_proposal_id[ 0 ] = 0 ;
    for ( $proposal_pointer = 0 ; $proposal_pointer <= $#global_list_of_vote_info_proposal_ids ; $proposal_pointer ++ )
    {
        $proposal_id = $global_list_of_vote_info_proposal_ids[ $proposal_pointer ] ;
        $proposal_count ++ ;
        $global_proposal_id_for_proposal_count[ $proposal_count ] = $proposal_id ;
        $global_proposal_count_for_proposal_id[ $proposal_id ] = $proposal_count ;
        $global_log_output .= "<getvoteinfo>Proposal ID " . $proposal_id . " is at proposal count " . $proposal_count . "<\/getvoteinfo>" ;
    }
    $global_number_of_proposals = $proposal_count ;


#-----------------------------------------------
#  Begin a loop that repeats for each listed voter.

    $voter_count = 0 ;
    for ( $participant_pointer = 0 ; $participant_pointer <= $#global_list_of_vote_info_participant_ids ; $participant_pointer ++ )
    {
        $voter_count ++ ;
        $participant_id = $global_list_of_vote_info_participant_ids[ $participant_pointer ] ;
        $global_log_output .= "<getvoteinfo>Considering participant: " . $participant_id . " (and voter count " . $voter_count . ")<\/getvoteinfo>" ;


#-----------------------------------------------
#  Create participant-specific offset pointers into the
#  preference information.
#  This array associates participant IDs
#  with consecutive voter (not just participant) count numbers.

        $global_participant_id_for_voter_count[ $voter_count ] = $participant_id ;
        $global_voter_count_for_participant_id[ $participant_id ] = $voter_count ;


#-----------------------------------------------
#  Create, for this participant, the offset into
#  the array that holds all preferences.

        $vote_info_offset_for_current_voter = $global_number_of_proposals * ( $voter_count - 1 ) - 1 ;
        $global_vote_info_offset_for_participant_id[ $participant_id ] = $vote_info_offset_for_current_voter ;
        $global_log_output .= "<getvoteinfo>Vote info offset: " . $vote_info_offset_for_current_voter . "<\/getvoteinfo>" ;


#-----------------------------------------------
#  Get this voter's positive and negative ranking
#  sequences.

        $positive_ranking_sequence = &dashrep_get_replacement( "voteinfo-preferencespositive-for-participantid-" . $participant_id ) ;
        @list_of_positive_ranked_proposal_ids = &split_delimited_items_into_array( $positive_ranking_sequence ) ;

        $negative_ranking_sequence = &dashrep_get_replacement( "voteinfo-preferencesnegative-for-participantid-" . $participant_id ) ;
        @list_of_negative_ranked_proposal_ids = &split_delimited_items_into_array( $negative_ranking_sequence ) ;

        $global_log_output .= "<getvoteinfo>Voter's proposal ranking, positive: " . join( "," , @list_of_positive_ranked_proposal_ids ) . "<\/getvoteinfo>" ;
        $global_log_output .= "<getvoteinfo>Voter's proposal ranking, negative: " . join( "," , @list_of_negative_ranked_proposal_ids ) . "<\/getvoteinfo>" ;


#-----------------------------------------------
#  Using only the positive rankings -- without
#  neutrality (tie-resolution) and negative
#  rankings -- count how many voters support each
#  proposal.
#  Also do the same counting for negative-only
#  votes.

        foreach $proposal_id ( @list_of_positive_ranked_proposal_ids )
        {
            $global_vote_count_positive_only_for_proposal_id[ $proposal_id ] ++ ;
        }
        foreach $proposal_id ( @list_of_negative_ranked_proposal_ids )
        {
            $global_vote_count_negative_only_for_proposal_id[ $proposal_id ] ++ ;
        }


#-----------------------------------------------
#  Clear an array that tracks how many times
#  each proposal ID is listed in this voter's
#  preferences.
#  (Only the first occurrance will be considered.)

        @use_count_for_proposal_count = ( ) ;


#-----------------------------------------------
#  Starting at the top, assign a preference level
#  to each positively ranked proposal.

        $non_duplicate_proposal_count = 0 ;
        $ranking_level = $#global_list_of_vote_info_proposal_ids + 1 ;
        $global_log_output .= "<getvoteinfo>Initial ranking level is " . $ranking_level . "</getvoteinfo>" ;
        for ( $proposal_pointer = 0 ; $proposal_pointer <= $#list_of_positive_ranked_proposal_ids ; $proposal_pointer ++ )
        {
            $proposal_id = $list_of_positive_ranked_proposal_ids[ $proposal_pointer ] ;
            $proposal_count = $global_proposal_count_for_proposal_id[ $proposal_id ] ;
            if ( $use_count_for_proposal_count[ $proposal_count ] == 0 )
            {
                if ( $ranking_level < 1 )
                {
                    $global_log_output .= "<getvoteinfo>ERROR:  Ranking level is " . $ranking_level. " which is less than one!</getvoteinfo>" ;
                }
                $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] = $ranking_level ;
                $global_log_output .= "<getvoteinfo>Proposal ID " . $proposal_id . " is at ranking level " . $ranking_level . "</getvoteinfo>" ;
                $ranking_level -- ;
                $use_count_for_proposal_count[ $proposal_count ] ++ ;
                $non_duplicate_proposal_count ++ ;
            } else
            {
                $global_log_output .= "<getvoteinfo>Proposal ID " . $proposal_id . " was repeated.</getvoteinfo>" ;
            }
        }
        $ranking_level_just_below_positive_ranked_proposals = $ranking_level ;


#-----------------------------------------------
#  Make the count of this voter's positive-ranked
#  proposals available outside this subroutine.

        $global_log_output .= "<getvoteinfo>Participant ID " . $participant_id . "<\/getvoteinfo>" ;
        $global_proposal_count_positive_ranked_for_participant_id[ $participant_id ] = $non_duplicate_proposal_count ;
        $global_log_output .= "<getvoteinfo>Number of positively ranked proposals is " . $non_duplicate_proposal_count . " </getvoteinfo>" ;


#-----------------------------------------------
#  Starting at the bottom, assign a preference level
#  to each negatively ranked proposal.

        $non_duplicate_proposal_count = 0 ;
        $ranking_level = 1 ;
        for ( $proposal_pointer = $#list_of_negative_ranked_proposal_ids ; $proposal_pointer >= 0 ; $proposal_pointer -- )
        {
            $proposal_id = $list_of_negative_ranked_proposal_ids[ $proposal_pointer ] ;
            $proposal_count = $global_proposal_count_for_proposal_id[ $proposal_id ] ;
            if ( $use_count_for_proposal_count[ $proposal_count ] == 0 )
            {
                $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] = $ranking_level ;
                $global_log_output .= "<getvoteinfo>Proposal ID " . $proposal_id . " is at ranking level " . $ranking_level . "</getvoteinfo>" ;
                $ranking_level ++ ;
                $use_count_for_proposal_count[ $proposal_count ] ++ ;
                $non_duplicate_proposal_count ++ ;
            } else
            {
                $global_log_output .= "<getvoteinfo>Proposal ID " . $participant_id . " was repeated.</getvoteinfo>" ;
            }
        }


#-----------------------------------------------
#  Make the count of this voter's negative-ranked
#  proposals available outside this subroutine.

        $global_log_output .= "<getvoteinfo>Participant ID " . $participant_id . "<\/getvoteinfo>" ;
        $global_proposal_count_negative_ranked_for_participant_id[ $participant_id ] = $non_duplicate_proposal_count ;
        $global_log_output .= "<getvoteinfo>Number of negatively ranked proposals is " . $non_duplicate_proposal_count . " </getvoteinfo>" ;


#-----------------------------------------------
#  Using the tie-resolution sequence,
#  assign a preference level to each proposal
#  that the voter has not yet ranked.

        $ranking_level = $ranking_level_just_below_positive_ranked_proposals ;
        for ( $proposal_pointer = 0 ; $proposal_pointer <= $#global_tie_resolution_rank_order ; $proposal_pointer ++ )
        {
            $proposal_id = $global_tie_resolution_rank_order[ $proposal_pointer ] ;
#            $proposal_id = @global_tie_resolution_rank_order[ $proposal_pointer ] ;
            $proposal_count = $global_proposal_count_for_proposal_id[ $proposal_id ] ;
            if ( $use_count_for_proposal_count[ $proposal_count ] == 0 )
            {
                if ( $ranking_level < 1 )
                {
                    $global_log_output .= "<getvoteinfo>ERROR:  Ranking level is " . $ranking_level. " which is less than one!</getvoteinfo>" ;
                }
                $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] = $ranking_level ;
                $global_log_output .= "<getvoteinfo>Proposal ID " . $proposal_id . " is at ranking level " . $ranking_level . "</getvoteinfo>" ;
                $ranking_level -- ;
                $use_count_for_proposal_count[ $proposal_count ] ++ ;
            }
        }


#-----------------------------------------------
#  Log the ranking for this voter.

        $global_log_output .= "<getvoteinfo>For voter " . $participant_id . " the proposal IDs and ranking levels are: " . "</getvoteinfo>" ;
        for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
        {
            $ranking_level = $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] ;
            $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
            $global_log_output .= "<getvoteinfo>    proposal " . $proposal_id . " at level " . $ranking_level . "</getvoteinfo>" ;
        }


#-----------------------------------------------
#  Repeat the loop for the next voter.

    }


#-----------------------------------------------
#  Count the number of considered voters.

    $global_vote_info_number_of_voters = $voter_count ;
    $global_log_output .= "<getvoteinfo>Voter count: " . $global_vote_info_number_of_voters . "</getvoteinfo>" ;


#-----------------------------------------------
#  Show how many voters positively support each
#  proposal.

    foreach $proposal_id ( @global_list_of_vote_info_proposal_ids )
    {
        $global_log_output .= "<getvoteinfo>For proposal " . $proposal_id . " there are " . $global_vote_count_positive_only_for_proposal_id[ $proposal_id ] . " voters who positively support this proposal.<\/getvoteinfo>" ;
    }


#-----------------------------------------------
#  Log the contents of the output arrays.

    $global_log_output .= "<getvoteinfo>Proposal ID array: " . join( "," , @global_list_of_vote_info_proposal_ids ) . "</getvoteinfo>" ;

    $global_log_output .= "<getvoteinfo>Array proposal_count_for_proposal_id contents: " . join( "," , @global_proposal_count_for_proposal_id ) . "</getvoteinfo>" ;

    $global_log_output .= "<getvoteinfo>Ranking-level array: " . join( "," , @global_array_preference_level_for_voter_and_proposal ) . "</getvoteinfo>" ;
    &log_write ;


#-----------------------------------------------
#  End of subroutine.

}

