#-----------------------------------------------
#-----------------------------------------------
#          sort_tie_resolution_ranking
#-----------------------------------------------
#-----------------------------------------------
#  Specify the ranking order that is used to
#  resolve ties.


sub sort_tie_resolution_ranking
{

    my ( $proposal_id ) ;

#-----------------------------------------------
#  Get the full list of proposal ID numbers,
#  but exclude any not yet approved.

    $global_log_output .= "<sorttie>Entered sort-tie-resolution-ranking subroutine<\/sorttie>" ;
    $global_log_output .= "<sorttie>List of proposal IDs: " . join( "," , @global_list_of_all_proposal_ids ) ."<\/sorttie>" ;


#-----------------------------------------------
#  Use the tie-break ranking for positive and
#  negative categories.

    @global_tie_break_rank_order_positive = ( ) ;
    @global_tie_break_rank_order_negative = ( ) ;
    if ( &dashrep_get_replacement( "tiebreak-sequencepositive" ) =~ /[0-9]/ )
    {
        @global_tie_break_rank_order_positive = &split_delimited_items_into_array( &dashrep_get_replacement( "tiebreak-sequencepositive" ) ) ;
    }
    if ( &dashrep_get_replacement( "tiebreak-sequencenegative" ) =~ /[0-9]/ )
    {
        @global_tie_break_rank_order_negative = &split_delimited_items_into_array( &dashrep_get_replacement( "tiebreak-sequencenegative" ) ) ;
    }


#-----------------------------------------------
#  Determine which proposal ID numbers are in the
#  positive and negative rankings.

     @use_count_for_proposal_count = ( ) ;
     foreach $proposal_id ( @global_tie_break_rank_order_positive , @global_tie_break_rank_order_negative )
     {
         if ( $use_count_for_proposal_count[ $proposal_id ] == 0 )
         {
             $use_count_for_proposal_count[ $proposal_id ] ++ ;
         }
     }


#-----------------------------------------------
#  If there are any proposals that have not yet
#  been ranked for the tie-breaking sequence,
#  (and if there are no tie-breaking rankings),
#  rank them in the neutral category.
#  Use the order in which they were created,
#  based on the proposal ID numbers.

    @global_tie_break_rank_order_neutral = ( ) ;
    foreach $proposal_id ( sort( @global_list_of_all_proposal_ids ) )
    {
        if ( $use_count_for_proposal_count[ $proposal_id ] == 0 )
        {
            push( @global_tie_break_rank_order_neutral , $proposal_id ) ;
            $use_count_for_proposal_count[ $proposal_id ] ++ ;
        }
    }


#-----------------------------------------------
#  Combine the positive, neutral, and negative
#  categories to create the overall
#  tie-resolution ranking.

    @global_tie_resolution_rank_order = ( @global_tie_break_rank_order_positive , @global_tie_break_rank_order_neutral , @global_tie_break_rank_order_negative  ) ;


#-----------------------------------------------
#  End of subroutine.

    $global_log_output .= "<sorttie>Tie resolution ranking: " . join( "," , @global_tie_resolution_rank_order ) ."<\/sorttie>" ;

}

