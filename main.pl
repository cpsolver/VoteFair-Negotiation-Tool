#
#                Main.pl
#                -------
#
#
#  (c) Copyright 2006-2008 by Richard Fobes at WebHost@VoteFair.org
#  Solutions Through Innovation, PO Box 19003, Portland, OR 97280-0003 USA
#  ALL RIGHTS RESERVED
#
#-----------------------------------------------


#-----------------------------------------------
#  Execute the main subroutine.

&do_all ;
exit ;


#-----------------------------------------------
#  Highest-level subroutine.

sub do_all
{


#-----------------------------------------------
#  Specify whether this program is being executed
#  locally, or in a CGI environment.

    &dashrep_define( "cgi-version" , "cgi-yes" ) ;
    $local_filename = 'Temp_FullNegotiationTool_Output.html' ;
    if ( -e $local_filename )
    {
        &dashrep_define( "local-version" , "local-yes" ) ;
        &dashrep_define( "cgi-version" , "cgi-no" ) ;
        $global_log_output .= "<main>Found local file: " . $local_filename . "<\/main>" ;
    }


#-----------------------------------------------
#  Do common initialization.

    $global_log_file_outer_xml_tag = "[GenNegLog]" ;

    &initialization_main ;


#-----------------------------------------------
#  Determine if this is a test version.

    if ( $global_standard_replacements_filename =~ /test/ )
    {
        &dashrep_define( "test-version" , "yes" ) ;
    } else
    {
        &dashrep_define( "test-version" , "no" ) ;
    }


#-----------------------------------------------
#  Specify a default action.

    $global_action_request = "undefined" ;


#-----------------------------------------------
#  Initialize some replacement items.
#  These replacements must not be defined in
#  the replacements file (or else they will
#  overwrite these values).

    $global_phrase_referring_to_entire_web_page = "entire-standard-web-page" ;

    &dashrep_define( "web-page-content" , "" ) ;
    &dashrep_define( "possible-user-error-message" , "" ) ;


#-----------------------------------------------
#  Get the replacements from the file that
#  contains the unchanging replacements.
#  Keep track of which replacements were defined
#  here so their definitions won't appear in the
#  log file.

    $global_filename = $global_standard_replacements_filename ;
    &file_read ;
    @global_list_of_standard_replacement_names = &dashrep_import_replacements( $global_content_read_from_file ) ;
    &error_check ;


#-----------------------------------------------
#  Define a special test-css action and page.
#  The page contains all the content from all
#  the normal pages.

    &dashrep_define( "yes-no-permission-for-action-testcss" , "yes-permission" ) ;
    &dashrep_define( "page-name-for-action-testcss" , "page-test-css" ) ;
    &dashrep_define( "page-test-css" , &dashrep_get_replacement( "list-of-page-names" ) ) ;
    $replacement_string = &dashrep_get_replacement( "page-test-css" ) ;
    $replacement_string =~ s/ +/-\] \[-/g ;
    $replacement_string =~ s/^ */\[-/ ;
    $replacement_string =~ s/ *$/-\]/ ;
    &dashrep_define( "page-test-css" , $replacement_string ) ;

#    $global_log_output .= "<main>Page-test-css equals: " . &dashrep_get_replacement( "page-test-css" ) . "<\/main>" ;


#-----------------------------------------------
#  For local debugging, list all possible actions
#  and their associations with page names, inputs,
#  etc.

#     if ( &dashrep_get_replacement( "local-version" ) =~ /yes/ )
#     {
#         foreach $temp_permission_category ( "administrator" , "voter" , "observer" , "inactive" )
#         {
#             @temp_list_of_actions = &split_delimited_items_into_array(&dashrep_get_replacement( "list-of-actions-permitted-for-category-" . $temp_permission_category ) ) ;
#             foreach $action_name ( @temp_list_of_actions )
#             {
#                 &dashrep_get_replacement( "yes-permission-for-category-" . $temp_permission_category . "-and-action-" . $action_name ) = "yes" ;
# #                $global_log_output .= "<main>Category " . $temp_permission_category . " and action " . $action_name . " permission is yes<\/main>" ;
#             }
#         }
#         $global_log_output .= "<main>----------------- Associations -------------------------<\/main>" ;
#         @list_of_action_names_require_permission = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-actions-that-require-permission" ) ) ;
#         @list_of_action_names_no_require_permission = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-non-permission-action-names" ) ) ;
#         @list_of_all_action_names = @list_of_action_names_require_permission , @list_of_action_names_no_require_permission ;
#         $global_log_output .= "<main>List of all action names: " . join( "," , @list_of_all_action_names ) . "<\/main>" ;
#         $temporary_log_output = "" ;
#         foreach $action_name ( @list_of_all_action_names )
#         {
#             if ( $action_name =~ /[a-z]/ )
#             {
#                 @list_of_input_value_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "input-value-names-for-action-" . $action_name ) ) ;
#                 $text_list_of_input_value_names = join( ", " , @list_of_input_value_names ) ;
#                 $temporary_log_output .= "<main>------------------------------------------<\/main>" ;
#                 $temporary_log_output .= "<main>" . $action_name . "    (= action)<\/main>" ;
#                 $temporary_log_output .= "<main>    " . &dashrep_get_replacement( "page-name-for-action-" . $action_name ) . "    (= page)<\/main>" ;
#                 $temporary_log_output .= "<main>    " . $text_list_of_input_value_names . "    (= inputs)<\/main>" ;
#                 $temporary_log_output .= "<main>    " . &dashrep_get_replacement( "template-names-for-action-" . $action_name ) . "    (= output templates)<\/main>" ;
#                 $temporary_log_output .= "<main>    " . &dashrep_get_replacement( "source-action-name-for-action-" . $action_name ) . "    (= source action)<\/main>" ;
#                 $temporary_log_output .= "<main>    " . &dashrep_get_replacement( "list-of-selection-names-for-action-" . $action_name ) . "    (= selections)<\/main>" ;
#                 foreach $temp_permission_category ( "administrator" , "voter" , "observer" , "inactive" )
#                 {
#                     $temporary_log_output .= "<main>    " . &dashrep_get_replacement( "yes-permission-for-category-" . $temp_permission_category . "-and-action-" . $action_name ) . "    (= " . $temp_permission_category . " permission)<\/main>" ;
#                 }
#             }
#         }
#         $global_log_output .= "<main>------------------------------------------<\/main>" ;
#         $global_log_output .= $temporary_log_output ;
#         $global_log_output .= "<main>------------------------------------------<\/main>" ;
#     }


#-----------------------------------------------
#  If this is a test version, redirect cgi-bin
#  references to the test version, and use the
#  test version of the stylesheet.

    if ( &dashrep_get_replacement( "test-version" ) =~ /yes/ )
    {
        &dashrep_define( "cgi-votefair-negotiation-tool" , "cgi-votefair-negotiation-tool-test-version" ) ;
        &dashrep_define( "stylesheet-filename" , "stylesheet-filename-test-version" ) ;
        $global_log_output .= "<main>Running in test CGI environment<\/main>" ;
    }


#-----------------------------------------------
#  If this is a local version, adjust some
#  replacements.

    if ( &dashrep_get_replacement( "local-version" ) =~ /yes/ )
    {
        &dashrep_define( "cgi-votefair-negotiation-tool" , "cgi-votefair-negotiation-tool-local-version" ) ;
        &dashrep_define( "stylesheet-filename" , "stylesheet-filename-local-version" ) ;
        $global_log_output .= "<main>Running in local environment<\/main>" ;
    }


#-----------------------------------------------
#  Get the input information -- either supplied
#  from a previous web page through CGI, or
#  supplied from an input file.
#  Store the collected information in the
#  "replacement" associative array, with each
#  element name prefixed by "input-".

    &get_input_information ;


#-----------------------------------------------
#  Check for any fatal errors so far.

    $global_log_output .= "<main>Checking for errors<\/main>" ;
    &error_check ;


#-----------------------------------------------
#  If this program is being executed in CGI mode,
#  specify the required CGI heading.

    if ( &dashrep_get_replacement( "cgi-version" ) =~ /yes/ )
    {
        $global_possible_cgi_heading = 'Content-type: text/html' . "\n\n" ;
#        $global_log_output .= "<main>cgi-heading: yes<\/main>" ;
    } else
    {
        $global_possible_cgi_heading = "" ;
#        $global_log_output .= "<main>cgi-heading: no<\/main>" ;
    }


#-----------------------------------------------
#  Allow backdoor access to erase all the log files.
#  Use a special Access ID.

    $delete_access_word = &dashrep_get_replacement( "word-delete-all-log-files" ) ;
    $delete_access_word =~ s/[^a-z0-9]//sgi ;
    if ( $delete_access_word !~ /[a-z0-9]/i )
    {
        $delete_access_word = "invalid_access_id" ;
    }

# $global_log_output .= "<main>Special word: " . $delete_access_word . "<\/main>" ;

    if ( &dashrep_get_replacement( "input-accessid" ) eq $delete_access_word )
    {
        unlink( glob( $global_log_directory_prefix . "log-*.txt" ) ) ;
        $global_log_output .= "<main>Erased all log files!<\/main>" ;
        $global_error_message .= "Log files erased." ;
        &error_check ;  # Exits here
    }


#-----------------------------------------------
#  Get the requested action.

    if ( &dashrep_get_replacement( "input-action" ) =~ /[a-z]/i )
    {
        $global_action_request = &dashrep_get_replacement( "input-action" ) ;
    }
    &dashrep_define( "output-requested-action" , $global_action_request ) ;
    $global_log_output .= "<main>Action requested: " . $global_action_request . "<\/main>" ;


#-----------------------------------------------
#  For local, non-CGI, execution, force a
#  specific Access ID number and requested action.
#  Use for local debugging.

    if ( &dashrep_get_replacement( "local-version" ) =~ /yes/ )
    {
        $global_log_output .= "<main>Using local environment<\/main>" ;


#  code removed


#        &dashrep_define( "input-proposalid" , 1 ) ;
#        &dashrep_define( "input-validated-proposalid" , 1 ) ;
#        &dashrep_define( "input-proposalsecond" , 2 ) ;
#        &dashrep_define( "input-validated-proposalsecond" , 2 ) ;
#        &dashrep_define( "input-aliasid" , 1 ) ;
#        &dashrep_define( "input-validated-aliasid" , 1 ) ;

#        &dashrep_define( "input-participantid" , 1 ) ;
#        &dashrep_define( "input-validated-participantid" , 1 ) ;

#        &dashrep_define( "participant-permissioncategory-for-participantid-1" , "administrator" ) ;
#        $global_user_id = 1 ;

#        &dashrep_define( "input-aliastitle" , "title two" ) ;
#        &dashrep_define( "input-validated-aliastitle" , "title two" ) ;
#        &dashrep_define( "input-description" , "description two" ) ;
#        &dashrep_define( "input-validated-description" , "description two" ) ;

#        &dashrep_define( "input-action" , "getproposaladded" ) ;

#        &dashrep_define( "input-action" , "home" ) ;
#        &dashrep_define( "input-action" , "testcss" ) ;
        &dashrep_define( "input-action" , "showoverallranking" ) ;
#        &dashrep_define( "input-action" , "showothervoterranking" ) ;
#        &dashrep_define( "input-action" , "showtiebreakrank" ) ;

        $global_action_request = &dashrep_get_replacement( "input-action" ) ;
        $global_log_output .= "<main>Using default test ID " . &dashrep_get_replacement( "input-accessid" ) . " and default action of " . $global_action_request . "<\/main>" ;
    }


#-----------------------------------------------
#  If a new case is being started, start it
#  (by writing initial info to a new case file),
#  get the new Access ID, and request the home
#  page.

    if ( $global_action_request eq "newcase" )
    {
        &start_new_case ;
        $global_log_output .= "<main>Created a new case, with case number " . $global_case_number . "<\/main>" ;
        &dashrep_define( "input-accessid" , $global_access_id ) ;
        &dashrep_define( "input-action" , "home" ) ;
    }


#-----------------------------------------------
#  Get the Access ID number, possibly translate it
#  from text into a number, and extract the case
#  number and user number (and check for validity).
#  Note: The user number is not the participant ID.

    &access_id_convert_to_case_and_user_id ;
    $global_log_output .= "<main>Case number is " . $global_case_number . "<\/main>" ;
    $global_log_output .= "<main>User ID number is " . $global_user_id . "<\/main>" ;


#-----------------------------------------------
#  Possibly hide a convoluted version of the
#  Access ID number in an HTML comment.

#  code removed

    &dashrep_define( "reference-number" , "" ) ;


#-----------------------------------------------
#  If an Access ID number was supplied, but it
#  doesn't correspond to a case number, change
#  the requested action to show an
#  invalid-access-ID error message.

    if ( ( &dashrep_get_replacement( "input-accessid" ) =~ /[0-9a-z]/i ) && ( $global_case_number == 0 ) )
    {
        $global_action_request = "invalidaccessid" ;
        $global_user_error_message .= &dashrep_get_replacement( "error-message-voting-id-invalid" ) . "<\/convertcaseuser>" ;
        $global_log_output .= "<convertcaseuser>Access ID is not valid<\/convertcaseuser>" ;
    }


#-----------------------------------------------
#  If this is not a request to start a new case
#  and there is no case number, or the user ID
#  number is zero, specify the welcome page action.

    if ( $global_action_request ne "newcase" )
    {
        if ( ( $global_case_number <= 0 ) || ( $global_user_id <= 0 ) )
        {
            $global_case_number = 0 ;
            $global_user_id = 0 ;
            $global_action_request = "welcome" ;
            $global_log_output .= "<main>Action changed because case number or user ID is zero or less than zero<\/main>" ;
            $global_log_output .= "<main>Action requested: " . $global_action_request . "<\/main>" ;
        }
    }


#-----------------------------------------------
#  If there is a case number, but there is no
#  action specified, or the action is the word
#  "undefined", show the home page as the default
#  action.

    if ( ( $global_case_number > 0 ) && ( ( $global_action_request !~ /[a-z]/ ) || ( $global_action_request eq "undefined" ) ) )
    {
        $global_log_output .= "<main>Action changed because case number (" . $global_case_number . ") is specified but no action (" . $global_action_request . ") is specified<\/main>" ;
        $global_action_request = "home" ;
        $global_log_output .= "<main>Action requested: " . $global_action_request . "<\/main>" ;
    }


#-----------------------------------------------
#  Indicate (in the log file) which action is now
#  being requested.

    $global_log_output .= "<main>Action requested: " . $global_action_request . "<\/main>" ;
    &error_check ;


#-----------------------------------------------
#  Suppress the log file for some kinds of actions.
#  (For debugging, the write flag can be changed
#  later in the code.)
#  If it is not supressed, write to the log file.

    if ( ( &dashrep_get_replacement( "suppress-log-for-action-" . $global_action_request ) =~ /yes/i ) && ( &dashrep_get_replacement( "cgi-version" ) =~ /yes/ ) )
    {
        $global_write_log_file = $global_false ;
    }
    &log_write ;


#-----------------------------------------------
#  If the case number is valid, read the case
#  information.

    $global_xml_read_from_case_file = "" ;
    if ( $global_case_number > 0 )
    {
        &get_case_info_filename ;
        if ( $global_error_message ne "" )
        {
            $global_error_message .= "error-message-no-access-for-this-voting-id" . "\n" ;
            $global_log_output .= "<main>Failure opening -- for reading -- file named " . $global_case_description_filename . "<\/main>" ;
            $global_log_output .= "<main>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/main>" ;
            $global_error_message = "" ;
            $global_user_error_message .= &dashrep_get_replacement( "error-message-voting-id-invalid" ) . "<\/convertcaseuser>" ;
            $global_case_number = 0 ;
            $global_user_id = 0 ;
            $global_action_request = "welcome" ;
            $global_log_output .= "<main>Action changed because case file was not found<\/main>" ;
            $global_log_output .= "<main>Action requested: " . $global_action_request . "<\/main>" ;
        }

        if ( $global_case_number > 0 )
        {
            $global_filename = $global_case_description_filename ;
            &file_read ;
            $global_xml_read_from_case_file = $global_content_read_from_file ;
#            $global_log_output .= "<main>Info read from case file: " . $global_xml_read_from_case_file . "<\/main>" ;
        }
        &error_check ;


#-----------------------------------------------
#  Convert the just-read XML case information
#  into replacements.
#
#  For now, convert almost all the XML into
#  replacements.
#  Later, if faster response is needed, just
#  get the information that is needed for the
#  action being done.

        &log_elapsed_time ;
        $global_xml_input = $global_xml_read_from_case_file ;
        @global_list_of_parameterized_xml_tags_to_read = ( ) ;
        &xml_to_replacements ;
        &get_id_numbers ;
        &log_elapsed_time ;
#        &log_write ;
    }


#-----------------------------------------------
#  Get the language-specific replacements.

    $language_choice = &dashrep_get_replacement( "case-info-language" ) ;
    $language_choice =~ s/ //g ;
    if ( $language_choice !~ /^[a-z][a-z]$/ )
    {
        $language_choice = "en" ;
    }
    $global_filename = $global_language_specific_replacements_filename_prefix . $language_choice . $global_language_specific_replacements_filename_suffix ;
    &file_read ;
    &dashrep_import_replacements( $global_content_read_from_file ) ;
    if ( $global_error_message =~ /[^ ]/ )
    {
        $language_choice = "en" ;
        $global_filename = $global_language_specific_replacements_filename_prefix . $language_choice . $global_language_specific_replacements_filename_suffix ;
        &file_read ;
        &dashrep_import_replacements( $global_content_read_from_file ) ;
    }
    &error_check ;
    push( @global_list_of_standard_replacement_names , @global_list_of_replacement_names ) ;


#-----------------------------------------------
#  Get the participant's ID number (which is
#  not the same as the hidden user ID number).

    $global_log_output .= "<main>This user's ID is " . $global_user_id . "<\/main>" ;
    $global_user_participant_id = &dashrep_get_replacement( "participant-participantid-for-userid-" . $global_user_id ) ;
    if ( $global_user_participant_id < 1 )
    {
        $global_user_participant_id = 0 ;
        $global_log_output .= "<main>Participant number is not recognized, so set to zero<\/main>" ;
    }
    &dashrep_define( "users-participant-id" , $global_user_participant_id ) ;
    $global_participant_id = $global_user_participant_id ;
    $global_log_output .= "<main>This user's participant ID number is " . $global_user_participant_id . "<\/main>" ;


#-----------------------------------------------
#  Determine the user's permission category.
#  If it is empty (not recognized), specify the
#  welcome page with an error message.

    $global_permission_category = &dashrep_get_replacement( "participant-permissioncategory-for-participantid-" . $global_user_participant_id ) ;
    $global_log_output .= "<main>User's permission category is " . $global_permission_category . "<\/main>" ;
    if ( $global_permission_category eq "" )
    {
        $global_log_output .= "<main>Access ID does not correspond to any participant in this case, so the welcome page will be shown, with an error message.<\/main>" ;
        $global_page_name = "page-welcome" ;
        &dashrep_define( "possible-error-message-about-access-id-not-recognized" , "error-message-about-access-id-not-recognized" ) ;
    }


#-----------------------------------------------
#  Indicate (in the log file) which action is now
#  being requested.

    $global_log_output .= "<main>Action requested: [" . $global_action_request . "]<\/main>" ;
    &log_write ;


#-----------------------------------------------
#  If the welcome page is to be displayed,
#  generate it, display it, and then exit.

    if ( ( $global_action_request eq "welcome" ) || ( $global_page_name eq "page-welcome" ) )
    {
        $global_page_name = "page-welcome" ;
        $global_log_output .= "<main>Generating page named " . $global_page_name . "<\/main>" ;
        &dashrep_define( "web-page-content" , &dashrep_expand_parameters( $global_page_name ) ) ;
#        $global_log_output .= $global_temporary_log_output ;
        $global_html_code = &dashrep_expand_phrases( $global_phrase_referring_to_entire_web_page ) ;
        print $global_possible_cgi_heading ;
        print $global_html_code ;
        $global_log_output .= "[\/GenNegLog]" ;
        &log_new_replacements ;
        &log_write ;
        exit ;
    }


#-----------------------------------------------
#  Specify whether the user has permission for
#  each special kind of action.

    @list_of_action_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-non-permission-action-names" ) ) ;
#    $global_log_output .= "<main>List of non-permission action names: " . join( "," , @list_of_action_names ) . "<\/main>" ;
    foreach $action_name ( @list_of_action_names )
    {
        &dashrep_define( "yes-no-permission-for-action-" . $action_name , "yes-permission" ) ;
    }

    @list_of_action_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-actions-that-require-permission" ) ) ;
#    $global_log_output .= "<main>List of permission-needed action names: " . join( "," , @list_of_action_names ) . "<\/main>" ;
    foreach $action_name ( @list_of_action_names )
    {
        &dashrep_define( "yes-no-permission-for-action-" . $action_name , "no-permission" ) ;
    }

    @list_of_action_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "list-of-actions-permitted-for-category-" . $global_permission_category ) ) ;
    foreach $action_name ( @list_of_action_names )
    {
#         if ( &dashrep_get_replacement( "yes-no-permission-for-action-" . $action_name ) !~ /[^ ]/ )
#         {
#             $global_log_output .= "<main>WARNING: Action name " . $action_name . " is in " . $global_permission_category . " category list, but not in the main permission lists.<\/main>" ;
#         }
        &dashrep_define( "yes-no-permission-for-action-" . $action_name , "yes-permission" ) ;
    }


