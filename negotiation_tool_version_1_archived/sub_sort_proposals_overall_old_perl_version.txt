#-----------------------------------------------
#-----------------------------------------------
#            sort_proposals_overall
#-----------------------------------------------
#-----------------------------------------------
#  Use a variation of VoteFair representation
#  ranking to calculate the overall ranking order
#  for all the proposals.


sub sort_proposals_overall
{

    $global_log_output .= "<negrank>Entered sort-proposals-overall subroutine<\/negrank>" ;
    &log_write ;
    &error_check ;


#-----------------------------------------------
#  Indicate the degree of represenation desired,
#  and how much of each kind of adjustment.
#  If a simple popularity ranking is desired,
#  the total number will be zero.  If full
#  representation is desired, the total will be
#  100%.
#  First adjustment type is based on raw pairwise-
#  comparison counts.
#  Second adjustment type is based on whether a
#  voter ranks an accepted proposal as positive
#  (rather than negative or neutral).
#  Third adjustment type is based on whether a
#  voter ranks an accepted proposal as negative
#  (rather than positive or neutral).
#  The different types involve subtle distictions
#  that may not make any difference in many cases.
#  If the numbers sum to more than 100, adjust
#  the values.

    $percent_representation_based_on_raw_pairwise_counts = int( &dashrep_get_replacement( "percent-of-representation-based-on-raw-pairwise-counts" ) ) ;
    if ( $percent_representation_based_on_raw_pairwise_counts < 1 )
    {
        $percent_representation_based_on_raw_pairwise_counts = 0 ;
    } elsif ( $percent_representation_based_on_raw_pairwise_counts > 99 )
    {
        $percent_representation_based_on_raw_pairwise_counts = 100 ;
    }
    $global_log_output .= "<negrank>Percent representation based on raw pairwise counts is " . $percent_representation_based_on_raw_pairwise_counts . "</negrank>" ;

    $percent_representation_based_on_positive_ranking = int( &dashrep_get_replacement( "percent-of-representation-based-on-positive-ranking" ) ) ;
    if ( $percent_representation_based_on_positive_ranking < 1 )
    {
        $percent_representation_based_on_positive_ranking = 0 ;
    } elsif ( $percent_representation_based_on_positive_ranking > 99 )
    {
        $percent_representation_based_on_positive_ranking = 100 ;
    }
    $global_log_output .= "<negrank>Percent representation based on positive ranking is " . $percent_representation_based_on_positive_ranking . "</negrank>" ;

    $percent_representation_based_on_negative_ranking = int( &dashrep_get_replacement( "percent-of-representation-based-on-negative-ranking" ) ) ;
    if ( $percent_representation_based_on_negative_ranking < 1 )
    {
        $percent_representation_based_on_negative_ranking = 0 ;
    } elsif ( $percent_representation_based_on_negative_ranking > 99 )
    {
        $percent_representation_based_on_negative_ranking = 100 ;
    }
    $global_log_output .= "<negrank>Percent representation based on negative ranking is " . $percent_representation_based_on_negative_ranking . "</negrank>" ;

#  If needed for debugging...
#    $percent_representation_based_on_raw_pairwise_counts = 40 ;
#    $percent_representation_based_on_positive_ranking = 30 ;
#    $percent_representation_based_on_negative_ranking = 30 ;

    $total = $percent_representation_based_on_raw_pairwise_counts + $percent_representation_based_on_positive_ranking + $percent_representation_based_on_negative_ranking ;
    if ( $total > 100 )
    {
        $percent_representation_based_on_raw_pairwise_counts = int( 100 * $percent_representation_based_on_raw_pairwise_counts / $total );
        $percent_representation_based_on_positive_ranking = int( 100 * $percent_representation_based_on_positive_ranking / $total );
        $percent_representation_based_on_negative_ranking = int( 100 * $percent_representation_based_on_negative_ranking / $total );
        $global_log_output .= "<negrank>Adjusted percent representation based on raw pairwise counts is " . $percent_representation_based_on_raw_pairwise_counts . "</negrank>" ;
        $global_log_output .= "<negrank>Adjusted percent representation based on positive ranking is " . $percent_representation_based_on_positive_ranking . "</negrank>" ;
        $global_log_output .= "<negrank>Adjusted percent representation based on negative ranking is " . $percent_representation_based_on_negative_ranking . "</negrank>" ;
    }


#-----------------------------------------------
#  Get the specified majority threshold percentage.
#  Also, in case the majority count needs to be
#  displayed before it is calculated below (after
#  counting the number of voters), specify the
#  majority count as unknown.

    $global_majority_threshold_percent = int( &dashrep_get_replacement( "case-info-majoritypercentage" ) ) ;
    &dashrep_define( "majority-threshold-percent" , $global_majority_threshold_percent ) ;
    &dashrep_define( "majority-threshold" , "word-unknown-in-brackets" ) ;


#-----------------------------------------------
#  Get the specified minority threshold percentage.
#  Also, in case the minority count needs to be
#  displayed before it is calculated below (after
#  counting the number of voters), specify the
#  minority threshold as unknown.

    $global_minority_threshold_percent = int( &dashrep_get_replacement( "case-info-minoritypercentage" ) ) ;
    &dashrep_define( "minority-threshold-percent" , $global_minority_threshold_percent ) ;


#-----------------------------------------------
#  Initialize the list of acceptable proposal ID
#  numbers.  The order of proposals in the list
#  will indicate the order in which they are
#  accepted.

    @list_of_proposal_ids_accepted = ( ) ;


#-----------------------------------------------
#  Initialize the list of proposals that are
#  incompatible with the accepted proposals.

    @list_of_proposal_ids_incompatible = ( ) ;


#-----------------------------------------------
#  Initialize the list of remaining proposals,
#  which are not popular enough and not
#  incompatible (with the acceptable proposals).

    @list_of_proposal_ids_unpopular = ( ) ;


#-----------------------------------------------
#  In case of an early exit, copy the now-empty
#  result arrays to the output arrays.

    @global_list_of_proposal_ids_ranked_positive = @list_of_proposal_ids_accepted ;
    @global_list_of_proposal_ids_ranked_neutral = @list_of_proposal_ids_unpopular ;
    @global_list_of_proposal_ids_ranked_negative = @list_of_proposal_ids_incompatible ;


#-----------------------------------------------
#  Specify which proposal IDs are to be sorted,
#  and count them.

    @global_list_of_vote_info_proposal_ids = @global_list_of_all_proposal_ids ;
    $global_log_output .= "<negrank>Proposal IDs: " . join( "," , @global_list_of_vote_info_proposal_ids ) . "</negrank>" ;
    $global_number_of_proposals = $#global_list_of_vote_info_proposal_ids + 1 ;
    $global_log_output .= "<negrank>Proposal count is " . $global_number_of_proposals . "</negrank>" ;


#-----------------------------------------------
#  Convert the tie-resolution ranking level
#  information into the internal (hidden from users)
#  convention where higher numbers indicate
#  higher ranking.

    $ranking_level = $global_number_of_proposals ;
    for ( $proposal_pointer = 0 ; $proposal_pointer <= $#global_tie_resolution_rank_order ; $proposal_pointer ++ )
    {
        $proposal_id = $global_tie_resolution_rank_order[ $proposal_pointer ] ;
        $tie_resolution_rank_level_for_proposal_id[ $proposal_id ] = $ranking_level ;
        $global_log_output .= "<negrank>Proposal " . $proposal_id . " is at tie resolution ranking level " . $ranking_level . "<\/negrank>" ;
        $ranking_level -- ;
    }


#-----------------------------------------------
#  If only an overall popularity ranking is
#  requested, specify that variation.

    $overall_popularity_ranking_requested = $global_false ;
    if ( &dashrep_get_replacement( "parameter-category-ranking-type" ) =~ "overallpopularity" )
    {
        $overall_popularity_ranking_requested = $global_true ;
    }


#-----------------------------------------------
#  Determine the criteria for acceptance, which
#  is either "average" or "each".

    $acceptance_criteria_average = 1 ;
    $acceptance_criteria_each = 2 ;
    if ( &dashrep_get_replacement( "case-info-acceptancecriteria" ) =~ /average/i )
    {
        $acceptance_criteria = $acceptance_criteria_average ;
        &dashrep_define( "acceptance-criteria" , "Average" ) ;
        $global_log_output .= "<negrank>Acceptance criteria: average<\/negrank>" ;
    } elsif ( &dashrep_get_replacement( "case-info-acceptancecriteria" ) =~ /each/i )
    {
        $acceptance_criteria = $acceptance_criteria_each ;
        &dashrep_define( "acceptance-criteria" , "Each" ) ;
        $global_log_output .= "<negrank>Acceptance criteria: each<\/negrank>" ;
    } else
    {
        $acceptance_criteria = $acceptance_criteria_each ;
        &dashrep_define( "acceptance-criteria" , "Each" ) ;
        $global_log_output .= "<negrank>Acceptance criteria not recognized, so using EACH criteria<\/negrank>" ;
    }


#-----------------------------------------------
#  If there is not at least one proposal, just
#  return.

    if ( $global_number_of_proposals < 1 )
    {
        $global_log_output .= "<negrank>The number of proposals is zero (" . $global_number_of_proposals . ") so no sorting is needed.<\/negrank>" ;
        &log_write ;
        &error_check ;
        return ;
    }


#-----------------------------------------------
#  Log the participant ID numbers for all
#  the voters, and count the number of voters.

    $global_log_output .= "<negrank>Participant IDs: " . join( "," , @global_list_of_all_voter_participant_ids ) . "<\/negrank>" ;

    $global_number_of_voters = $#global_list_of_all_voter_participant_ids + 1 ;
    $global_log_output .= "<negrank>Voter count is " . $global_number_of_voters . "<\/negrank>" ;


#-----------------------------------------------
#  If there is not at least one voter, return the
#  default tie-resolution ranking order in the
#  unpopular category.
#  Ensure that no proposal IDs are added to the
#  list of ones to be sorted.

    if ( $global_number_of_voters < 1 )
    {
        $global_log_output .= "<negrank>There are no voters<\/negrank>" ;

        $global_log_output .= "<negrank>Getting sort-tie ranking<\/negrank>" ;
        &sort_tie_resolution_ranking ;
        $global_log_output .= "<negrank>Done getting sort-tie ranking<\/negrank>" ;

        @using_proposal_id = ( ) ;
        foreach $proposal_id ( @global_list_of_vote_info_proposal_ids )
        {
            $using_proposal_id[ $proposal_id ] = $global_true
        }
        for ( $proposal_pointer = 0 ; $proposal_pointer <= $#global_tie_resolution_rank_order ; $proposal_pointer ++ )
        {
            $proposal_id = $global_tie_resolution_rank_order[ $proposal_pointer ] ;
            if ( $using_proposal_id[ $proposal_id ] == $global_true )
            {
                push ( @list_of_proposal_ids_unpopular , $proposal_id ) ;
                &dashrep_define( "percentage-positive-only-votes-for-proposalid-" . $proposal_id , "0" ) ;
                $global_log_output .= "<negrank>Next proposal ID is " . $proposal_id . "<\/negrank>" ;
                $global_overall_ranking_criteria_for_proposal[ $proposal_id ] = "no-votes-yet" ;
            }
        }
        @global_list_of_proposal_ids_ranked_neutral = @list_of_proposal_ids_unpopular ;

        &dashrep_define( "table-overall-proposals-multiple" , &dashrep_get_replacement( "table-overall-proposals-no-votes" ) ) ;

        $global_log_output .= "<negrank>The number of voters is zero, so using default tie-resolution order.<\/negrank>" ;

        &proposal_ranking_elements_generate ;

        return ;
    }


#-----------------------------------------------
#  For the specified proposal ID numbers,
#  and for all the voters (participants who can
#  vote), read all the voting
#  information and put their equivalent
#  non-overlapping preference-level
#  numbers into a one-dimensional array that
#  functions like a two-dimensional array.
#  Also set up pointer arrays that associate
#  proposal ID numbers with consecutive proposal
#  count numbers.
#  Also, get the tie-resolution ranking levels.
#  Also, using only positive or negative rankings
#  -- without neutrality (tie-resolution) rankings
#  -- count how many voters support and oppose
#  each proposal.

    &log_write ;
    @global_list_of_vote_info_participant_ids = @global_list_of_all_voter_participant_ids ;

    $global_log_output .= "<negrank>Getting voter info</negrank>" ;
    &get_vote_info ;
    $global_log_output .= "<negrank>Done getting voter info</negrank>" ;

    &log_write ;

    @local_array_preference_level_for_voter_and_proposal = @global_array_preference_level_for_voter_and_proposal ;

#    $global_log_output .= "<negrank>Ranking-level array: " . join( "," , @local_array_preference_level_for_voter_and_proposal ) . "</negrank>" ;


#-----------------------------------------------
#  Log the voter preferences grouped by voter.

    $array_pointer = 0 ;
    for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
    {
        $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
        $global_log_output .= "<negrank>Voter " . $participant_id . " prefs: " ;
        for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
        {
            $need_comma = $global_true ;
            $global_log_output .= $local_array_preference_level_for_voter_and_proposal[ $array_pointer ] ;
            $preference_level = $global_number_of_proposals - $proposal_count + 1;
            if ( $preference_level == $global_proposal_count_negative_ranked_for_participant_id[ $participant_id ] )
            {
                $global_log_output .= "*" ;
                $need_comma = $global_false ;
            }
            if ( $preference_level == $global_number_of_proposals - $global_proposal_count_positive_ranked_for_participant_id[ $participant_id ] )
            {
                $global_log_output .= "*" ;
                $need_comma = $global_false ;
            }
            if ( $need_comma == $global_true )
            {
                $global_log_output .= "," ;
            }
            $array_pointer ++ ;
        }
        $global_log_output .= "</negrank>" ;
    }


#-----------------------------------------------
#  If specified, assign how much weight each voter
#  has.  Allow decimal values, but not less than
#  one.  If not specified, use one vote per voter.

    $global_total_weight_of_all_votes = 0 ;
    for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
    {
        $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
        if ( &dashrep_get_replacement( "weight-for-voter-id-" . $participant_id ) =~ /([0-9\.]+)/ )
        {
            $weight_value = $1 ;
        } else
        {
            $weight_value = 1 ;
        }
        if ( $weight_value < 1 )
        {
            $weight_value = 1 ;
        }
        $global_total_weight_of_all_votes += $weight_value ;
        $weight_for_voter_count[ $voter_count ] = $weight_value ;
        $global_log_output .= "<negrank>Voter " . $participant_id . " has a weighted influence value of " . $weight_value . "</negrank>" ;
    }
    $global_log_output .= "<negrank>Total weight of all votes is " . $global_total_weight_of_all_votes . "</negrank>" ;


#-----------------------------------------------
#  Calculate a scale value that equals 100
#  divided by the total weight of all voters.

    $scale_value_based_on_voter_count = 1 / $global_total_weight_of_all_votes ;
    $global_log_output .= "<negrank>Scale value based on voter count is " . $scale_value_based_on_voter_count . "<\/negrank>" ;


#-----------------------------------------------
#  Calculate the positive-only-acceptance
#  percentage of each proposal.

        for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
        {
            $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
            $positive_only_vote_weight = 0 ;
            for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
            {
                $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;

                $lowest_positive_ranked_count = $global_number_of_proposals - $global_proposal_count_positive_ranked_for_participant_id[ $participant_id ] + 1 ;

                $vote_info_offset_for_current_voter = $global_number_of_proposals * ( $voter_count - 1 ) - 1 ;
#               Use global (non-local) version of preferences; local version has been adjusted.
                $preference_level = $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] ;
                if ( $preference_level >= $lowest_positive_ranked_count )
                {
                    $positive_only_vote_weight += $weight_for_voter_count[ $voter_count ] ;
                    $global_log_output .= "<negrank>Voter=" . $participant_id . " Pref level=" . $preference_level . " Lowest positive rank=" . $lowest_positive_ranked_count . " Ranked POSITIVE<\/negrank>" ;
                } else
                {
                    $global_log_output .= "<negrank>Voter=" . $participant_id . " Pref level=" . $preference_level . " Lowest positive rank=" . $lowest_positive_ranked_count . "<\/negrank>" ;
                }
            }
#            $global_log_output .= "<negrank>Positive only votes for most popular proposal equals " . $positive_only_vote_weight . "</negrank>" ;
            $percentage_positive_only_for_proposal[ $proposal_id ] = int( ( 100 * $positive_only_vote_weight / $global_total_weight_of_all_votes ) + 0.5 ) ;
            &dashrep_define( "percentage-positive-only-votes-for-proposalid-" . $proposal_id , $percentage_positive_only_for_proposal[ $proposal_id ] ) ;
            $global_log_output .= "<negrank>Weighted percentage positive only for most popular proposal is " . $percentage_positive_only_for_proposal[ $proposal_id ] . "</negrank>" ;
        }


#-----------------------------------------------
#  Create an array (virtually 2-D) that identifies
#  which proposal counts are incompatible with
#  which other proposal counts.

    for ( $proposal_count_if_accepted = 1 ; $proposal_count_if_accepted <= $global_number_of_proposals ; $proposal_count_if_accepted ++ )
    {
        $proposal_id_if_accepted = $global_proposal_id_for_proposal_count[ $proposal_count_if_accepted ] ;
        for ( $proposal_count_then_not_accepted = 1 ; $proposal_count_then_not_accepted <= $global_number_of_proposals ; $proposal_count_then_not_accepted ++ )
        {
            $proposal_id_then_not_accepted = $global_proposal_id_for_proposal_count[ $proposal_count_then_not_accepted ] ;
            $true_or_false_proposal_count_not_accepted_if_proposal_count[ ( $proposal_count_then_not_accepted - 1 ) * $global_number_of_proposals + $proposal_count_if_accepted ] = $global_false ;
            $replacement_name = "voteincompatibility-yesnoundecided-for-ifproposal-" . $proposal_id_if_accepted . "-thennotproposal-" . $proposal_id_then_not_accepted ;
            if ( &dashrep_get_replacement( $replacement_name ) =~ /y/ )
            {
                $true_or_false_proposal_count_not_accepted_if_proposal_count[ ( $proposal_count_then_not_accepted - 1 ) * $global_number_of_proposals + $proposal_count_if_accepted ] = $global_true ;
                $global_log_output .= "<negrank>If proposal " . $proposal_id_if_accepted . " is accepted then " . $proposal_id_then_not_accepted . " is not compatible<\/negrank>" ;
            }
        }
    }


#-----------------------------------------------
#  Calculate how many voters must, on average,
#  or for each proposal, must positively rank
#  proposals for them to be accepted.
#
#  If this threshold has to be achieved by
#  each (and every) accepted proposal,
#  minority voters would never get any of
#  their proposals passed.
#
#  If there are an even number of voters,
#  the threshold must be at least one more
#  than half the voters; otherwise an impasse
#  could occur, with the first proposal getting
#  locked into being acceptable and all other
#  proposals could be rejected as incompatible.

    $global_majority_threshold_percent = int( &dashrep_get_replacement( "case-info-majoritypercentage" ) ) ;
    $global_log_output .= "<negrank>Majority threshold percent is " . $global_majority_threshold_percent . "<\/negrank>" ;
    if ( $global_majority_threshold_percent > 50 )
    {
        $global_majority_threshold_decimal = $global_number_of_voters * $global_majority_threshold_percent / 100. ;
        $global_majority_threshold = int( $global_majority_threshold_decimal ) ;
        while ( $global_majority_threshold < $global_majority_threshold_decimal )
        {
            $global_majority_threshold ++ ;
        }
    } else
    {
        $global_majority_threshold = int( $global_number_of_voters / 2 ) ;
    }

    if ( $global_number_of_voters == 2 )
    {
        $global_majority_threshold = 2 ;
    }

    while ( ( $global_majority_threshold * 2 ) <= $global_number_of_voters )
    {
        $global_majority_threshold ++ ;
    }

    &dashrep_define( "majority-threshold" , $global_majority_threshold ) ;
    &dashrep_define( "majority-threshold-percent" , $global_majority_threshold_percent ) ;

    $global_log_output .= "<negrank>Majority threshold count (for this case) is " . $global_majority_threshold . "<\/negrank>" ;


#-----------------------------------------------
#  Calculate the percentage equivalent of the
#  just-calculated number.
#  If the result is greater than 40 and the
#  "average" acceptance criteria is to be used,
#  reduce the value to 40.  Otherwise the
#  voters who form the majority will get what
#  they want and minorities will not get what
#  they want.

    $majority_threshold_percent_based_on_majority_voter_count = 100 * $global_majority_threshold / $global_total_weight_of_all_votes ;
    if ( ( $acceptance_criteria == $acceptance_criteria_average ) && ( $majority_threshold_percent_based_on_majority_voter_count > 40 ) )
    {
          $majority_threshold_percent_based_on_majority_voter_count = 40 ;
    }
    $global_log_output .= "<negrank>Calculated majority threshold percentage is " . $majority_threshold_percent_based_on_majority_voter_count . "<\/negrank>" ;


#-----------------------------------------------
#  Get the percentage threshold value that
#  determines what portion of proposals to
#  temporarily ignore in the
#  successive-elimination portion of the overall
#  ranking process.
#  The value should be something like 10 to 30
#  percent, indicating that proposals that are
#  not in the top 10 to 30 percent should be
#  ignored for the second-pass ranking
#  calculations.
#  The number can be 100 percent to dismiss this
#  correction.
#  The correction reduces the
#  ability of a voter to rank an unpopular
#  proposal as their first choice as a way to
#  appear to be unable to get accepted a
#  proposal they supposedly really want
#  (which gives them more influence in choosing
#  later accepted propsals).

    $threshold_percentage_top_ranked_proposals_for_successive_elimination = &dashrep_get_replacement( "threshold-percentage-top-ranked-proposals-for-successive-elimination" ) ;
    $global_log_output .= "<negrank>Threshold percentage top ranked proposals for successive elimination is " . $threshold_percentage_top_ranked_proposals_for_successive_elimination . "</negrank>" ;


#-----------------------------------------------
#  Specify that, so far, all the proposals are being
#  considered.

    for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
    {
        $using_proposal_at_proposal_count[ $proposal_count ] = $global_true ;
        $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
        $global_log_output .= "<negrank>Proposal count " . $proposal_count . " corresponds to proposal ID " . $proposal_id . "<\/negrank>" ;
    }


#-----------------------------------------------
#  Initialize the influence-so-far values for
#  all the voters.

    for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
    {
        $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] = 0 ;
        $percent_opposing_influence_so_far_for_voter_count[ $voter_count ] = 0 ;
        $number_of_accepted_proposals_ranked_positive_by_voter_count[ $voter_count ] = 0 ;
        $number_of_accepted_proposals_ranked_negative_by_voter_count[ $voter_count ] = 0 ;
    }


#-----------------------------------------------
#  Begin a loop that identifies the first/next
#  proposal to be accepted.

    $loop_status_not_done = 1 ;
    $loop_status_done = 2 ;
    $loop_status = $loop_status_not_done ;
    $global_endless_loop_counter = 0 ;
    while ( $loop_status != $loop_status_done )
    {


#-----------------------------------------------
#  Stop if there is an endless loop.

        $global_endless_loop_counter ++ ;
        $global_log_output .= "<negrank>Endless loop counter = " . $global_endless_loop_counter . "<\/negrank>" ;
        if ( $global_endless_loop_counter > 300 )
        {
            $global_log_output .= "<negrank>ERROR! Loop count exceeded maximum, so calculations terminated.<\/negrank>" ;
            $loop_status = $loop_status_done ;
            last ;
        }


#-----------------------------------------------
#  Count the number of proposals that have been
#  accepted so far.

        $number_of_accepted_proposals = $#list_of_proposal_ids_accepted + 1 ;
        $global_log_output .= "<negrank>Number of accepted proposals so far is " . $number_of_accepted_proposals . "<\/negrank>" ;


#-----------------------------------------------
#  Count the number of proposals that remain to
#  be considered.
#  If none remain, exit the loop.

        $number_of_unpopular_proposals = $#list_of_proposal_ids_unpopular + 1 ;
#        $global_log_output .= "<negrank>Number of unpopular proposals is " . $number_of_unpopular_proposals . "<\/negrank>" ;
        $number_of_incompatible_proposals = $#list_of_proposal_ids_incompatible + 1 ;
#        $global_log_output .= "<negrank>Number of incompatible proposals is " . $number_of_incompatible_proposals . "<\/negrank>" ;
        $number_of_remaining_proposals = $global_number_of_proposals - $number_of_accepted_proposals - $number_of_unpopular_proposals - $number_of_incompatible_proposals ;
#        $global_log_output .= "<negrank>Number of proposals remaining is " . $number_of_remaining_proposals . "<\/negrank>" ;
        if ( $number_of_remaining_proposals < 1 )
        {
            $global_log_output .= "<negrank>Number of proposals remaining is zero, so exiting main loop.<\/negrank>" ;
            $loop_status = $loop_status_done ;
            last ;
        }


#-----------------------------------------------
#  Begin a loop that repeats only twice, once to
#  identify the top few most popular proposals,
#  and a second time to identify the single top
#  proposal.

        $successive_elimination_loop_counter = 1 ;
        if ( $overall_popularity_ranking_requested == $global_true )
        {
            $successive_elimination_loop_counter = 2 ;
        }
        while ( $successive_elimination_loop_counter <= 2 )
        {
            $global_log_output .= "<negrank>Successive-elimination loop counter = " . $successive_elimination_loop_counter . "<\/negrank>" ;


#-----------------------------------------------
#  Check for an endless loop.

            $global_endless_loop_counter ++ ;
#            $global_log_output .= "<negrank>Loop counter = " . $global_endless_loop_counter . "<\/negrank>" ;
            if ( $global_endless_loop_counter > 300 )
            {
                $global_log_output .= "<negrank>ERROR! Loop count exceeded maximum, so calculations terminated.<\/negrank>" ;
                $successive_elimination_loop_counter = 99999 ;
                last ;
            }


#-----------------------------------------------
#  Count how many proposals remain to be
#  considered, which is not necessarily the same
#  as what was recently calculated above.
#  Reminder:  The successive-elimination loop
#  temporarily ignores some proposals (and
#  then restores them to consideration).

            $number_of_remaining_proposals = 0 ;
            for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
            {
                if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                {
                    $number_of_remaining_proposals ++ ;
                }
            }
            $global_log_output .= "<negrank>Number of remaining proposals is " . $number_of_remaining_proposals . "<\/negrank>" ;


#-----------------------------------------------
#  Specify whether just the most popular proposal
#  or a percentage-related number of top proposals
#  need to be identified this time through the
#  two-cycle successive-elimination loop.
#  The second (and last) time through this loop,
#  specify that only the most popular choice is
#  to be identified.

            $decimal_equivalent_threshold_percentage_top_ranked_proposals_for_successive_elimination = $threshold_percentage_top_ranked_proposals_for_successive_elimination * 0.01 ;
            if ( $successive_elimination_loop_counter == 1 )
            {
                $top_ranked_proposals_to_find = int( $number_of_remaining_proposals * $threshold_percentage_top_ranked_proposals_for_successive_elimination * 0.01 ) ;
#                $global_log_output .= "<negrank>Based on percentage, the number of top-ranked proposals to find is " . $top_ranked_proposals_to_find . "</negrank>" ;
            } else
            {
                $top_ranked_proposals_to_find = 1 ;
            }
            if ( $top_ranked_proposals_to_find < 1 )
            {
                $top_ranked_proposals_to_find = 1 ;
            }
            if ( $number_of_remaining_proposals == 1 )
            {
                $top_ranked_proposals_to_find = 1 ;
            }
            if ( $top_ranked_proposals_to_find == 1 )
            {
                $successive_elimination_loop_counter = 2 ;
            }
            $global_log_output .= "<negrank>Out of " . $number_of_remaining_proposals . " remaining, seeking " . $top_ranked_proposals_to_find . " top-ranked proposals</negrank>" ;


#-----------------------------------------------
#  Log and calculate values that are needed within
#  loops.

            $decimal_equivalent_for_division_by_number_of_accepted_proposals = 1 ;
            if ( $number_of_accepted_proposals > 0 )
            {
                $decimal_equivalent_for_division_by_number_of_accepted_proposals = 1 / $number_of_accepted_proposals ;
            }
#            $global_log_output .= "<negrank>Decimal equivalent for division by number of accepted proposals = " . $decimal_equivalent_for_division_by_number_of_accepted_proposals . "<\/negrank>" ;

#            $maximum_possible_influence_sum = $global_total_weight_of_all_votes * $number_of_accepted_proposals ;
#            $global_log_output .= "<negrank>Maximum possible influence sum is " . $maximum_possible_influence_sum . "<\/negrank>" ;


#-----------------------------------------------
#  Calculate each voter's influence-so-far
#  adjustment amount, which is based on how much
#  influence the voter has had so far in choosing
#  the accepted proposals.
#
#  A value of 100 percent for the variable
#  $adjustment_for_supporting_pairwise_count
#  indicates that the voter has ranked
#  all the accepted proposals as the voter's
#  top choice (after ignoring quite-unpopular
#  proposals).
#
#  If the influence adjustments are all zero, the
#  result is a simple popularity ranking, which
#  means that minorities have little influence in
#  the results, and two-sided cases will not
#  achieve balanced results.

            $total_of_all_adjustment_values = 0 ;
            if ( $number_of_accepted_proposals > 0 )
            {
                $global_log_output .= "<negrank>Number of accepted proposals is " . $number_of_accepted_proposals . "<\/negrank>" ;
                $global_log_output .= "<debug>Influence-based adjustments:<\/negrank>" ;
            }
            for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
            {
                $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
#                $global_log_output .= "<negrank>For voter " . $participant_id . " , vote weight is " . $weight_for_voter_count[ $voter_count ] . "<\/negrank>" ;

                if ( $number_of_accepted_proposals < 1 )
                {
                    $adjustment_for_voter_count[ $voter_count ] = 100 ;
#                    $global_log_output .= "<negrank>No proposals accepted yet, so adjustment for voter " . $participant_id . " is zero<\/negrank>" ;
                } else
                {
                    $adjustment_for_supporting_pairwise_count = int( $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] * 0.01 * $percent_representation_based_on_raw_pairwise_counts ) ;

                    $adjustment_for_opposing_pairwise_count = int( $percent_opposing_influence_so_far_for_voter_count[ $voter_count ] * 0.01 * $percent_representation_based_on_raw_pairwise_counts ) ;
#                    $global_log_output .= "<negrank>Adjustment for opposing pairwise count is " . $adjustment_for_opposing_pairwise_count . "<\/negrank>" ;

                    $adjustment_for_positive_count = $number_of_accepted_proposals_ranked_positive_by_voter_count[ $voter_count ] * $percent_representation_based_on_positive_ranking ;

                    $adjustment_for_negative_count = ( $number_of_accepted_proposals - $number_of_accepted_proposals_ranked_negative_by_voter_count[ $voter_count ] ) * $percent_representation_based_on_negative_ranking ;

                    $adjustment_for_voter_count[ $voter_count ] = int( 100 - ( $weight_for_voter_count[ $voter_count ] * ( $adjustment_for_supporting_pairwise_count + $adjustment_for_positive_count + $adjustment_for_negative_count ) ) ) ;


#                    $percent_representation_based_on_pairwise_count = int( $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] * $decimal_equivalent_for_division_by_number_of_accepted_proposals ) ;

                    $percent_representation_based_on_positive_count = $number_of_accepted_proposals_ranked_positive_by_voter_count[ $voter_count ] * $decimal_equivalent_for_division_by_number_of_accepted_proposals * 100 ;

                    $percent_representation_based_on_negative_count = ( $number_of_accepted_proposals - $number_of_accepted_proposals_ranked_negative_by_voter_count[ $voter_count ] ) * $decimal_equivalent_for_division_by_number_of_accepted_proposals * 100 ;

                    $global_log_output .= "<negrank>Voter=" . sprintf( "%2d" , $participant_id ) . " \%sofar=" . sprintf( "%3d" , $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] ) . " pairwise=" . sprintf( "%3d" , $adjustment_for_supporting_pairwise_count ) . " positive=" . sprintf( "%3d" , $percent_representation_based_on_positive_count ) . " negative=" . sprintf( "%3d" , $percent_representation_based_on_negative_count ) . " scale=" . sprintf( "%3d" , $adjustment_for_voter_count[ $voter_count ] ) . "<\/negrank>" ;

                }
#                $global_log_output .= "<negrank>For voter " . $participant_id . " the influence-so-far adjustment is " . $adjustment_for_voter_count[ $voter_count ] . "<\/negrank>" ;
                $total_of_all_adjustment_values += $adjustment_for_voter_count[ $voter_count ] ;
                $support_from_voter_count[ $voter_count ] = 0 ;
            }


#-----------------------------------------------
#  If the sum of all the adjustment values is
#  below a specified minimum, reset each of the
#  adjustment values to 100 percent.

            $global_log_output .= "<negrank>Total of all adjustment values is " . $total_of_all_adjustment_values . "<\/negrank>" ;
            if ( $total_of_all_adjustment_values < ( $global_total_weight_of_all_votes * $global_minority_threshold_percent ) )
            {
                for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
                {
                    if ( $number_of_accepted_proposals < 1 )
                    {
                        $adjustment_for_voter_count[ $voter_count ] = 100 ;
                    }
                }
                $global_log_output .= "<debug>Adjustment values have decreased too far, so being reset<\/negrank>" ;
            }


#-----------------------------------------------
#  Adjust the preference-level numbers so that
#  they are still contiguous when some of the
#  proposals are no longer being considered.
#  (This code assumes there is no more than
#  one proposal at each preference level.)

            @local_array_preference_level_for_voter_and_proposal = @global_array_preference_level_for_voter_and_proposal ;
            for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
            {
                $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
                $vote_info_offset_for_current_voter = $global_number_of_proposals * ( $voter_count - 1 ) - 1 ;
#                $global_log_output .= "<negrank>Preference levels for voter " . $participant_id . "<\/negrank>" ;
                for ( $preference_level = 1 ; $preference_level <= $global_number_of_proposals ; $preference_level ++ )
                {
                    $proposal_count_at_preference_level[ $preference_level ] = 0 ;
                }
                for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
                {
                    $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                    if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                    {
                        $preference_level = $local_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] ;
                        $proposal_count_at_preference_level[ $preference_level ] = $proposal_count ;
#                        $global_log_output .= "<negrank>In adjustment, proposal ID " . $proposal_id . " is at preference level " . $preference_level . "<\/negrank>" ;
                    }
                }
                $preference_level = 1 ;
                for ( $ranking_position = 1 ; $ranking_position <= $global_number_of_proposals ; $ranking_position ++ )
                {
                    $proposal_count = $proposal_count_at_preference_level[ $ranking_position ] ;
                    if ( $proposal_count > 0 )
                    {
                        $local_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] = $preference_level ;
                        $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
#                        $global_log_output .= "<negrank>Proposal ID " . $proposal_id . " is now at ranking level " . $preference_level . "<\/negrank>" ;
                        $preference_level ++ ;
                    }
                }
                $highest_preference_level = $preference_level - 1 ;
            }
            if ( $highest_preference_level < 1 )
            {
                $highest_preference_level = 1 ;
            }
            $global_log_output .= "<negrank>The highest preference level is " . $highest_preference_level . "<\/negrank>" ;


