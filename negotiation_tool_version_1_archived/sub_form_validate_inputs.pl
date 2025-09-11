#-----------------------------------------------
#-----------------------------------------------
#         form_validate_inputs
#-----------------------------------------------
#-----------------------------------------------
#  Validates the values received from a form.


sub form_validate_inputs
{


#-----------------------------------------------
#  In case, at a future time, this subroutine
#  should be used more than once, track subroutine
#  usage to allow first-time error messages to be
#  retained.

    $global_usage_count_for_form_validate_inputs_subroutine ++ ;


#-----------------------------------------------
#  Initialize the validation error status.

    $global_validation_error = $global_false ;
    $global_essential_validation_error = $global_false ;
    %validation_failure_for_input_value_name = ( ) ;


#-----------------------------------------------
#  Get the input value names.  Do not change the
#  order because some input values must be
#  validated before others.

    @list_of_input_value_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "input-value-names-for-action-" . $global_action_request ) ) ;
    $text_list_of_input_value_names = join( ", " , @list_of_input_value_names ) ;
#    $global_log_output .= $global_temporary_log_output ;
    $global_log_output .= "<validate>List of input values to validate: " . $text_list_of_input_value_names . "<\/validate>" ;
    if ( $text_list_of_input_value_names !~ /[^ ]/ )
    {
        $global_log_output .= "<validate>No input values to validate<\/validate>" ;
        return ;
    }


