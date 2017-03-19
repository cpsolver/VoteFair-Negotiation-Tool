#-----------------------------------------------
#-----------------------------------------------
#          get_vote_info_voter_specific
#-----------------------------------------------
#-----------------------------------------------
#  For the specified voter, generate lists that
#  rank proposals, with a separate list for
#  the positive, negative, and neutral categories.

sub get_vote_info_voter_specific
{


#-----------------------------------------------
#  Log the participant ID.

    $global_log_output .= "<getvoterspecificinfo>Participant ID " . $global_input_participant_id . "<\/getvoterspecificinfo>" ;


#-----------------------------------------------
#  Calculate the ranking level for each proposal
#  (for this voter).

    @global_list_of_vote_info_participant_ids = ( $global_input_participant_id ) ;
    @global_list_of_vote_info_proposal_ids = @global_list_of_all_proposal_ids ;

    &get_vote_info ;


#-----------------------------------------------
#  Put the proposal ID numbers into ranking order.
#  Take advantage of the fact that the ranking
#  levels calculated in get_vote_info are non-
#  overlapping, sequential (no missing level
#  numbers), and start at 1 (for the lowest
#  ranking).

    @list_of_proposal_ids_in_ranking_order = ( ) ;
    $vote_info_offset = -1 ;
    $number_of_proposals = $#global_list_of_vote_info_proposal_ids + 1 ;
    $global_log_output .= "<getvoterspecificinfo>Proposal count is " . $number_of_proposals . "<\/getvoterspecificinfo>" ;
    for $proposal_id ( @global_list_of_vote_info_proposal_ids )
    {
        $proposal_count = $global_proposal_count_for_proposal_id[ $proposal_id ] ;
        $ranking_level = $global_array_preference_level_for_voter_and_proposal[ $vote_info_offset + $proposal_count ] ;
        $list_pointer = $ranking_level - 1 ;
#        $list_pointer = $number_of_proposals - $ranking_level - 1 ;
        if ( $list_pointer >= 0 )
        {
            $list_of_proposal_ids_in_ranking_order[ $list_pointer ] = $proposal_id ;
            $global_log_output .= "<getvoterspecificinfo>Proposal ID " . $proposal_id . " (count " . $proposal_count .") is at ranking level " . $ranking_level . "<\/getvoterspecificinfo>" ;
        } else
        {
            $global_log_output .= "<getvoterspecificinfo>ERROR: List pointer equals " . $list_pointer . " which is less than zero!<\/getvoterspecificinfo>" ;
        }
    }


#-----------------------------------------------
#  Count the number of proposals in each category:
#  positive, neutral, and negative.

    $global_log_output .= "<getvoterspecificinfo>Participant ID " . $global_input_participant_id . "<\/getvoterspecificinfo>" ;
    $global_log_output .= "<getvoterspecificinfo>Proposal count total = " . $number_of_proposals . "<\/getvoterspecificinfo>" ;
    $proposal_count_positive = $global_proposal_count_positive_ranked_for_participant_id[ $global_input_participant_id ] ;
    $global_log_output .= "<getvoterspecificinfo>Count positive = " . $proposal_count_positive . "<\/getvoterspecificinfo>" ;
    $proposal_count_negative = $global_proposal_count_negative_ranked_for_participant_id[ $global_input_participant_id ] ;
    $global_log_output .= "<getvoterspecificinfo>Count negative = " . $proposal_count_negative . "<\/getvoterspecificinfo>" ;
    $proposal_count_neutral = $number_of_proposals - $proposal_count_positive - $proposal_count_negative  ;
    $global_log_output .= "<getvoterspecificinfo>Count neutral = " . $proposal_count_neutral  . "<\/getvoterspecificinfo>" ;


#-----------------------------------------------
#  Split the lists into separate lists for each
#  category:  positive, neutral, and negative.

    @global_list_of_proposal_ids_ranked_positive = ( ) ;
    @global_list_of_proposal_ids_ranked_neutral = ( ) ;
    @global_list_of_proposal_ids_ranked_negative = ( ) ;
    $proposal_counter = 1 ;
    for ( $proposal_pointer = $#list_of_proposal_ids_in_ranking_order ; $proposal_pointer >= 0 ; $proposal_pointer -- )
    {
        $proposal_id = $list_of_proposal_ids_in_ranking_order[ $proposal_pointer ] ;
        if ( $proposal_counter <= $proposal_count_positive )
        {
            push( @global_list_of_proposal_ids_ranked_positive , $proposal_id ) ;
            $global_log_output .= "<getvoterspecificinfo>Proposal ID " . $proposal_id . " is next in category positive<\/getvoterspecificinfo>" ;
        } elsif ( $proposal_counter > $proposal_count_positive + $proposal_count_neutral )
        {
            push( @global_list_of_proposal_ids_ranked_negative , $proposal_id ) ;
            $global_log_output .= "<getvoterspecificinfo>Proposal ID " . $proposal_id . " is next in category negative<\/getvoterspecificinfo>" ;
        } else
        {
            push( @global_list_of_proposal_ids_ranked_neutral , $proposal_id ) ;
            $global_log_output .= "<getvoterspecificinfo>Proposal ID " . $proposal_id . " is next in category neutral<\/getvoterspecificinfo>" ;
        }
        $proposal_counter ++ ;
    }


#-----------------------------------------------
#  End of subroutine.

}

