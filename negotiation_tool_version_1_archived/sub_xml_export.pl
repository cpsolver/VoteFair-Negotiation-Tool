#-----------------------------------------------
#-----------------------------------------------
#            xml_export
#-----------------------------------------------
#-----------------------------------------------
#  Generate the export web page.


sub xml_export
{


#-----------------------------------------------
#  Get the XML code from the case file.

    $global_filename = $global_case_description_filename ;
    $global_log_output .= "<export>Filename: " . $global_filename . "<\/export>" ;
    &file_read ;
    $text_read = $global_content_read_from_file ;
    &error_check ;


#-----------------------------------------------
#  Later, write code to eliminate duplicate
#  information.

# ...


#-----------------------------------------------
#  Put the XML code into a special variable --
#  which will be put into a box within the web page.
#  It can't be a replacement because it would lose
#  the line break positions.

    $global_text_to_export = &dashrep_get_replacement( "xml-template-begin" ) . $text_read . &dashrep_get_replacement( "xml-template-end" ) ;


#-----------------------------------------------
#  End of subroutine.

}