#-----------------------------------------------
#  Begin a loop to handle each input value --
#  in the correct order.

    for ( $value_name_pointer = 0 ; $value_name_pointer <= $#list_of_input_value_names ; $value_name_pointer ++ )
    {
        $input_value_name = $list_of_input_value_names[ $value_name_pointer ] ;
        &dashrep_define( "yes-need-to-validate-input-value-" . $input_value_name , "yes" ) ;
        $global_log_output .= "<validate>Input value name:  " . $input_value_name . "<\/validate>" ;


#-----------------------------------------------
#  Get the next supplied input value.

        $user_text = &dashrep_get_replacement( "input-" . $input_value_name ) ;
        $global_log_output .= "<validate>Input value:  " . $user_text . "<\/validate>" ;


#-----------------------------------------------
#  Determine which kinds of validation are needed
#  for this input value.

        %need_validation_of_type = ( ) ;

        @list_of_validations_needed = &split_delimited_items_into_array( &dashrep_expand_parameters( "validation-checks-for-input-value-named-" . $input_value_name ) ) ;
        foreach $validation_type_needed ( @list_of_validations_needed )
        {
            $need_validation_of_type{ $validation_type_needed } = $global_true ;
        }

        @list_of_validations_needed = &split_delimited_items_into_array( &dashrep_expand_parameters( "validation-checks-for-input-value-named-" . $input_value_name . "-and-action-" . $global_action_request ) ) ;
        foreach $validation_type_needed ( @list_of_validations_needed )
        {
            $need_validation_of_type{ $validation_type_needed } = $global_true ;
        }


#-----------------------------------------------
#  If needed, clean up any text that was entered
#  or (in the case of hidden parameters) modified.

        if ( $need_validation_of_type{ "skip-cleanup" } != $global_true )
        {
            $user_text = &clean_up_user_text ( $user_text ) ;
            $global_log_output .= "<validate>Did cleanup<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, verify the supplied text is not
#  empty.

        if ( $need_validation_of_type{ "not-empty" } == $global_true )
        {
            if ( $user_text =~ /^ *$/ )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-is-missing " ;
                $global_log_output .= "<validate>Failed validation check:  not-empty<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  not-empty<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, verify the supplied value is a number.
#  Also remove any non-digits, except hyphens.

        if ( $need_validation_of_type{ "is-number" } == $global_true )
        {
            $user_text =~ s/[^0-9\-]+//g ;
            if ( $user_text !~ /^[0-9\-]+$/ )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-not-a-number " ;
                $global_log_output .= "<validate>Failed validation check:  is-number<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  is-number<\/validate>" ;
        }



#-----------------------------------------------
#  If needed, verify the supplied number is not
#  zero.
#  Note that numbers such as " 000-000" are also
#  checked for.

        if ( $need_validation_of_type{ "not-zero" } == $global_true )
        {
            if ( $user_text =~ /^[ 0\-]+$/ )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-number-is-not-valid " ;
                $global_log_output .= "<validate>Failed validation check:  not-zero<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  not-zero<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, verify the supplied ID value already
#  exists.

        if ( $need_validation_of_type{ "id-value-exists" } == $global_true )
        {
            $not_yet_found = $global_true ;
            $input_value_name_without_id_suffix = $input_value_name ;
            $input_value_name_without_id_suffix =~ s/id$// ;
            $id_list_replacement_name = "idlist" . $input_value_name_without_id_suffix . "s" ;
            $global_log_output .= "<validate>ID list replacement name: " . $id_list_replacement_name . "<\/validate>" ;
            @list_of_id_numbers = &split_delimited_items_into_array( &dashrep_get_replacement( $id_list_replacement_name ) ) ;
            $global_log_output .= "<validate>Searching for ID value " . $user_text . " in list: " . join( "," , @list_of_id_numbers ) . "<\/validate>" ;
            for $id_number ( @list_of_id_numbers )
            {
                if ( int( $user_text ) == int( $id_number ) )
                {
                    $not_yet_found = $global_false ;
                    last ;
                }
            }


#  Finish debugging later

            $not_yet_found = $global_false ;


            if ( $not_yet_found == $global_true )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-number-is-not-valid " ;
                $global_log_output .= "<validate>Failed validation check:  id-value-exists<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  id-value-exists<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, ensure the supplied value is unique.

        if ( $need_validation_of_type{ "not-duplicate" } == $global_true )
        {

#  implement check later ...

#            $global_validation_error_message .= "user-error-message-value-not-unique " ;

            $global_log_output .= "<validate>Validation check not-duplicate not actually done<\/validate>" ;

            $global_log_output .= "<validate>Would have done validation check:  not-duplicate<\/validate>" ;
        }




#-----------------------------------------------
#  If needed, ensure the supplied value is one of
#  several specified valid values.  If not, indicate
#  a user error.

        if ( $need_validation_of_type{ "matches-one-of-valid-values" } == $global_true )
        {
            $not_yet_found = $global_true ;
            @list_of_valid_values = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-valid-values-for-value-named-" . $input_value_name ) ) ;
            for $valid_value ( @list_of_valid_values )
            {
                $global_log_output .= "<validate>  Valid value: " . $valid_value . "<\/validate>" ;
                if ( $user_text eq $valid_value )
                {
                    $not_yet_found = $global_false ;
                    last ;
                }
            }
            if ( $not_yet_found == $global_true )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-does-not-match-a-valid-value " ;
                $global_log_output .= "<validate>Failed validation check:  matches-one-of-valid-values<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  matches-one-of-valid-values<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, ensure the supplied value appears
#  to be a valid email address.  If not, indicate
#  a user error.

        if ( $need_validation_of_type{ "is-email-address" } == $global_true )
        {
            if ( ( $user_text !~ /^ *$/ ) && ( $user_text !~ /^[^ ]+@[^ ]+\.[^ ]+$/ ) )
            {
                $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
                $global_validation_error_message .= "user-error-message-value-is-not-email-address " ;
                $global_log_output .= "<validate>Failed validation check:  is-email-address<\/validate>" ;
            }
            $global_log_output .= "<validate>Did validation check:  is-email-address<\/validate>" ;
        }


#-----------------------------------------------
#  If needed, ensure the value has changed, and
#  if not, indicate it should not be written.

        if ( $need_validation_of_type{ "not-changed" } == $global_true )
        {

#  ...  write code later

        }


#-----------------------------------------------
#  If this value is essential -- meaning it cannot
#  have any error -- then display a major error
#  message -- instead of allowing an edit page.

        if ( $need_validation_of_type{ "is-essential" } == $global_true )
        {
            if ( $validation_failure_for_input_value_name{ $input_value_name } eq "yes" )
            {
                $global_essential_validation_error = $global_true ;
                $global_validation_error_message .= "user-error-message-value-is-essential " ;
                $global_log_output .= "<validate>Failed validation check:  is-essential<\/validate>" ;
                $global_log_output .= "<validate>Need to display a major error message<\/validate>" ;
            }
        }


#-----------------------------------------------
#  If the value is valid, put the validated value
#  into a replacement, and add the value name to a list.

        $replacement_name = "xml-content-" . $input_value_name ;
        if ( $validation_failure_for_input_value_name{ $input_value_name } ne "yes" )
        {
            &dashrep_define( $replacement_name , $user_text ) ;
            push ( @list_of_validated_value_names , $replacement_name ) ;
            &dashrep_define( "input-validated-" . $input_value_name , $user_text ) ;
            $global_log_output .= "<validate>----------------------<\/validate>" ;
            $global_log_output .= "<validate>Valid value " . $input_value_name . " = " . $user_text . "<\/validate>" ;
            $global_log_output .= "<validate>----------------------<\/validate>" ;
            $global_log_output .= "<validate>Valid value named: " . $replacement_name . "<\/validate>" ;


#-----------------------------------------------
#  If there was any validation error for this
#  input value, set a validation error flag.
#  Also fill the "xml-content-..."
#  replacement with an "unknown" value.
#  Also track the name of the input value.

        } else
        {
            $global_validation_error = $global_true ;
            &dashrep_define( $replacement_name , &dashrep_get_replacement( "placeholder-for-invalid-input-values" ) ) ;
#            &dashrep_define( "output-" . $input_value_name , &dashrep_get_replacement( "input-" . $input_value_name ) ) ;
            $validation_failure_for_input_value_name{ $input_value_name } = "yes" ;
        }


#-----------------------------------------------
#  Repeat the loop to handle the next input value.

    }


#-----------------------------------------------
#  If this is the first time using this subroutine,
#  list any values that failed to validate.

    if ( $global_usage_count_for_form_validate_inputs_subroutine == 1 )
    {
        &dashrep_define( "possible-intro-listing-invalid-input-values" , "" ) ;
        foreach $input_value_name ( keys( %validation_failure_for_input_value_name ) )
        {
            if ( $validation_failure_for_input_value_name{ $input_value_name } eq "yes" )
            {
                &dashrep_define( "list-of-invalid-input-values" , &dashrep_get_replacement( "list-of-invalid-input-values" ) . ", " . &dashrep_get_replacement( "user-name-for-input-value-name-" . $input_value_name ) ) ;
                &dashrep_define( "possible-intro-listing-invalid-input-values" , "intro-listing-invalid-input-values" ) ;
                $global_log_output .= "<validate>----------------------<\/validate>" ;
                $global_log_output .= "<validate>INVALID value " . $input_value_name . " = " . $user_text . "<\/validate>" ;
                $global_log_output .= "<validate>----------------------<\/validate>" ;
            }
        }
        $temporary_string = &dashrep_get_replacement( "list-of-invalid-input-values" ) ;
        $temporary_string =~ s/^[ ,]+// ;
        &dashrep_define( "list-of-invalid-input-values" , $temporary_string ) ;
    }


#-----------------------------------------------
#  End of subroutine.

}

