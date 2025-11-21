// -----------------------------------------------
// -----------------------------------------------
//
//  negotiation_tool.cpp
//
//  This software utility calculates results for the
//  VoteFair Negotiation Tool version 2.
//
//  The README file contains more documentation about what
//  this software does, how it works, and how to use it.
//
//  The infographic named "legislative_negotiation.png"
//  summarizes what this program does, and how
//  participants use this software.
//
//  Additional details appear below within the
//  code comments.
//
// 
// -----------------------------------------------
//
//  COPYRIGHT & LICENSE
//
//  (c) Copyright 2025 by Richard Fobes at
//  www.VoteFair.org.  You can redistribute and/or
//  modify this negotiation_tool software under
//  the MIT software license terms that appear
//  below.
//
//  Conversion of this code into another
//  programming language is also covered by the
//  above license terms.
//
//
// -----------------------------------------------
//
//  VERSION
//
//  Version 2.00 - In July 2025 Richard Fobes
//  derived this code from the rcipe_stv.cpp
//  code (elsewhere within the CPSolver
//  repositories) and from the Perl code that
//  implemented version 1.0 of the VoteFair
//  Negotiation Tool at NegotiationTool.com.
//
//  This code is finally functioning, but is not yet
//  refined and tested.  It should NOT yet be used for
//  real-life negotiation situations.
//
// -----------------------------------------------
//
//  USAGE
//
//  The following sample code compiles and
//  executes this software under Linux.
//
//      g++ negotiation_tool.cpp -o negotiation_tool
//      ./negotiation_tool.exe < input_negotiation_tool.csv > output_negotiation_tool.json
//
//  If this software is executed under under a typical Windows environment then the g++ compiler and the mingw32 library must be installed.  Also the following path command must be executed once:
//
//      path=C:\Program Files (x86)\mingw-w64\i686-8.1.0-posix-dwarf-rt_v6-rev0\mingw32\bin\
//
//  This usage assumes that file
//  input_negotiation_tool.txt contains appropriately
//  formatted data , and it writes the JSON coded results
//  to file output_negotiation_tool.txt.
//
//  The input file is generated from a spreadsheet.
//
//  The mathematical algorithm of this software
//  is in the public domain.
//
//
// -----------------------------------------------
//
//  SAMPLE INPUT FILES
//
//  The folder in which this software is stored includes
//  the following sample input files:
//
//    input_negotiation_tool.csv
//
//    input_cabinet_ministers.txt
//
//
// -----------------------------------------------
//
//  LICENSE
//
//  This negotiation_tool software is licensed
//  under the following MIT License terms.
//
//  MIT License for negotiation_tool.cpp
//
//  Copyright (c) 2025 by Richard Fobes at
//  ww.VoteFair.org
//
//  Permission is hereby granted, free of charge,
//  to any person obtaining a copy of this software
//  and associated documentation files (the
//  "Software"), to deal in the Software without
//  restriction, including without limitation the
//  rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom
//  the Software is furnished to do so, subject
//  to the following conditions:
//
//  The above copyright notice and this
//  permission notice shall be included in all
//  copies or substantial portions of the
//  Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
//  WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
//  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//
// -----------------------------------------------
//
//      IMPORTANT NOTES TO CODERS!
//
//  Please report any bugs or feature requests on
//  GitHub, at the CPSolver account, in the
//  VoteFair-Negotiation-Tool project area.
//  Thank you!
//
//  If you offer improvements to this code,
//  please follow the conventions used here, and
//  please keep this code easy to convert into
//  other programming languages.
//
//  Please resist the temptation to add the
//  handling any text.  The absense of that
//  text makes it obvious that this code is
//  completely unbiased -- because participant
//  names, and proposal text are
//  not available to this software.  Instead
//  all data is identified by integer numbers
//  (1, 2, 3, etc.) and only the software that
//  assigned these numbers can correlate them
//  with any names or identities.
//
//
// -----------------------------------------------


// -----------------------------------------------
//  Begin code.
// -----------------------------------------------


// -----------------------------------------------
//  Specify libraries needed.

#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
#include <cstdio>


// -----------------------------------------------
//  Declare constants.

//  Specify the maximum number of participants and
//  proposals.  If these numbers need to be increased,
//  also increase the dimension limits for the lists and
//  arrays that hold this info.

const int global_maximum_participant_number = 500 ;
const int global_maximum_proposal_number = 2000 ;


//  Declare ballot-related constants.  These numbers
//  should not change.  If they are changed, also change
//  the documentation that explains how to use this
//  software.

const int global_maximum_ranking_number = 100 ;
const int global_minimum_ranking_number = -100 ;
const int global_full_ballot_weight = 2000 ;


//  Declare the maximum number of pairwise counts.  If the
//  number of proposals exceeds the square root of this
//  number then approval voting will be used to reduce
//  the number of considered proposals so their pairwise
//  counts fit within this number.

const int global_maximum_proposal_pairs = 4000 ;


//  Specify the yes and no values. These are used instead
//  of language-specific true-versus-false codes because
//  different programming languages use different
//  conventions for their true/false logic.

const int global_yes = 1 ;
const int global_no = 0 ;


//  Specify flags.

const int global_const_start_line_incompatibility_pairs = -1 ;
const int global_const_start_line_incompatibility_group = -2 ;
const int global_const_start_line_limit_maximum_proposals_accepted = -10 ;
const int global_const_start_line_percent_threshold_dislike_rejection = -20 ;
const int global_const_start_line_hide_logging_in_json = -30 ;
const int global_const_start_line_disparity_gap_threshold_for_acceptance = -40 ;


// -----------------------------------------------
//  Declare the two-dimensional ranking-data array.

int global_array_ranking_for_participant_and_proposal[ 501 ][ 2001 ] ;


// -----------------------------------------------
//  Declare lists.

//  For speed reasons, lists are declared here,
//  not within a function, even if a single
//  function uses them.

//  Position one -- [ 1 ] -- is used as the starting
//  position for these lists, so the declared list length
//  must exceed, by (at least) one, the number of items
//  to be stored in the list.

int global_list_actual_proposal_for_alias_proposal[ 2001 ] ;
int global_list_adjustment_for_participant[ 501 ] ;
int global_list_alias_proposal_for_actual_proposal[ 2001 ] ;
int global_list_approval_count_for_proposal[ 2001 ] ;
int global_list_disapproval_count_for_proposal[ 2001 ] ;
int global_list_elimination_sequence[ 2001 ] ;
int global_list_integer_count_for_proposal[ 2001 ] ;
int global_list_loss_count_for_proposal[ 2001 ] ;
int global_list_of_all_proposals_ranked[ 2001 ] ;
int global_list_of_incompatible_proposal_number_for_pair[ 10001 ] ;
int global_list_of_integers_to_sort[ 501 ] ;
int global_list_of_proposals_just_incompatible[ 2001 ] ;
int global_list_of_proposals_accepted[ 2001 ] ;
int global_list_of_proposals_contributing_to_satisfaction_counts[ 501 ] ;
int global_list_of_proposals_rejected_as_incompatible[ 2001 ] ;
int global_list_of_proposals_not_popular[ 2001 ] ;
int global_list_of_proposals_ranked_negative[ 2001 ] ;
int global_list_of_proposals_ranked_neutral[ 2001 ] ;
int global_list_of_proposals_ranked_positive[ 2001 ] ;
int global_list_of_proposals_tied[ 2001 ] ;
int global_list_of_proposals_widely_disliked[ 2001 ] ;
int global_list_of_tied_proposals[ 2001 ] ;
int global_list_of_trigger_proposal_number_for_pair[ 10001 ] ;
int global_list_opposing_count_for_proposal_count[ 2001 ] ;
int global_list_overall_ranking_criteria_for_proposal[ 2001 ] ;
int global_list_pairwise_opposition_or_support_count_for_proposal[ 2001 ] ;
int global_list_percent_opposing_influence_so_far_for_participant[ 2001 ] ;
int global_list_percent_supporting_influence_so_far_for_participant[ 2001 ] ;
int global_list_percentage_positive_only_for_proposal[ 2001 ] ;
int global_list_proposal_count_negative_ranked_for_participant[ 5001 ] ;
int global_list_proposal_count_positive_ranked_for_participant[ 5001 ] ;
int global_list_proposal_count_temporarily_ignored_for_proposal_pointer[ 2001 ] ;
int global_list_proposal_first_at_pair_count[ 4001 ] ;
int global_list_proposal_for_proposal_count[ 2001 ] ;
int global_list_proposal_second_at_pair_count[4001 ] ;
int global_list_remaining_ballot_weight_for_participant[ 501 ] ;
int global_list_support_from_participant[ 2001 ] ;
int global_list_satisfaction_count_for_participant[ 501 ] ;
int global_list_tally_first_over_second_at_pair_count[ 4001 ] ;
int global_list_tally_second_over_first_at_pair_count[ 4001 ] ;
int global_list_tie_resolution_rank_level_for_proposal[ 2001 ] ;
int global_list_vote_count_positive_only_for_proposal[ 2001 ] ;
int global_list_yes_or_no_acceptance_possible_for_proposal[ 2001 ] ;
int global_list_yes_or_no_elimination_continuing_for_proposal[ 2001 ] ;
int global_list_yes_or_no_popularity_continuing_for_proposal[ 2001 ] ;
int global_sorted_list_of_satisfaction_counts[ 501 ] ;


// -----------------------------------------------
//  Declare global variables.

int global_acceptance_criteria ;
int global_actual_proposal_accepted ;
int global_actual_proposal_incompatible ;
int global_actual_proposal_number ;
int global_actual_proposal_trigger ;
int global_adjustment_for_negative_count ;
int global_adjustment_for_opposing_pairwise_count ;
int global_adjustment_for_positive_count ;
int global_adjustment_for_supporting_pairwise_count ;
int global_alias_accepted_proposal_number ;
int global_alias_just_identified_proposal_number ;
int global_alias_proposal_accepted ;
int global_alias_proposal_first_in_pair ;
int global_alias_proposal_for_satisfaction_count ;
int global_alias_proposal_incompatible ;
int global_alias_proposal_just_elected ;
int global_alias_proposal_number ;
int global_alias_proposal_possible_single_continuing ;
int global_alias_proposal_second_in_pair ;
int global_alias_proposal_to_eliminate ;
int global_alias_proposal_trigger ;
int global_alias_proposal_winner_of_elimination_rounds ;
int global_alias_proposal_with_largest_opposition_or_smallest_support ;
int global_alias_proposal_with_largest_sum ;
int global_approval_or_disapproval_count ;
int global_average_acceptance_if_this_proposal_accepted ;
int global_ballot_count_for_shared_preference_level ;
int global_ballot_info_repeat_count ;
int global_bottom_satisfaction_count_among_dominant_coalition ;
int global_bottom_satisfaction_count_among_opposition_coalition ;
int global_coalition_count ;
int global_column_pointer ;
int global_count_of_elimination_continuing_proposals ;
int global_count_of_popularity_continuing_proposals ;
int global_count_of_possibly_acceptable_continuing_proposals ;
int global_count_of_proposals_at_highest_support_value ;
int global_count_of_proposals_at_top_preference_level ;
int global_count_of_rankings_on_this_line ;
int global_count_of_tied_proposals ;
int global_count_of_top_ranked_remaining_proposals ;
int global_count_of_votes_to_each_proposal_at_shared_preference_level ;
int global_counter_disliked ;
int global_counting_cycle_number ;
int global_current_input_data_number ;
int global_disapproval_count ;
int global_dislikes_encountered ;
int global_disparity_gap ;
int global_disparity_gap_threshold_for_acceptance ;
int global_do_nothing ;
int global_dominant_coalition_size ;
int global_elimination_loop_count_maximum ;
int global_elimination_round_count ;
int global_endless_loop_counter ;
int global_first_number_in_input_line ;
int global_first_proposal_number ;
int global_graph_scale_offset ;
int global_highest_negative_ranked_count ;
int global_highest_preference_level ;
int global_highest_preference_level_of_any_remaining_proposal ;
int global_highest_vote_transfer_count ;
int global_incompatible_proposal_number_first_in_pair ;
int global_incompatible_proposal_number_second_in_pair ;
int global_input_line_number ;
int global_input_pointer_start_next_case ;
int global_largest_disapproval_count ;
int global_largest_or_smallest_count ;
int global_largest_satisfaction_count ;
int global_largest_support_value ;
int global_length_of_array_preference_level_for_participant_and_proposal ;
int global_length_of_list_elimination_sequence ;
int global_length_of_list_incompatible_proposal_number_pairs ;
int global_length_of_list_of_all_participant_participants ;
int global_length_of_list_of_all_proposals_ranked ;
int global_length_of_list_of_incompatible_pairs ;
int global_length_of_list_of_integers_to_sort ;
int global_length_of_list_of_mutually_incompatible_proposals ;
int global_length_of_list_of_proposals_accepted ;
int global_length_of_list_of_proposals_contributing_to_satisfaction_counts ;
int global_length_of_list_of_proposals_just_incompatible ;
int global_length_of_list_of_proposals_not_popular ;
int global_length_of_list_of_proposals_ranked_negative ;
int global_length_of_list_of_proposals_ranked_neutral ;
int global_length_of_list_of_proposals_ranked_positive ;
int global_length_of_list_of_proposals_rejected_as_incompatible ;
int global_length_of_list_of_proposals_widely_disliked ;
int global_length_of_list_of_tied_proposals ;
int global_limit_maximum_proposals_accepted ;
int global_list_pointer ;
int global_list_pointer_to_accepted_proposal ;
int global_list_tie_resolution_rank_level_for_proposal_being_checked ;
int global_list_tie_resolution_rank_level_for_proposal_with_largest_sum ;
int global_log_item_number ;
int global_lowest_positive_ranked_count ;
int global_lowest_vote_transfer_count ;
int global_majority_threshold ;
int global_majority_threshold_decimal ;
int global_majority_threshold_percent ;
int global_majority_threshold_percent_based_on_majority_participant_count ;
int global_matrix_column_number ;
int global_matrix_row_number ;
int global_maximum_coalition_count ;
int global_maximum_possible_influence_sum ;
int global_minimum_dislikes_required_to_reject ;
int global_minority_threshold_percent ;
int global_need_comma ;
int global_need_to_initialize_group_ballot_count ;
int global_neutral_ranking_level ;
int global_next_input_data_number ;
int global_number_of_ballots_getting_zero_influence ;
int global_number_of_participants ;
int global_number_of_proposals ;
int global_number_of_proposals_being_pairwise_considered ;
int global_number_of_proposals_remaining_for_possible_acceptance ;
int global_number_of_proposals_temporarily_not_considered ;
int global_number_of_proposals_with_highest_vote_transfer_count ;
int global_number_of_proposals_with_lowest_vote_transfer_count ;
int global_number_of_proposals_with_some_approval ;
int global_number_of_proposals_with_some_disapproval ;
int global_number_of_seats_filled ;
int global_number_of_seats_still_available ;
int global_number_of_seats_to_fill ;
int global_one_for_approval_two_for_disapproval ;
int global_one_for_opposition_two_for_support ;
int global_opposing_count_from_this_participant ;
int global_opposition_coalition_size ;
int global_opposition_or_support_count ;
int global_opposition_score ;
int global_pair_counter ;
int global_pair_counter_maximum ;
int global_pairwise_count_for_proposal ;
int global_pairwise_losing_proposal ;
int global_participant_number ;
int global_percent_representation_based_on_negative_count ;
int global_percent_representation_based_on_negative_ranking ;
int global_percent_representation_based_on_positive_count ;
int global_percent_representation_based_on_positive_ranking ;
int global_percent_representation_based_on_raw_pairwise_counts ;
int global_percent_support_for_this_accepted_proposal ;
int global_percent_threshold_dislike_rejection ;
int global_percentage ;
int global_percentage_positive_only ;
int global_pointer_to_current_ballot ;
int global_pointer_to_input_data_number ;
int global_pointer_to_list ;
int global_pointer_to_list_of_tied_proposals ;
int global_positive_only_being_checked ;
int global_positive_only_largest ;
int global_positive_only_vote_weight ;
int global_preference_level ;
int global_preference_level_adjusted ;
int global_preference_level_original ;
int global_previous_input_data_number ;
int global_proposal_count_accepted ;
int global_proposal_count_with_largest_sum ;
int global_proposal_if_accepted ;
int global_proposal_then_not_accepted ;
int global_question_number ;
int global_quota_count ;
int global_ranking_level ;
int global_ranking_number ;
int global_ranking_number_of_accepted_proposal ;
int global_ranking_position ;
int global_satisfaction_count ;
int global_satisfaction_count_range ;
int global_second_proposal_number ;
int global_smallest_approval_or_largest_disapproval_count ;
int global_smallest_satisfaction_count ;
int global_smallest_support_value ;
int global_successive_elimination_loop_counter ;
int global_sum_for_possible_dominant_coalition ;
int global_sum_for_possible_opposition_coalition ;
int global_sum_satisfaction_counts_for_core_dominant_coalition ;
int global_sum_satisfaction_counts_for_opposition_coalition ;
int global_supporting_count_from_this_participant ;
int global_supporting_vote_count_that_exceeds_quota ;
int global_supporting_votes_for_elected_proposal ;
int global_tally ;
int global_threshold_percentage_top_ranked_proposals_for_successive_elimination ;
int global_threshold_support_value ;
int global_tie_resolution_rank_order ;
int global_top_ranked_proposal_if_only_one_else_zero ;
int global_top_ranked_proposals_to_find ;
int global_top_satisfaction_count_among_dominant_coalition ;
int global_top_satisfaction_count_among_opposition_coalition ;
int global_total ;
int global_total_number_of_ballots_that_got_zero_influence ;
int global_total_of_all_adjustment_values ;
int global_unused_string_length ;
int global_weight_value ;
int global_within_ballots ;
int global_yes_or_no_at_beginning_of_input_line ;
int global_yes_or_no_at_incompatibility_info ;
int global_yes_or_no_at_least_one ;
int global_yes_or_no_find_largest_not_smallest ;
int global_yes_or_no_find_pairwise_opposition_not_support ;
int global_yes_or_no_hide_logging_in_json ;
int global_yes_or_no_input_is_integer ;
int global_yes_or_no_largest_or_smallest_count_initialized ;
int global_yes_or_no_tie_breaking_affected_outcome ;