#-----------------------------------------------
#  Determine if the user has permission for the
#  requested action.

    &dashrep_define( "yes-no-permission" , "no-permission" ) ;
    if ( &dashrep_get_replacement( "yes-no-permission-for-action-" . $global_action_request ) eq "yes-permission" )
    {
        &dashrep_define( "yes-no-permission" , "yes-permission" ) ;
    }
    $global_log_output .= "<main>Permission for this action: " . &dashrep_get_replacement( "yes-no-permission" ) . "<\/main>" ;


#-----------------------------------------------
#  If the user's permission category is "inactive",
#  specify an appropriate action.

    if ( $global_permission_category eq "inactive" )
    {
        if ( ( $global_action_request eq "home" ) || ( &dashrep_get_replacement( "yes-no-permission" ) eq "no-permission" ) )
        {
            $global_log_output .= "<main>Participant is inactive, or does not have permission for action " . $global_action_request . " so pageinactive action specified instead<\/main>" ;
            $global_action_request = "pageinactive" ;
            &dashrep_define( "yes-no-permission" , "yes-permission" ) ;
        }
    }
    &log_write ;


#-----------------------------------------------
#  If the user does not have permission for the
#  requested action, show the home page with an
#  error message.
#  If the home page is not allowed, indicate an
#  error.

    if ( &dashrep_get_replacement( "yes-no-permission" ) eq "no-permission" )
    {
        if ( &dashrep_get_replacement( "yes-no-permission-for-action-" . "home" ) =~ /y/ )
        {
            $global_action_request = "home" ;
            &dashrep_get_replacement( "user-error-message-wording" ) .= " " . "no-permission-for-this-action-usage-user-error-messaage" ;
            $global_log_output .= "<main>Participant does not have permission for action " . $global_action_request . " so home page will be displayed<\/main>" ;
        } else
        {
            $global_action_request = "error" ;
        }
    }


