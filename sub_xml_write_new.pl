#-----------------------------------------------
#-----------------------------------------------
#            xml_write_new
#-----------------------------------------------
#-----------------------------------------------
#  Write any new XML data to the appropriate
#  case-information file(s).
#
#  Later, increase speed for large cases by storing
#  incompatibility information in a separate file,
#  and storing participant rankings in a separate file.
#  Do selection based on level-one tag names.
#
#  For now, put all case information into the main file.


sub xml_write_new
{


#-----------------------------------------------
#  Begin a loop that handles each of the
#  case-information file types.

    foreach $case_info_file_type ( "main" , "statements" )
    {
        $global_log_output .= "<xmlwrite>Checking case info type " . $case_info_file_type . "<\/xmlwrite>" ;


#-----------------------------------------------
#  Get the file type's list of new replacement names.

        @replacements_with_new_xml = &split_delimited_items_into_array( &dashrep_get_replacement( "list-of-xml-code-of-type-" . $case_info_file_type ) ) ;
        $global_log_output .= "<xmlwrite>List of replacements to write: " . join( "  " , @replacements_with_new_xml ) . "<\/xmlwrite>" ;


#-----------------------------------------------
#  If there is any XML code to write for this file
#  type, write it.
#  Also include the date and time and
#  action-log name -- except at the beginning of
#  a file.

        if ( $#replacements_with_new_xml >= 0 )
        {
            $global_content_to_append_to_file = "" ;
            &dashrep_define( "xml-date-time" , "<writetime><date>" . $global_date . "<\/date><time>" . $global_hour_minute . "</time><ipaddress>" . $global_ip_address . " </ipaddress></writetime>" ) ;
            if ( $replacements_with_new_xml[ 0 ] !~ /<\?xml / )
            {
                unshift ( @replacements_with_new_xml , "xml-date-time" ) ;
                unshift ( @replacements_with_new_xml , "xml-logged-action-name" ) ;
            }

            while ( $#replacements_with_new_xml >= 0 )
            {
                $xml_code_replacement_name = shift( @replacements_with_new_xml ) ;
                $xml_code = &dashrep_get_replacement( $xml_code_replacement_name ) ;
                $xml_code =~ s/^ +// ;
                $xml_code =~ s/\n +/\n/gs ;
                $global_content_to_append_to_file .= $xml_code . "\n" ;
                $global_log_output .= "<xmlwrite>Wrote replacement named " . $xml_code_replacement_name . "<\/xmlwrite>" ;
            }

            $global_filename = $global_case_filename_prefix . $global_case_number . "-" . $case_info_file_type . $global_case_filename_suffix ;

            &file_append ;
        }


#-----------------------------------------------
#  Repeat the loop for the next file type.

    }


#-----------------------------------------------
#  End of subroutine.

}