// -----------------------------------------------
//  Declare decimal variables.

float decimal_equivalent_for_division_by_number_of_accepted_proposals ;
float decimal_equivalent_global_threshold_percentage_top_ranked_proposals_for_successive_elimination ;
float decimal_equivalent_multiply_by_100_and_divide_by_highest_preference_level ;
float global_decimal_scale_value_based_on_participant_count ;
float global_decimal_scale_value_based_on_proposal_count ;
float global_graph_scale_divisor ;


// -----------------------------------------------
//  Declare message strings.

std::string global_colon ;
std::string global_comma ;
std::string global_double_quotation_mark ;
std::string global_elim_sequence ;
std::string global_json_key ;
std::string global_json_value ;
std::string global_logitem_message ;
std::string global_logitem_text_store_longer ;
std::string global_result_text ;


// -----------------------------------------------
// -----------------------------------------------
//      convert_integer_to_text
//
//  This function is used instead of "std::to_string"
//  for compatibility with older C++ "string" libraries
//  that have a bug.  The bug is that the "to_string"
//  function is not recognized as being within the
//  "std" library, even though it is defined there.
//
//  Reminder, cannot write logitem message within this
//  function because that function is defined next, after
//  this function.

std::string convert_integer_to_text( int supplied_integer )
{
    char c_format_string[ 50 ] ;
    try
    {
        global_unused_string_length = sprintf( c_format_string , "%01d" , supplied_integer ) ;
        return ( std::string ) c_format_string ;
    }
    catch( ... )
    {
        return "NAN" ;
    }
}


// -----------------------------------------------
// -----------------------------------------------
//      write_json_key_value_pair
//
//  This function writes one JSON key-and-value pair.

void write_json_key_value_pair( )
{
    std::cout << global_double_quotation_mark << global_json_key << global_double_quotation_mark << global_colon << global_double_quotation_mark << global_json_value << global_double_quotation_mark << global_comma << std::endl ;
}


// -----------------------------------------------
// -----------------------------------------------
//      write_logitem_message
//
//  This function writes the next logitem message.  To
//  omit the logitem messages, comment-out the line that
//  writes these key value pairs.

void write_logitem_message( )
{
    if ( global_yes_or_no_hide_logging_in_json == global_no )
    {
        global_log_item_number ++ ;
        if ( global_log_item_number == 1 )
        {
            global_json_key = "logging_status_note" ;
            global_json_value = "hide logitem messages by inserting an input line that begins with negative integer " + convert_integer_to_text( global_const_start_line_hide_logging_in_json ) ;
            write_json_key_value_pair( ) ;
        }
        global_json_key = "logitem " + convert_integer_to_text( global_log_item_number ) ;
        global_json_value = global_logitem_message ;
        write_json_key_value_pair( ) ;
    }
}


// -----------------------------------------------
// -----------------------------------------------
//      convert_text_to_integer
//
//  To read why this function is here, see the comment
//  above for function: convert_integer_to_text
//
//  Note: Function "atoi" returns zero if not an integer,
//  so do not use that function.

int convert_text_to_integer( char * supplied_text )
{
    int equivalent_integer ;
    equivalent_integer = -999999 ;
    try
    {
        equivalent_integer = std::__cxx11::stoi( supplied_text ) ;
        global_yes_or_no_input_is_integer = global_yes ;
    }
    catch( ... )
    {
        global_yes_or_no_input_is_integer = global_no ;
    }


    return equivalent_integer ;
}


// -----------------------------------------------
// -----------------------------------------------
//      pad_integer
//
//  Pads integer with spaces, to left side.
//  Also ensures value of zero shows as "0",
//  not blank.

std::string pad_integer( int input_integer , int pad_width )
{
    std::string output_text ;
    output_text = "" ;
    int text_length ;
    if ( input_integer == 0 )
    {
        output_text = "0" ;
    } else
    {
        output_text = convert_integer_to_text( input_integer ) ;
    }
    text_length = output_text.length( ) ;
    while ( text_length < pad_width )
    {
        output_text = " " + output_text ;
        text_length ++ ;
    }
    return output_text ;
//  End of function pad_integer.
}



// -----------------------------------------------
// -----------------------------------------------
//      convert_float_to_text
//
//  To read why this function is here, see the comment
//  above for function: convert_integer_to_text

std::string convert_float_to_text( float supplied_float )
{
    std::string returned_string ;
    char c_format_string[ 50 ] ;
    try
    {
        global_unused_string_length = sprintf( c_format_string , "%1f" , supplied_float ) ;
        returned_string = ( std::string ) c_format_string ;
        //  next line assumes the sprintf result always includes a decimal point
        returned_string.erase( returned_string.find_last_not_of( "0" ) + 1 , std::string::npos ) ;
        returned_string.erase( returned_string.find_last_not_of( "." ) + 1 , std::string::npos ) ;
        return returned_string ;
    }
    catch( ... )
    {
        return "NAN" ;
    }
}


// -----------------------------------------------
// -----------------------------------------------
//      pad_real
//
//  Pads a real number with spaces on left side
//  and, if needed, zeros on right side.
//  Also ensures value of zero shows as "0.00",
//  not blank.

std::string pad_real( float input_real_number , int pad_width )
{
    std::string output_text ;
    output_text = "" ;
    int text_length ;
    int decimal_length ;
    int decimal_point_position ;
    if ( input_real_number == 0.0 )
    {
        output_text = "0.00" ;
    } else
    {
        output_text = convert_float_to_text( ( (int) ( input_real_number * 100 ) ) / 100 ) ;
    }
    decimal_point_position = output_text.find( "." , 0 ) ;
    if ( decimal_point_position < 1 )
    {
        output_text += "." ;
        decimal_point_position = output_text.find( "." , 0 ) ;
    }
    text_length = output_text.length( ) ;
    decimal_length = text_length - decimal_point_position - 1 ;
    while ( decimal_length < 2 )
    {
        output_text = output_text + "0" ;
        decimal_length ++ ;
    }
    text_length = output_text.length( ) ;
    while ( text_length < pad_width )
    {
        output_text = " " + output_text ;
        text_length ++ ;
    }
    return output_text ;
//  End of function pad_real.
}


// -----------------------------------------------
// -----------------------------------------------
//      read_data
//
//  Reads numbers from the standard input file, one line
//  at a time, and then interprets each number according
//  to context, especially based on the first number in
//  the line.
//
//  If the first number in the line is a positive integer
//  greater than zero, it is a proposal number.  All
//  remaining numbers in that line are ranking numbers --
//  for that proposal -- assigned by the participants.
//  The ranking numbers are stored in a list that will be
//  accessed repeatedly during vote counting.  The
//  calculations use alias proposal numbers, which are
//  consecutive, are used instead of actual proposal
//  numbers.  The associations between alias proposal
//  numbers and actual proposal numbers are tracked.
//
//  If the first number in the line is a negative integer
//  (and non-zero), it indicates which kind of info that
//  line contains.  Handle those lines according to the
//  kind of info supplied.