#-----------------------------------------------
#  Get the name of the page to display.

    $global_page_name = &dashrep_get_replacement( "page-name-for-action-" . $global_action_request ) ;
    $global_log_output .= "<main>For action " . $global_action_request . " page name is " . $global_page_name . "<\/main>" ;
    &log_write ;


#-----------------------------------------------
#  If the user is an administrator, and the
#  user's Access ID is to be shown, show
#  this Access ID differently.

    if ( ( $global_permission_category eq "administrator" ) && ( &dashrep_get_replacement( "input-participantid" ) == $global_user_participant_id ) && ( $global_page_name eq "page-show-participant-access-id" ) )
    {
        $global_page_name = "page-show-admin-access-id" ;
    }


#-----------------------------------------------
#  If the page name (or action) is not recognized,
#  request the home page.

    if ( $global_page_name !~ /[^ ]/ )
    {
        $global_action_request = "home" ;
        $global_page_name = &dashrep_get_replacement( "page-name-for-action-" . $global_action_request ) ;
    }
    $global_log_output .= "<main>Page name: " . $global_page_name . "<\/main>" ;


#-----------------------------------------------
#  If a new proposal is being defined and either
#  -- but not both -- the description or title
#  is missing, copy the title into the
#  description or copy the description into the
#  title.

    if ( $global_action_request eq "getproposaladded" )
    {
        if ( ( &dashrep_get_replacement( "input-aliastitle" ) !~ /[^ \n]/ ) && ( &dashrep_get_replacement( "input-description" ) =~ /[^ \n]/ ) )
        {
            &dashrep_define( "input-aliastitle" , &dashrep_get_replacement( "input-description" ) ) ;
            $global_log_output .= "<main>Copied proposal description into empty aliastitle value<\/main>" ;
        } elsif ( ( &dashrep_get_replacement( "input-description" ) !~ /[^ \n]/ ) && ( &dashrep_get_replacement( "input-aliastitle" ) =~ /[^ \n]/ ) )
        {
            &dashrep_define( "input-description" , &dashrep_get_replacement( "input-aliastitle" ) ) ;
            $global_log_output .= "<main>Copied proposal title into empty description value<\/main>" ;
        }
    }


