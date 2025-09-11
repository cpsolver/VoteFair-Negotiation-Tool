#-----------------------------------------------
#-----------------------------------------------
#           initialization_main
#-----------------------------------------------
#-----------------------------------------------

sub initialization_main
{


#-----------------------------------------------
#  Save the starting time.

    $global_starting_time = time ;


#-----------------------------------------------
#  Define true and false.

    $global_true = 1 ;
    $global_false = 0 ;


#-----------------------------------------------
#  Insert the first XML tag at the beginning of
#  the log file.

    $global_log_output = $global_log_file_outer_xml_tag ;


#-----------------------------------------------
#  Get the current date and time.

    &get_current_time ;


#-----------------------------------------------
#  Set limits.

    $global_proposal_limit = 100 ;


#-----------------------------------------------
#  Miscellaneous initialization.

    @global_word_for_number = ( "unused" , "first" , "second" , "third" , "fourth" , "fifth" , "sixth" , "seventh" , "eighth" , "ninth" , "tenth" , "eleventh" , "twelfth" ) ;

    $global_write_log_file = $global_true ;

    $global_participant_is_unknown = $global_true ;
    $global_participant_can_vote = $global_false ;
    $global_participant_is_administrator = $global_false ;

    $global_only_need_basic_vote_info = $global_false ;

    $global_warning_file_text = "-WARNING" ;

    $global_form_number = 0 ;

    &dashrep_define( "possible-significant-error-message-on-home-page" , "" ) ;

    $global_endless_loop_counter_limit = 500000 ;


#-----------------------------------------------
#  Specify default or empty hidden CGI values.

    &dashrep_define( "output-accessid" , "unknown" ) ;
    &dashrep_define( "output-access-id" , "" ) ;
    &dashrep_define( "parameter-sort-by" , &dashrep_get_replacement( "input-sortby" ) ) ;
    &dashrep_define( "parameter-next-action" , "" ) ;
    &dashrep_define( "parameter-proposal-id" , "" ) ;
    &dashrep_define( "parameter-participant-id" , "" ) ;
    &dashrep_define( "parameter-proposal-second" , "" ) ;
    &dashrep_define( "parameter-alias-id" , "" ) ;


#-----------------------------------------------
#  Specify default replacement values.

    &dashrep_define( "case-number" , 0 ) ;
    &dashrep_define( "parameter-participant-id" , 0 ) ;


#-----------------------------------------------
#  Initialize the packing-bit constants.

    &access_id_packing_bit_sequence ;


#-----------------------------------------------
#  Specify file locations and names.
#  (And components of filenames.)

    $global_starting_date_hour_minute_second = $global_date_hour_minute_second ;

    $global_path_to_cgi_bin = "/var/www/cgi-bin/" ;

    $global_cases_directory_prefix = "cases/" ;
    $global_log_directory_prefix = "log/" ;

    $global_archive_directory_prefix = "cases/archive/" ;
    $global_archive_filename_prefix = $global_archive_directory_prefix . "archived-" ;
    $global_archive_filename_suffix = '.txt' ;

    $global_standard_replacements_filename = "replacements-negotiationtool-main.txt" ;

    $global_language_specific_replacements_filename_prefix = "replacements-negotiationtool-language-" ;
    $global_language_specific_replacements_filename_suffix = ".txt" ;

    $global_case_filename_prefix = $global_cases_directory_prefix . "case-" ;
    $global_case_filename_suffix = '.txt' ;
    $global_case_info_file_type_main = "main" ;

    $global_case_number = "000000" ;


#-----------------------------------------------
#  Initialize the number that is part of each form
#  name.  (There can be multiple forms on the same
#  page, so this keeps their names unique.)
#  Also initialize the numbers that indicate the
#  order in which "input" elements get focus when
#  the Tab key is pressed.

    &dashrep_define( "form-number" , 1 ) ;
    &dashrep_define( "auto-increment-tab-index-number" , 1 ) ;


#-----------------------------------------------
#  Initialize a percentage threshold value that
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
#  correction.  The correction reduces the
#  ability of a voter to rank an unpopular
#  proposal as their first choice as a way to
#  appear to be unable to get accepted a
#  proposal they supposedly really want
#  (which gives them more influence in choosing
#  the accepted propsals).

    &dashrep_define( "threshold-percentage-top-ranked-proposals-for-successive-elimination" , 35 ) ;


#-----------------------------------------------
#  Initialize the degree of represenation desired,
#  and how much of each kind of adjustment.
#  If a simple popularity ranking is desired,
#  the total number should be zero.  If full
#  representation is desired, the total of all
#  three types should be 100%.
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
#  If the numbers sum to more than 100, the values
#  will be adjusted.

    &dashrep_define( "percent-of-representation-based-on-raw-pairwise-counts" , 40 ) ;
    &dashrep_define( "percent-of-representation-based-on-positive-ranking" , 35 ) ;
    &dashrep_define( "percent-of-representation-based-on-negative-ranking" , 35 ) ;


#-----------------------------------------------
#  Initialize the majority percentage threshold
#  value.  It indicates the percentage of voters
#  who must rank a proposal in the positive
#  category in order for it to be accepted.
#  If the acceptance criteria is "average", then
#  this threshold only needs to be exceeded on
#  an average basis.

    &dashrep_define( "case-info-majoritypercentage" , 51 ) ;


#-----------------------------------------------
#  Initialize the minority percentage threshold
#  value.  It indicates the percentage of voters
#  who must rank a proposal in the positive
#  category in order for it to be accepted in
#  cases where the acceptance criteria is
#  "average".

    &dashrep_define( "case-info-minoritypercentage" , 20 ) ;


#-----------------------------------------------
#  All done.

}