void read_data( )
{

    std::string input_line ;
    std::string input_text_word ;


// -----------------------------------------------
//  Initialization.

    global_alias_proposal_number = 0 ;
    global_number_of_proposals = 0 ;
    global_number_of_participants = 0 ;
    global_length_of_list_of_incompatible_pairs = 0 ;
    global_number_of_proposals_remaining_for_possible_acceptance = 0 ;
    global_length_of_list_of_proposals_widely_disliked = 0 ;
    global_length_of_list_of_proposals_not_popular = 0 ;


// -----------------------------------------------
//  Indicate the current status.

//    global_logitem_message = "[reading input numbers]" ;
//    write_logitem_message( ) ;


// -----------------------------------------------
//  Begin the loop to handle one line from the input file,
//  which is "standard input" (which means it's the input
//  file specified on the command line).

    for ( std::string input_line ; std::getline( std::cin , input_line ) ; )
    {
        global_input_line_number ++ ;
        std::size_t pointer_found = input_line.find_last_not_of( " \t\n\r" ) ;
        if ( pointer_found != std::string::npos )
        {
            input_line.erase( pointer_found + 1 ) ;
        } else
        {
            input_line.clear( ) ;
        }
        char input_line_c_version[ 2000 ] = "" ;
        std::size_t line_length = std::min( 2000 , (int) input_line.length() ) ;
        std::size_t line_length_copied = input_line.copy( input_line_c_version , line_length , 0 ) ;
        input_line_c_version[ line_length_copied ] = '\0' ;


// -----------------------------------------------
//  Do initialization at the beginning of each line.

        global_yes_or_no_at_beginning_of_input_line = global_yes ;
        global_first_number_in_input_line = 0 ;
        global_actual_proposal_number = 0 ;
        global_incompatible_proposal_number_first_in_pair = 0 ;
        global_length_of_list_of_mutually_incompatible_proposals = 0 ;


// -----------------------------------------------
//  Begin the loop to get first/next space-delimited, or
//  comma-delimited, or period-delimited, word of text
//  from the input line.

        char * pointer_to_word ;
        // reminder: strtok modifies the string
        pointer_to_word = strtok( input_line_c_version , " ,." ) ;
        while ( pointer_to_word != NULL )
        {
            input_text_word = pointer_to_word ;


// -----------------------------------------------
//  Convert the text word into an integer.  If this
//  conversion is not successful, specify it as the
//  number zero.

            global_current_input_data_number = convert_text_to_integer( pointer_to_word ) ;


// -----------------------------------------------
//  If this is the first number in the line, store the
//  number for use while handling the other numbers in
//  the same line.

            if ( global_yes_or_no_at_beginning_of_input_line == global_yes )
            {
                global_first_number_in_input_line = global_current_input_data_number ;
//                global_logitem_message = "[global_first_number_in_input_line: " + convert_integer_to_text( global_first_number_in_input_line ) + " ]" ;
//                write_logitem_message( ) ;
            }


// -----------------------------------------------
//  If the first number in any line is zero, ignore this
//  line as if it is a comment.

            if ( global_first_number_in_input_line == 0 )
            {
//                global_logitem_message = "[First number in input line is zero, so assume it is a comment line.]" ;
//                write_logitem_message( ) ;
                break ;
            }


// -----------------------------------------------
//  If the first number in the line is a positive integer
//  greater than zero, it is a proposal number, so get
//  the proposal number.  It indicates the beginning of
//  the line that specifies the rank at which each
//  participant has ranked that proposal.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_yes ) && ( global_first_number_in_input_line > 0 ) )
            {
                global_actual_proposal_number = global_current_input_data_number ;
                global_first_number_in_input_line = global_actual_proposal_number ;
                global_alias_proposal_number ++ ;
                global_number_of_proposals ++ ;
                global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] = global_actual_proposal_number ;
                global_list_alias_proposal_for_actual_proposal[ global_actual_proposal_number ] = global_alias_proposal_number ;
                global_participant_number = 0 ;
                global_count_of_rankings_on_this_line = 0 ;
                if ( global_alias_proposal_number > global_maximum_proposal_number )
                {
                    global_json_key = "error" ;
                    global_json_value = "Error: proposal number exceeds limit for proposal numbers, at input line number " + convert_integer_to_text( global_input_line_number ) ;
                    write_json_key_value_pair( ) ;
                    exit( EXIT_FAILURE ) ;
                }
//                global_logitem_message = "[at proposal number " + convert_integer_to_text( global_actual_proposal_number ) + " ]" ;
//                write_logitem_message( ) ;
            }


// -----------------------------------------------
//  If this input number is the next participant's ranking
//  number for this proposal, store it in an array.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_actual_proposal_number > 0 ) )
            {
                global_ranking_number = global_current_input_data_number ;
                global_count_of_rankings_on_this_line ++ ;
                global_participant_number ++ ;
                if ( global_ranking_number > global_maximum_ranking_number )
                {
//                    global_logitem_message = "[warning, ranking number exceeds limit, at input line number " + convert_integer_to_text( global_input_line_number ) + " so using maximum allowed]" ;
//                    write_logitem_message( ) ;
                    global_ranking_number = global_maximum_ranking_number ;
                }
                if ( global_ranking_number < global_minimum_ranking_number )
                {
//                    global_logitem_message = "[warning, ranking number exceeds negative limit, at input line number " + convert_integer_to_text( global_input_line_number ) + " so using maximum allowed]" ;
//                    write_logitem_message( ) ;
                    global_ranking_number = global_minimum_ranking_number ;
                }
                global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] = global_ranking_number ;

//                global_logitem_message = "[global_ranking_number: " + convert_integer_to_text( global_ranking_number ) + " ]" ;
//                write_logitem_message( ) ;

            }


// -----------------------------------------------
//  If the first number in the line specifies the line
//  contains incompatibility info, handle the next number
//  in the same line.  Then repeat the loop for the next
//  input number.
//
//  If this number is the second number in the line, it is
//  the proposal number that is incompatible with at
//  least one other proposal.
//
//  If this number is the third or later number in that
//  line, specify that it is incompatible with the
//  proposal specified as the second number in the line.
//
//  The first such proposal number is the "if" proposal
//  number.  The following proposal numbers indicate
//  which proposals cannot be accepted if the "if"
//  proposal is accepted.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_first_number_in_input_line == global_const_start_line_incompatibility_pairs ) )
            {
                if ( global_incompatible_proposal_number_first_in_pair == 0 )
                {
                    global_incompatible_proposal_number_first_in_pair = global_current_input_data_number ;
                } else
                {
                    global_length_of_list_of_incompatible_pairs ++ ;
                    global_list_of_trigger_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_incompatible_proposal_number_first_in_pair ;
                    global_list_of_incompatible_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_current_input_data_number ;
//                    global_logitem_message = "[proposal " + convert_integer_to_text( global_incompatible_proposal_number_first_in_pair ) + " is incompatible with proposal " + convert_integer_to_text( global_current_input_data_number ) + " ]" ;
//                    write_logitem_message( ) ;
                }
            }


// -----------------------------------------------
//  If the first number in the line specifies the line
//  contains a list of proposals that are mutually
//  incompatible, handle the next number in the same
//  line, and create all the possible pairs and indicate
//  every pair is mutually incompatible.  Then repeat the
//  loop for the next input number.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_first_number_in_input_line == global_const_start_line_incompatibility_group ) )
            {
                global_length_of_list_of_mutually_incompatible_proposals ++ ;
                global_list_of_proposals_just_incompatible[ global_length_of_list_of_mutually_incompatible_proposals ] = global_current_input_data_number ;
                if ( global_length_of_list_of_mutually_incompatible_proposals > 1 )
                {
                    for ( global_pointer_to_list = 1 ; global_pointer_to_list <= ( global_length_of_list_of_mutually_incompatible_proposals - 1 ) ; global_pointer_to_list ++ )
                    {
                        global_incompatible_proposal_number_first_in_pair = global_list_of_proposals_just_incompatible[ global_pointer_to_list ] ;
                        global_incompatible_proposal_number_second_in_pair = global_list_of_proposals_just_incompatible[ global_length_of_list_of_mutually_incompatible_proposals ] ;
                        global_length_of_list_of_incompatible_pairs ++ ;
                        global_list_of_trigger_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_list_alias_proposal_for_actual_proposal[ global_incompatible_proposal_number_first_in_pair ] ;
                        global_list_of_incompatible_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_list_alias_proposal_for_actual_proposal[ global_incompatible_proposal_number_second_in_pair ] ;
                        global_length_of_list_of_incompatible_pairs ++ ;
                        global_list_of_trigger_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_list_alias_proposal_for_actual_proposal[ global_incompatible_proposal_number_second_in_pair ] ;
                        global_list_of_incompatible_proposal_number_for_pair[ global_length_of_list_of_incompatible_pairs ] = global_list_alias_proposal_for_actual_proposal[ global_incompatible_proposal_number_first_in_pair ] ;
//                        global_logitem_message = "[mutually incompatible, proposals " + convert_integer_to_text( global_incompatible_proposal_number_first_in_pair ) + " and " + convert_integer_to_text( global_incompatible_proposal_number_second_in_pair ) + " ]" ;
//                        write_logitem_message( ) ;
                    }
                }
            }


// -----------------------------------------------
//  If the first number in the line specifies the line
//  contains a limit on the number of proposals that can
//  be accepted, and this number is the second number in
//  the line, save it as the specified limit.  Then
//  repeat the loop for the next input number.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_first_number_in_input_line == global_const_start_line_limit_maximum_proposals_accepted ) )
            {
                global_limit_maximum_proposals_accepted = global_current_input_data_number ;
//                global_logitem_message = "[maximum number of proposals accepted is " + convert_integer_to_text( global_limit_maximum_proposals_accepted ) + " ]" ;
//                write_logitem_message( ) ;
            }


// -----------------------------------------------
//  If the first number in the line specified the line
//  contains the percentage of dislikes that cause a
//  proposal to be rejected immediately, and this is the
//  second number, get this specified number, then repeat
//  the loop for the next input number.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_first_number_in_input_line == global_const_start_line_percent_threshold_dislike_rejection ) )
            {
                global_percent_threshold_dislike_rejection = global_current_input_data_number ;
//                global_logitem_message = "[percent dislikes needed for early rejection " + convert_integer_to_text( global_percent_threshold_dislike_rejection ) + " ]" ;
//                write_logitem_message( ) ;
            }


// -----------------------------------------------
//  If the first number in the line specifies hiding the
//  logging of details in the JSON output, update the
//  relevant flag, write a relevant reminder in the log
//  file, then repeat the loop for the next input
//  number.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_yes ) && ( global_first_number_in_input_line == global_const_start_line_hide_logging_in_json ) )
            {
                global_yes_or_no_hide_logging_in_json = global_yes ;
                global_json_key = "logging_status" ;
                global_json_value = "off" ;
                write_json_key_value_pair( ) ;
                global_json_key = "logging_status_note" ;
                global_json_value = "turn on logging by removing (or commenting-out) the input line that begins with negative integer " + convert_integer_to_text( global_const_start_line_hide_logging_in_json ) ;
                write_json_key_value_pair( ) ;
            }


// -----------------------------------------------
//  If the first number in the line specified the line
//  contains the satisfaction disparity threshold that
//  must be reached to adopt a proposal, and this is the
//  second number, get this specified number, then repeat
//  the loop for the next input number.

            if ( ( global_yes_or_no_at_beginning_of_input_line == global_no ) && ( global_first_number_in_input_line == global_const_start_line_disparity_gap_threshold_for_acceptance ) )
            {
                global_percent_threshold_dislike_rejection = global_current_input_data_number ;
//                global_logitem_message = "[percent dislikes needed for early rejection " + convert_integer_to_text( global_percent_threshold_dislike_rejection ) + " ]" ;
//                write_logitem_message( ) ;
            }


// -----------------------------------------------
//  Repeat the loop for the next word (within the line).

            global_yes_or_no_at_beginning_of_input_line = global_no ;
            pointer_to_word = strtok( NULL, " ,." ) ;
        }


// -----------------------------------------------
//  Verify each line has the same number of rankings, one
//  for each participant.

        if ( global_number_of_participants == 0 )
        {
            global_number_of_participants = global_count_of_rankings_on_this_line ;
        } else if ( global_count_of_rankings_on_this_line > global_number_of_participants )
        {
            global_json_key = "error" ;
            global_json_value = "count of rankings on input line number " + convert_integer_to_text( global_input_line_number ) + " does not match earlier lines." ;
            write_json_key_value_pair( ) ;
            exit( EXIT_FAILURE ) ;
        }


// -----------------------------------------------
//  Repeat the loop for the next line of data from
//  the input file.

    }
    global_json_key = "number_of_participants" ;
    global_json_value = convert_integer_to_text( global_number_of_participants ) ;
    write_json_key_value_pair( ) ;
    global_json_key = "number_of_proposals" ;
    global_json_value = convert_integer_to_text( global_number_of_proposals ) ;
    write_json_key_value_pair( ) ;


// -----------------------------------------------
//  If a meaningful number of participants were not found,
//  indicate this lack of data as a fatal error.

    if ( global_number_of_participants < 2 )
    {
        global_json_key = "error" ;
        global_json_value = "fewer than two participants." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


// -----------------------------------------------
//  End of function read_data.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      fill_tally_table
//
//  Fills the tally table with the ranking numbers from
//  the participants' ballots.

void fill_tally_table( )
{


// -----------------------------------------------
//  Create the needed pointers to pairs of counts.  If the
//  storage limit is exceeded, exit with an error
//  message.

    global_pair_counter = 0 ;
    for ( global_alias_proposal_first_in_pair = 1 ; global_alias_proposal_first_in_pair < global_number_of_proposals ; global_alias_proposal_first_in_pair ++ )
    {
        if ( global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_first_in_pair ] == global_yes )
        {
            for ( global_alias_proposal_second_in_pair = global_alias_proposal_first_in_pair + 1 ; global_alias_proposal_second_in_pair <= global_number_of_proposals ; global_alias_proposal_second_in_pair ++ )
            {
                if ( global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_second_in_pair ] == global_yes )
                {
                    global_pair_counter ++ ;
                    if ( global_pair_counter >= global_maximum_proposal_pairs )
                    {
                        global_json_key = "error" ;
                        global_json_value = "the number of proposals being pairwise counted exceeds the available storage space." ;
                        write_json_key_value_pair( ) ;
                        exit( EXIT_FAILURE ) ;
                    }
                    global_list_proposal_first_at_pair_count[ global_pair_counter ] = global_alias_proposal_first_in_pair ;
                    global_list_proposal_second_at_pair_count[ global_pair_counter ] = global_alias_proposal_second_in_pair ;
                }
            }
        }
    }
    global_pair_counter_maximum = global_pair_counter ;


// -----------------------------------------------
//  Fill the tally table with the current ballot
//  information.  Allow the influence amount
//  (ballot weight) for each ballot to be different.

    for ( global_pair_counter = 1 ; global_pair_counter <= global_pair_counter_maximum ; global_pair_counter ++ )
    {
        global_alias_proposal_first_in_pair = global_list_proposal_first_at_pair_count[ global_pair_counter ] ;
        global_alias_proposal_second_in_pair = global_list_proposal_second_at_pair_count[ global_pair_counter ] ;
        global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] = 0 ;
        global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] = 0 ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
//            global_logitem_message = "[first ranking is " + convert_integer_to_text( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_first_in_pair ] ) + " second ranking is " + convert_integer_to_text( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_second_in_pair ] ) + " ]" ;
//            write_logitem_message( ) ;
//            global_logitem_message = "[ballot weight is " + convert_integer_to_text( global_list_remaining_ballot_weight_for_participant[ global_participant_number ] ) + " ]" ;
//            write_logitem_message( ) ;
            if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_first_in_pair ] > global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_second_in_pair ] )
            {
                global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] += global_list_remaining_ballot_weight_for_participant[ global_participant_number ] ;
            } else if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_first_in_pair ] < global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_second_in_pair ] )
            {
                global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] += global_list_remaining_ballot_weight_for_participant[ global_participant_number ] ;
            }
        }
//        global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_first_in_pair ] ) + " versus " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_second_in_pair ] ) + " counts are " + convert_integer_to_text( global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] ) + " and " + convert_integer_to_text( global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] ) + " ]" ;
//        write_logitem_message( ) ;
    }


// -----------------------------------------------
//  End of function fill_tally_table.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      count_remaining_proposals
//
//  This function counts how many proposals are still
//  being considered for possible elimination.  If there
//  is just one proposal remaining, save the proposal
//  number.  The list
//  named "global_list_yes_or_no_elimination_continuing_for_proposal"
//  is used to indicate which proposals are remaining to
//  be eliminated.  Sometimes these continuing proposals
//  are just the proposals that are tied for
//  elimination.

void count_remaining_proposals( )
{

    global_count_of_elimination_continuing_proposals = 0 ;
    global_alias_proposal_possible_single_continuing = 0 ;
    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
        {
            global_count_of_elimination_continuing_proposals ++ ;
            global_alias_proposal_possible_single_continuing = global_alias_proposal_number ;
        }
    }
//    global_logitem_message = "[continuing proposal count is " + convert_integer_to_text( global_count_of_elimination_continuing_proposals ) + " ]" ;
//    write_logitem_message( ) ;

    return ;