#-----------------------------------------------
#  If any input values -- from a form, button,
#  or link -- need to be validated, validate them.

    &form_validate_inputs ;


#-----------------------------------------------
#  If an essential ID number is not valid, show
#  a major error message.

    if ( $global_essential_validation_error == $global_true )
    {
        &dashrep_define( "possible-significant-error-message-on-home-page" , "significant-error-message-on-home-page" ) ;
        $global_action_request = "home" ;
        $global_page_name = &dashrep_get_replacement( "page-name-for-action-" . $global_action_request ) ;
    }


#-----------------------------------------------
#  If a participant ID is specified in the input
#  information, make it available as a global
#  variable and as a named replacement.
#  If it was not specified, use the user's
#  participant ID.

    $global_input_participant_id = int( &dashrep_get_replacement( "input-validated-participantid" ) ) ;
    if ( $global_input_participant_id <= 0 )
    {
        $global_input_participant_id = $global_user_participant_id ;
    }
    &dashrep_define( "parameter-participant-id" , $global_input_participant_id ) ;
    &dashrep_define( "participant-shortname-for-input-participantid" , "participant-shortname-for-participantid-" . $global_input_participant_id ) ;
    &dashrep_define( "participant-fullname-for-input-participantid" , "participant-fullname-for-participantid-" . $global_input_participant_id ) ;
    $global_log_output .= "<main>Input specifies participant ID " . $global_input_participant_id . "<\/main>" ;