#-----------------------------------------------
#  Calculate a scale value that equals 100
#  divided by quantity-begin the number of
#  remaining proposals minus one quantity-end.

            if ( $number_of_remaining_proposals > 1 )
            {
                $scale_value_based_on_proposal_count = 100 / ( $number_of_remaining_proposals - 1 ) ;
            } else
            {
                $scale_value_based_on_proposal_count = 100 ;
            }
            $global_log_output .= "<negrank>Scale value based on proposal count is " . $scale_value_based_on_proposal_count . "<\/negrank>" ;


#-----------------------------------------------
#  Begin a loop that calculates the adjusted
#  cumulative pairwise-comparison support and
#  opposition counts for each still-considered
#  proposal.

#            $global_log_output .= "<negrank>Successive-elimination loop counter = " . $successive_elimination_loop_counter . "<\/negrank>" ;
#            $global_log_output .= "<negrank>Support value for each combination of proposal and voter:<\/negrank>" ;
            for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
            {
                $proposal_id_being_checked = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                {
#                    $global_log_output .= "<negrank>Support values for proposal ID " . $proposal_id_being_checked . " are:<\/negrank>" ;
                    $supporting_count_for_proposal_count[ $proposal_count ] = 0 ;


#-----------------------------------------------
#  Add each voter's contribution to this
#  proposal's support and opposition
#  cumulative pairwise-comparison counts, but
#  scale the contribution with the voter's
#  influence-so-far adjustment.
#  If a proposal is unranked (ranked as neutral),
#  adjust the count so that the unranked proposal
#  is regarded as being at the preference level
#  immediately above the top negative-ranked
#  proposal.

                    for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
                    {
                        $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
                        $vote_info_offset_for_current_voter = $global_number_of_proposals * ( $voter_count - 1 ) - 1 ;
                        $preference_level = $local_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count ] ;
#                        $global_log_output .= "<negrank>From voter " . $participant_id . " the preference level is " . $preference_level . "<\/negrank>" ;

                        $lowest_positive_ranked_count = $global_number_of_proposals - $global_proposal_count_positive_ranked_for_participant_id[ $participant_id ] + 1 ;
                        $highest_negative_ranked_count = $global_proposal_count_negative_ranked_for_participant_id[ $participant_id ] ;
                        $neutral_ranking_level = $highest_negative_ranked_count + 1 ;

                        if ( ( $preference_level > $highest_negative_ranked_count ) && ( $preference_level < $lowest_positive_ranked_count ) )
                        {
                            $preference_level = $neutral_ranking_level ;
                            $global_log_output .= "<debug>Neutral ranking, so adjustment done<\/negrank>" ;
                        }

                        $supporting_count_from_this_voter = ( ( $preference_level - 1 ) * $scale_value_based_on_proposal_count ) * $adjustment_for_voter_count[ $voter_count ] ;
#                        $global_log_output .= "<negrank>Prop=" . sprintf( "%2d" , $proposal_id_being_checked ) . " , Vtr=" . sprintf( "%2d" , $participant_id ) . " , Pref=" . sprintf( "%2d" , $preference_level ) . " , Adj=" . sprintf( "%3d" , int( $adjustment_for_voter_count[ $voter_count ] ) ) . " , Suprt=" . sprintf( "%5d" , int( $supporting_count_from_this_voter ) ) . "<\/negrank>" ;

                        $supporting_count_for_proposal_count[ $proposal_count ] += $supporting_count_from_this_voter ;

                        $support_from_voter_count[ $voter_count ] = $supporting_count_from_this_voter ;

                        $opposing_count_from_this_voter = ( $preference_level - 1 ) * $scale_value_based_on_proposal_count * $adjustment_for_voter_count[ $voter_count ] ;
                        if ( $opposing_count_from_this_voter > 0 )
                        {
                            $opposing_count_for_proposal_count[ $proposal_count ] += $opposing_count_from_this_voter ;
                        } else
                        {
                            $do_nothing ++ ;
                        }
#                        $global_log_output .= "<negrank>End of this loop<\/negrank>" ;
                    }


#-----------------------------------------------
#  Calculate the overall result for each
#  proposal.

                    $supporting_count_for_proposal_count[ $proposal_count ] *= $scale_value_based_on_voter_count ;
#                    $global_log_output .= "<negrank>Overall support count for proposal " . $proposal_id_being_checked . " is " . int( $supporting_count_for_proposal_count[ $proposal_count ] ) . "<\/negrank>" ;


#-----------------------------------------------
#  Repeat the loop for the next non-ignored
#  proposal.

                }
            }