//  End of function count_remaining_proposals.
}


// -----------------------------------------------
// -----------------------------------------------
//      count_approvals_and_disapprovals
//
//  This function counts how many participants approve, or
//  disaprove, each proposal.  These counts do not change
//  because each participant has the same full influence
//  (ballot weight) as each other participant.  

void count_approvals_and_disapprovals( )
{

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_approval_count_for_proposal[ global_alias_proposal_number ] = 0 ;
        global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] = 0 ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] > 0 )
            {
                global_list_approval_count_for_proposal[ global_alias_proposal_number ] ++ ;
            } else if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] < 0 )
            {
                global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] ++ ;
            }
        }
//        global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " has approval count " + convert_integer_to_text( global_list_approval_count_for_proposal[ global_alias_proposal_number ] ) + " and disapproval count " + convert_integer_to_text( global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] ) + " ]" ;
//        write_logitem_message( ) ;
    }

//  End of function count_approvals_and_disapprovals.
}


// -----------------------------------------------
// -----------------------------------------------
//      eliminate_one_proposal
//
//  This function eliminates the proposal specified in
//  global_alias_proposal_to_eliminate.  The proposal is
//  eliminated from the "popularity" version of
//  the "continuing"(or "remaining") list.
//  The "elimination" version of the continuing list is
//  updated to match the "popularity" version.

void eliminate_one_proposal( )
{


// -----------------------------------------------
//  Eliminate the specified proposal by specifying it is
//  no longer a continuing proposal during the
//  elimination process, during which the most popular
//  proposal is being determined.

    global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_to_eliminate ] = global_no ;
    global_elim_sequence = global_elim_sequence + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_to_eliminate ] ) ;
//    global_logitem_message = "[eliminating proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_to_eliminate ] ) + " ]" ;
//    write_logitem_message( ) ;


// -----------------------------------------------
//  Restore the flags that track which proposals continue
//  to be considered for elimination when finding the
//  proposal with the highest popularity (based on
//  current ballot weights).

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] ;
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
        {
//            global_logitem_message = "[after elimination, continuing proposals include " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " ]" ;
//            write_logitem_message( ) ;
        }
    }


// -----------------------------------------------
//  Add this proposal to the list that indicates the
//  elimination sequence.

    global_length_of_list_elimination_sequence ++ ;
    global_list_elimination_sequence[ global_length_of_list_elimination_sequence ] = global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_to_eliminate ] ;


// -----------------------------------------------
//  End of function eliminate_one_proposal.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      count_pairwise_losses
//
//  This function counts the number of pairwise losses for
//  each proposal.  Also if there is a pairwise losing
//  proposal, that proposal number is put into
//  global_pairwise_losing_proposal".  Otherwise
//  "global_pairwise_losing_proposal" is zero.  A pairwise
//   losing proposal is a proposal that loses against
//   every other remaining proposal.  The list
//  "global_list_yes_or_no_elimination_continuing_for_proposal"
//   specifies which proposals are not yet eliminated.
//   This convention allows looking for a pairwise losing
//   proposal from among a few proposals that are tied
//   for possible elimination.
//
//  Terminology clarification:  The terms Condorcet loser
//  and pairwise loser are similar, but Condorcet loser
//  only applies to the pairwise loser if all the choices
//  are still being considered.

void count_pairwise_losses( )
{


// -----------------------------------------------
//  Initialization.

    global_pairwise_losing_proposal = 0 ;
    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_loss_count_for_proposal[ global_alias_proposal_number ] = 0 ;
    }


// -----------------------------------------------
//  Count the number of pairwise losses for each proposal.
//  Also look for a pairwise losing proposal.

    for ( global_pair_counter = 1 ; global_pair_counter <= global_pair_counter_maximum ; global_pair_counter ++ )
    {
        global_alias_proposal_first_in_pair = global_list_proposal_first_at_pair_count[ global_pair_counter ] ;
        global_alias_proposal_second_in_pair = global_list_proposal_second_at_pair_count[ global_pair_counter ] ;
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_first_in_pair ] == global_no )
        {
            continue ;
        }
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_second_in_pair ] == global_no )
        {
            continue ;
        }
        if ( global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] < global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] )
        {
            global_list_loss_count_for_proposal[ global_alias_proposal_first_in_pair ] ++ ;
            if ( global_list_loss_count_for_proposal[ global_alias_proposal_first_in_pair ] == global_count_of_elimination_continuing_proposals - 1 )
            {
                global_pairwise_losing_proposal = global_alias_proposal_first_in_pair ;
            }
        } else if ( global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] < global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] )
        {
            global_list_loss_count_for_proposal[ global_alias_proposal_second_in_pair ] ++ ;
            if ( global_list_loss_count_for_proposal[ global_alias_proposal_second_in_pair ] == global_count_of_elimination_continuing_proposals - 1 )
            {
                global_pairwise_losing_proposal = global_alias_proposal_second_in_pair ;
            }
        }
    }


// -----------------------------------------------
//  If there is a pairwise losing proposal, log which one it is.

    if ( global_pairwise_losing_proposal > 0 )
    {
        global_elim_sequence = global_elim_sequence + " pwl" ;
        global_logitem_message = "[found pairwise losing proposal, proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_pairwise_losing_proposal ] ) + ", has " + convert_integer_to_text( global_list_loss_count_for_proposal[ global_pairwise_losing_proposal ] ) + " losses]" ;
//        write_logitem_message( ) ;
    }


// -----------------------------------------------
//  End of function count_pairwise_losses.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      calculate_pairwise_opposition_or_support
//
//  This function identifies which proposal has either the
//  highest pairwise opposition count or the smallest
//  pairwise support count, depending on which
//  calculation is requested.  Only the "popularity"
//  continuing proposals are included in the pairwise
//  counting.  Ties are possible.  The variable:
//  "global_length_of_list_of_tied_proposals" indicates
//  how many proposals have the highest pairwise
//  opposition count or the smallest pairwise support
//  count.  The proposal numbers are stored in the
//  list:
//  "global_list_of_tied_proposals"(which is a single item
//  if there is no tie).  This function does not
//  eliminate any proposal.

void calculate_pairwise_opposition_or_support( )
{


// -----------------------------------------------
//  Initialization.

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_number ] = 0 ;
    }


// -----------------------------------------------
//  Calculate the pairwise opposition count, or
//  pairwise support count if that is flagged,
//  for each proposal for which the value of
//  "global_list_yes_or_no_elimination_continuing_for_proposal"
//  is yes, and only consider contributions from
//  other proposals that have not yet been eliminated.

    for ( global_pair_counter = 1 ; global_pair_counter <= global_pair_counter_maximum ; global_pair_counter ++ )
    {
        global_alias_proposal_first_in_pair = global_list_proposal_first_at_pair_count[ global_pair_counter ] ;
        global_alias_proposal_second_in_pair = global_list_proposal_second_at_pair_count[ global_pair_counter ] ;
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_first_in_pair ] == global_no )
        {
            continue ;
        }
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_second_in_pair ] == global_no )
        {
            continue ;
        }
//        global_logitem_message = "[tally info " + convert_integer_to_text( global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] ) + " and " + convert_integer_to_text( global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] ) + " ]" ;
//        write_logitem_message( ) ;
        if ( global_yes_or_no_find_pairwise_opposition_not_support == global_yes )
        {
            global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_first_in_pair ] += global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] ;
            global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_second_in_pair ] += global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] ;
        } else
        {
            global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_first_in_pair ] += global_list_tally_first_over_second_at_pair_count[ global_pair_counter ] ;
            global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_second_in_pair ] += global_list_tally_second_over_first_at_pair_count[ global_pair_counter ] ;
        }
    }


// -----------------------------------------------
//  Identify which proposal has the largest pairwise
//  opposition count or the smallest pairwise support
//  count.  Allow for ties.

    global_alias_proposal_with_largest_opposition_or_smallest_support = 0 ;
    global_length_of_list_of_tied_proposals = 0 ;
    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
        {
            global_opposition_or_support_count = global_list_pairwise_opposition_or_support_count_for_proposal[ global_alias_proposal_number ] ;
            if ( global_yes_or_no_find_pairwise_opposition_not_support == global_yes )
            {
//                global_logitem_message = "[pairwise opposition count for proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " is " + convert_integer_to_text( global_opposition_or_support_count ) + " ]" ;
//                write_logitem_message( ) ;
            } else
            {
//                global_logitem_message = "[pairwise support count for proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " is " + convert_integer_to_text( global_opposition_or_support_count ) + " ]" ;
//                write_logitem_message( ) ;
            }
            if ( global_length_of_list_of_tied_proposals == 0 )
            {
                global_largest_or_smallest_count = global_opposition_or_support_count ;
            }
            if ( global_opposition_or_support_count == global_largest_or_smallest_count )
            {
                global_length_of_list_of_tied_proposals ++ ;
                global_list_of_tied_proposals[ global_length_of_list_of_tied_proposals ] = global_alias_proposal_number ;
            } else if ( ( ( global_yes_or_no_find_pairwise_opposition_not_support == global_yes ) && ( global_opposition_or_support_count > global_largest_or_smallest_count ) ) || ( ( global_yes_or_no_find_pairwise_opposition_not_support == global_no ) && ( global_opposition_or_support_count < global_largest_or_smallest_count ) ) )
            {
                global_largest_or_smallest_count = global_opposition_or_support_count ;
                global_length_of_list_of_tied_proposals = 1 ;
                global_list_of_tied_proposals[ global_length_of_list_of_tied_proposals ] = global_alias_proposal_number ;
            }
        }
    }
//    global_logitem_message = "[there are " + convert_integer_to_text( global_length_of_list_of_tied_proposals ) + " proposals at largest opposition or smallest support count " + convert_integer_to_text( global_largest_or_smallest_count ) + " ]" ;
//    write_logitem_message( ) ;


// -----------------------------------------------
//  End of function calculate_pairwise_opposition_or_support.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      limit_elimination_continuing_proposals_to_tied_proposals
//
//  This function updates the list of proposals being
//  considered for elimination (the "elimination" version
//  of the "continuing" list) to just the tied
//  proposals.

void limit_elimination_continuing_proposals_to_tied_proposals( )
{

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] = global_no ;
    }
    for ( global_pointer_to_list_of_tied_proposals = 1 ; global_pointer_to_list_of_tied_proposals <= global_length_of_list_of_tied_proposals ; global_pointer_to_list_of_tied_proposals ++ )
    {
        global_alias_proposal_number = global_list_of_tied_proposals[ global_pointer_to_list_of_tied_proposals ] ;
        global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] = global_yes ;
//        global_logitem_message = "[one of the " + convert_integer_to_text( global_length_of_list_of_tied_proposals ) + " tied proposals to eliminate is proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " ]" ;
//        write_logitem_message( ) ;
    }
    global_elim_sequence = global_elim_sequence + " tie" ;

    return ;
//  End of function limit_elimination_continuing_proposals_to_tied_proposals.

}


// -----------------------------------------------
// -----------------------------------------------
//      method_instant_pairwise_elimination
//
//  This function implements the election method named
//  "Instant Pairwise Elimination" (IPE).  It does rounds
//  of elimination and eliminates the pairwise losing
//  proposal or otherwise (when there is not such a
//  proposal) eliminates the proposal with the largest
//  pairwise opposition count.  If there is still a tie,
//  it eliminates the pairwise losing proposal from
//  within the tied proposals.  If there is still a tie,
//  it eliminates the proposal with the smallest pairwise
//  support count.  If there is still a tie, it
//  eliminates the pairwise losing proposal from among
//  the tied proposals.  If there is still a tie, it
//  eliminates the proposal with the lowest approval, or
//  else the proposal with the highest disapproval.  If
//  there is still a tie, it eliminates the proposal that
//  was the last of the tied proposals to appear in the
//  input data.


void method_instant_pairwise_elimination( )
{

// -----------------------------------------------
//  Initialize the list of proposals that can be
//  eliminated to be the full list of proposals for which
//  the popularity is calculated.  Also count the number
//  of proposals in this list.

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] ;
    }
    count_remaining_proposals( ) ;


// -----------------------------------------------
//  Create the tally table and fill it based on the
//  rankings supplied.  Use the current ballot weights,
//  which might be reduced for some participants who have
//  already gotten what they want, so there is full
//  weight for participants who have not yet gotten much
//  of what they want.

    fill_tally_table( ) ;


// -----------------------------------------------
//  Begin the loop that handles each round of elimination.
//  Allow for the possibility that every elimination
//  involves a deep tie, where each elimination in the
//  tie requires one loop.

    global_elim_sequence = "[elim sequence:" ;
    global_length_of_list_elimination_sequence = 0 ;
    global_elimination_loop_count_maximum = ( global_count_of_elimination_continuing_proposals + 1 ) * 4  ;
    for ( global_elimination_round_count = 1 ; global_elimination_round_count <= global_elimination_loop_count_maximum ; global_elimination_round_count ++ )
    {


// -----------------------------------------------
//  If the number of proposals not yet eliminated is one,
//  identify it as the winner and return.

        count_remaining_proposals( ) ;
        global_alias_proposal_winner_of_elimination_rounds = 0 ;
        if ( global_count_of_elimination_continuing_proposals == 1 )
        {
            global_alias_proposal_winner_of_elimination_rounds = global_alias_proposal_possible_single_continuing ;
            global_logitem_message = "[winner of IPE is proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_winner_of_elimination_rounds ] ) + " ]" ;
            write_logitem_message( ) ;
            global_elim_sequence = global_elim_sequence + " win " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_winner_of_elimination_rounds ] ) + " ]" ;
            global_logitem_message = global_elim_sequence ;
            write_logitem_message( ) ;
            return ;
        }


// -----------------------------------------------
//  If there is a pairwise losing proposal, eliminate that
//  proposal and restart the elimination loop.

        count_pairwise_losses( ) ;
        if ( global_pairwise_losing_proposal > 0 )
        {
            global_alias_proposal_to_eliminate = global_pairwise_losing_proposal ;
            eliminate_one_proposal( ) ;
            global_length_of_list_of_tied_proposals = 0 ;
            continue ;
        }