#-----------------------------------------------
#  If a proposal ID is specified, get it.

    $global_input_proposal_id = int( &dashrep_get_replacement( "input-validated-proposalid" ) ) ;
    if ( $global_input_proposal_id < 0 )
    {
        $global_input_proposal_id = 0 ;
    }
    &dashrep_define( "parameter-proposal-id" , $global_input_proposal_id ) ;
    $global_log_output .= "<main>Input specifies proposal ID " . $global_input_proposal_id . "<\/main>" ;


#-----------------------------------------------
#  If an alias ID was specified, get its
#  associated proposal ID.

    $global_input_alias_id = int( &dashrep_get_replacement( "input-validated-aliasid" ) ) ;
    if ( $global_input_alias_id > 0 )
    {
        $global_input_proposal_id = &dashrep_get_replacement( "alias-proposalid-for-aliasid-" . $global_input_alias_id ) ;
        &dashrep_define( "input-validated-proposalid" , $global_input_proposal_id ) ;
        &dashrep_define( "xml-content-proposalid" , $global_input_proposal_id ) ;
        $global_log_output .= "<main>Revised proposal ID " . $global_input_proposal_id . " based on supplied alias ID " . $global_input_alias_id . "<\/main>" ;
    }


#-----------------------------------------------
#  Initialize output values that are normally
#  empty (unless there is a user input error).

    foreach $input_value_name ( "aliastitle" , "description" , "exiturl" )
    {
        &dashrep_define( "form-output-" . $input_value_name , &dashrep_get_replacement( "input-validated-" . $input_value_name ) ) ;
    }