#-----------------------------------------------
#  Log the support counts.

#            $global_log_output .= "<negrank>Support value for each proposal:<\/negrank>" ;
            for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
            {
                $proposal_id_being_checked = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                {
#                    $global_log_output .= "<negrank>For proposal ID " . $proposal_id_being_checked . " total support= " . int( $supporting_count_for_proposal_count[ $proposal_count ] ) . "<\/negrank>" ;
                }
            }

            $global_log_output .= "<negrank>Support amounts from each voter:<\/negrank>" ;
            for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
            {
                $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
                $global_log_output .= "<negrank>For voter " . $participant_id . " voter-specific support is " . int( $support_from_voter_count[ $voter_count ] ) . "<\/negrank>" ;
            }
#            $global_log_output .= "<negrank>The highest preference level is " . $highest_preference_level . "<\/negrank>" ;


#-----------------------------------------------
#  Identify the largest and smallest support
#  values.
#  Also count how many proposals have
#  the largest support value.
#  Also save the proposal ID and count number
#  of what could be the only proposal with the
#  largest support value.
#
#  Implement later:
#  The opposition counts allow for equal-preference
#  votes, without which the support and opposition
#  counts would always be the compliment of one
#  another.

            $smallest_support_value = 999999 ;
            $largest_support_value = -999999 ;
            $proposal_count_with_largest_sum = 0 ;
            $global_proposal_id_for_proposal_count[ 0 ] = 0 ;
            $count_of_proposals_at_highest_support_value = 0 ;
            for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
            {
                $proposal_id_being_checked = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                {
                    $supporting_count_for_proposal_being_checked = $supporting_count_for_proposal_count[ $proposal_count ] ;
#                    $global_log_output .= "<negrank>For proposal ID " . $proposal_id_being_checked . " the total support count is " . $supporting_count_for_proposal_being_checked . "<\/negrank>" ;
                    if ( $supporting_count_for_proposal_being_checked > $largest_support_value )
                    {
                        $proposal_count_with_largest_sum = $proposal_count ;
                        $largest_support_value = $supporting_count_for_proposal_being_checked ;
#                        $global_log_output .= "<negrank>Proposal " . $proposal_id_being_checked . " has a larger support value<\/negrank>" ;
                        $count_of_proposals_at_highest_support_value = 0 ;
                    } elsif ( $supporting_count_for_proposal_being_checked == $largest_support_value )
                    {
                        $count_of_proposals_at_highest_support_value ++ ;
                    } elsif ( $supporting_count_for_proposal_being_checked < $smallest_support_value )
                    {
                        $smallest_support_value = $supporting_count_for_proposal_being_checked ;
#                        $global_log_output .= "<negrank>Proposal " . $proposal_id_being_checked . " has a smaller support value<\/negrank>" ;
                    }

#                            if ( $global_total_weight_of_all_votes - $opposing_count_for_proposal_count[ $proposal_count ] > $largest_support_value )
#                            {
    #  Later implement search for lowest opposition value and compare which is optimum....
    #                    $proposal_count_with_largest_sum = $proposal_count ;
    #                    $largest_support_value = $global_total_weight_of_all_votes - $opposing_count_for_proposal_count[ $proposal_count ] ;
    #                    $tie_status == $tie_status_no ;
#                                $global_log_output .= "<negrank>Proposal " . $proposal_id_being_checked . " might have an equivalently smaller sum, but this has not been fully checked, so it is ignored<\/negrank>" ;
#                            }

                }
            }