// -----------------------------------------------
//  There is still a tie, so identify which proposal has,
//  or proposals have, the largest pairwise opposition
//  count, or the smallest support count.  If there is
//  only one such proposal, eliminate it, then repeat the
//  counting loop.  Otherwise, if the number of tied
//  proposals is less than the count of proposals
//  remaining to be considered for elimination, limit
//  the "remaining" proposals and repeat the counting
//  loop, which starts by looking for a pairwise losing
//  proposal among the tied proposals.

        global_elim_sequence = global_elim_sequence + " opp" ;
//        global_logitem_message = "[calculating pairwise opposition]" ;
//        write_logitem_message( ) ;
        global_yes_or_no_find_pairwise_opposition_not_support = global_yes ;
        for ( global_one_for_opposition_two_for_support = 1 ; global_one_for_opposition_two_for_support <= 2 ; global_one_for_opposition_two_for_support ++ )
        {
            calculate_pairwise_opposition_or_support( ) ;
            if ( global_length_of_list_of_tied_proposals == 1 )
            {
                global_alias_proposal_with_largest_opposition_or_smallest_support = global_list_of_tied_proposals[ 1 ] ;
                if ( global_yes_or_no_find_pairwise_opposition_not_support == global_yes )
                {
//                    global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_with_largest_opposition_or_smallest_support ] ) + " has the single largest opposition count]" ;
//                    write_logitem_message( ) ;
                } else
                {
//                    global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_with_largest_opposition_or_smallest_support ] ) + " has the single smallest support count]" ;
//                    write_logitem_message( ) ;
                }
                global_alias_proposal_to_eliminate = global_alias_proposal_with_largest_opposition_or_smallest_support ;
                eliminate_one_proposal( ) ;
                break ;
            }
            if ( global_length_of_list_of_tied_proposals > 1 )
            {
                if ( global_yes_or_no_find_pairwise_opposition_not_support == global_yes )
                {
//                    global_logitem_message = "[there are " + convert_integer_to_text( global_length_of_list_of_tied_proposals ) + " proposals with the largest opposition count of " + convert_integer_to_text( global_largest_or_smallest_count ) + " ]" ;
//                    write_logitem_message( ) ;
                } else
                {
//                    global_logitem_message = "[there are " + convert_integer_to_text( global_length_of_list_of_tied_proposals ) + " proposals with the lowest support count of " + convert_integer_to_text( global_largest_or_smallest_count ) + " ]" ;
//                    write_logitem_message( ) ;
                }
            }
            limit_elimination_continuing_proposals_to_tied_proposals( ) ;
            count_remaining_proposals( ) ;
            if ( global_length_of_list_of_tied_proposals < global_count_of_elimination_continuing_proposals )
            {
                break ;
            }
            global_yes_or_no_find_pairwise_opposition_not_support = global_no ;
            global_elim_sequence = global_elim_sequence + " supp" ;
//            global_logitem_message = "[calculating pairwise support]" ;
//            write_logitem_message( ) ;
        }
//  If a proposal was eliminated, repeat the main loop (not the smaller loop above).
        if ( global_length_of_list_of_tied_proposals == 1 )
        {
            continue ;
        }
//  If the number of tied proposals has been reduced, repeat the main loop.
        if ( global_length_of_list_of_tied_proposals < global_count_of_elimination_continuing_proposals )
        {
            continue ;
        }


// -----------------------------------------------
//  There is still a tie for which proposal to eliminate,
//  so identify the continuing proposal, or proposals,
//  that have the smallest approval count, or the largest
//  disapproval count.  This tie breaking method regards
//  each ballot as having the same weight
//  (influence) because the approval and disapproval
//  counts are counted only once when all proposals are
//  being considered.

        global_elim_sequence = global_elim_sequence + " appr" ;
//        global_logitem_message = "[finding smallest approval count]" ;
//        write_logitem_message( ) ;
        for ( global_one_for_approval_two_for_disapproval = 1 ; global_one_for_approval_two_for_disapproval <= 2 ; global_one_for_approval_two_for_disapproval ++ )
        {
            global_length_of_list_of_tied_proposals = 0 ;
            for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
            {
                if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
                {
//                    global_logitem_message = "[considering proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " ]" ;
//                    write_logitem_message( ) ;
                    if ( global_one_for_approval_two_for_disapproval == 1 )
                    {
                        global_approval_or_disapproval_count = global_list_approval_count_for_proposal[ global_alias_proposal_number ] ;
//                        global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " has approval count of " + convert_integer_to_text( global_approval_or_disapproval_count ) + " ]" ;
//                        write_logitem_message( ) ;
                    } else
                    {
                        global_approval_or_disapproval_count = global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] ;
//                        global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " has disapproval count of " + convert_integer_to_text( global_approval_or_disapproval_count ) + " ]" ;
//                        write_logitem_message( ) ;
                    }
                    if ( global_length_of_list_of_tied_proposals == 0 )
                    {
                        global_smallest_approval_or_largest_disapproval_count = global_approval_or_disapproval_count ;
                    }
                    if ( global_smallest_approval_or_largest_disapproval_count == global_approval_or_disapproval_count )
                    {
                        global_length_of_list_of_tied_proposals ++ ;
                        global_list_of_tied_proposals[ global_length_of_list_of_tied_proposals ] = global_alias_proposal_number ;
                    } else if ( ( ( global_one_for_approval_two_for_disapproval == 1 ) && ( global_approval_or_disapproval_count < global_smallest_approval_or_largest_disapproval_count ) ) || ( ( global_one_for_approval_two_for_disapproval == 2 ) && ( global_approval_or_disapproval_count > global_smallest_approval_or_largest_disapproval_count ) ) )
                    {
                        global_smallest_approval_or_largest_disapproval_count = global_approval_or_disapproval_count ;
                        global_length_of_list_of_tied_proposals = 1 ;
                        global_list_of_tied_proposals[ global_length_of_list_of_tied_proposals ] = global_alias_proposal_number ;
                    }
                }
            }
            if ( global_one_for_approval_two_for_disapproval == 1 )
            {
//                global_logitem_message = "[smallest approval count is " + convert_integer_to_text( global_smallest_approval_or_largest_disapproval_count ) + " ]" ;
//                write_logitem_message( ) ;
            } else
            {
//                global_logitem_message = "[largest disapproval count is " + convert_integer_to_text( global_smallest_approval_or_largest_disapproval_count ) + " ]" ;
//                write_logitem_message( ) ;
            }
            if ( global_length_of_list_of_tied_proposals == 1 )
            {
                global_alias_proposal_to_eliminate = global_list_of_tied_proposals[ 1 ] ;
                eliminate_one_proposal( ) ;
                break ;
            }
            limit_elimination_continuing_proposals_to_tied_proposals( ) ;
            count_remaining_proposals( ) ;
            if ( global_length_of_list_of_tied_proposals < global_count_of_elimination_continuing_proposals )
            {
                break ;
            }
            global_elim_sequence = global_elim_sequence + " disapp" ;
//            global_logitem_message = "[finding largest disapproval count]" ;
//            write_logitem_message( ) ;
        }
        if ( global_length_of_list_of_tied_proposals == 1 )
        {
            continue ;
        }
        if ( global_length_of_list_of_tied_proposals < global_count_of_elimination_continuing_proposals )
        {
            continue ;
        }


// -----------------------------------------------
//  There is still a tie for which proposal to eliminate,
//  so resolve the tie by eliminating the proposal that
//  was the last of the tied proposals to appear in the
//  input data.

        for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
        {
            if ( global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
            {
                global_alias_proposal_to_eliminate = global_alias_proposal_number ;
            }
        }
        global_elim_sequence = global_elim_sequence + " deep_tie_resolved" ;
//        global_logitem_message = "[to break deep tie, eliminating tied proposal lowest in data input list]" ;
//        write_logitem_message( ) ;
        eliminate_one_proposal( ) ;


// -----------------------------------------------
//  Repeat the loop that handles each round of
//  elimination.

    }


// -----------------------------------------------
//  An endless loop was encountered.

    global_logitem_message = "[endless loop reached count " + convert_integer_to_text( global_elimination_round_count ) + " ]" ;
    write_logitem_message( ) ;


// -----------------------------------------------
//  End of function method_instant_pairwise_elimination.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      identify_incompatible_proposals
//
//  Identify which proposals are incompatitible with the
//  proposal specified in the variable named
//  "global_alias_just_identified_proposal_number".


void identify_incompatible_proposals( )
{


// -----------------------------------------------
//  Identify the incompatible proposals.

    global_length_of_list_of_proposals_just_incompatible = 0 ;
    global_logitem_message = "[proposals incompatible with proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_just_identified_proposal_number ] ) + ":" ;
    for ( global_pair_counter = 1 ; global_pair_counter <= global_length_of_list_of_incompatible_pairs ; global_pair_counter ++ )
    {
        if ( global_list_of_trigger_proposal_number_for_pair[ global_pair_counter ] == global_alias_just_identified_proposal_number )
        {
            global_length_of_list_of_proposals_just_incompatible ++ ;
            global_list_of_proposals_just_incompatible[ global_length_of_list_of_proposals_just_incompatible ] = global_list_of_incompatible_proposal_number_for_pair[ global_pair_counter ] ;
            global_logitem_message = global_logitem_message + " " + convert_integer_to_text( global_list_of_proposals_just_incompatible[ global_length_of_list_of_proposals_just_incompatible ] ) ;
        }
    }
    global_logitem_message = global_logitem_message + " ]" ;
    if ( global_length_of_list_of_proposals_just_incompatible > 0 )
    {
        write_logitem_message( ) ;
    }


// -----------------------------------------------
//  End of function identify_incompatible_proposals.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      calculate_satisfaction_counts
//
//  Calculate a satisfaction count for each participant.
//  Offset each count by the number of proposals so these
//  counts are always positive, never negative. The
//  satisfaction count is a normalized value that is
//  based on pairwise support-minus-opposition counts.
//  These counts are based on comparing accepted
//  proposals with incompatible proposals, and comparing
//  accepted proposals with all proposals.  Details are
//  explained in the comments.

void calculate_satisfaction_counts( )
{


// -----------------------------------------------
//  Verify there is at least one proposal accepted.  If
//  not, return with zeros as satisfaction counts.

    if ( global_length_of_list_of_proposals_accepted < 1 )
    {
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            global_list_satisfaction_count_for_participant[ global_participant_number ] = 0 ;
        }
        return ;
    }


// -----------------------------------------------
//  Initialization.

    for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
    {
        global_list_satisfaction_count_for_participant[ global_participant_number ] = 0 ;
    }


// -----------------------------------------------
//  Begin a loop that considers each accepted proposal.

    for ( global_list_pointer_to_accepted_proposal = 1 ; global_list_pointer_to_accepted_proposal <= global_length_of_list_of_proposals_accepted ; global_list_pointer_to_accepted_proposal ++ )
    {
        global_alias_accepted_proposal_number = global_list_of_proposals_accepted[ global_list_pointer_to_accepted_proposal ] ;
//        global_logitem_message = "[accepted proposal is " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_accepted_proposal_number ] ) + " ]" ;
//        write_logitem_message( ) ;


// -----------------------------------------------
//  Begin a loop that considers the proposals that are
//  incompatible with each accepted proposal.

        global_alias_just_identified_proposal_number = global_alias_accepted_proposal_number ;
        identify_incompatible_proposals( ) ;
        for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_just_incompatible ; global_list_pointer ++ )
        {
            global_alias_proposal_for_satisfaction_count = global_list_of_proposals_just_incompatible[ global_list_pointer ] ;
//            global_logitem_message = "[incompatible proposal is " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_for_satisfaction_count ] ) + " ]" ;
//            write_logitem_message( ) ;


// -----------------------------------------------
//  Begin a loop that handles each participant.

            for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
            {
                global_ranking_number_of_accepted_proposal = global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_accepted_proposal_number ] ;
//                global_logitem_message = "[rank " + convert_integer_to_text( global_ranking_number_of_accepted_proposal ) + " ]" ;
//                write_logitem_message( ) ;


// -----------------------------------------------
//  Increment or decrement by two (not one) the
//  satisfaction count based on comparing the accepted
//  proposal rank with the incompatible proposal rank.

                if ( global_ranking_number_of_accepted_proposal > global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_for_satisfaction_count ] )
                {
                    global_list_satisfaction_count_for_participant[ global_participant_number ] += 2 ;
                } else if ( global_ranking_number_of_accepted_proposal < global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_for_satisfaction_count ] )
                {
                    global_list_satisfaction_count_for_participant[ global_participant_number ] -= 2 ;
                }
//                global_logitem_message = "[satisfaction count is " + convert_integer_to_text( global_list_satisfaction_count_for_participant[ global_participant_number ] ) + " ]" ;
//                write_logitem_message( ) ;


// -----------------------------------------------
//  Repeat the loop to handle the next participant.

            }


// -----------------------------------------------
//  Repeat the loop to handle the next proposal that is
//  incompatible with the current accepted proposal.

        }


// -----------------------------------------------
//  Begin a loop that compares the accepted proposal with
//  every other proposal that is still available to be
//  accepted.

        for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
        {
            if ( global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] == global_yes )
            {
//                global_logitem_message = "[available proposal is " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " ]" ;
//                write_logitem_message( ) ;


// -----------------------------------------------
//  Begin a loop that handles each participant.

                for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
                {


// -----------------------------------------------
//  Increment or decrement the satisfaction count based on
//  comparing the accepted proposal rank with the next
//  proposal not yet accepted.

                    global_ranking_number_of_accepted_proposal = global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_accepted_proposal_number ] ;
//                    global_logitem_message = "[rank " + convert_integer_to_text( global_ranking_number_of_accepted_proposal ) + " ]" ;
//                    write_logitem_message( ) ;
                    if ( global_ranking_number_of_accepted_proposal > global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] )
                    {
                        global_list_satisfaction_count_for_participant[ global_participant_number ] ++ ;
                    } else if ( global_ranking_number_of_accepted_proposal < global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] )
                    {
                        global_list_satisfaction_count_for_participant[ global_participant_number ] -- ;
                    }
