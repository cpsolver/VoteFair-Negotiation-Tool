#-----------------------------------------------
#-----------------------------------------------
#             xml_import
#-----------------------------------------------
#-----------------------------------------------
#  Imports from the "import" web page the case
#  information supplied as XML.

sub xml_import
{


#-----------------------------------------------
#  Check if any new info was added to the file
#  -- by another participant -- since the exporting
#  was done.
#  Perhaps insert an "export-here" tag in the file
#  and confirm no additions.

#  Write this code later.


#-----------------------------------------------
#  Put all the old description information
#  into an archive file.

    &get_case_info_filename ;
    $global_filename = $global_case_description_filename ;
    &file_read ;

    $global_content_to_append_to_file = $global_content_read_from_file ;

    $global_filename = $global_archive_filename_prefix . $global_case_number . "-" . $global_date . $global_archive_filename_suffix ;
    &file_append ;
    if ( $global_error_message ne "" )
    {
        $global_log_output .= "<import>Ignoring this error message: " . $global_error_message . "<\/import>" ;
        $global_error_message = "" ;
    }


#-----------------------------------------------
#  Get the XML data.

    $global_log_output .= "<import>Importing XML supplied by participant<\/import>" ;
    &dashrep_define( "input-xmlraw" , &dashrep_get_replacement( "input-texttoimport" ) ) ;
    $xml_input = &dashrep_get_replacement( "input-xmlraw" ) ;


#-----------------------------------------------
#  Strip the outer unneeded tags, then wrap in
#  the correct tags.

    $xml_import =~ s/<xmlraw>//sg ;
    $xml_import =~ s/<\/?xmlraw>//sg ;
    $xml_import =~ s/<votefairnegotiationvoting>//sg ;
    $xml_import =~ s/<\/?votefairnegotiationvoting>//sg ;
    $xml_import =~ s/^ +//sg ;
    $xml_import =~ s/ +$//sg ;
    $xml_import = &dashrep_get_replacement( "xml-template-begin" ) . $xml_import . &dashrep_get_replacement( "xml-template-end" ) ;


#-----------------------------------------------
#  Validate the XML code.

#  Write this code later.


#-----------------------------------------------
#  Write the imported XML-formatted case info.

    $global_filename = $global_case_description_filename ;
    $global_content_to_append_to_file = $xml_input ;
    &file_overwrite ;


#-----------------------------------------------
#  Indicate done.

    $global_log_output .= "<import>Done importing XML.<\/import>" ;


#-----------------------------------------------
#  End of subroutine.

}