#-----------------------------------------------
#  If more than one top-ranked proposal is being
#  identified, identify those top-ranked proposals
#  based on their support value (relative to the
#  highest and lowest support values), temporarily
#  remove the other proposals from consideration,
#  and then repeat the successive-elimination loop.

            $global_log_output .= "<negrank>Largest and smallest support values are " . int( $largest_support_value ) . " and " . int( $smallest_support_value ) . "<\/negrank>" ;
            if ( $smallest_support_value + 4 > $largest_support_value )
            {
                $smallest_support_value = $largest_support_value - 4 ;
            }
            $threshold_support_value = ( ( $largest_support_value - $smallest_support_value ) *  $decimal_equivalent_threshold_percentage_top_ranked_proposals_for_successive_elimination ) + $smallest_support_value ;
            $global_log_output .= "<negrank>Threshold support value is " . int( $threshold_support_value ) . "<\/negrank>" ;
            if ( $top_ranked_proposals_to_find > 1 )
            {
                $number_of_proposals_temporarily_not_considered = 0 ;
                for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
                {
                    if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
                    {
                        $proposal_id_being_checked = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
#                        $global_log_output .= "<negrank>Proposal count is " . $proposal_count . " and proposal ID is " . $proposal_id_being_checked . "<\/negrank>" ;
                        if ( $supporting_count_for_proposal_count[ $proposal_count ] <= $threshold_support_value )
                        {
                            $number_of_proposals_temporarily_not_considered ++ ;
                            $proposal_count_temporarily_ignored_for_proposal_pointer[ $number_of_proposals_temporarily_not_considered ] = $proposal_count ;
                            $using_proposal_at_proposal_count[ $proposal_count ] = $global_false ;
#                            $global_log_output .= "<negrank>Proposal ID " . $proposal_id_being_checked . " is temporarily no longer being considered<\/negrank>" ;
                        }
                    }
                }
                $successive_elimination_loop_counter ++ ;
                next ;
            }


