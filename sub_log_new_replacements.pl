#-----------------------------------------------
#-----------------------------------------------
#         log_new_replacements
#-----------------------------------------------
#-----------------------------------------------
#  For debugging, put into the log all the newly
#  created replacements.


sub log_new_replacements
{


#-----------------------------------------------
#  Put into the log all the newly created
#  replacements, but don't list the ones that
#  are defined in the standard replacements file.

    $global_log_output .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
    $global_log_output .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
    $global_log_output .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
    $global_log_output .= "<lognewrepl>Newly created replacements:<\/lognewrepl>" ;

    foreach $replacement_name ( @global_list_of_standard_replacement_names )
    {
        $do_not_log_replacement{ $replacement_name } =  "yes" ;
#        $global_log_output .= "<lognewrepl>Standard replacement: " . $replacement_name . "<\/lognewrepl>" ;
    }

    $do_not_log_replacement{ "input-xmlraw" } =  "yes" ;
    $do_not_log_replacement{ "variable-xml-info" } =  "yes" ;
    $do_not_log_replacement{ "comments_ignored" } =  "yes" ;
    $do_not_log_replacement{ "list-of-action-buttons" } =  "yes" ;

    $do_not_log_replacement{ "entire-standard-web-page" } =  "no" ;
    $do_not_log_replacement{ "test-version" } = "no" ;
    $do_not_log_replacement{ "cgi-version" } = "no" ;
    $do_not_log_replacement{ "cgi-votefair-negotiation-tool" } = "no" ;
    $do_not_log_replacement{ "cgi-votefair-negotiation-tool-test-version" } = "no" ;
    $do_not_log_replacement{ "user-instructions" } =  "yes" ;

    @list_of_phrases = &dashrep_get_list_of_phrases ;
#    $global_log_output .= "<lognewrepl>List of phrases: " . join( " , " , @list_of_phrases ) . "<\/lognewrepl>" ;

    foreach $replacement_name ( sort( @list_of_phrases ) )
    {
        if ( ( $replacement_name =~ /-list-named-/ ) || ( $replacement_name =~ /^words?-/ ) || ( $do_not_log_replacement{ $replacement_name } ne "yes" ) )
        {
            $global_log_output .= "<lognewrepl>" . $replacement_name . 
" = " . &dashrep_get_replacement( $replacement_name ) . "<\/lognewrepl>" ;
        }
    }


#-----------------------------------------------
#  End of subroutine.

    $global_log_output .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
    $global_log_output .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;

}