//                    global_logitem_message = "[satisfaction count is " + convert_integer_to_text( global_list_satisfaction_count_for_participant[ global_participant_number ] ) + " ]" ;
//                    write_logitem_message( ) ;


// -----------------------------------------------
//  Repeat the loop to handle the next participant.

                }


// -----------------------------------------------
//  Repeat the loop to handle the next available proposal
//  that is being compared to the current accepted
//  proposal.

            }
        }


// -----------------------------------------------
//  Repeat the loop to handle the next accepted
//  proposal.

    }


// -----------------------------------------------
//  Calculate and log the smallest and largest raw
//  (not-yet_normalized) satisfaction counts.

    global_smallest_satisfaction_count = 0 ;
    global_largest_satisfaction_count = 0 ;
    for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
    {
        global_satisfaction_count = global_list_satisfaction_count_for_participant[ global_participant_number ] ;
        if ( ( global_satisfaction_count < global_smallest_satisfaction_count ) || ( global_smallest_satisfaction_count == 0 ) )
        {
            global_smallest_satisfaction_count = global_satisfaction_count ;
        }
        if ( ( global_satisfaction_count > global_largest_satisfaction_count ) || ( global_largest_satisfaction_count == 0 ) )
        {
            global_largest_satisfaction_count = global_satisfaction_count ;
        }
    }
//    global_logitem_message = "[smallest and largest raw satisfaction counts are " + convert_integer_to_text( global_smallest_satisfaction_count ) + " and " + convert_integer_to_text( global_largest_satisfaction_count ) + " ]" ;
//    write_logitem_message( ) ;


// -----------------------------------------------
//  Normalize the satisfaction counts to range from zero
//  to the full ballot weight.

    global_satisfaction_count_range = global_largest_satisfaction_count - global_smallest_satisfaction_count ;
    for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
    {
        global_list_satisfaction_count_for_participant[ global_participant_number ] = int( float( global_full_ballot_weight * ( global_list_satisfaction_count_for_participant[ global_participant_number ] - global_smallest_satisfaction_count ) ) / float( global_satisfaction_count_range ) ) ;
//        global_logitem_message = "[par_" + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_participant_number] ) + " normalized value is " + convert_integer_to_text( global_list_satisfaction_count_for_participant[ global_participant_number ] ) + " ]" ;
//        write_logitem_message( ) ;
    }


// -----------------------------------------------
//  Log the calculated normalized satisfaction counts.

    global_logitem_message = "[*****]" ;
    write_logitem_message( ) ;
    global_logitem_message = "[***** normalized satisfaction counts begin *****]" ;
    write_logitem_message( ) ;
    for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
    {
        global_graph_scale_divisor = float( global_full_ballot_weight ) / 30.0 ;
        global_logitem_message = "[par_" + convert_integer_to_text( global_participant_number ) + "  " ;
        for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_list_satisfaction_count_for_participant[ global_participant_number ] ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
        {
            global_logitem_message = global_logitem_message + " " ;
        }
        global_logitem_message = global_logitem_message + convert_integer_to_text( global_list_satisfaction_count_for_participant[ global_participant_number ] ) + " ]" ;
        write_logitem_message( ) ;
    }
    global_logitem_message = "[***** normalized satisfaction counts end *****]" ;
    write_logitem_message( ) ;
    global_logitem_message = "[*****]" ;
    write_logitem_message( ) ;


// -----------------------------------------------
//  End of function calculate_satisfaction_counts.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      comparison_for_sort
//
//  This function compares two integers.  It is needed for
//  the qsort function.

int comparison_for_sort(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);

//  End of function comparison_for_sort.
}


// -----------------------------------------------
// -----------------------------------------------
//      sort_satisfaction_counts
//
//  Create a sorted list of the latest satisfaction
//  counts.
//
//  The qsort function requires a list that starts at
//  index zero.

void sort_satisfaction_counts( )
{

    global_length_of_list_of_integers_to_sort = 0 ;
    for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
    {
        global_list_of_integers_to_sort[ global_length_of_list_of_integers_to_sort ] = global_list_satisfaction_count_for_participant[ global_participant_number ] ;
        global_length_of_list_of_integers_to_sort ++ ;
    }
    qsort( global_list_of_integers_to_sort , global_length_of_list_of_integers_to_sort , sizeof(int) , comparison_for_sort ) ;
    for ( global_pointer_to_list = 0 ; global_pointer_to_list <= global_number_of_participants - 1 ; global_pointer_to_list ++ )
    {
        global_sorted_list_of_satisfaction_counts[ global_pointer_to_list + 1 ] = global_list_of_integers_to_sort[ global_pointer_to_list ] ;
    }


// -----------------------------------------------
//  Identify the count values that are largest and
//  smallest among the opposition coalition, and largest
//  and smallest among the dominant coalition.

        global_bottom_satisfaction_count_among_opposition_coalition = global_sorted_list_of_satisfaction_counts[ 1 ] ;
        global_top_satisfaction_count_among_opposition_coalition = global_sorted_list_of_satisfaction_counts[ global_opposition_coalition_size ] ;
        global_bottom_satisfaction_count_among_dominant_coalition = global_sorted_list_of_satisfaction_counts[ global_number_of_participants - global_dominant_coalition_size + 1 ] ;
        global_top_satisfaction_count_among_dominant_coalition = global_sorted_list_of_satisfaction_counts[ global_number_of_participants ] ;
//        global_logitem_message = "[key satisfaction values are: " + convert_integer_to_text( global_bottom_satisfaction_count_among_opposition_coalition ) + "  " + convert_integer_to_text( global_top_satisfaction_count_among_opposition_coalition ) + "  " + convert_integer_to_text( global_bottom_satisfaction_count_among_dominant_coalition ) + "  " + convert_integer_to_text( global_top_satisfaction_count_among_dominant_coalition ) + " ]" ;
//        write_logitem_message( ) ;


// -----------------------------------------------
//  End of function sort_satisfaction_counts.

    return ;
}


// -----------------------------------------------
// -----------------------------------------------
//      accept_one_proposal
//
//  Accepts one proposal, the one specified
//  in "global_alias_proposal_accepted". 

void accept_one_proposal( )
{


// -----------------------------------------------
//  Translate the alias proposal number into the actual proposal number.

    global_actual_proposal_accepted = global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_accepted ] ;
    global_logitem_message = "[accepting proposal " + convert_integer_to_text( global_actual_proposal_accepted ) + " ]" ;
    write_logitem_message( ) ;


// -----------------------------------------------
//  Add the accepted proposal to the list of accepted
//  proposals, which tracks alias proposal numbers.
//  Actual proposal numbers are written to the output
//  JSON file.

    global_length_of_list_of_proposals_accepted ++ ;
    global_list_of_proposals_accepted[ global_length_of_list_of_proposals_accepted ] = global_alias_proposal_accepted ;
    global_json_key = "accepted_proposal_" + convert_integer_to_text( global_length_of_list_of_proposals_accepted ) ;
    global_json_value = convert_integer_to_text( global_actual_proposal_accepted ) ;
    write_json_key_value_pair( ) ;


// -----------------------------------------------
//  Remove this accepted proposal from the list of
//  proposals to be considered when additional popularity
//  calculations are done.

    global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_accepted ] = global_no ;


// -----------------------------------------------
//  Eliminate any proposals that are incompatible with the
//  just-accepted proposal.

    global_alias_just_identified_proposal_number = global_alias_proposal_accepted ;
    identify_incompatible_proposals( ) ;
    global_logitem_message = "[proposals rejected as incompatible:" ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_just_incompatible ; global_list_pointer ++ )
    {
        global_alias_proposal_incompatible = global_list_of_proposals_just_incompatible[ global_list_pointer ] ;
        global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_incompatible ] = global_no ;
        global_length_of_list_of_proposals_rejected_as_incompatible ++ ;
        global_list_of_proposals_rejected_as_incompatible[ global_length_of_list_of_proposals_rejected_as_incompatible ] = global_alias_proposal_incompatible ;
        global_logitem_message = global_logitem_message + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_incompatible ] ) ;
    }
    global_logitem_message = global_logitem_message + " ]" ;
    if ( global_length_of_list_of_proposals_just_incompatible > 0 )
    {
        write_logitem_message( ) ;
    }


// -----------------------------------------------
//  End of function accept_one_proposal.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      calculate_weighted_most_popular_proposal
//
//  Calculate the most popular proposal among the
//  remaining proposals available for acceptance, based
//  on the current weight/influence amounts for the
//  participants.  Exit with a fatal error if a winner is
//  not found because the number of remaining proposals
//  should have been checked to be at least one
//  proposal.
//
//  The ballot weight is an integer that can be divided
//  into amounts that are still integers.  This is
//  analogous to using the numbers 0 to 100 for "percent"
//  units.  The suggested number is 2000 units for one
//  full weight for one ballot.  At some later steps
//  during the calculations some ballots will have
//  reduced weight after they contribute to accepting a
//  proposal.

void calculate_weighted_most_popular_proposal( )
{


// -----------------------------------------------
//  Specify the popularity calculation is based on the
//  proposals still available for acceptance.

        global_logitem_message = "[proposals considered:" ;
        for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
        {
            global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] ;
            global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] ;
            if ( global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] == global_yes )
            {
                global_logitem_message = global_logitem_message + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) ;
            }
        }
        global_logitem_message = global_logitem_message + " ]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Log the count of remaining proposals.

        count_remaining_proposals( ) ;
        global_logitem_message = "[finding winner among " + convert_integer_to_text( global_count_of_elimination_continuing_proposals ) + " proposals]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Do the calculations for instant pairwise elimination.

        method_instant_pairwise_elimination( ) ;


//-----------------------------------------------
//  If a winning proposal was not found, indicate a fatal
//  error.  This check is useful during debugging code
//  edits.

        if ( global_alias_proposal_winner_of_elimination_rounds == 0 )
        {
            global_json_key = "error" ;
            global_json_value = "winning proposal was not found." ;
            write_json_key_value_pair( ) ;
            exit( EXIT_FAILURE ) ;
        }


// -----------------------------------------------
//  End of function calculate_weighted_most_popular_proposal.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      log_crude_plot
//
//  Write into log lines a crude plot of satisfaction
//  counts.  Include a dotted line that separates the
//  opposition coalition from the dominant coalition, and
//  another dotted line that separates the top
//  participants of the same participant size.

void log_crude_plot( )
{


// -----------------------------------------------
//  Write the opening line.

        global_logitem_message = "[*****]" ;
        write_logitem_message( ) ;
        global_logitem_message = "[***** satisfaction counts sorted begin *****]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Write the lines above the first dotted line.

        for ( global_list_pointer = 1 ; global_list_pointer <= global_opposition_coalition_size ; global_list_pointer ++ )
        {
            global_logitem_message = "[" ;
            for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
            {
                global_logitem_message = global_logitem_message + " " ;
            }
            global_logitem_message = global_logitem_message + convert_integer_to_text( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) + " ]" ;
            write_logitem_message( ) ;
        }


// -----------------------------------------------
//  Write the first dotted line.

        global_logitem_message = "[" ;
        for ( global_column_pointer = 1 ; global_column_pointer <= 50 ; global_column_pointer ++ )
        {
            global_logitem_message = global_logitem_message + "." ;
        }
        global_logitem_message = global_logitem_message + " ]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Write the lines between the two dotted lines.

        if ( ( global_opposition_coalition_size + 1 ) < ( global_number_of_participants - global_opposition_coalition_size ) )
        {
            for ( global_list_pointer = ( global_opposition_coalition_size + 1 ) ; global_list_pointer <= ( global_number_of_participants - global_opposition_coalition_size ) ; global_list_pointer ++ )
            {
                global_logitem_message = "[" ;
                for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
                {
                    global_logitem_message = global_logitem_message + " " ;
                }
                global_logitem_message = global_logitem_message + convert_integer_to_text( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) + " ]" ;
                write_logitem_message( ) ;
            }
        }


// -----------------------------------------------
//  Write the second dotted line.

        global_logitem_message = "[" ;
        for ( global_column_pointer = 1 ; global_column_pointer <= 50 ; global_column_pointer ++ )
        {
            global_logitem_message = global_logitem_message + "." ;
        }
        global_logitem_message = global_logitem_message + " ]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Write the lines below the second dotted line.

        for ( global_list_pointer = ( global_number_of_participants - global_opposition_coalition_size + 1 ) ; global_list_pointer <= global_number_of_participants ; global_list_pointer ++ )
        {
            global_logitem_message = "[" ;
            for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
            {
                global_logitem_message = global_logitem_message + " " ;
            }
            global_logitem_message = global_logitem_message + convert_integer_to_text( global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ) + " ]" ;
            write_logitem_message( ) ;
        }


// -----------------------------------------------
//  Write the closing line.

        global_logitem_message = "[***** satisfaction counts sorted end *****]" ;
        write_logitem_message( ) ;
        global_logitem_message = "[*****]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  End of function log_crude_plot.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      calculate_most_popular_proposal_focus_on_incompatible_proposals
//
//  Calculate the most popular proposal, then if that
//  proposal is incompatible with any other proposal,
//  calculate the most popular proposal among the
//  incompatible proposals.
//
//  The two results can be different because the presence
//  and absence of additional proposals can affect the
//  pairwise opposition counts and the pairwise support
//  counts.
//
//  This extra calculation helps defeat attempts to "bury"
//  a proposal under unpopular proposals because this
//  reduction increases the likelihood that different
//  participants are using the same "unpopular" proposal
//  for burial purposes, which makes it likely
//  the "unpopular" proposal can become the most popular
//  proposal.


void calculate_most_popular_proposal_focus_on_incompatible_proposals( )
{


// -----------------------------------------------
//  Calculate the most popular proposal based on the
//  current ballot weights.

    calculate_weighted_most_popular_proposal( ) ;
    global_alias_just_identified_proposal_number = global_alias_proposal_winner_of_elimination_rounds ;


//-----------------------------------------------
//  Identify which proposals are incompatitible with the
//  just-identified most-popular proposal.

    identify_incompatible_proposals( ) ;


// -----------------------------------------------
//  If there are no incompatible proposals, return with
//  the most popular proposal identified.

    if ( global_length_of_list_of_proposals_just_incompatible == 0 )
    {
        global_alias_proposal_winner_of_elimination_rounds = global_alias_just_identified_proposal_number ;
        return ;
    }


//-----------------------------------------------
//  Reduce the list of proposals being considered to the
//  just-identified proposal and the proposals that are
//  incompatitible with that proposal.

    for ( global_pointer_to_list = 1 ; global_pointer_to_list <= global_length_of_list_of_proposals_just_incompatible ; global_pointer_to_list ++ )
    {
        global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_just_identified_proposal_number ] = global_no ;
    }
    global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_just_identified_proposal_number ] = global_yes ;
    global_list_yes_or_no_elimination_continuing_for_proposal[ global_alias_just_identified_proposal_number ] = global_yes ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_just_incompatible ; global_list_pointer ++ )
    {
        global_list_yes_or_no_popularity_continuing_for_proposal[ global_list_of_proposals_just_incompatible[ global_list_pointer ] ] = global_yes ;
        global_list_yes_or_no_elimination_continuing_for_proposal[ global_list_of_proposals_just_incompatible[ global_list_pointer ] ] = global_yes ;
    }


