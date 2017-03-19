#-----------------------------------------------
#-----------------------------------------------
#            error_check
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that checks for an error and
#  reports it if encountered.

sub error_check
{

#-----------------------------------------------
#  If an endless loop occurs, display a simple
#  web page, write the log contents, then stop
#  the program.

    $global_endless_loop_counter ++ ;
    $global_log_output .= "<errorcheck>Endless loop counter = " . $global_endless_loop_counter . "<\/errorcheck>" ;
    if ( $global_endless_loop_counter > $global_endless_loop_counter_limit )
    {
        $global_error_message .= "ERROR: Endless loop encountered!\n" ;
        $global_log_output .= "<error>" . $global_error_message . "<\/error>" ;
        &log_write ;
#  Already displayed error page and exited from log_write subroutine, but just in case:
        die ;
    }


#-----------------------------------------------
#  If there has been no error, return.

    if ( $global_error_message !~ /[^ ]/ )
    {
#        $global_log_output .= "<errorcheck>No error, so continuing.<\/errorcheck>" ;
        return ;
    }


#-----------------------------------------------
#  Write the log file.

    $global_log_output .= "<errorcheck>Error message detected<\/errorcheck>" ;
    $global_log_output .= "<error>" . $global_error_message . "<\/error>" ;
    &log_write ;


#-----------------------------------------------
#  Generate an error-message page.

    $global_phrase_referring_to_entire_web_page = "entire-standard-web-page" ;
    &dashrep_define( "web-page-content" , "page-content-for-error-page" ) ;
    &dashrep_define( "error-message" , $global_error_message ) ;
    &dashrep_define( "javascript-in-heading" , "" ) ;
    if ( &dashrep_get_replacement( "words-copyright-notice" ) !~ /[^ ]/ )
    {
        $language_choice = &dashrep_get_replacement( "case-info-language" ) ;
        $language_choice =~ s/ //g ;
        if ( $language_choice !~ /[^ ]/ )
        {
            $language_choice = "en" ;
        }
        $global_filename = $global_language_specific_replacements_filename_prefix . $language_choice . $global_language_specific_replacements_filename_suffix ;
        $global_filename = $global_standard_replacements_filename ;
        &file_read ;
        &dashrep_read_definitions( $global_content_read_from_file ) ;
    }
    $global_html_code = &dashrep_expand_phrases( $global_phrase_referring_to_entire_web_page ) ;
    print $global_possible_cgi_heading ;
    print $global_html_code ;


#-----------------------------------------------
#  Stop execution.  Exit program.

    die ;

}

