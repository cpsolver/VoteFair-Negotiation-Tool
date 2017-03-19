#-----------------------------------------------
#-----------------------------------------------
#         form_mark_unmark_selection_buttons
#-----------------------------------------------
#-----------------------------------------------
#  Mark the selection ("radio") buttons that
#  correspond to each selection's current value,
#  or (if there is no valid current value) the
#  default value.


sub form_mark_unmark_selection_buttons
{


#-----------------------------------------------
#  Begin a loop that handles each set of selection
#  (radio) buttons.

    $delimited_list_of_selection_names = &dashrep_get_replacement( "list-of-selection-names-for-action-" . $global_action_request ) ;
    $global_log_output .= "<selectbuttons>List of selection names: " . $delimited_list_of_selection_names . "<\/selectbuttons>" ;
    if ( $delimited_list_of_selection_names =~ /[a-z]/ )
    {
        @list_of_selection_names = &split_delimited_items_into_array( $delimited_list_of_selection_names ) ;
        foreach $selection_name ( @list_of_selection_names )
        {


#-----------------------------------------------
#  Get the relevant information.

            $current_value_encountered = $global_false ;
            @list_of_selection_values = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-valid-values-for-value-named-" . $selection_name ) ) ;

            $current_value = &dashrep_expand_parameters( "current-value-for-selection-named-" . $selection_name ) ;
#            $global_log_output .= $global_temporary_log_output ;

            $selection_default = &dashrep_expand_parameters( "default-value-for-selection-" . $selection_name ) ;

            $global_log_output .= "<selectbuttons>Selection name, current value, and default value: " . $selection_name . " , " . $current_value . " , " . $selection_default . "<\/selectbuttons>" ;


#-----------------------------------------------
#  Do the marking, and leave all other selection
#  (radio) buttons unmarked.
#  If there is a valid current value, use it
#  instead of the default value.

            foreach $selection_value ( @list_of_selection_values )
            {
                $global_log_output .= "<selectbuttons>  Selection value: " . $selection_value . "<\/selectbuttons>" ;
                if ( $selection_value eq $current_value )
                {
                    &dashrep_define( "possible-marked-selection-" . $selection_name . "-" . $selection_value , "radio-button-marked" ) ;
                    $current_value_encountered = $global_true ;
                    $global_log_output .= "<selectbuttons>Match: selection value is " . $selection_value . " and current value is " . $current_value . "<\/selectbuttons>" ;
                } else
                {
                    &dashrep_define( "possible-marked-selection-" . $selection_name . "-" . $selection_value , "no-space" ) ;
                    $global_log_output .= "<selectbuttons>No match: selection value is " . $selection_value . " and current value is " . $current_value . "<\/selectbuttons>" ;
                }
            }
            if ( $current_value_encountered == $global_false )
            {
                &dashrep_define( "possible-marked-selection-" . $selection_name . "-" . $selection_default , "radio-button-marked" ) ;
            }


#-----------------------------------------------
#  Repeat the loop for the next group of selection
#  buttons.

        }
    }


#-----------------------------------------------
#  End of subroutine.

}

