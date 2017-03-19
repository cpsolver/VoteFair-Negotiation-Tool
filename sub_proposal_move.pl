#-----------------------------------------------
#-----------------------------------------------
#         proposal_move
#-----------------------------------------------
#-----------------------------------------------
#  Get the destination to which a proposal is
#  to be moved, and move the proposal to that
#  position in the ranking.

#  Conflicts could occur if two participants
#  are moving that participant's proposal
#  rankings at the same time.

#  A secondproposal value of 99990 refers to
#  the top of the positively ranked proposals.
#  A secondproposal value of 99991 refers to
#  the top of the negatively ranked proposals.


sub proposal_move
{


#-----------------------------------------------
#  Determine which proposal is being moved, and
#  its new destination.

    $proposal_to_move = int( &dashrep_get_replacement( "input-validated-proposalid" ) ) ;
    $move_after_proposal = int( &dashrep_get_replacement( "input-validated-proposalsecond" ) ) ;
    $global_log_output .= "<proposalmove>Proposal " . $proposal_to_move . " is being moved after " . $move_after_proposal ."<\/proposalmove>" ;


#-----------------------------------------------
#  If a participant's ranking is being changed,
#  specify the participant ID, and
#  get the current ranking sequences, both
#  positive and negative.

    if ( ( $global_action_request eq "getmoveproposal" ) || ( $global_action_request eq "getmoveothervoterproposal" ) )
    {
        $global_participant_id_for_move_proposal = int( &dashrep_get_replacement( "input-validated-participantid" ) ) ;
        $global_participant_id = $global_participant_id_for_move_proposal ;

        @proposal_id_sequence_positive = &split_delimited_items_into_array( &dashrep_get_replacement( "voteinfo-preferencespositive-for-participantid-" . $global_participant_id_for_move_proposal ) ) ;

        @proposal_id_sequence_negative = &split_delimited_items_into_array( &dashrep_get_replacement( "voteinfo-preferencesnegative-for-participantid-" . $global_participant_id_for_move_proposal ) ) ;

        $global_log_output .= "<proposalmove>Previous rankings for participant ID " . $global_participant_id . " are positive sequence of " . join( "," , @proposal_id_sequence_positive ) . " and negative sequence of " . join( "," , @proposal_id_sequence_negative ) ."<\/proposalmove>" ;


#-----------------------------------------------
#  If the tie-break ranking is being changed,
#  get the previous tie-break ranking.

    } elsif ( $global_action_request eq "getmovetiebreak" )
    {
        @proposal_id_sequence_positive = &split_delimited_items_into_array( &dashrep_get_replacement( "tiebreak-sequencepositive" ) ) ;

        @proposal_id_sequence_negative = &split_delimited_items_into_array( &dashrep_get_replacement( "tiebreak-sequencenegative" ) ) ;

        $global_log_output .= "<proposalmove>Previous tie-break rankings are positive " . join( "," , @proposal_id_sequence_positive ) . " and negative " . join( "," , @proposal_id_sequence_negative ) ."<\/proposalmove>" ;


#-----------------------------------------------
#  Catch a possible coding error.

    } else
    {
        $global_log_output .= "<proposalmove>ERROR, reached proposal-move subroutine but requested action is " . $global_action_request . "<\/proposalmove>" ;
        return ;
    }


#-----------------------------------------------
#  Move the proposal number from the old
#  to the new position, allowing for these
#  locations to be within either the positive
#  or negative sequence, or the neutral sequence
#  for the source location.

    @new_proposal_id_sequence_positive = ( ) ;
    @new_proposal_id_sequence_negative = ( ) ;

    if ( $move_after_proposal == 99990 )
    {
        push( @new_proposal_id_sequence_positive , $proposal_to_move ) ;
        $global_log_output .= "<proposalmove>Proposal moved after 99990<\/proposalmove>" ;
    }
    for ( $pointer = 0 ; $pointer <= $#proposal_id_sequence_positive ; $pointer ++ )
    {
        $proposal_id = $proposal_id_sequence_positive[ $pointer ] ;
        if ( $proposal_id != $proposal_to_move )
        {
            push( @new_proposal_id_sequence_positive , $proposal_id ) ;
            $global_log_output .= "<proposalmove>Next proposal is " . $proposal_id . "<\/proposalmove>" ;
        }
        if ( $proposal_id == $move_after_proposal )
        {
            push( @new_proposal_id_sequence_positive , $proposal_to_move ) ;
            $global_log_output .= "<proposalmove>Inserting moved proposal here<\/proposalmove>" ;
        }
    }

    if ( $move_after_proposal == 99991 )
    {
        push( @new_proposal_id_sequence_negative , $proposal_to_move ) ;
        $global_log_output .= "<proposalmove>Proposal moved after 99991<\/proposalmove>" ;
    }
    for ( $pointer = 0 ; $pointer <= $#proposal_id_sequence_negative ; $pointer ++ )
    {
        $proposal_id = $proposal_id_sequence_negative[ $pointer ] ;
        if ( $proposal_id != $proposal_to_move )
        {
            push( @new_proposal_id_sequence_negative , $proposal_id ) ;
            $global_log_output .= "<proposalmove>Next proposal is " . $proposal_id . "<\/proposalmove>" ;
        }
        if ( $proposal_id == $move_after_proposal )
        {
            push( @new_proposal_id_sequence_negative , $proposal_to_move ) ;
            $global_log_output .= "<proposalmove>Inserting moved proposal here<\/proposalmove>" ;
        }
    }


#-----------------------------------------------
#  Convert the lists to delimited strings.

    $sequence_positive = join( "," , @new_proposal_id_sequence_positive ) ;
    $sequence_negative = join( "," , @new_proposal_id_sequence_negative ) ;

    $sequence_positive =~ s/^[ ,]+// ;
    $sequence_negative =~ s/^[ ,]+// ;
    $sequence_positive =~ s/[ ,]+$// ;
    $sequence_negative =~ s/[ ,]+$// ;

    $global_log_output .= "<proposalmove>New sequence, positive " . $sequence_positive . " and negative " . $sequence_negative ."<\/proposalmove>" ;


#-----------------------------------------------
#  Pass the updated sequence lists to the
#  appropriate "xml-content-..." replacements.

    if ( ( $global_action_request eq "getmoveproposal" ) || ( $global_action_request eq "getmoveothervoterproposal" ) )
    {
        &dashrep_define( "xml-content-preferencespositive" , $sequence_positive ) ;
        &dashrep_define( "xml-content-preferencesnegative" , $sequence_negative ) ;

    } elsif ( $global_action_request eq "getmovetiebreak" )
    {
        &dashrep_define( "xml-content-sequencepositive" , $sequence_positive ) ;
        &dashrep_define( "xml-content-sequencenegative" , $sequence_negative ) ;
    }


#-----------------------------------------------
#  End of subroutine.

}