// -----------------------------------------------
//  Identify the most popular proposal among these
//  incompatible proposals.

    count_remaining_proposals( ) ;
    global_logitem_message = "[finding winner based on " + convert_integer_to_text( global_count_of_elimination_continuing_proposals ) + " proposals]" ;
    write_logitem_message( ) ;
    method_instant_pairwise_elimination( ) ;


// -----------------------------------------------
//  End of function calculate_most_popular_proposal_focus_on_incompatible_proposals.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//      do_negotiation_tool_calculations
//
//  Does the VoteFair negotiation ranking calculations
//  that identify which proposals are suggested as an
//  optimal combination of widely appreciated proposals.

void do_negotiation_tool_calculations( )
{

    global_logitem_message = "[beginning negotiation ranking calculations]" ;
    write_logitem_message( ) ;


//-----------------------------------------------
//  If there are not at least two proposals, exit with an
//  error.

    if ( global_number_of_proposals < 2 )
    {
        global_json_key = "error" ;
        global_json_value = "The proposal count is zero or one, so there is nothing to calculate." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


//-----------------------------------------------
//  If there are not at least two participants, exit with
//  an error.

    if ( global_number_of_participants < 2 )
    {
        global_json_key = "error" ;
        global_json_value = "The participant count is zero or one, so there is nothing to calculate." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


//-----------------------------------------------
//  Initialize the result lists.

    global_length_of_list_of_proposals_accepted = 0 ;
    global_length_of_list_of_proposals_contributing_to_satisfaction_counts = 0 ;
    global_length_of_list_of_proposals_rejected_as_incompatible = 0 ;
    global_length_of_list_of_proposals_not_popular = 0 ;
    global_length_of_list_of_proposals_ranked_negative = 0 ;
    global_length_of_list_of_proposals_ranked_neutral = 0 ;
    global_length_of_list_of_proposals_ranked_positive = 0 ;
    global_length_of_list_of_proposals_rejected_as_incompatible = 0 ;
    global_length_of_list_of_proposals_widely_disliked = 0 ;


// -----------------------------------------------
//  Count how many participants approve and disapprove
//  each proposal.  A positive ranking indicates
//  approval.  A negative ranking indicates disapproval.
//  These counts become available to resolve an exact
//  tie.  These counts can be useful for summarizing
//  participant preferences.  Also they can be used to
//  resolve deep ties.  Log these counts.

    count_approvals_and_disapprovals( ) ;
    global_logitem_message = "[approval counts:" ;
    global_logitem_text_store_longer = "[disapproval counts:" ;
    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_logitem_message = global_logitem_message + " " + convert_integer_to_text( global_list_approval_count_for_proposal[ global_alias_proposal_number ] ) ;
        global_logitem_text_store_longer = global_logitem_text_store_longer + " " + convert_integer_to_text( global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] ) ;
    }
    global_logitem_message = global_logitem_message + " ]" ;
//    write_logitem_message( ) ;
    global_logitem_message = global_logitem_text_store_longer + " ]" ;
//    write_logitem_message( ) ;


// -----------------------------------------------
//  If none of the proposals have at least one approval or
//  at least one disapproval, exit with an error.

    global_number_of_proposals_with_some_approval = 0 ;
    global_number_of_proposals_with_some_disapproval = 0 ;
    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        if ( global_list_approval_count_for_proposal[ global_alias_proposal_number ] > 0 )
        {
            global_number_of_proposals_with_some_approval ++ ;
        }
        if ( global_list_disapproval_count_for_proposal[ global_alias_proposal_number ] > 0 )
        {
            global_number_of_proposals_with_some_disapproval ++ ;
        }
    }
    if ( ( global_number_of_proposals_with_some_approval == 0 ) || ( global_number_of_proposals_with_some_disapproval == 0 ) )
    {
        global_json_key = "error" ;
        global_json_value = "None of the proposals have any approvals or disapprovals." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


// -----------------------------------------------
//  Specify that all proposals are currently being
//  considered for possible acceptance.

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] = global_yes ;
    }


// -----------------------------------------------
//  If there are any proposals that are disliked by a
//  large enough percentage of participants, reject them
//  as not worthy of getting accepted.

    for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
    {
        global_dislikes_encountered = 0 ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_alias_proposal_number ] < 0 )
            {
                global_dislikes_encountered ++ ;
            }
        }
        if ( global_dislikes_encountered > global_minimum_dislikes_required_to_reject )
        {
            global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] = global_no ;
            global_length_of_list_of_proposals_widely_disliked ++ ;
            global_list_of_proposals_widely_disliked[ global_length_of_list_of_proposals_widely_disliked ] = global_alias_proposal_number ;
            global_json_key = "disliked_proposal_" + convert_integer_to_text( global_length_of_list_of_proposals_widely_disliked ) ;
            global_json_value = convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) ;
            write_json_key_value_pair( ) ;
        }
    }


// -----------------------------------------------
//  Log the incompatibility info, which identifies which
//  proposals are incompatible with which other
//  proposals.

    for ( global_pointer_to_list = 1 ; global_pointer_to_list <= global_length_of_list_of_incompatible_pairs ; global_pointer_to_list ++ )
    {
        global_actual_proposal_trigger = global_list_of_trigger_proposal_number_for_pair[ global_pointer_to_list ] ;
        global_actual_proposal_incompatible = global_list_of_incompatible_proposal_number_for_pair[ global_pointer_to_list ] ;
//        global_logitem_message = "[if proposal " + convert_integer_to_text( global_actual_proposal_trigger ) + " is accepted then incompatible proposal " + convert_integer_to_text( global_actual_proposal_incompatible ) + " cannot be accepted]" ;
//        write_logitem_message( ) ;
    }


//-----------------------------------------------
//  Specify the maximum coalition count.  This number
//  indicates the maximum number of possible coalitions.
//  Acoalition is a group of participants who share
//  similar preferences.  It is not a named coalition
//  because the participants do not need to identify
//  other participants in the same coalition.  Instead,
//  participant preferences determine which participants
//  are similar.  This number cannot exceed the number of
//  participants.  It cannot be one because that would
//  not allow an opposition coalition to exist.

    global_maximum_coalition_count = global_number_of_participants ;
    if ( global_maximum_coalition_count > 7 )
    {
        global_maximum_coalition_count = 7 ;
    }


//-----------------------------------------------
//  Initialize the coalition count.

    global_coalition_count = 0 ;


//-----------------------------------------------
//  Begin the main loop that identifies each proposal to
//  be accepted.

    global_endless_loop_counter = 0 ;
    for ( global_endless_loop_counter = 1 ; global_endless_loop_counter <= ( global_number_of_proposals * global_number_of_proposals ) ; global_endless_loop_counter ++ )
    {


//-----------------------------------------------
//  Specify which proposals remain to be considered.

        global_number_of_proposals_remaining_for_possible_acceptance = 0 ;
        for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
        {
            global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] ;
            if ( global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] == global_yes )
            {
                global_number_of_proposals_remaining_for_possible_acceptance ++ ;
            }
        }
        global_logitem_message = "[remaining " + convert_integer_to_text( global_number_of_proposals_remaining_for_possible_acceptance ) + "   accepted " + convert_integer_to_text( global_length_of_list_of_proposals_accepted ) + "   incompatible " + convert_integer_to_text( global_length_of_list_of_proposals_rejected_as_incompatible ) + " ]" ;
        write_logitem_message( ) ;


//-----------------------------------------------
//  If the number of proposals that remain to be
//  considered is zero, the loop is done, so exit the
//  loop.

        if ( global_number_of_proposals_remaining_for_possible_acceptance < 1 )
        {
            global_logitem_message = "[number of proposals remaining is zero, so calculations are done.]" ;
            write_logitem_message( ) ;
            break ;
        }


//-----------------------------------------------
//  If the number of accepted proposals has reach the
//  specified limit for how many proposals can be
//  accepted, specify the remaining proposals are not
//  popular.  This limit is needed when electing a group
//  of candidates to a specific number of non-unique
//  openings.
//
//  If this number is one, the negotiation ranking
//  calculations just amounts to identifying a single
//  most-popular proposal.

        if ( global_length_of_list_of_proposals_accepted == global_limit_maximum_proposals_accepted )
        {
            global_logitem_message = "[reached limit of " + convert_integer_to_text( global_limit_maximum_proposals_accepted ) + " proposals accepted]" ;
            write_logitem_message( ) ;
            for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
            {
                global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] = global_no ;
                global_length_of_list_of_proposals_not_popular ++ ;
                global_list_of_proposals_not_popular[ global_length_of_list_of_proposals_not_popular ] = global_alias_proposal_number ;
                global_logitem_message = "[proposal " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_alias_proposal_number ] ) + " not popular enough]" ;
                write_logitem_message( ) ;
            }
            continue ;
        }


//-----------------------------------------------
//  Specify the current coalition count for this cycle
//  through the main loop.  When this count equals 1, all
//  the participants have equal influence, without
//  considering any possible coalitions (within the full
//  range of participants).  When this count reaches the
//  maximum (which typically is about 7), restart at 1.
//  If it is larger than 2 and exceeds the number of
//  accepted proposals, restart at 1.

        global_coalition_count ++ ;
        if ( global_coalition_count > global_maximum_coalition_count )
        {
            global_coalition_count = 1 ;
        }
        if ( ( global_coalition_count > 2 ) && ( global_coalition_count >= global_length_of_list_of_proposals_accepted ) )
        {
            global_coalition_count = 1 ;
            global_logitem_message = "[coalition count limited to number of proposals accepted so far, which is " + convert_integer_to_text( global_length_of_list_of_proposals_accepted ) + " ]" ;
            write_logitem_message( ) ;
        }
        global_logitem_message = "[********** coalition count " + convert_integer_to_text( global_coalition_count ) + " **********]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  If the coalition count equals 1, then specify that all
//  the ballots have the same ballot weight
//  (influence amount), and identify which proposal is
//  most popular, then reduce the possible proposals to
//  just the ones that are incompatible with that
//  proposal, and again identify which proposal is most
//  popular, accept this proposal, and repeat the main
//  loop.

        if ( global_coalition_count == 1 )
        {
            for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
            {
                global_list_remaining_ballot_weight_for_participant[ global_participant_number ] = global_full_ballot_weight ;
            }
            for ( global_alias_proposal_number = 1 ; global_alias_proposal_number <= global_number_of_proposals ; global_alias_proposal_number ++ )
            {
                global_list_yes_or_no_popularity_continuing_for_proposal[ global_alias_proposal_number ] = global_list_yes_or_no_acceptance_possible_for_proposal[ global_alias_proposal_number ] ;
            }
            calculate_most_popular_proposal_focus_on_incompatible_proposals( ) ;
            global_alias_proposal_accepted = global_alias_proposal_winner_of_elimination_rounds ;
            accept_one_proposal( ) ;
//  Repeat the main loop:
            continue ;
        }


// -----------------------------------------------
//  For the remainder of this main loop, the coalition
//  count is larger than 1.  It specifies the number of
//  equal-size coaltions that could fit within the full
//  group of participants.
//
//  For example, if the coaltion count is 3, the size of
//  the coalition is one-third of the participants
//  (with rounding to the nearest smaller integer).
//
//  Calculate how many participants would be in the
//  opposition coalition based on the coalition count.
//
//  Also calculate how many participants are in the
//  dominant coalition, which is the majority coalition
//  the opposition coalition opposes.  It is not always
//  equal to the number of participants minus the
//  opposition coalition size.  For example, if there
//  are an odd number of participants, and they are
//  equally divided into two groups (opposition and
//  dominant) there is one participant who is not in
//  either group because the group sizes must be equal.
//  This concept is related to the idea that a "median"
//  calculation can have one number that is exactly the
//  median value and therefore is neither above nor below
//  the median.

        global_opposition_coalition_size = int( float( global_number_of_participants ) / float ( global_coalition_count ) ) ;
//        global_logitem_message = "[opposition coalition size is " + convert_integer_to_text( global_opposition_coalition_size ) + " ]" ;
//        write_logitem_message( ) ;
        global_dominant_coalition_size = global_opposition_coalition_size * ( global_coalition_count - 1 ) ;
//        global_logitem_message = "[dominant coalition size is " + convert_integer_to_text( global_dominant_coalition_size ) + " ]" ;
//        write_logitem_message( ) ;


// -----------------------------------------------
//  Based on the proposals already accepted, calculate a
//  satisfaction count for each participant.

        calculate_satisfaction_counts( ) ;


// -----------------------------------------------
//  Sort the satisfaction counts.

        sort_satisfaction_counts( ) ;


// -----------------------------------------------
//  Log a crude graphical display of the sorted counts.

        global_graph_scale_divisor = float( global_full_ballot_weight ) / 30.0 ;
        log_crude_plot( ) ;


//-----------------------------------------------
//  If the largest and smallest satisfaction counts are
//  the same, repeat the main loop because there is no
//  coalition at this coalition count.

        if ( global_smallest_satisfaction_count == global_largest_satisfaction_count )
        {
            global_logitem_message = "[smallest and largest satisfaction counts are equal, so no coalition of this size]" ;
            write_logitem_message( ) ;
            continue ;
        }