#-----------------------------------------------
#  If the supplied information is to be written
#  to a case information file,
#  and there were no validation errors,
#  convert the information into XML code
#  and write that code to the file.
#  Also accomodate the moving of a proposal.

    $source_action = &dashrep_get_replacement( "source-action-name-for-action-" . $global_action_request ) ;
    $global_log_output .= "<main>Source action was " . $source_action . "<\/main>" ;
    if ( $source_action =~ /[^ ]/ )
    {
        if ( $global_validation_error == $global_false )
        {
            &form_save_user_supplied_info ;
            &dashrep_define( "possible-validation-error-message" , "" ) ;


#-----------------------------------------------
#  If any validation errors occurred, change the
#  requested action to display the source page,
#  with the error message displayed, and the
#  user-entered text already inserted.

        } else
        {
            $global_log_output .= "<main>There was a validation error!<\/main>" ;
            if ( $source_action =~ /[a-z]/ )
            {
                $global_action_request = $source_action ;
                $global_log_output .= "<main>Revised action is " . $global_action_request . "<\/main>" ;
                $global_page_name = &dashrep_get_replacement( "page-name-for-action-" . $global_action_request ) ;
                $global_log_output .= "<main>Revised page name is " . $global_page_name . "<\/main>" ;
            } else
            {
                $global_page_name = "error" ;
                $global_log_output .= "<main>Revised page name is " . $global_page_name . " , which is intentionally invalid, so an error will be triggered<\/main>" ;
            }

#  May still need work here...

            foreach $input_value_name ( "aliastitle" , "description" , "exiturl" )
            {
                &dashrep_define( "form-output-" . $input_value_name , &dashrep_get_replacement( "input-validated-" . $input_value_name ) ) ;
            }
        }
    }


#-----------------------------------------------
#  If extra case-information files need to be
#  read, read them and translate the XML code
#  into replacements.

    @list_of_extra_case_file_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "extra-case-files-for-" . $global_page_name ) ) ;
    $global_log_output .= "<main>Extra case files to read: " . join( "," , @list_of_extra_case_file_names ) . "<\/main>" ;
    foreach $extra_case_file_name ( @list_of_extra_case_file_names )
    {
        $global_extra_filename = $global_case_filename_prefix . $global_case_number . "-" . $extra_case_file_name . $global_case_filename_suffix ;
        $global_log_output .= "<main>Will read file: " . $global_extra_filename . "<\/main>" ;
        $global_filename = $global_extra_filename ;
        &error_check ;
        &file_read ;
        $global_error_message = "" ;
        $global_xml_read_from_extra_file = $global_content_read_from_file ;
        if ( $global_xml_read_from_extra_file =~ /[^ ]/ )
        {
#            $global_log_output .= "<main>Info read from extra file: " . $global_xml_read_from_extra_file . "<\/main>" ;
            $global_xml_input = $global_xml_read_from_extra_file ;
            @global_list_of_parameterized_xml_tags_to_read = ( ) ;
            &xml_to_replacements ;
        }
    }


#-----------------------------------------------
#  If the incompatibility information is needed
#  (either for display or for the sort
#  calculations), get that information, including
#  counting incompatibility votes.

    @list_of_page_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "page-names-that-need-incompatibility-info" ) ) ;
    foreach $page_name ( @list_of_page_names )
    {
        if ( $global_page_name eq $page_name  )
        {
            $global_log_output .= "<main>Getting incompatibility info<\/main>" ;
            &get_incompatibility_info ;
            last ;
        }
    }