#-----------------------------------------------
#  If just one proposal has the highest support
#  value, identify it.

            if ( $count_of_proposals_at_highest_support_value == 1 )
            {
                $proposal_id_with_largest_sum = $global_proposal_id_for_proposal_count[ $proposal_count_with_largest_sum ] ;
                $global_log_output .= "<negrank>Proposal " . $proposal_id_with_largest_sum . " has the largest support value<\/negrank>" ;


#-----------------------------------------------
#  If multiple proposals are tied with the same
#  (highest) support value, begin a loop that
#  handles each proposal that is tied with the
#  largest support value.

            } else
            {
                for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
                {
                    $proposal_id_being_checked = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                    if ( ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true ) && ( $proposal_count != $proposal_count_with_largest_sum ) )
                    {
                        $proposal_id_with_largest_sum = $global_proposal_id_for_proposal_count[ $proposal_count_with_largest_sum ] ;
                        if ( $supporting_count_for_proposal_count[ $proposal_count ] == $largest_support_value )
                        {
                            $global_log_output .= "<negrank>Proposal " . $proposal_id_with_largest_sum . " and " . $proposal_id_being_checked . " are tied<\/negrank>" ;


#-----------------------------------------------
#  Resolve the tie by choosing the proposal
#  that is ranked as positive by more voters.

                            $positive_only_largest = $global_vote_count_positive_only_for_proposal_id[ $proposal_id_with_largest_sum ] ;
                            $positive_only_being_checked = $global_vote_count_positive_only_for_proposal_id[ $proposal_id_being_checked ] ;
                            if ( $positive_only_being_checked > $positive_only_largest )
                            {
                                $proposal_count_with_largest_sum = $proposal_count ;
                                $global_log_output .= "<negrank>The ranking-based tie has been broken because proposal " . $proposal_id_being_checked . " has more support -- " . $positive_only_being_checked . " versus " . $positive_only_largest ."<\/negrank>" ;

                            } elsif ( $positive_only_being_checked < $positive_only_largest )
                            {
                                $global_log_output .= "<negrank>The ranking-based tie has been broken because proposal " . $proposal_id_with_largest_sum . " has more support -- " . $positive_only_largest . " versus " . $positive_only_being_checked ."<\/negrank>" ;


#-----------------------------------------------
#  If there is still a tie, use the tie-
#  breaking ranking.

                            } else
                            {
                                $true_false_tie_breaking_affected_outcome = $global_true ;
                                $tie_resolution_rank_level_for_proposal_being_checked = $tie_resolution_rank_level_for_proposal_id[ $proposal_id_being_checked ] ;
                                $tie_resolution_rank_level_for_proposal_with_largest_sum = $tie_resolution_rank_level_for_proposal_id[ $proposal_id_with_largest_sum ] ;
                                $global_log_output .= "<negrank>Broke tie using tie-resolution ranking, where proposal " . $proposal_id_being_checked . " has rank level " . $tie_resolution_rank_level_for_proposal_being_checked . " and proposal " . $proposal_id_with_largest_sum . " has rank level " . $tie_resolution_rank_level_for_proposal_with_largest_sum . "<\/negrank>" ;
                                if ( $tie_resolution_rank_level_for_proposal_being_checked > $tie_resolution_rank_level_for_proposal_with_largest_sum )
                                {
                                    $proposal_count_with_largest_sum = $proposal_count ;
                                }
                                $global_log_output .= "<negrank>Tie resolved using tie-breaking ranking<\/negrank>" ;
                            }
                            $global_log_output .= "<negrank>End of tie resolution code<\/negrank>" ;
                        }
                    }


#-----------------------------------------------
#  Exit the successive-elimination loop and
#  terminate the proposal-based loop now that
#  the most popular proposal has been identified.

#                    $global_log_output .= "<negrank>End of code for proposal-based loop<\/negrank>" ;
                }
                $global_log_output .= "<negrank>Done finding most popular proposal, exiting successive-elimination loop<\/negrank>" ;
                $successive_elimination_loop_counter = 99999 ;
                last ;
            }


