#-----------------------------------------------
#-----------------------------------------------
#         form_save_user_supplied_info
#-----------------------------------------------
#-----------------------------------------------
#  Use the (already validated) values from a form
#  to create XML code and write that code to the
#  case information file.
#  (Permission to do the action must have been
#  already checked.)

sub form_save_user_supplied_info
{


#-----------------------------------------------
#  Get the names of the XML templates that are
#  associated with the form type.
#  Often there is just one template involved.

    $text_list_of_template_names = &dashrep_get_replacement( "template-names-for-action-" . $global_action_request ) ;
    $global_log_output .= "<formsave>Template names are: " . $text_list_of_template_names . "<\/formsave>" ;
    if ( $text_list_of_template_names !~ /[^ ]/ )
    {
        return ;
    }
    @list_of_template_names_for_this_form = &split_delimited_items_into_array( $text_list_of_template_names ) ;


#-----------------------------------------------
#  If any new ID numbers are needed, create them.
#  Also update the list of those ID numbers.

    @list_of_new_id_number_types = &split_delimited_items_into_array( &dashrep_get_replacement( "new-id-number-types-for-action-" . $global_action_request ) ) ;
    foreach $new_id_number_type ( @list_of_new_id_number_types )
    {
        $global_log_output .= "<formsave>ID number type: " . $new_id_number_type . "<\/formsave>" ;
        if ( $new_id_number_type =~ /^[^ ]+$/ )
        {
            $tag_name_for_id_list = "idlist" . $new_id_number_type  . "s" ;
            $replacement_name = "case-info-" . $tag_name_for_id_list ;
            $text_list_of_id_numbers = &dashrep_get_replacement( $replacement_name ) ;
            $global_log_output .= "<formsave>List of existing ID numbers: " . $text_list_of_id_numbers . "<\/formsave>" ;
            if ( $text_list_of_id_numbers =~ /[^ ]/ )
            {
                @list_of_id_numbers = &split_delimited_items_into_array( $text_list_of_id_numbers ) ;
                $largest_id_number = -1 ;
                foreach $id_number ( @list_of_id_numbers )
                {
                    if ( $id_number > $largest_id_number )
                    {
                        $largest_id_number = $id_number ;
                    }
                }
                $new_id_number = $largest_id_number + 1 ;
                $text_list_of_id_numbers  .= ',' . $new_id_number ;
            } else
            {
                $largest_id_number = 0 ;
                $new_id_number = 1 ;
                $text_list_of_id_numbers = "1" ;
            }
            $global_log_output .= "<formsave>Revised list of ID numbers: " . $text_list_of_id_numbers . "<\/formsave>" ;
            &dashrep_define( $replacement_name , $text_list_of_id_numbers ) ;
            $xml_replacement_name = "xml-list-of-id-numbers-of-type-" . $new_id_number_type ;
            &dashrep_define( $xml_replacement_name , "<" . $tag_name_for_id_list . ">" . $text_list_of_id_numbers . "<\/" . $tag_name_for_id_list . ">" ) ;

            $global_case_info_file_type = "main" ;
            $temporary_replacement_name = "list-of-xml-code-of-type-" . $global_case_info_file_type ;
            &dashrep_define( $temporary_replacement_name , &dashrep_get_replacement( $temporary_replacement_name ) . $xml_replacement_name . "," ) ;
            $global_log_output .= "<formsave>Info named " . $xml_replacement_name . " to be added: " . &dashrep_get_replacement( $xml_replacement_name ) . "<\/formsave>" ;

            $level_one_tag_name = $tag_name_for_id_list ;
            push( @global_list_of_parameterized_xml_tags_to_read , $level_one_tag_name ) ;

            &dashrep_define( "xml-content-" . $new_id_number_type . "id" , $new_id_number ) ;
        }
    }


#-----------------------------------------------
#  If a proposal is being edited (by an
#  administrator), get the appropriate alias
#  ID number.

    if ( $global_action_request eq "getproposaledited" )
    {
        &dashrep_define( "xml-content-aliasid" , &dashrep_get_replacement( "proposal-aliasid-for-proposalid-" . &dashrep_get_replacement( "xml-content-proposalid" ) ) ) ;
        $global_log_output .= "<formsave>Alias ID " . &dashrep_get_replacement( "xml-content-aliasid" ) . " for proposal ID " . &dashrep_get_replacement( "xml-content-proposalid" ) . "<\/formsave>" ;
    }


#-----------------------------------------------
#  If a new participant is being added, create
#  their hidden user ID number.
#  Also ensure it is not the same as any existing
#  participant's user ID number.
#  Also make the new ID number available as a
#  participant ID number.

    if ( $global_action_request eq "getparticipantadded" )
    {
        &generate_user_id ;
        &dashrep_define( "xml-content-userid" , $global_new_user_id ) ;
        $global_user_participant_id = $new_id_number ;
    }


#-----------------------------------------------
#  If a different specified participant ID is not
#  being used, specify the user's participant ID
#  (in case it is used).

    if ( &dashrep_get_replacement( "yes-need-to-validate-input-value-participantid" ) ne "yes" )
    {
        &dashrep_define( "xml-content-participantid" , $global_user_participant_id ) ;
        $global_log_output .= "<formsave>XML content participant ID set to " . $global_user_participant_id . "<\/formsave>" ;
    }


#-----------------------------------------------
#  If an administrator is casting an overriding
#  incompatibility vote for a specified pair of
#  proposals, specify a participant ID of 99999.

    if ( $global_action_request eq "getoverrideincompatibilityedited" )
    {
        &dashrep_define( "xml-content-participantid" , "99999" ) ;
        $global_log_output .= "<formsave>Participant ID changed to 99999 for administrator-based incompatibility voting<\/formsave>" ;
    }


#-----------------------------------------------
#  If a proposal is being moved, get the vote
#  information, create the updated new sequence,
#  and define "xml-content-..." replacements
#  that pass the results back here.

    if ( ( $global_action_request eq "getmoveproposal" ) || ( $global_action_request eq "getmoveothervoterproposal" ) || ( $global_action_request eq "getmovetiebreak" ) )
    {
        &proposal_move ;
        $global_log_output .= "<formsave>Back in form-save-user-supplied-info subroutine<\/formsave>" ;
    }


#-----------------------------------------------
#  Begin a loop to handle each relevant XML
#  template type.

    foreach $xml_template_name ( @list_of_template_names_for_this_form )
    {
        $global_log_output .= "<formsave>Template name: " . $xml_template_name . "<\/formsave>" ;


#-----------------------------------------------
#  Create the XML code that contains the validated
#  input values.

        $new_xml = &dashrep_expand_parameters( $xml_template_name ) ;
#        $global_log_output .= $global_temporary_log_output ;


#-----------------------------------------------
#  Create a replacement that contains the XML code.

        $xml_replacement_name = "xml-info-from-template-" . $xml_template_name ;
        &dashrep_define( $xml_replacement_name , $new_xml . "\n" ) ;


#-----------------------------------------------
#  Specify which file (type) to put the
#  information into.

        $global_case_info_file_type = &dashrep_get_replacement( "file-type-for-template-" . $xml_template_name ) ;
        if ( $global_case_info_file_type !~ /[a-z]/i )
        {
            $global_case_info_file_type = "main" ;
        }


#-----------------------------------------------
#  List this XML code as ready to be written to the file.

        $temporary_replacement_name = "list-of-xml-code-of-type-" . $global_case_info_file_type ;
        &dashrep_define( $temporary_replacement_name , &dashrep_get_replacement( $temporary_replacement_name ) . $xml_replacement_name . "," ) ;
        $global_log_output .= "<formsave>Info named " . $xml_replacement_name . " to be added: " . &dashrep_get_replacement( $xml_replacement_name ) . "<\/formsave>" ;


#-----------------------------------------------
#  Later, to save file space, can check if
#  values are unchanged.

# '''


#-----------------------------------------------
#  List the level-one tag names that have new
#  entries.
#  (This information may be used to re-read the
#  XML code within theses tags, without also
#  reading other XML data.)

        $template_contents = &dashrep_get_replacement( $xml_template_name ) ;
        if ( $template_contents =~ /^[^<]*<([^>]+)>/ )
        {
            $level_one_tag_name = $1 ;
            push( @global_list_of_parameterized_xml_tags_to_read , $level_one_tag_name ) ;
        }


#-----------------------------------------------
#  Finish the loop that handles each relevant XML
#  template type.

    }


#-----------------------------------------------
#  Specify the action name that will be logged.

     &dashrep_define( "logged-action-name" , "logged-action-name-for-action-" . $global_action_requested ) ;


#-----------------------------------------------
#  Write the new replacement variable definitions
#  to the description file.

    &xml_write_new ;


#-----------------------------------------------
#  Re-read the (updated) case information (in XML)
#  and convert all non-parameterized information
#  -- and any requested parameterized information --
#  into replacements.  This update ensures that
#  the web page about to be displayed uses up-to-date
#  information.

    $global_filename = $global_case_description_filename ;
    &file_read ;
    $global_xml_read_from_case_file = $global_content_read_from_file ;
    &log_write ;
#    $global_log_output .= "<formsave>Updated info read from case file: " . $global_xml_read_from_case_file . "<\/formsave>" ;
    $global_xml_input = $global_xml_read_from_case_file ;
    &xml_to_replacements ;
    &log_write ;
    &get_id_numbers ;
    &log_write ;


#-----------------------------------------------
#  End of subroutine.

}