#-----------------------------------------------
#  If an XML export or import is requested,
#  handle it.

    if ( $global_action_request eq "exportimport" )
    {
        $global_log_output .= "<main>Export requested<\/main>" ;
        &xml_export ;
    } elsif ( $global_action_request eq "getimported" )
    {
        $global_log_output .= "<main>Import requested<\/main>" ;
        &xml_import ;
    }


#-----------------------------------------------
#  If the proposals need to be sorted overall,
#  sort them using a variation of VoteFair
#  ranking.
#  Also write the ranking results to the case file.
#  This is the core part of this software!!

    if ( $global_page_name eq "page-overall-ranked-proposals" )
#    if ( ( $global_page_name eq "page-overall-ranked-proposals" ) || ( $global_page_name eq "page-contract-wording" ) )
    {
        $global_log_output .= "<main>Sorting proposals<\/main>" ;
        &log_write ;
        &sort_proposals_overall ;
        $global_log_output .= "<main>Done sorting proposals<\/main>" ;
        &log_write ;


#-----------------------------------------------
#  If the voter-specific rankings are needed, get
#  them.
#  (These pages may be displayed after new information
#  has just been added or edited through a form.)

    } elsif ( ( $global_page_name eq "page-my-ranking" ) || ( $global_page_name eq "page-other-voter-ranked-proposals" ) || ( $global_page_name eq "page-move-my-proposal" ) || ( $global_page_name eq "page-move-other-voter-proposal" ) )
    {
        $global_log_output .= "<main>Getting voter-specific vote info<\/main>" ;
        &get_vote_info_voter_specific ;


#-----------------------------------------------
#  If the tie-break rankings are needed for
#  displaying the tie-break sequence, get them.

    } elsif ( ( $global_page_name eq "page-tie-break-ranked-proposals" ) || ( $global_page_name eq "page-move-tie-break-proposals" ) )
    {
        $global_log_output .= "<main>Getting tie-break rankings<\/main>" ;
        &sort_tie_resolution_ranking ;
        @global_list_of_proposal_ids_ranked_positive = @global_tie_break_rank_order_positive ;
        @global_list_of_proposal_ids_ranked_neutral = @global_tie_break_rank_order_neutral ;
        @global_list_of_proposal_ids_ranked_negative = @global_tie_break_rank_order_negative ;
        $global_log_output .= "<main>Back from getting tie-break rankings<\/main>" ;
    }


#-----------------------------------------------
#  If a ranking table is to be shown, generate
#  the replacements that contain the
#  ranking information.

    if ( &dashrep_get_replacement( "yes-lists-proposals-" . $global_page_name ) =~ /y/ )
    {
        $global_log_output .= "<main>Page lists proposals<\/main>" ;
        &proposal_ranking_elements_generate ;
    }


#-----------------------------------------------
#  If the home page is displayed, create a list
#  of recent changes.

    &dashrep_define( "list-of-recent-changes" , "" ) ;
    if ( $global_action_request eq "home" )
    {
        $global_log_output .= "<main>Getting recent changes<\/main>" ;
        &get_recent_changes ;
    }


#-----------------------------------------------
#  If proposal titles are to be displayed,
#  get the needed voter-specific alias titles.

    @list_of_page_names = &split_delimited_items_into_array( &dashrep_expand_parameters( "page-names-that-need-aliased-info" ) ) ;
    $global_log_output .= "<main>List of pages needing aliased titles: " . join( " , " , @list_of_page_names ) . "<\/main>" ;
    foreach $page_name ( @list_of_page_names )
    {
        if ( $global_page_name eq $page_name  )
        {
            &get_aliased_titles ;
            last ;
        }
    }


#-----------------------------------------------
#  If an email is to be sent, send it.

    if ( $global_action_request eq "getemailadmin" )
    {
        $global_log_output .= "<main>Need to send email<\/main>" ;
        &email_send ;
    }


#-----------------------------------------------
#  Specify the web page to display.

    &dashrep_define( "page-name" , $global_page_name ) ;
    $global_log_output .= "<main>Web page to display: " . $global_page_name . "<\/main>" ;
    if ( $global_page_name !~ /[a-z]/ )
    {
        $global_log_output .= "<main>No web page content<\/main>" ;
        $global_error_message .= "ERROR: No web page content.  Contact the website administrator for assistance." ;
#        &dashrep_get_replacement( "user-error-message-wording" ) .= " " . "words-major-error-message" ;
#        &dashrep_define( "button-go-back-to-action-list" , &dashrep_expand_parameters( "button-go-back-to-action-list-with-parameters" ) ) ;
        &error_check ;
    }
    &dashrep_define( "output-page-name" , $global_page_name ) ;
    $global_log_output .= "<main>Generating page named " . $global_page_name . "<\/main>" ;
    &dashrep_define( "web-page-content" , &dashrep_expand_parameters( $global_page_name ) ) ;
#    $global_log_output .= $global_temporary_log_output ;