#-----------------------------------------------
#  Repeat the successive-elimination loop.

            $successive_elimination_loop_counter ++ ;
            $global_log_output .= "<negrank>Repeating successive-elimination loop<\/negrank>" ;
        }


#-----------------------------------------------
#  Identify the proposal with the highest support
#  value.

        $proposal_id_with_largest_sum = $global_proposal_id_for_proposal_count[ $proposal_count_with_largest_sum ] ;
        $global_log_output .= "<negrank>Proposal with largest sum (" . $largest_support_value . ") is " . $proposal_id_with_largest_sum . "<\/negrank>" ;
        $proposal_id_accepted = 0 ;


#-----------------------------------------------
#  Restore to consideration any less-popular
#  proposals that were temporarily removed from
#  consideration.

        $global_log_output .= "<negrank>Number of proposals to restore is " . $number_of_proposals_temporarily_not_considered . "<\/negrank>" ;
        if ( $number_of_proposals_temporarily_not_considered > 0 )
        {
            for ( $proposal_pointer = 1 ; $proposal_pointer <= $number_of_proposals_temporarily_not_considered ; $proposal_pointer ++ )
            {
                $proposal_count = $proposal_count_temporarily_ignored_for_proposal_pointer[ $proposal_pointer ] ;
                $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                $using_proposal_at_proposal_count[ $proposal_count ] = $global_true ;
#                $global_log_output .= "<negrank>Restoring proposal " . $proposal_id . " to consideration<\/negrank>" ;
            }
        }
        $number_of_proposals_temporarily_not_considered = 0 ;


