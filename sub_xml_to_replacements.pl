#-----------------------------------------------
#-----------------------------------------------
#             xml_to_replacements
#-----------------------------------------------
#-----------------------------------------------
#  Converts XML info into replacements.

sub xml_to_replacements
{


#-----------------------------------------------
#  Get the XML.

    $xml_input = $global_xml_input ;
    $xml_input =~ s/[\n\r]+/ /gs ;


#-----------------------------------------------
#  Identify which tags are level-one tags.

    @list_of_level_one_tag_names = &split_delimited_items_into_array( &dashrep_get_replacement( "list-of-level-one-tag-names" ) ) ;
    foreach $tag_name_at_level_one ( @list_of_level_one_tag_names )
    {
#        $global_log_output .= "<replfromxml>ID type tag name:  " . $tag_name_at_level_one . "<\/replfromxml>" ;
        $true_is_level_one_tag_name{ $tag_name_at_level_one } = $global_true ;
    }


#-----------------------------------------------
#  Identify which tags have level-two tags but
#  without an ID number.

    @list_of_level_two_no_id_tag_names = &split_delimited_items_into_array( &dashrep_get_replacement( "list-of-templates-with-second-level-elements-but-no-id" ) ) ;
    foreach $tag_name_at_level_two ( @list_of_level_two_no_id_tag_names )
    {
#        $global_log_output .= "<replfromxml>Non-ID type tag name:  " . $tag_name_at_level_two . "<\/replfromxml>" ;
        $true_is_level_two_no_id_tag_name{ $tag_name_at_level_two } = $global_true ;
    }


#-----------------------------------------------
#  Identify the tags for which accumulation is
#  done, and clear any accumulated text.

    @list_of_template_types_to_accumulate = &split_delimited_items_into_array( &dashrep_get_replacement( "list-of-templates-types-to-accumulate-xml" ) ) ;
    foreach $tag_name_to_accumulate ( @list_of_template_types_to_accumulate )
    {
        &dashrep_define( "accumulate-xml-for-tag-" . $tag_name_to_accumulate , "yes" ) ;
        &dashrep_define( "case-info-" . $tag_name_to_accumulate , "" ) ;
    }


#-----------------------------------------------
#  Allow tracking new replacements.

    @list_of_all_phrases_at_start = &dashrep_get_list_of_phrases( ) ;
    $global_log_output .= "<replfromxml>There are " . ( $#list_of_all_phrases_at_start + 1 ) . " phrases at beginning of subroutine.<\/replfromxml>" ;


#-----------------------------------------------
#  Begin a loop that repeats for each XML tag.

    $level_number = 0 ;
    @tag_name_at_level_number = ( ) ;
    while ( $xml_input =~ /^([^<>]*)<(\/?)([^>]+)>(.*)$/ )
    {
        $text_between_tags = $1 ;
        $possible_slash = $2 ;
        $current_tag_name = $3 ;
        $xml_input = $4 ;
        if ( $possible_slash eq '/' )
        {
            $close_tag_type = $global_true ;
        } else
        {
            $close_tag_type = $global_false ;
        }


#-----------------------------------------------
#  Ignore the opening XML-standard-required
#  declarations.

        if ( $current_tag_name =~ /^((\?xml )|(.DOCTYPE ))/ )
        {
            $global_log_output .= "<replfromxml>Ignoring tag:  " . $current_tag_name . "<\/replfromxml>" ;
            next ;
        }


#-----------------------------------------------
#  Begin to handle an open tag.

        if ( $close_tag_type == $global_false )
        {
            $open_tag_name = $current_tag_name ;
#            $global_log_output .= "<replfromxml>Open tag:  " . $open_tag_name . "<\/replfromxml>" ;
            $level_number ++ ;


#-----------------------------------------------
#  If this is a level-one tag, start
#  fresh in collecting XML code.

            if ( $true_is_level_one_tag_name{ $open_tag_name } == $global_true )
            {
                $level_number = 1 ;
                $tag_name_at_level_number[ $level_number ] = $open_tag_name ;
                &dashrep_define( "xml-content-" . $open_tag_name , "" ) ;
                @list_of_level_two_tag_names = ( ) ;


#-----------------------------------------------
#  If this level-one open tag is identified as one
#  that should be accumuated (and parsed later),
#  collect/accumulate the XML up to the paired
#  (level-one) closing tag in a collection
#  replacement.

                if ( &dashrep_get_replacement( "accumulate-xml-for-tag-" . $open_tag_name ) =~ /y/ )
                {
                    &dashrep_define( "case-info-" . $open_tag_name , &dashrep_get_replacement( "case-info-" . $open_tag_name ) . "<" . $open_tag_name . ">" ) ;
#                    $global_log_output .= "<replfromxml>Accumulating XML:  " . $open_tag_name . "<\/replfromxml>" ;
                    $loop_continue = $global_true ;
                    while ( $loop_continue == $global_true )
                    {
#                        $global_log_output .= "<replfromxml>Accumulating from:  " . $xml_input . "<\/replfromxml>" ;
                        if ( $xml_input =~ /^(.*?)(<\/([^\/>]+)>)(.+)$/ )
                        {
                            $text_between_tags = $1 ;
                            $closing_tag = $2 ;
                            $closing_tag_name = $3 ;
                            $xml_input = $4 ;
                            &dashrep_define( "case-info-" . $open_tag_name , &dashrep_get_replacement( "case-info-" . $open_tag_name ) . $text_between_tags . $closing_tag ) ;
#                            $global_log_output .= "<replfromxml>Accumulated XML:  " . $text_between_tags . $closing_tag . "<\/replfromxml>" ;
                            if ( $closing_tag_name eq $open_tag_name )
                            {
                                $loop_continue = $global_false ;
                            }
                        } else
                        {
                            $loop_continue = $global_false ;
                        }
                    }
                }


#-----------------------------------------------
#  Finish handling open tags.

            }


#-----------------------------------------------
#  Begin to handle a close tag, 

        } else
        {
            $close_tag_name = $current_tag_name ;
#            $global_log_output .= "<replfromxml>Close tag:  " . $close_tag_name . "<\/replfromxml>" ;


#-----------------------------------------------
#  Save the content within the matching tags.

            &dashrep_define( "xml-content-" . $close_tag_name , $text_between_tags ) ;
#            $global_log_output .= "<replfromxml>Within tags named  " . $close_tag_name . "  XML content is  " . $text_between_tags . "<\/replfromxml>" ;


#-----------------------------------------------
#  If this close tag is at level two, store its
#  name.

            if ( $level_number == 2 )
            {
                push( @list_of_level_two_tag_names , $close_tag_name ) ;


#-----------------------------------------------
#  Begin to handle a closing tag at level one.

            } elsif ( $level_number == 1 )
            {
                $level_one_tag_name = $tag_name_at_level_number[ $level_number ] ;
#                $global_log_output .= "<replfromxml>Close tag is at level one<\/replfromxml>" ;
                $unique_id_name = &dashrep_get_replacement( "unique-id-name-for-tag-" . $level_one_tag_name ) ;
                $inverse_unique_id_name = &dashrep_get_replacement( "inverse-unique-id-name-for-tag-" . $level_one_tag_name ) ;
                $true_has_non_id_level_two = $true_is_level_two_no_id_tag_name{ $level_one_tag_name  } ;


#-----------------------------------------------
#  If there are no level two tags, create the
#  replacement using just the level one tag name.

                if ( ( $unique_id_name !~ /[^ ]/ ) && ( $true_has_non_id_level_two == $global_false ) )
                {
                    $replacement_name = "case-info-" . $level_one_tag_name ;
                    $replacement_value = &dashrep_get_replacement( "xml-content-" . $level_one_tag_name ) ;
                    if ( $level_one_tag_name =~ /[^ ]/ )
                    {
                        &dashrep_define( $replacement_name , $replacement_value ) ;
#                        $global_log_output .= "<replfromxml>Level-one replacement name is " . $replacement_name . " and value is " . $replacement_value . "<\/replfromxml>" ;
                    }


#-----------------------------------------------
#  If there are level two tags but no ID number,
#  create the appropriate replacements.

                } elsif ( $true_has_non_id_level_two == $global_true )
                {
                    foreach $level_two_tag_name ( @list_of_level_two_tag_names )
                    {
#                        $global_log_output .= "<replfromxml>Level-two tag name is " . $level_two_tag_name . "<\/replfromxml>" ;
                        $replacement_value = &dashrep_get_replacement( "xml-content-" . $level_two_tag_name ) ;
                        $replacement_name = $level_one_tag_name . "-" . $level_two_tag_name ;
                        if ( $replacement_name =~ /[^ ]/ )
                        {
                            &dashrep_define( $replacement_name , $replacement_value ) ;
#                            $global_log_output .= "<replfromxml>Level-two replacement name is " . $replacement_name . " and value is " . $replacement_value . "<\/replfromxml>" ;
                        }
                    }


#-----------------------------------------------
#  There are ID-number-based level-two tags,
#  so get the name of the unique ID number,
#  and use it in the name of each replacement
#  that stores each of the other
#  level-two-tag-based values.

                } else
                {
                    foreach $level_two_tag_name ( @list_of_level_two_tag_names )
                    {
#                        $global_log_output .= "<replfromxml>Level-two tag name is " . $level_two_tag_name . "<\/replfromxml>" ;
                        $replacement_value = &dashrep_get_replacement( "xml-content-" . $level_two_tag_name ) ;
                        if ( $level_two_tag_name ne $unique_id_name )
                        {
                            $replacement_name = $level_one_tag_name . "-" . $level_two_tag_name . "-for-" . $unique_id_name . "-" . &dashrep_get_replacement( "xml-content-" . $unique_id_name ) ;
                            if ( $replacement_name =~ /[^ ]/ )
                            {
                                &dashrep_define( $replacement_name , $replacement_value ) ;
#                                $global_log_output .= "<replfromxml>Level-two replacement name is " . $replacement_name . " and value is " . $replacement_value . "<\/replfromxml>" ;
                            }
                        } elsif ( $inverse_unique_id_name =~ /[^ ]/ )
                        {
                            $replacement_name = $level_one_tag_name . "-" . $unique_id_name . "-for-" . $inverse_unique_id_name . "-" . &dashrep_get_replacement( "xml-content-" . $inverse_unique_id_name ) ;
                            &dashrep_define( $replacement_name , $replacement_value ) ;
#                            $global_log_output .= "<replfromxml>Inverse replacement name is " . $replacement_name . " and value is " . $replacement_value . "<\/replfromxml>" ;

                        }
                    }


#-----------------------------------------------
#  Finish handling a close tag at level one.

                }
            }


#-----------------------------------------------
#  Finish handling a close tag.

            $level_number -- ;
        }


#-----------------------------------------------
#  Repeat the loop for the next tag.

    }


#-----------------------------------------------
#  Log the new replacements.

    @list_of_all_phrases_at_end = &dashrep_get_list_of_phrases( ) ;
    $global_log_output .= "<replfromxml>There are " . ( $#list_of_all_phrases_at_end + 1 ) . " phrases at end of subroutine.<\/replfromxml>" ;
    if ( &dashrep_get_replacement( "cgi-version" ) eq "cgi-yes" )
    {
        %phrase_already_existed = ( ) ;
        foreach $phrase ( @list_of_all_phrases_at_start )
        {
            $phrase_already_existed{ $phrase } = $global_true ;
#            $global_log_output .= "<replfromxml>Pre-existing phrase: " . $phrase . "<\/replfromxml>" ;
        }
        foreach $phrase ( @list_of_all_phrases_at_end )
        {
            if ( $phrase_already_existed{ $phrase } != $global_true )
            {
                $replacement_value = &dashrep_get_replacement( $phrase ) ;
                $global_log_output .= "<replfromxml>" . $phrase . "\n\n" . $replacement_value . "\n---------------\n\n<\/replfromxml>" ;
            }
        }
    }


#-----------------------------------------------
#  End of subroutine.

}