#-----------------------------------------------
#  If an Access ID is needed, get it.

    if ( &dashrep_get_replacement( "admin-access-id-needed" ) =~ /y/ )
    {
        $global_log_output .= "<main>Need admin access ID<\/main>" ;
        $global_participant_id = $global_user_participant_id ;
        &access_id_get_for_participant ;
#        $global_log_output .= "<main>Access ID for participant " . $global_participant_id . " is " . &dashrep_get_replacement( "access-id-for-participantid-" . $global_participant_id ) . "<\/main>" ;
    }
    if ( &dashrep_get_replacement( "participant-access-id-needed" ) =~ /y/ )
    {
        $global_log_output .= "<main>Need participant access ID<\/main>" ;
        $global_participant_id = $global_input_participant_id ;
        &access_id_get_for_participant ;
#        $global_log_output .= "<main>Access ID for participant " . $global_participant_id . " is " . &dashrep_get_replacement( "access-id-for-participantid-" . $global_participant_id ) . "<\/main>" ;
    }
#    $global_log_output .= "<main>User Access ID is " . &dashrep_get_replacement( "output-access-id" ) . "<\/main>" ;


#-----------------------------------------------
#  If there are any selection ("radio") buttons,
#  mark the ones that indicate current values.

    $global_log_output .= "<main>Checking for need to mark radio buttons<\/main>" ;
    &form_mark_unmark_selection_buttons ;


#-----------------------------------------------
#  For debugging, identify any link that goes to
#  an action for which permission is denied.

    @debug_list_of_next_possible_actions = &split_delimited_items_into_array( &dashrep_get_replacement( "debugging-list-of-next-actions" ) ) ;
    &dashrep_define( "debug-list-of-non-permission-next-action-names" , "" ) ;
    foreach $action_name ( @debug_list_of_next_possible_actions )
    {
        if ( &dashrep_get_replacement( "yes-no-permission-for-action-" . $action_name ) !~ /y/ )
        {
            if ( &dashrep_get_replacement( "debug-list-of-non-permission-next-action-names" ) eq "" )
            {
                &dashrep_define( "debug-list-of-non-permission-next-action-names" , "paragraph-standard-begin" . "  " . "NO PERMISSION FOR ACTIONS: " ) ;
            }
            &dashrep_get_replacement( "debug-list-of-non-permission-next-action-names" ) .= $action_name . ", " ;
            $global_log_output .= "<main>DEBUG WARNING! Link to " . $action_name . " does not match permissions.<\/main>" ;
        } else
        {
            $global_log_output .= "<main>Link to " . $action_name . " matches permissions.<\/main>" ;
        }
    }
    if ( &dashrep_get_replacement( "debug-list-of-non-permission-next-action-names" ) ne "" )
    {
        &dashrep_define( "debug-list-of-non-permission-next-action-names" , " " ) . "paragraph-end" ;
    }


#-----------------------------------------------
#  In case it's needed for debugging, write
#  the collected log information to a file.

    $global_log_output .= "<main>Writing log information<\/main>" ;
    &log_elapsed_time ;
    &log_write ;
    &error_check ;


#-----------------------------------------------
#  For debugging, put into the log all the newly
#  created replacements.

    $global_log_output .= "<main>Logging new replacements<\/main>" ;
    &log_new_replacements ;


#-----------------------------------------------
#  If there is no web page content, handle this error.

    if ( &dashrep_get_replacement( "web-page-content" ) =~ /^ *$/s )
    {
        $global_log_output .= "<main>No web page content<\/main>" ;
        $global_error_message .= "ERROR: No web page content.  Contact the website administrator for assistance." ;
        &log_write ;
        &error_check ;
    }


#-----------------------------------------------
#  If there was a user error, put it into the top
#  of the web page.

    if ( $global_user_error_message ne "" )
    {
        $global_log_output .= "<main>User error string is not empty<\/main>" ;
        &dashrep_get_replacement( "user-error-message-wording" ) .= " " . $global_user_error_message ;
    }
    if ( &dashrep_get_replacement( "user-error-message-wording" ) ne "" )
    {
        $global_log_output .= "<main>Getting user error message<\/main>" ;
        &dashrep_define( "possible-user-error-message" , "user-error-message" ) ;
    }


#-----------------------------------------------
#  If there are any warning messages, put them at
#  the top of the web page.

    if ( $global_warning_message =~ /[^ ]/ )
    {
        $global_log_output .= "<main>Warning message string is not empty<\/main>" ;
        $warning_message = "warning-message-prefix\n" . $global_warning_message . "\nwarning-message-suffix" . &dashrep_get_replacement( "web-page-content" ) . "\n"
        &dashrep_define( "web-page-content" , $warning_message ) ;
    }


#-----------------------------------------------
#  Generate a results web page by doing the
#  replacements specified in the replacements file.

    $global_log_output .= "<main>Generating web page<\/main>" ;
    $global_html_code = &dashrep_expand_phrases( $global_phrase_referring_to_entire_web_page ) ;


#-----------------------------------------------
#  Handle end-of-line replacements separately.

    $global_html_code =~ s/<eol \/>/\n/sg ;


#-----------------------------------------------
#  Handle exported XML specially so it doesn't
#  lose the line spacing and indentation.

    if ( $global_html_code =~ /^(.*)texttoexport(.*)$/s )
    {
        $prefix = $1 ;
        $suffix = $2 ;
        $global_html_code = $prefix . $global_text_to_export . $suffix ;
        $global_log_output .= "<main>Inserted text to export: " . $global_text_to_export . "<\/main>" ;
    }


#-----------------------------------------------
#  Send the generated web page to the
#  browser.

    print $global_possible_cgi_heading ;
    print $global_html_code ;


#-----------------------------------------------
#  Write the log file.

    $global_log_output .= "[\/GenNegLog]" ;
    &log_write ;


#-----------------------------------------------
#  End of main subroutine.

}