#-----------------------------------------------
#  Calculate the average positive-only-acceptance
#  percentage over all the proposals accepted so far.

        $number_of_accepted_proposals = $#list_of_proposal_ids_accepted + 1 ;
        if ( $number_of_accepted_proposals == 0 )
        {
            $average_acceptance_if_this_proposal_accepted = $percentage_positive_only_for_proposal[ $proposal_id_with_largest_sum ] ;
        } else
        {
            $average_acceptance_if_this_proposal_accepted = ( ( $average_acceptance_if_this_proposal_accepted * $number_of_accepted_proposals ) + $percentage_positive_only_for_proposal[ $proposal_id_with_largest_sum ] ) / ( $number_of_accepted_proposals + 1 ) ;
        }
        $global_log_output .= "<negrank>Average acceptance if this proposal accepted is " . $average_acceptance_if_this_proposal_accepted . "</negrank>" ;


#-----------------------------------------------
#  If only the overall popularity ranking is
#  requested, identify this proposal (that has
#  the highest sum) as the next-most popular.

        if ( $overall_popularity_ranking_requested == $global_true )
        {
            $proposal_id_accepted = $proposal_id_with_largest_sum ;
            $global_log_output .= "<negrank>Proposal " . $proposal_id_accepted . " is the next-most popular overall<\/negrank>" ;


#-----------------------------------------------
#  If each proposal must exceed the positive-only
#  acceptance threshold, and this proposal meets
#  or exceeds that threshold, indicate that this
#  proposal is to be accepted.

        } elsif ( $acceptance_criteria == $acceptance_criteria_each )
        {
#            $global_log_output .= "<negrank>Acceptance criteria is: each<\/negrank>" ;
            if ( $percentage_positive_only_for_proposal[ $proposal_id_with_largest_sum ] >= $majority_threshold_percent_based_on_majority_voter_count )
            {
                $proposal_id_accepted = $proposal_id_with_largest_sum ;
                $global_log_output .= "<negrank>Proposal meets acceptance threshold of " . $majority_threshold_percent_based_on_majority_voter_count . "<\/negrank>" ;
            } else
            {
                $proposal_id_accepted = 0 ;
                $global_log_output .= "<negrank>Proposal does NOT meet acceptance threshold of " . $majority_threshold_percent_based_on_majority_voter_count . "<\/negrank>" ;
            }
        } else
        {


#-----------------------------------------------
#  If the positive-only acceptance threshold of
#  all the proposals must meet or exceed the
#  specified threshold, and this criteria is met,
#  indicate that this proposal is to be accepted.
#
#  First check if the votes for this proposal--
#  without averaging--exceed the vote-count
#  threshold because that alone can only
#  improve the average.
#
#  (Verify this correctly handles a case involving
#  only two voting participants.)

            if ( $percentage_positive_only_for_proposal[ $proposal_id_with_largest_sum ] >= $majority_threshold_percent_based_on_majority_voter_count )
            {
                $proposal_id_accepted = $proposal_id_with_largest_sum ;
                $global_log_output .= "<negrank>Proposal has votes (without averaging) that meets acceptance threshold of " . $majority_threshold_percent_based_on_majority_voter_count . "<\/negrank>" ;
            } else
            {
#                $global_log_output .= "<negrank>Acceptance criteria is: average<\/negrank>" ;
                $global_log_output .= "<negrank>Number of proposals accepted is " . $number_of_accepted_proposals . "</negrank>" ;
#                $global_log_output .= "<negrank>Total weight of voters is " . $global_total_weight_of_all_votes . "</negrank>" ;
                $global_log_output .= "<negrank>Average positive-only vote count will be " . $average_acceptance_if_this_proposal_accepted . "</negrank>" ;
#                $global_log_output .= "<negrank>Majority threshold is " . $majority_threshold_percent_based_on_majority_voter_count . " based on threshold percent of " . $global_majority_threshold_percent . "<\/negrank>" ;
                if ( $average_acceptance_if_this_proposal_accepted >= $global_majority_threshold_percent )
                {
                    $proposal_id_accepted = $proposal_id_with_largest_sum ;
                    $global_log_output .= "<negrank>This proposal will maintain sufficient average acceptance threshold of " . $global_majority_threshold_percent  . "<\/negrank>" ;
                } else
                {
                    $proposal_id_accepted = 0 ;
                    $global_log_output .= "<negrank>Proposal does NOT exceed acceptance threshold of " . $global_majority_threshold_percent . "<\/negrank>" ;
                }
            }
        }


#-----------------------------------------------
#  If this proposal does not meet the acceptance
#  criteria, reject it as unacceptable.

        if ( $proposal_id_accepted == 0 )
        {
            push( @list_of_proposal_ids_unpopular , $proposal_id_with_largest_sum ) ;
            $using_proposal_at_proposal_count[ $proposal_count_with_largest_sum ] = $global_false ;
            $global_log_output .= "<negrank>Proposal " . $proposal_id_with_largest_sum . " has NOT been accepted<\/negrank>" ;
        } else
        {


#-----------------------------------------------
#  This proposal meets the acceptance criteria,
#  so move it into the acceptable category.

            $global_log_output .= "<negrank>-------------------------------<\/negrank>" ;
            $global_log_output .= "<negrank>Accepting proposal " . $proposal_id_accepted . "<\/negrank>" ;
            $proposal_count_accepted = $global_proposal_count_for_proposal_id[ $proposal_id_accepted ] ;
            push( @list_of_proposal_ids_accepted , $proposal_id_accepted ) ;
            $using_proposal_at_proposal_count[ $proposal_count_accepted ] = $global_false ;
            $number_of_accepted_proposals ++ ;
            $global_log_output .= "<negrank>Number of accepted proposals is " . $number_of_accepted_proposals . " accepted<\/negrank>" ;


#-----------------------------------------------
#  Remove from consideration any proposals that
#  are incompatible with the just-accepted proposal.
#  (But skip this section if only the overall
#  popularity ranking is requested.)

            if ( $overall_popularity_ranking_requested != $global_true )
            {
                for ( $proposal_count_then_not_accepted = 1 ; $proposal_count_then_not_accepted <= $global_number_of_proposals ; $proposal_count_then_not_accepted ++ )
                {
                    $proposal_id_then_not_accepted = $global_proposal_id_for_proposal_count[ $proposal_count_then_not_accepted ] ;
                    if ( $using_proposal_at_proposal_count[ $proposal_count_then_not_accepted ] == $global_true )
                    {
    #                    $global_log_output .= "<negrank>Remaining proposal " . $proposal_id_then_not_accepted . " being considered<\/negrank>" ;
    #                    $global_log_output .= "<negrank>Incompatibility flag is " . $true_or_false_proposal_count_not_accepted_if_proposal_count[ ( $proposal_count_then_not_accepted - 1 ) * $global_number_of_proposals + $proposal_count_accepted ] . "<\/negrank>" ;
                        if ( $true_or_false_proposal_count_not_accepted_if_proposal_count[ ( $proposal_count_then_not_accepted - 1 ) * $global_number_of_proposals + $proposal_count_accepted ] == $global_true )
                        {
                            push( @list_of_proposal_ids_incompatible , $proposal_id_then_not_accepted ) ;
                            $using_proposal_at_proposal_count[ $proposal_count_then_not_accepted ] = $global_false ;
    #                        $global_log_output .= "<negrank>Proposal " . $proposal_id_then_not_accepted . " identified as incompatible<\/negrank>" ;
                        }
                    }
                }
            }


#-----------------------------------------------
#  Finish skipping code if no proposal was
#  accepted.

        }