//-----------------------------------------------
//  Invert the just-calculated satisfaction counts and use
//  those inverted values to give more influence to
//  participants who have had less influence in earlier
//  popularity calculations.

        global_satisfaction_count_range = global_largest_satisfaction_count - global_smallest_satisfaction_count ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            global_list_remaining_ballot_weight_for_participant[ global_participant_number ] = global_full_ballot_weight - global_list_satisfaction_count_for_participant[ global_participant_number ] ;
        }


//-----------------------------------------------
//  Log the ballot weights as a crude plot.

        global_logitem_message = "[*****]" ;
        write_logitem_message( ) ;
        global_logitem_message = "[***** ballot weights begin *****]" ;
        write_logitem_message( ) ;
        global_graph_scale_divisor = float( global_full_ballot_weight ) / 30.0 ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            global_logitem_message = "[par_" + convert_integer_to_text( global_participant_number ) + "  " ;
            for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_list_remaining_ballot_weight_for_participant[ global_participant_number ] ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
            {
                global_logitem_message = global_logitem_message + " " ;
            }
            global_logitem_message = global_logitem_message + convert_integer_to_text( global_list_remaining_ballot_weight_for_participant[ global_participant_number ] ) + " ]" ;
            write_logitem_message( ) ;
        }
        global_logitem_message = "[***** ballot weights end *****]" ;
        write_logitem_message( ) ;
        global_logitem_message = "[*****]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  Identify which proposal is most popular based on
//  current ballot-weight (influence) amounts.  Then do
//  it again focused on that proposal and the proposals
//  that are incompatible with this most-popular
//  proposal.

        calculate_most_popular_proposal_focus_on_incompatible_proposals( ) ;


// -----------------------------------------------
//  Calculate the disparity gap, which is the difference
//  between the average satisfaction counts for the
//  opposition coalition and the average satisfaction
//  counts for the same number of participants who are at
//  the top of the sorted satisfaction counts.

        global_sum_satisfaction_counts_for_opposition_coalition = 0 ;
        for ( global_list_pointer = 1 ; global_list_pointer <= global_opposition_coalition_size ; global_list_pointer ++ )
        {
            global_sum_satisfaction_counts_for_opposition_coalition += global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ;
        }
        global_sum_satisfaction_counts_for_core_dominant_coalition = 0 ;
        for ( global_list_pointer = ( global_number_of_participants - global_opposition_coalition_size + 1 ) ; global_list_pointer <= global_number_of_participants ; global_list_pointer ++ )
        {
            global_sum_satisfaction_counts_for_core_dominant_coalition += global_sorted_list_of_satisfaction_counts[ global_list_pointer ] ;
        }
        global_disparity_gap = int( ( float( global_sum_satisfaction_counts_for_core_dominant_coalition ) / float( global_opposition_coalition_size ) ) - ( float( global_sum_satisfaction_counts_for_opposition_coalition ) / float( global_opposition_coalition_size ) ) + 0.5 ) ;
        global_logitem_message = "[satisfaction disparity gap is " + convert_integer_to_text( global_disparity_gap ) + " ]" ;
        write_logitem_message( ) ;


// -----------------------------------------------
//  If the disparity gap is less than the specified
//  threshold, repeat the main loop without accepting
//  this most-popular proposal.
//
//  If there are just two participants, a smaller
//  disparity gap might be acceptable.

        if ( global_disparity_gap <= global_disparity_gap_threshold_for_acceptance )
        {
            global_logitem_message = "[disparity gap not big enough to accept this proposal]" ;
            write_logitem_message( ) ;
            continue ;
        }


//-----------------------------------------------
//  Accept the identified proposal.

        global_alias_proposal_accepted = global_alias_proposal_winner_of_elimination_rounds ;
        accept_one_proposal( ) ;


//-----------------------------------------------
//  Repeat the loop that identifies the next proposal to
//  be accepted.

//        global_logitem_message = "[endless loop counter = " + convert_integer_to_text( global_endless_loop_counter ) + " ]" ;
//        write_logitem_message( ) ;
    }


//-----------------------------------------------
//  Calculate a pairwise support-minus-opposition count
//  for each PROPOSAL, and log these counts as a crude
//  plot.  (Elsewhere in this code each count is for a
//  participant, not for a proposal).

    global_logitem_message = "********* todo ************ code here probably needs editing]" ;
    write_logitem_message( ) ;

    global_logitem_message = "[satisfaction counts for accepted proposals:]" ;
    write_logitem_message( ) ;
    global_graph_scale_divisor = float( global_full_ballot_weight ) / 30.0 ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_accepted ; global_list_pointer ++ )
    {
        global_first_proposal_number = global_list_of_proposals_accepted[ global_list_pointer ] ;
        global_actual_proposal_number = global_list_actual_proposal_for_alias_proposal[ global_first_proposal_number ] ;
        global_pairwise_count_for_proposal = 0 ;
        for ( global_participant_number = 1 ; global_participant_number <= global_number_of_participants ; global_participant_number ++ )
        {
            for ( global_second_proposal_number = 1 ; global_second_proposal_number <= global_number_of_proposals ; global_second_proposal_number ++ )
            {
                if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_first_proposal_number ] > global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_second_proposal_number ] )
                {
                    global_pairwise_count_for_proposal ++ ;
                } else if ( global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_first_proposal_number ] < global_array_ranking_for_participant_and_proposal[ global_participant_number ][ global_second_proposal_number ] )
                {
                    global_pairwise_count_for_proposal -- ;
                }
            }
        }
        global_logitem_message = "[pro" + convert_integer_to_text( global_actual_proposal_number ) + " " ;
        global_graph_scale_divisor = float( global_full_ballot_weight ) / 30.0 ;
        for ( global_column_pointer = 1 ; global_column_pointer <= int( float( global_pairwise_count_for_proposal ) / global_graph_scale_divisor ) ; global_column_pointer ++ )
        {
            global_logitem_message = global_logitem_message + " " ;
        }
        global_logitem_message = global_logitem_message + convert_integer_to_text( global_pairwise_count_for_proposal ) + " ]" ;
        write_logitem_message( ) ;
    }


//-----------------------------------------------
//  Calculate and log the pairwise counts based on all the
//  accepted proposals.

    global_logitem_message = "[satisfaction count per participant based on accepted proposals:]" ;
    write_logitem_message( ) ;
    calculate_satisfaction_counts( ) ;


//-----------------------------------------------
//  Write the list of accepted proposals.

    global_json_key = "number_of_accepted_proposals" ;
    global_json_value = convert_integer_to_text( global_length_of_list_of_proposals_accepted ) ;
    write_json_key_value_pair( ) ;
    global_result_text = "" ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_accepted ; global_list_pointer ++ )
    {
        global_result_text = global_result_text + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_list_of_proposals_accepted[ global_list_pointer ] ] ) ;
    }
    global_json_key = "list_of_accepted_proposals" ;
    global_json_value = global_result_text ;
    write_json_key_value_pair( ) ;


//-----------------------------------------------
//  Write the list of incompatible proposals.

    global_result_text = "" ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_rejected_as_incompatible ; global_list_pointer ++ )
    {
        global_result_text = global_result_text + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_list_of_proposals_rejected_as_incompatible[ global_list_pointer ] ] ) ;
    }
    global_json_key = "list_of_incompatible_proposals" ;
    global_json_value = global_result_text ;
    write_json_key_value_pair( ) ;


//-----------------------------------------------
//  Write the list of proposals that are not rejected
//  because too many participants dislike them.  A rating
//  of zero or negative indicates a dislike.

    global_result_text = "" ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_widely_disliked ; global_list_pointer ++ )
    {
        global_result_text = global_result_text + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_list_of_proposals_widely_disliked[ global_list_pointer ] ] ) ;
    }
    global_json_key = "list_of_proposals_widely_disliked" ;
    global_json_value = global_result_text ;
    write_json_key_value_pair( ) ;


//-----------------------------------------------
//  Write the list of proposals that are not popular
//  enough to qualify for the limited number of accepted
//  proposals.

    global_result_text = "" ;
    for ( global_list_pointer = 1 ; global_list_pointer <= global_length_of_list_of_proposals_not_popular ; global_list_pointer ++ )
    {
        global_result_text = global_result_text + " " + convert_integer_to_text( global_list_actual_proposal_for_alias_proposal[ global_list_of_proposals_not_popular[ global_list_pointer ] ] ) ;
    }
    global_json_key = "list_of_proposals_not_popular" ;
    global_json_value = global_result_text ;
    write_json_key_value_pair( ) ;


// -----------------------------------------------
//  End of function do_negotiation_tool_calculations.

    return ;

}


// -----------------------------------------------
// -----------------------------------------------
//  Execution starts here.
//  Do initialization, then do the processing.

int main() {


// -----------------------------------------------
//  Initialize logging.

    std::cout << "{" << std::endl ;
    global_log_item_number = 0 ;
    global_yes_or_no_hide_logging_in_json = global_no ;


// -----------------------------------------------
//  Initialize special (constant) text strings.

    global_double_quotation_mark = "\"" ;
    global_comma = "," ;
    global_colon = ":" ;


// -----------------------------------------------
//  Initialize zero values.

    global_number_of_proposals = 0 ;
    global_input_line_number = 0 ;
    global_pointer_to_input_data_number = 0 ;


// -----------------------------------------------
//  Initialize non-zero default values.

    global_percent_threshold_dislike_rejection = 80 ;
    global_limit_maximum_proposals_accepted = 0 ;
    global_disparity_gap_threshold_for_acceptance = int( float( global_full_ballot_weight ) / 40.0 ) ;


// -----------------------------------------------
//  Read input data from standard input (which
//  typically is a file).

    read_data( ) ;


//-----------------------------------------------
//  If there are not at least two participants, return
//  with an error message.

    if ( global_number_of_participants < 2 )
    {
        global_json_key = "error" ;
        global_json_value = "There are not at least two participants." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


//-----------------------------------------------
//  If there is not at least two proposals, return with
//  an error message.

    if ( global_number_of_proposals < 2 )
    {
        global_json_key = "error" ;
        global_json_value = "There are not at least two proposals." ;
        write_json_key_value_pair( ) ;
        exit( EXIT_FAILURE ) ;
    }


//-----------------------------------------------
//  If the limit on the number of proposals that can be
//  accepted is less than zero, set this limit to allow
//  as many proposals as the number of proposals.

    if ( global_limit_maximum_proposals_accepted < 1 )
    {
        global_limit_maximum_proposals_accepted = global_number_of_proposals ;
    }
    global_json_key = "limit_number_of_proposals_to_accept" ;
    global_json_value = convert_integer_to_text( global_limit_maximum_proposals_accepted ) ;
    write_json_key_value_pair( ) ;


//-----------------------------------------------
//  If the threshold for acceptance based on satisfaction
//  count is too small, increase it. accepted is less
//  than zero, set this limit to allow as many proposals
//  as the number of proposals.

    if ( global_disparity_gap_threshold_for_acceptance  < 5 )
    {
        global_disparity_gap_threshold_for_acceptance = 10 ;
    }
    global_json_key = "satisfaction_count_threshold_needed_for_acceptance" ;
    global_json_value = convert_integer_to_text( global_disparity_gap_threshold_for_acceptance ) ;
    write_json_key_value_pair( ) ;


// -----------------------------------------------
//  Calculate how many participants must dislike a
//  proposal to reject the proposal as not worthy of
//  getting accepted.  This number is based on the
//  percentage threshold for rejection.

    global_minimum_dislikes_required_to_reject = int( float( global_number_of_participants * global_percent_threshold_dislike_rejection ) / 100.0 );
    global_json_key = "percent_threshold_dislike_rejection" ;
    global_json_value = convert_integer_to_text( global_percent_threshold_dislike_rejection ) ;
    write_json_key_value_pair( ) ;
    global_json_key = "global_minimum_dislikes_required_to_reject" ;
    global_json_value = convert_integer_to_text( global_minimum_dislikes_required_to_reject ) ;
    write_json_key_value_pair( ) ;


// -----------------------------------------------
//  Do the VoteFair negotiation tool calculations.

    do_negotiation_tool_calculations( ) ;


// -----------------------------------------------
//  Prevent a compiler warning message about unused variable.

    global_unused_string_length = 0 ;
    int unused_variable ;
    unused_variable = global_unused_string_length ;
    global_unused_string_length = unused_variable ;


// -----------------------------------------------
//  End of "main" code.

    global_json_key = "error_status" ;
    global_json_value = "no errors found" ;
    write_json_key_value_pair( ) ;
    std::cout << global_double_quotation_mark << "end of json" << global_double_quotation_mark << global_colon << global_double_quotation_mark << "no trailing comma" << global_double_quotation_mark << std::endl ;
    std::cout << "}" << std::endl ;
}


// -----------------------------------------------
// -----------------------------------------------
//
//  End of all code.
//
// -----------------------------------------------


// -----------------------------------------------
//
//  AUTHOR
//
//  Richard Fobes, www.VoteFair.org
//
//
// -----------------------------------------------
//
//  BUGS
//
//  Please report any bugs or feature requests on
//  GitHub, at the CPSolver account, in the
//  VoteFair-ranking-cpp project area.  Thank you!
//
//
// -----------------------------------------------
//
//  SUPPORT
//
//  You can find documentation for this code on
//  GitHub, in the CPSolver account, in the
//  VoteFair-ranking-cpp project area.
//
//
// -----------------------------------------------
//
//  ACKNOWLEDGEMENTS
//
//  Richard Fobes designed the VoteFair
//  Negotiation Ranking method.  Richard Fobes is
//  the author of the books titled
//  "The Creative Problem Solver's Toolbox" and
//  "Ending The Hidden Unfairness In U.S. Elections."
//
//
// -----------------------------------------------
//
//  COPYRIGHT & LICENSE
//
//  (c) Copyright 2025 by Richard Fobes at
//  www.VoteFair.org.  You can redistribute and/or
//  modify this negotiation_tool software under the MIT
//  software license terms as written above.
//
//  Conversion of this code into another
//  programming language is also covered by the
//  above license terms.
//
//  The mathematical algorithm of VoteFair
//  Negotiation Ranking is in the public domain.
//
//
// -----------------------------------------------
//
//  End of negotiation_tool.cpp
