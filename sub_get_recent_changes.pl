#-----------------------------------------------
#-----------------------------------------------
#          get_recent_changes
#-----------------------------------------------
#-----------------------------------------------
#  Get the most recent changes, for lising on
#  the home page.


sub get_recent_changes
{


#-----------------------------------------------
#  Next line was already executed during
#  initialization, so it can be commented out here.

    @ShortMonthNames = ( "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" ) ;

    for ( $month_number = 1 ; $month_number <= 12 ; $month_number ++ )
    {
        $three_characters_month_name = substr( $ShortMonthNames[ $month_number - 1 ] , 0, 3 ) ;
        $month_number_for_three_character_month_name{ $three_characters_month_name } =  $month_number ;
    }


#-----------------------------------------------
#  Begin a loop that parses the information in
#  the XML case-info file.

    $copy_of_xml_read_from_case_file = $global_xml_read_from_case_file ;
    $copy_of_xml_read_from_case_file =~ s/\n+/ /gs ;
#    $global_log_output .= "<getrecent>XML from case file: " . $copy_of_xml_read_from_case_file  . "<\/getrecent>" ;
    while ( $copy_of_xml_read_from_case_file =~ /.*?<((writetime)|(proposal)|(participant)|(voteinfo)|(tiebreak)|(voteincompatibility)|(logstatementedit))>(.*)$/ )
    {
        $open_tag_name = $1 ;
        $copy_of_xml_read_from_case_file = $9 ;
#        $global_log_output .= "<getrecent>Open tag name: " . $open_tag_name . "<\/getrecent>" ;
        if ( $copy_of_xml_read_from_case_file =~ /^ *(.*?)<\/((writetime)|(proposal)|(participant)|(voteinfo)|(tiebreak)|(voteincompatibility)|(logstatementedit))>(.*)$/ )
        {
            $xml_content = $1 ;
            $close_tag = $2 ;
            $copy_of_xml_read_from_case_file = $10 ;
            $global_log_output .= "<getrecent>Tag " . $open_tag_name . " contains: " . $xml_content . "<\/getrecent>" ;


#-----------------------------------------------
#  If this is the date and time, get it.

            if ( $open_tag_name eq "writetime" )
            {
                if ( $xml_content =~ /<date>(.+?)<\/date>.*?<time>(.+?)<\/time>/ )
                {
                    $date = $1 ;
                    $time = $2 ;
                    $date_time = $date . " " . $time ;
                    $global_log_output .= "<getrecent>Date and time: " . $date_time . "<\/getrecent>" ;
                    if ( $date =~ /^([0-9\-]+)([a-z]+)\-?([0-9]+)$/i )
                    {
                        $year = $1 ;
                        $month_name = $2 ;
                        $day = $3 ;
                        $inverse_year = sprintf( "%04d" , ( 3000 - $year ) ) ;
                        $three_characters_month_name = substr( $month_name , 0 , 3 ) ;
                        $month_number = $month_number_for_three_character_month_name{ $three_characters_month_name } ;
                        $global_log_output .= "<getrecent>Month number: " . $month_number . " for month prefix " . $three_characters_month_name . "<\/getrecent>" ;
                        $inverse_month_number = sprintf( "%02d" , ( 20 - $month_number ) ) ;
                        $inverse_day_number = sprintf( "%02d" , ( 40 - $day ) ) ;
                        $sortable_date = $inverse_year . $inverse_month_number . $inverse_day_number . " " . $month_name . "-" . $day ;
                    }
                    $activity_sortable_id = "" ;
#                    $global_log_output .= "<getrecent>Sortable date: " . $sortable_date . "<\/getrecent>" ;
                }


#-----------------------------------------------
#  If this is a proposal change, get the proposal
#  ID number.

            } elsif ( $open_tag_name eq "proposal" )
            {
                if ( $xml_content =~ /<proposalid>(.*?)<\/proposalid>/ )
                {
                    $proposal_id = $1 ;
                    $sortable_proposal_id = sprintf( "%03d" , $proposal_id ) ;
                    $activity_sortable_id = "02 proposal" ;
                    $parameter_info = $sortable_proposal_id . " " . $proposal_id ;
                }


#-----------------------------------------------
#  If this is an incompatibility vote change,
#  get the proposal ID numbers.

            } elsif ( $open_tag_name eq "voteincompatibility" )
            {
                $activity_sortable_id = "03 proposalincompatvote" ;
                if ( $participant_id == 99999 )
                {
                    $activity_sortable_id = "04 adminincompatibility" ;
                }
                if ( $xml_content =~ /<proposalid>(.*?)<\/proposalid>/ )
                {
                    $proposal_id = $1 ;
                    $sortable_proposal_id = sprintf( "%03d" , $proposal_id ) ;
                    $parameter_info = $sortable_proposal_id . " " . $proposal_id ;
                }
                if ( $xml_content =~ /<proposalsecond>(.*?)<\/proposalsecond>/ )
                {
                    $proposal_id = $1 ;
                    $sortable_proposal_id = sprintf( "%03d" , $proposal_id ) ;
                    $parameter_info = $sortable_proposal_id . " " . $proposal_id ;
                }


#-----------------------------------------------
#  If this is a new participant,
#  get the participant ID number.

            } elsif ( $open_tag_name eq "participant" )
            {
                if ( $xml_content =~ /<participantid>(.*?)<\/participantid>/ )
                {
                    $participant_id = $1 ;
                    if ( $already_defined_participant[ $participant_id ] ne "yes" )
                    {
                        $sortable_participant_id = sprintf( "%03d" , $participant_id ) ;
                        $activity_sortable_id = "01 participantadded" ;
                        $parameter_info = $sortable_participant_id . " " . $participant_id ;
                    }
                    $already_defined_participant[ $participant_id ] = "yes" ;
                }


#-----------------------------------------------
#  If this is a ranking change, get the participant
#  ID number.

            } elsif ( $open_tag_name eq "voteinfo" )
            {
                if ( $xml_content =~ /<participantid>(.*?)<\/participantid>/ )
                {
                    $participant_id = $1 ;
                    $sortable_participant_id = sprintf( "%03d" , $participant_id ) ;
                    $activity_sortable_id = "05 participantranking" ;
                    $parameter_info = $sortable_participant_id . " " . $participant_id ;
                }


#-----------------------------------------------
#  If this is a statement edit, get the participant
#  ID number.

            } elsif ( $open_tag_name eq "logstatementedit" )
            {
                if ( $xml_content =~ /<participantid>(.*?)<\/participantid>/ )
                {
                    $participant_id = $1 ;
                    $sortable_participant_id = sprintf( "%03d" , $participant_id ) ;
                    $activity_sortable_id = "06 participantstatement" ;
                    $parameter_info = $sortable_participant_id . " " . $participant_id ;
                }
            }


#-----------------------------------------------
#  If this is a tie-break change, get the proposal
#  ID number.

            } elsif ( $open_tag_name eq "tiebreak" )
            {
                $activity_sortable_id = "07 tiebreak" ;
                $parameter_info = "" ;
        }


#-----------------------------------------------
#  Store each activity.

        if ( $activity_sortable_id ne "" )
        {
            $recent_change = $sortable_date . " " . $activity_sortable_id . " " . $parameter_info ;
            $item_recent_change{ $recent_change } = $recent_change ;
            $global_log_output .= "<getrecent>Recent change: " . $recent_change . "<\/getrecent>" ;
        }


#-----------------------------------------------
#  Repeat the loop.

    }


#-----------------------------------------------
#  Create a sorted list of recent activities.

#  Sorted text format:  "2008-02-07 Feb-7 02 proposal 006 6"

    $previous_date = "" ;
    $date_change_counter = 0 ;
    $date_change_counter_limit = 7 ;
    $global_log_output .= "<getrecent>Sorted order below<\/getrecent>" ;
    foreach $recent_change  ( sort( keys ( %item_recent_change ) ) )
    {
        $global_log_output .= "<getrecent>Recent change: " . $recent_change . "<\/getrecent>" ;
        @recent_change_component = split( / / , $recent_change ) ;
        $sortable_latest_date = $recent_change_component[ 0 ] ;
        $latest_date = $recent_change_component[ 1 ] ;
        $sortable_item_changed = $recent_change_component[ 2 ] ;
        $item_changed = $recent_change_component[ 3 ] ;
        $sortable_id = $recent_change_component[ 4 ] ;
        $changed_id = $recent_change_component[ 5 ] ;

        if ( ( $item_changed =~ /[^ ]/ ) && ( $already_listed{ $item_changed . "-" . $changed_id } ne "yes" ) )
        {
            $already_listed{ $item_changed . "-" . $changed_id } = "yes" ;
            if ( $sortable_latest_date ne $sortable_previous_date )
            {
                $date_change_counter ++ ;
                if ( $date_change_counter > $date_change_counter_limit )
                {
                    last ;
                }
                $sortable_previous_date = $sortable_latest_date ;
                $text_list_of_recent_changes =~ s/, *$// ;
                if ( $text_list_of_recent_changes ne "" )
                {
                    $text_list_of_recent_changes .= " recent-change-date-end " ;
                }
                $text_list_of_recent_changes .= " recent-change-date-begin " . $latest_date . " no-space : " ;
            }
            &dashrep_define( "parameter-next-action" , "next-action-for-recent-change-item-" . $item_changed ) ;
            &dashrep_define( "parameter-link-label" , "prefix-for-recent-change-" . $item_changed . " " . $changed_id . " " . " suffix-for-recent-change-" . $item_changed ) ;
            $replacement_name = "link-to-recently-changed-" . $item_changed . "-" . $changed_id ;
            if ( $item_changed =~ /proposal/ )
            {
                &dashrep_define( "parameter-proposal-id" , $changed_id ) ;
                &dashrep_define( "parameter-participant-id" , 0 ) ;
            } elsif ( $item_changed =~ /participant/ )
            {
                &dashrep_define( "parameter-proposal-id" , 0 ) ;
                &dashrep_define( "parameter-participant-id" , $changed_id ) ;
            }
            &dashrep_define( $replacement_name ,  &dashrep_expand_parameters( "template-for-recent-change-link" ) ) ;
            $text_list_of_recent_changes .= " " . $replacement_name . "  no-space  , " ;
        }
    }
    $text_list_of_recent_changes =~ s/, *$// ;
    $text_list_of_recent_changes .= " recent-change-date-end " ;
    &dashrep_define( "list-of-recent-changes" , $text_list_of_recent_changes ) ;
    $global_log_output .= "<getrecent>List of recent changes: " . $text_list_of_recent_changes . "<\/getrecent>" ;


#-----------------------------------------------
#  End of subroutine.

}