#-----------------------------------------------
#  If there are not any proposals remaining to be
#  considered, the loop is done, so exit the loop.

        $number_of_remaining_proposals = 0 ;
        $list_proposals_still_being_used = "" ;
        for ( $proposal_count = 1 ; $proposal_count <= $global_number_of_proposals ; $proposal_count ++ )
        {
            if ( $using_proposal_at_proposal_count[ $proposal_count ] == $global_true )
            {
#                $global_log_output .= "<negrank>Proposal count " . $proposal_count . " still being used<\/negrank>" ;
                $number_of_remaining_proposals ++ ;
                $proposal_id = $global_proposal_id_for_proposal_count[ $proposal_count ] ;
                $list_proposals_still_being_used .= "," . $proposal_id ;
            } else
            {
#                $global_log_output .= "<negrank>Proposal " . $proposal_count . " is not being used<\/negrank>" ;

            }
        }
        $global_log_output .= "<negrank>Proposals still being used: " . $list_proposals_still_being_used . "<\/negrank>" ;
        if ( $number_of_remaining_proposals < 1 )
        {
            $global_log_output .= "<negrank>Number of proposals remaining to be ranked is zero, so ranking calculations terminated.<\/negrank>" ;
            $loop_status = $loop_status_done ;
            last ;
        }


#-----------------------------------------------
#  As an extra endless-loop check, make sure
#  there are not more already-ranked proposals
#  than the total number of proposals.

        @list_of_all_proposals_ranked = ( @list_of_proposal_ids_accepted , @list_of_proposal_ids_incompatible , @list_of_proposal_ids_unpopular ) ;
        if ( $#list_of_all_proposals_ranked > $global_number_of_proposals )
        {
            $global_log_output .= "<negrank>ERROR! Number of proposals ranked has exceeded the total number of proposals, so ranking calculations terminated.<\/negrank>" ;
            $loop_status = $loop_status_done ;
            last ;
        }


#-----------------------------------------------
#  For the just-accepted proposal, update how
#  much influence each voter has had so far
#  in choosing the accepted proposals.
#  (But skip this section if only the overall
#  popularity ranking is requested.)

        if ( ( $proposal_id_accepted > 0 ) && ( $overall_popularity_ranking_requested != $global_true ) )
        {
            $global_log_output .= "<debug>Influence after latest proposal accepted<\/negrank>" ;
            if ( $highest_preference_level < 1 )
            {
                $highest_preference_level = 1 ;
            }
            $decimal_equivalent_multiply_by_100_and_divide_by_highest_preference_level = 100 / $highest_preference_level ;
            for ( $voter_count = 1 ; $voter_count <= $global_number_of_voters ; $voter_count ++ )
            {
                $participant_id = $global_participant_id_for_voter_count[ $voter_count ] ;
                $vote_info_offset_for_current_voter = $global_number_of_proposals * ( $voter_count - 1 ) - 1 ;
                $preference_level_adjusted = $local_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count_accepted ] ;
                $preference_level_original = $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset_for_current_voter + $proposal_count_accepted ] ;
#                $global_log_output .= "<negrank>Voter=" . sprintf( "%2d" , $participant_id ) . " original pref level=" . sprintf( "%2d" , $preference_level_original ) . " adjusted pref level=" . sprintf( "%2d" , $preference_level_adjusted ) . "<\/negrank>" ;
                if ( $preference_level_adjusted > $highest_preference_level )
                {
                    $global_log_output .= "<debug>Preference level " . $preference_level_adjusted . " exceeds highest preference level of " . $highest_preference_level . "<\/negrank>" ;
                }
                $percent_support_for_this_accepted_proposal = 100 * $preference_level_adjusted / $highest_preference_level ;
                if ( $number_of_accepted_proposals < 2 )
                {
                    $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] = int( $percent_support_for_this_accepted_proposal + 0.5 ) ;
                } else
                {
                    $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] = int( ( ( ( $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] * ( $number_of_accepted_proposals - 1 ) ) + $percent_support_for_this_accepted_proposal ) / $number_of_accepted_proposals ) + 0.5 ) ;
                }
                if ( $preference_level_original <= $global_proposal_count_negative_ranked_for_participant_id[ $participant_id ] )
                {
                    $number_of_accepted_proposals_ranked_negative_by_voter_count[ $voter_count ] ++ ;
                }
                if ( $preference_level_original >= $global_number_of_proposals - $global_proposal_count_positive_ranked_for_participant_id[ $participant_id ] + 1 )
                {
                    $number_of_accepted_proposals_ranked_positive_by_voter_count[ $voter_count ] ++ ;
                }
                $global_log_output .= "<negrank>Votr=" . sprintf( "%2d" , $participant_id ) . " , pairwise=" . sprintf( "%4d" , $percent_supporting_influence_so_far_for_voter_count[ $voter_count ] ) . " , postive=" . sprintf( "%3d" , $number_of_accepted_proposals_ranked_positive_by_voter_count[ $voter_count ] ) . " negative=" . sprintf( "%3d" , $number_of_accepted_proposals_ranked_negative_by_voter_count[ $voter_count ] ) . "<\/negrank>" ;
            }
        }


#-----------------------------------------------
#  Repeat the loop that identifies the next
#  proposal to be accepted.

    }
    $global_log_output .= "<negrank>End of overall ranking<\/negrank>" ;


#-----------------------------------------------
#  Copy the results into the global arrays used
#  for all ranking displays.

    @global_list_of_proposal_ids_ranked_positive = @list_of_proposal_ids_accepted ;
    @global_list_of_proposal_ids_ranked_neutral = @list_of_proposal_ids_unpopular ;
    @global_list_of_proposal_ids_ranked_negative = @list_of_proposal_ids_incompatible ;


#-----------------------------------------------
#  Write the results to the case-info file.

    &dashrep_define( "xml-content-preferencesaccepted" , join( "," , @list_of_proposal_ids_accepted ) ) ;
    &dashrep_define( "xml-content-preferencesunpopular" , join( "," , @list_of_proposal_ids_unpopular ) ) ;
    &dashrep_define( "xml-content-preferencesincompatible" , join( "," , @list_of_proposal_ids_incompatible ) ) ;
    $new_xml = &dashrep_expand_parameters( "xml-template-rankoverall" ) ;
    $xml_replacement_name = "xml-overall-rankoverall" ;
    &dashrep_define( $xml_replacement_name , $new_xml . "\n" ) ;
    &dashrep_define( "list-of-xml-code-of-type-" . "main" , $xml_replacement_name  ) ;
    push ( @global_replacements_with_new_xml_for_main_file , $xml_replacement_name ) ;
    &xml_write_new ;


#-----------------------------------------------
#  End of subroutine.

}

