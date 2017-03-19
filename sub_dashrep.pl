#-----------------------------------------------
#  This code was copied on 2009-March-3 from the
#  a draft version of the code being created for
#  the CPAN Archive.  In turn, that code was
#  extracted from this NegotiationTool software,
#  and then modified for use by others.
#-----------------------------------------------



#-----------------------------------------------
#-----------------------------------------------
#        Dashrep (TM) language implementation
#-----------------------------------------------
#-----------------------------------------------

#-------------------------------------------
#  Details about the Dashrep language are
#  documented at: www.Dashrep.org
#
#  The Dashrep (TM) language is in the public
#  domain.
#
#  The name Dashrep is trademarked by
#  Richard Fobes at www.SolutionsCreative.com
#  to prevent the name from being co-opted.
#-------------------------------------------




#-----------------------------------------------
#-----------------------------------------------
#                 dashrep_define
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine assigns a replacement for a
#  specified hyphenated phrase.

#  The dashrep_define subroutine associates a
#  replacement text string with the specified
#  hyphenated phrase.
#  First parameter is the hyphenated phrase.
#  Second parameter is its replacement text
#  string.
#  Return value is 1 if the definition was
#  successful.  Return value is zero if there
#  are not exactly two parameters.

sub dashrep_define
{

    my ( $phrase_name ) ;
    my ( $expanded_text ) ;


#-----------------------------------------------
#  Do the assignment.

#     if ( scalar( @_ ) == 2 )
#     {
        $phrase_name = $_[ 0 ] ;
        $expanded_text = $_[ 1 ] ;
        $phrase_name =~ s/^ +// ;
        $phrase_name =~ s/ +$// ;
        $dashrep_replacement{ $phrase_name } = $expanded_text ;
#     } else
#     {
#         warn "Warning: Call to dashrep_define subroutine does not have exactly two parameters." ;
#         return 0 ;
#     }


#-----------------------------------------------
#  End of subroutine.

    return 1 ;

}

#-----------------------------------------------
#-----------------------------------------------
#                dashrep_import_replacements
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine reads replacement definitions
#  from text written in the Dashrep language.

#  The dashrep_import_replacements subroutine
#  parses a text string that is written in the
#  Dashrep language.  Often the text string is
#  the content of a text file.  The text
#  specifies the replacement text strings for
#  specified hyphenated phrases.
#  First, and only, parameter is the text
#  string that uses the Dashrep language.
#  Return value is an array that lists the
#  hyphenated phrases that were defined (or]
#  redefined).  Return value is zero if there
#  is not exactly one parameter.

sub dashrep_import_replacements
{

    my ( $definition_name ) ;
    my ( $definition_value ) ;
    my ( $input_string ) ;
    my ( $replacements_text_to_import ) ;
    my ( $text_before ) ;
    my ( $text_including_comment_end ) ;
    my ( $text_after ) ;
    my ( $do_nothing ) ;
    my ( $temporary_string ) ;
    my ( @list_of_replacement_names ) ;
    my ( @list_of_replacement_strings ) ;


#-----------------------------------------------
#  Get the text that contains replacement
#  definitions.

#     if ( scalar( @_ ) == 1 )
#     {
        $replacements_text_to_import = $_[ 0 ] ;
#     } else
#     {
#         warn "Warning: Call to dashrep_define subroutine does not have exactly one parameter." ;
#         return 0 ;
#     }


#-----------------------------------------------
#  Initialization.

    @list_of_replacement_names = ( ) ;


#-----------------------------------------------
#  Replace line breaks with spaces.

    $replacements_text_to_import =~ s/[\n\r]/ /sg ;
    $replacements_text_to_import =~ s/[\n\r]/ /sg ;
    $replacements_text_to_import =~ s/  +/ /sg ;


#-----------------------------------------------
#  Ignore comments that consist of, or are embedded
#  in, strings of the following type: *------  -------*

    $replacements_text_to_import =~ s/\*\-\-\-+\*/ /g ;
    while ( $replacements_text_to_import =~ /^(.*?)(\*\-\-+)(.*)$/ )
    {
        $text_before = $1 ;
        $dashrep_replacement{ "comments_ignored" } .= "  " . $2 ;
        $text_including_comment_end = $3 ;
        $text_after = "" ;
        if ( $text_including_comment_end =~ /^(.*?\-\-+\*)(.*)$/ )
        {
            $dashrep_replacement{ "comments_ignored" } .= $1 . "  " ;
            $text_after = $2 ;
        }
        $replacements_text_to_import = $text_before . " " . $text_after ;
    }


#-----------------------------------------------
#  Split the replacement text at spaces,
#  and put the strings into an array.

    $replacements_text_to_import =~ s/  +/ /g ;
    @list_of_replacement_strings = split( / / , $replacements_text_to_import ) ;


#-----------------------------------------------
#  Read and handle each item in the array.

    $definition_name = "" ;
    foreach $input_string ( @list_of_replacement_strings )
    {
        if ( $input_string =~ /^ *$/ )
        {
            $do_nothing ++ ;


#-----------------------------------------------
#  Ignore the "define-begin" directive.

        } elsif ( $input_string eq 'define-begin' )
        {
            $do_nothing ++ ;


#-----------------------------------------------
#  When the "define-end" directive, or a series
#  of at least 3 dashes ("--------"), is encountered,
#  clear the definition name.
#  Also remove trailing spaces from the previous
#  replacement.

        } elsif ( ( $input_string eq 'define-end' ) || ( $input_string =~ /^---+$/ ) )
        {
            $definition_value = $dashrep_replacement{ $definition_name } ;
            $definition_value =~ s/ +$// ;
            if ( $definition_value =~ /[^ \n\r]/ )
            {
                $dashrep_replacement{ $definition_name } = $definition_value ;
            } else
            {
                $dashrep_replacement{ $definition_name } = "" ;
            }
            $definition_name = "" ;


#-----------------------------------------------
#  Get a definition name.
#  Allow a colon after the hyphenated name.
#  If this definition name has already been defined,
#  ignore the earlier definition.

        } elsif ( $definition_name eq "" )
        {
            $definition_name = $input_string ;
            $definition_name =~ s/\:$//  ;
            $dashrep_replacement{ $definition_name } = "" ;
            push( @list_of_replacement_names , $definition_name ) ;


#-----------------------------------------------
#  Collect any text that is part of a definition.

        } elsif ( $input_string ne "" )
        {
            if ( $input_string eq $definition_name )
            {
                 $dashrep_replacement{ $definition_name } = "ERROR: Replacement for hyphenated phrase [" . $definition_name . "] includes itself, which would cause an endless replacement loop." . "\n" ;
                $global_log_output .= "<dashrep>Warning: Replacement for hyphenated phrase " . $definition_name . " includes itself, which would cause an endless replacement loop." . "\n" . "<\/dashrep>" ;
            } else
            {
                $dashrep_replacement{ $definition_name } = $dashrep_replacement{ $definition_name } . $input_string . "  " ;
            }
        }


#-----------------------------------------------
#  Repeat the loop for the next string.

    }


#-----------------------------------------------
#  End of subroutine.

    return $#list_of_replacement_names + 1 ;

}

#-----------------------------------------------
#-----------------------------------------------
#                 dashrep_get_replacement
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine gets the definition of a
#  hyphenated phrase.

#  The dashrep_get_replacement subroutine returns
#  the replacement text string that is associated
#  with the specified hyphenated phrase.
#  First, and only, parameter is the hyphenated
#  phrase.
#  Return value is the replacement string that
#  is associated with the specified hyphenated
#  phrase.  Return value is zero if there
#  is not exactly one parameter.

sub dashrep_get_replacement
{

    my ( $phrase_name ) ;
    my ( $expanded_text ) ;


#-----------------------------------------------
#  Get the name of the hyphenated phrase.

    if ( scalar( @_ ) == 1 )
    {
        $phrase_name = $_[ 0 ] ;
    } else
    {
        return 0 ;
    }


#-----------------------------------------------
#  Get the replacement text that is associated
#  with the hyphenated phrase.

    $expanded_text = $dashrep_replacement{ $phrase_name } ;


#-----------------------------------------------
#  End of subroutine.

    return $expanded_text ;

}

#-----------------------------------------------
#-----------------------------------------------
#           dashrep_get_list_of_phrases
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine gets a list of all the
#  hyphenated phrases that have been defined.

#  The dashrep_get_list_of_phrases subroutine
#  returns an array that lists all the
#  hyphenated phrases that have been defined
#  so far.
#  There are no parameters.
#  Return value is an array that lists all the
#  hyphenated phrases that have been defined.
#  Return value is zero if there is not exactly
#  zero parameters.

sub dashrep_get_list_of_phrases
{

    my ( @list_of_phrases ) ;

#     if ( scalar( @_ ) != 0 )
#     {
#         warn "Warning: Call to dashrep_define subroutine does not have exactly zero parameters." ;
#         return 0 ;
#     }

    @list_of_phrases = keys( %dashrep_replacement ) ;
    return @list_of_phrases ;

}


#-----------------------------------------------
#-----------------------------------------------
#       dashrep_expand_parameters
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine expands the replacement text
#  for the specified hyphenated phrase.  The
#  replacement text is expected to contain
#  parameter-based replacements, which are in
#  brackets.  Only the parameterized phrases
#  (not the other hyphenated phrases) are
#  expanded.

#  The dashrep_expand_parameters subroutine
#  parses a text string that is written in the
#  Dashrep language and handles parameter
#  replacements and special operations (which
#  must be within "[- ... -]" text strings.
#  Any hyphenated phrases that do not appear
#  withing the square-bracket pattern are
#  not replaced.  (They must be replaced using
#  either the dashrep_expand_phrases or
#  dashrep_expand_phrases_except_special
#  subroutine.
#  First, and only, parameter is the hyphenated
#  phrase that is expanded.
#  Return value is the text string associated
#  with the specified hyphenated phrase, after
#  that text string has had its parameters
#  expanded.  Return value is zero if there
#  is not exactly one parameter.

sub dashrep_expand_parameters
{

    my ( $replacement_text_name ) ;
    my ( $replacement_text ) ;
    my ( $loop_status_done ) ;
    my ( $text_begin ) ;
    my ( $text_parameter_name ) ;
    my ( $text_parameter_value ) ;
    my ( $text_end ) ;
    my ( $action_name ) ;
    my ( $object_of_action ) ;
    my ( $count ) ;
    my ( $zero_one_multiple ) ;
    my ( $empty_or_nonempty ) ;
    my ( $full_length ) ;
    my ( $length_half ) ;
    my ( $string_beginning ) ;
    my ( $string_end ) ;
    my ( $same_or_not_same ) ;
    my ( $sorted_numbers ) ;
    my ( $text_parameter_placeholder ) ;
    my ( $text_parameter ) ;
    my ( $item_name ) ;
    my ( $name_for_count ) ;
    my ( @list ) ;
    my ( @list_of_sorted_numbers ) ;
    my ( @list_of_replacements_to_auto_increment ) ;
    my ( %replacement_count_for_item_name ) ;


#-----------------------------------------------
#  Get the hyphenated phrase.

    if ( scalar( @_ ) == 1 )
    {
        $replacement_text_name = $_[ 0 ] ;
    } else
    {
        return 0 ;
    }


#-----------------------------------------------
#  Get its associated replacement text.

    $replacement_text = $dashrep_replacement{ $replacement_text_name } ;


#-----------------------------------------------
#  Initialize the list of replacement names
#  encountered that need to be auto-incremented.

    @list_of_replacements_to_auto_increment = ( ) ;


#-----------------------------------------------
#  Begin a loop that repeats until there have
#  been no more replacements.

    $loop_status_done = $global_false ;
    while ( $loop_status_done == $global_false )
    {
        $loop_status_done = $global_true ;


#-----------------------------------------------
#  If there are any parameter values specified
#  within the replacement, assign those
#  replacements.
#
#  Problems will arise if the parameter value
#  contains a space, bracket, colon, or equal
#  sign, but in those cases just specify a
#  replacement name instead of the value of
#  that replacement.

        while ( $replacement_text =~ /^(.*?)\[\-([^ \n\[\]\:=]+) *= *([^ \n\[\]\:=]+) *-?\](.*)$/ )
        {
            $text_begin = $1 ;
            $text_parameter_name = $2 ;
            $text_parameter_value = $3 ;
            $text_end = $4 ;
            $text_parameter_value =~ s/\-+$// ;
            if ( length( $text_parameter_name ) > 0 )
            {
                $dashrep_replacement{ $text_parameter_name } = $text_parameter_value ;
            } else
            {
            }
            $replacement_text = $text_begin . " " . $text_end ;
            $loop_status_done = $global_false ;
            if ( length( $text_parameter_name ) > 0 )
            {
                $replacement_count_for_item_name{ $text_parameter_name } ++ ;
            }
            $replacement_count_for_item_name{ $text_parameter_value } ++ ;
            $global_endless_loop_counter ++ ;
            if ( $global_endless_loop_counter > $global_endless_loop_counter_limit + 100 )
            {
                &dashrep_internal_endless_loop_info( %replacement_count_for_item_name ) ;
                $global_log_output .= "<dashrep>Error: The dashrep_expand_parameters subroutine encountered an endless loop.<\/dashrep>" ;
                &error_check ;
            }
        }


#-----------------------------------------------
#  If there are any actions requested,
#  handle them.

        while ( $replacement_text =~ /^(.*?)\[\-([^ \n\[\]\:=]+) *: *([^\[\]]*) *-?\](.*)$/ )
        {
            $text_begin = $1 ;
            $action_name = $2 ;
            $object_of_action = $3 ;
            $text_end = $4 ;
            $object_of_action =~ s/\-+$// ;


#-----------------------------------------------
#  Handle the zero-one-multiple-count-of-list
#  action.

            if ( $action_name eq "zero-one-multiple-count-of-list" )
            {
                @list = &dashrep_internal_split_delimited_items( $object_of_action ) ;
                $count = $#list + 1 ;
                if ( $count == 0 )
                {
                    $name_for_count = "zero" ;
                } elsif ( $count == 1 )
                {
                    $name_for_count = "one" ;
                } elsif ( $count > 1 )
                {
                    $name_for_count = "multiple" ;
                }
                $replacement_text = $text_begin . $name_for_count . $text_end ;


#-----------------------------------------------
#  Handle the zero-one-multiple action.

            } elsif ( $action_name eq "zero-one-multiple" )
            {
                if ( $object_of_action + 0 <= 0 )
                {
                    $zero_one_multiple = "zero" ;
                } elsif ( $object_of_action + 0 == 1 )
                {
                    $zero_one_multiple = "one" ;
                } else
                {
                    $zero_one_multiple = "multiple" ;
                }
                $replacement_text = $text_begin . $zero_one_multiple . $text_end ;


#-----------------------------------------------
#  Handle the empty-or-nonempty action.

            } elsif ( $action_name eq "empty-or-nonempty" )
            {
                if ( $object_of_action =~ /[^ ]/ )
                {
                    $empty_or_nonempty = "nonempty" ;
                } else
                {
                    $empty_or_nonempty = "empty" ;
                }
                $replacement_text = $text_begin . $empty_or_nonempty . $text_end ;


#-----------------------------------------------
#  Handle the same-or-not-same action.

            } elsif ( $action_name eq "same-or-not-same" )
            {
                $full_length = length( $object_of_action ) ;
                $length_half = int( $full_length / 2 ) ;
                $string_beginning = substr( $object_of_action , 0 , $length_half ) ;
                $string_end = substr( $object_of_action , $full_length - $length_half , $length_half ) ;
                if ( $string_beginning eq $string_end )
                {
                    $same_or_not_same = "same" ;
                } else
                {
                    $same_or_not_same = "not-same" ;
                }
                $replacement_text = $text_begin . $same_or_not_same . $text_end ;


#-----------------------------------------------
#  Handle the sort-numbers action.

            } elsif ( $action_name eq "sort-numbers" )
            {
                if ( $object_of_action =~ /[1-9]/ )
                {
                    $object_of_action =~ s/ +/,/gs ;
                    $object_of_action =~ s/^,// ;
                    $object_of_action =~ s/,$// ;
                    @list = split( /,+/ , $object_of_action ) ;
                    @list_of_sorted_numbers = sort { $a <=> $b } @list ;
                    $sorted_numbers = join( "," , @list_of_sorted_numbers ) ;
                } else
                {
                    $sorted_numbers = " " ;
                }
                $replacement_text = $text_begin . $sorted_numbers . $text_end ;


#-----------------------------------------------
#  Handle the auto-increment action.

            } elsif ( $action_name =~ /^auto-increment/ )
            {
                if ( exists( $dashrep_replacement{ $object_of_action } ) )
                {
                    $dashrep_replacement{ $object_of_action } = $dashrep_replacement{ $object_of_action } + 1 ;
                } else
                {
                    $dashrep_replacement{ $object_of_action } = 1 ;
                }
                $replacement_text = $text_begin . " " . $text_end ;


#-----------------------------------------------
#  Handle the create-list-named action.

            } elsif ( $action_name eq "create-list-named" )
            {
                push ( @global_list_of_lists_to_generate , $object_of_action ) ;
                $replacement_text = $text_begin . " " . $text_end ;


#-----------------------------------------------
#  Handle an action name that is not recognized.

            } else
            {
                $replacement_text = $text_begin . " " . $text_end ;
            }


#-----------------------------------------------
#  Finish handling a special action.

            $loop_status_done = $global_false ;
            $replacement_count_for_item_name{ $action_name } ++ ;
            $global_endless_loop_counter ++ ;
            if ( $global_endless_loop_counter > $global_endless_loop_counter_limit + 100 )
            {
                &dashrep_internal_endless_loop_info( %replacement_count_for_item_name ) ;
                $global_log_output .= "<dashrep>Error: The dashrep_expand_parameters subroutine encountered an endless loop.<\/dashrep>" ;
                &error_check ;
            }
        }


#-----------------------------------------------
#  Do each parameter replacement.

        if ( $replacement_text =~ /^(.*?)\[\-([^ \n\[\]]+)\-\](.*)$/ )
        {
            $text_begin = $1 ;
            $text_parameter_placeholder = $2 ;
            $text_end = $3 ;
            if ( exists( $dashrep_replacement{ $text_parameter_placeholder } ) )
            {
                $text_parameter = $dashrep_replacement{ $text_parameter_placeholder } ;
            } else
            {
                $text_parameter = "" ;
            }
            $replacement_text = $text_begin . $text_parameter . $text_end ;
            $loop_status_done = $global_false ;
            if ( $text_parameter_placeholder =~ /^auto-increment-/ )
            {
                push( @list_of_replacements_to_auto_increment , $text_parameter_placeholder ) ;
            }
            $replacement_count_for_item_name{ $text_parameter_placeholder } ++ ;
            $global_endless_loop_counter ++ ;
            if ( $global_endless_loop_counter > $global_endless_loop_counter_limit + 100 )
            {
                &dashrep_internal_endless_loop_info( %replacement_count_for_item_name ) ;
                $global_log_output .= "<dashrep>Error: The dashrep_expand_parameters subroutine encountered an endless loop.<\/dashrep>" ;
                &error_check ;
            }
        }


#-----------------------------------------------
#  Avoid an endless loop (caused by a replacement
#  containing, at some level, itself).

        $global_endless_loop_counter ++ ;
        if ( $global_endless_loop_counter > $global_endless_loop_counter_limit )
        {
            &dashrep_internal_endless_loop_info( %replacement_count_for_item_name ) ;
            $global_log_output .= "<dashrep>Error: The dashrep_expand_parameters subroutine encountered an endless loop.<\/dashrep>" ;
            &error_check ;
        }


#-----------------------------------------------
#  Repeat the inner loop if any replacements
#  were done.

    }


#-----------------------------------------------
#  For each encountered replacement that begins
#  with "auto-increment-", increment its value.

    foreach $text_parameter_placeholder ( @list_of_replacements_to_auto_increment )
    {
        $dashrep_replacement{ $text_parameter_placeholder } ++ ;
    }
    @list_of_replacements_to_auto_increment = ( ) ;


#-----------------------------------------------
#  Return the revised text.

    return $replacement_text ;


#-----------------------------------------------
#  End of subroutine.

}


#-----------------------------------------------
#-----------------------------------------------
#       dashrep_expand_phrases_except_special
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that expands hyphenated phrases
#  with replacements, but does not expand special
#  phrases for spaces, hyphens, and new-lines.

#  The dashrep_expand_phrases_except_special
#  subroutine expands all the hyphenated phrases
#  in a text string that is written in the
#  Dashrep language--except the special
#  (built-in) hyphenated phrases that handle
#  spaces, hyphens, and line breaks.
#  First, and only, parameter is the text
#  string that uses the Dashrep language.
#  Return value is the expanded text string.
#  Return value is zero if there is not
#  exactly one parameter.

sub dashrep_expand_phrases_except_special
{

    my ( $current_item ) ;
    my ( $hyphenated_phrase_to_expand ) ;
    my ( $expanded_output_string ) ;
    my ( $item_name ) ;
    my ( $first_item ) ;
    my ( $remainder ) ;
    my ( $replacement_item ) ;
    my ( $code_begin ) ;
    my ( $code_with_spaces ) ;
    my ( $code_end ) ;
    my ( $code_for_non_breaking_space ) ;
    my ( @item_stack ) ;
    my ( @items_to_add ) ;
    my ( %replacement_count_for_item_name ) ;


#-----------------------------------------------
#  Get the starting replacement name.

#     if ( scalar( @_ ) == 1 )
#     {
        $hyphenated_phrase_to_expand = $_[ 0 ] ;
#     } else
#     {
#         return 0 ;
#     }


#-----------------------------------------------
#  Generate any needed lists.

    &dashrep_generate_lists ;


#-----------------------------------------------
#  Start with a single phrase on a stack.

    @item_stack = ( ) ;
    push( @item_stack , $hyphenated_phrase_to_expand ) ;
    $expanded_output_string = "" ;


#-----------------------------------------------
#  Begin a loop that does all the replacements.

    while( $#item_stack >= 0 )
    {


#-----------------------------------------------
#  If an endless loop occurs, handle that situation.

        $global_endless_loop_counter ++ ;
        if ( $global_endless_loop_counter > $global_endless_loop_counter_limit )
        {
            &dashrep_internal_endless_loop_info( %replacement_count_for_item_name ) ;
            $global_log_output .= "<dashrep>Error: The dashrep_expand_phrases_except_special subroutine encountered an endless loop.<\/dashrep>" ;
            &error_check ;
        }


#-----------------------------------------------
#  Get the first/next item from the stack.
#  If it is empty (after removing spaces),
#  repeat the loop.

        $current_item = pop( @item_stack ) ;
        $current_item =~ s/^ +// ;
        $current_item =~ s/ +$// ;
        if ( $current_item eq "" )
        {
            next ;
        }


#-----------------------------------------------
#  If the item contains a space or line break,
#  split the string at the first space or
#  line break, and then repeat the loop.

        if ( $current_item =~ /^ *([^ ]+)[ \n\r]+(.*)$/ )
        {
            $first_item = $1 ;
            $remainder = $2 ;
            if ( $remainder =~ /[^ ]/ )
            {
                push( @item_stack , $remainder ) ;
            }
            push( @item_stack , $first_item ) ;
            next ;
        }


#-----------------------------------------------
#  If the item is a hyphenated phrase that has
#  been defined, expand the phrase into its
#  associated text (its definition), split the
#  text at any spaces or line breaks, put those
#  delimited items on the stack, and repeat
#  the loop.

        if ( exists( $dashrep_replacement{ $current_item } ) )
        {
            $replacement_item = $dashrep_replacement{ $current_item } ;
            if ( $replacement_item =~ /[^ ]/ )
            {
                @items_to_add = split( /[ \n\r]+/ , $replacement_item ) ;
                push( @item_stack , reverse( @items_to_add ) ) ;
                $replacement_count_for_item_name{ $current_item } ++ ;
                next ;
            }
            next ;
        }


#-----------------------------------------------
#  If the item cannot be expanded, append it to
#  the output string.

        $expanded_output_string .= $current_item . " " ;


#-----------------------------------------------
#  Repeat the loop for the next replacement.

    }


#-----------------------------------------------
#  Handle the "span-non-breaking-spaces-begin/end"
#  directives.

    $code_for_non_breaking_space = $dashrep_replacement{ "non-breaking-space" } ;
    while ( $expanded_output_string =~ /^(.*)\bspan-non-breaking-spaces-begin\b *(.*?) *\bspan-non-breaking-spaces-end\b(.*)$/sgi )
    {
        $code_begin = $1 ;
        $code_with_spaces = $2 ;
        $code_end = $3 ;
        $code_with_spaces =~ s/ +/ ${code_for_non_breaking_space} /sgi ;
        $expanded_output_string = $code_begin . $code_with_spaces . $code_end ;
    }


#-----------------------------------------------
#  End of subroutine.

    return $expanded_output_string ;

}


#-----------------------------------------------
#-----------------------------------------------
#              dashrep_expand_phrases
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that expands hyphenated phrases
#  with replacements.

#  The dashrep_expand_phrases subroutine
#  expands all the hyphenated phrases
#  in a text string that is written in the
#  Dashrep language.  This includes expanding
#  the special (built-in) hyphenated phrases
#  that handle spaces, hyphens, and line breaks.
#  First, and only, parameter is the hyphenated
#  phrase to be expanded.
#  Return value is the expanded text string.
#  Return value is zero if there is not
#  exactly one parameter.

sub dashrep_expand_phrases
{

    my ( $expanded_string ) ;
    my ( $hyphenated_phrase_to_expand ) ;


#-----------------------------------------------
#  Get the starting hyphenated-phrase.

#     if ( scalar( @_ ) == 1 )
#     {
        $hyphenated_phrase_to_expand = $_[ 0 ] ;
#     } else
#     {
#         return 0 ;
#     }


#-----------------------------------------------
#  Expand the phrase except for special phrases.

    $expanded_string = &dashrep_expand_phrases_except_special( $hyphenated_phrase_to_expand ) ;


#-----------------------------------------------
#  Handle the "empty-line" and "new-line" directives.

    $expanded_string =~ s/ *\bempty-line\b */\n\n/sg ;
    $expanded_string =~ s/ *\bnew-line\b */\n/sg ;


#-----------------------------------------------
#  Concatenate lines and spaces as indicated by
#  the "no-space" and "one-space" directives.

    $expanded_string =~ s/\bone-space\b/<onespace>/sgi ;

    $expanded_string =~ s/\bno-space\b/<nospace>/sgi ;

    $expanded_string =~ s/([ \t]*<nospace>)+[ \t]*//sgi ;
    $expanded_string =~ s/[ \t]*(<nospace>[ \t]*)+//sgi ;

    $expanded_string =~ s/([ \t]*<onespace>)+[ \t]*//sgi ;
    $expanded_string =~ s/[ \t]*(<onespace>[ \t]*)+//sgi ;


#-----------------------------------------------
#  End of subroutine.

    return $expanded_string ;

}


#-----------------------------------------------
#-----------------------------------------------
#            dashrep_generate_lists
#-----------------------------------------------
#-----------------------------------------------
#  Generate one or more lists, and the elements
#  in them, and put each list and each element
#  into a named replacement.
#  Allow new list names to be added to the list
#  while generating the initial lists.

#  This subroutine is not exported because it
#  is only needed within this Dashrep module.

sub dashrep_generate_lists
{

    my ( $list_name ) ;
    my ( $generated_list_name ) ;
    my ( $parameter_name ) ;
    my ( $do_nothing ) ;
    my ( $list_prefix ) ;
    my ( $list_separator ) ;
    my ( $list_suffix ) ;
    my ( $replacement_name ) ;
    my ( $delimited_list_of_parameters ) ;
    my ( $pointer ) ;
    my ( $parameter ) ;
    my ( $item_name ) ;
    my ( @list_of_parameters ) ;
    my ( %already_generated_list_named ) ;


#-----------------------------------------------
#  Begin a loop that handles each list to
#  be generated.

    foreach $list_name ( @global_list_of_lists_to_generate )
    {


#-----------------------------------------------
#  Don't generate the same list more than once.

        if ( exists( $already_generated_list_named{ $list_name } ) )
        {
            if ( $already_generated_list_named{ $list_name } == $global_true )
            {
                next ;
            }
        }
        $already_generated_list_named{ $list_name } = $global_true ;


#-----------------------------------------------
#  Get information about the list beging generated.

        $generated_list_name = "generated-list-named-" . $list_name ;
        $parameter_name = $dashrep_replacement{ "parameter-name-for-list-named-" . $list_name } ;


#-----------------------------------------------
#  If the list prefix, separator, or suffix is
#  not defined, set it to empty.
#  This allows these items to be omitted from
#  the replacements file.

        if ( exists( $dashrep_replacement{ "prefix-for-list-named-" . $list_name } ) )
        {
            $do_nothing ++ ;
        } else
        {
            $dashrep_replacement{ "prefix-for-list-named-" . $list_name } = "" ;
        }
        $list_prefix = &dashrep_expand_parameters( "prefix-for-list-named-" . $list_name ) . "\n" ;

        if ( exists( $dashrep_replacement{ "separator-for-list-named-" . $list_name } ) )
        {
            $do_nothing ++ ;
        } else
        {
            $dashrep_replacement{ "separator-for-list-named-" . $list_name } = "" ;
        }
        $list_separator = &dashrep_expand_parameters( "separator-for-list-named-" . $list_name ) . "\n" ;

        if ( exists( $dashrep_replacement{ "suffix-for-list-named-" . $list_name } ) )
        {
            $do_nothing ++ ;
        } else
        {
            $dashrep_replacement{ "suffix-for-list-named-" . $list_name } = "" ;
        }
        $list_suffix = &dashrep_expand_parameters( "suffix-for-list-named-" . $list_name ) . "\n" ;


#-----------------------------------------------
#  Get the list of parameters that define the list.

        $replacement_name = "list-of-parameter-values-for-list-named-" . $list_name ;
        $delimited_list_of_parameters = &dashrep_expand_parameters( "list-of-parameter-values-for-list-named-" . $list_name ) ;
        @list_of_parameters = &dashrep_internal_split_delimited_items( $delimited_list_of_parameters ) ;
        $dashrep_replacement{ "logged-list-of-parameter-values-for-list-named-" . $list_name } = join( "," , @list_of_parameters ) ;


#-----------------------------------------------
#  Insert a prefix at the beginning of the list.

        $dashrep_replacement{ $generated_list_name } = $list_prefix . "\n" ;


#-----------------------------------------------
#  Begin a loop that handles each list item.
#  Do not change the order of the parameters.

        for ( $pointer = 0 ; $pointer <= $#list_of_parameters ; $pointer ++ )
        {
            $parameter = $list_of_parameters[ $pointer ] ;
            $dashrep_replacement{ $parameter_name } = $parameter ;


#-----------------------------------------------
#  Add the next item to the list.

            $item_name = "item-for-list-" . $list_name . "-and-parameter-" . $parameter ;
            $dashrep_replacement{ $generated_list_name } .= $item_name . "\n" ;


#-----------------------------------------------
#  Using a template, generate each item in the list.

            $dashrep_replacement{ $item_name } = &dashrep_expand_parameters( "template-for-list-named-" . $list_name ) ;


#-----------------------------------------------
#  Insert separators between items.

            if ( $pointer < $#list_of_parameters )
            {
                $dashrep_replacement{ $generated_list_name } .= $list_separator . "\n" ;
            }


#-----------------------------------------------
#  Protect against an endless loop.

            $global_endless_loop_counter ++ ;
            if ( $global_endless_loop_counter > $global_endless_loop_counter_limit )
            {
                $global_log_output .= "<dashrep>Error: The dashrep_generate_lists subroutine encountered an endless loop.<\/dashrep>" ;
                &error_check ;
            }


#-----------------------------------------------
#  Repeat the loop for the next list item.

        }


#-----------------------------------------------
#  Terminate the generated list.

        $dashrep_replacement{ $generated_list_name } .= $list_suffix . "\n" ;


#-----------------------------------------------
#  Repeat the loop for the next list to be
#  generated.

    }

#-----------------------------------------------
#  End of subroutine.

    return 1 ;

}

#-----------------------------------------------
#-----------------------------------------------
#         dashrep_internal_endless_loop_info
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine displays counts for the number
#  of replacements for the top-ten most-replaced
#  hyphenated phrases.

#  This subroutine is not exported because it
#  is only needed within this Dashrep module.

sub dashrep_internal_endless_loop_info
{

    my ( $item_name ) ;
    my ( $highest_usage_counter ) ;
    my ( $highest_usage_item_name ) ;
    my ( %replacement_count_for_item_name ) ;

    $highest_usage_counter = - 1 ;
    foreach $item_name ( keys( %replacement_count_for_item_name ) )
    {
        if ( $replacement_count_for_item_name{ $item_name } > $highest_usage_counter )
        {
            $highest_usage_counter = $replacement_count_for_item_name{ $item_name } ;
            $highest_usage_item_name = $item_name ;
        }
    }
    $global_log_output .= "<dashrep>Too many cycles of replacement.\n" . "Hyphenated phrase with highest replacement count (" . $highest_usage_counter . ") is:\n" . "    " . $highest_usage_item_name . "\n" . "<\/dashrep>" ;


#-----------------------------------------------
#  End of subroutine.

    return 1 ;

}


#-----------------------------------------------
#-----------------------------------------------
#         dashrep_internal_split_delimited_items
#-----------------------------------------------
#-----------------------------------------------
#  This subroutine converts a text-format list
#  of text items separated by commas, spaces, or
#  line breaks into an array of separate
#  text strings.  It does not expand any
#  hyphenated phrases.

#  This subroutine is not exported because it
#  is only needed within this Dashrep module.

sub dashrep_internal_split_delimited_items
{
    my ( $text_string ) ;
    my ( @array ) ;

    $text_string = $_[ 0 ] ;


#-----------------------------------------------
#  Convert all delimiters to single commas.

    if ( $text_string =~ /[\n\r]/ )
    {
        $text_string =~ s/[\n\r][\n\r]+/,/gs ;
        $text_string =~ s/[\n\r][\n\r]+/,/gs ;
    }

    $text_string =~ s/ +/,/gs ;
    $text_string =~ s/,,+/,/gs ;


#-----------------------------------------------
#  Remove leading and trailing commas.

    $text_string =~ s/^,// ;
    $text_string =~ s/,$// ;


#-----------------------------------------------
#  If there are only commas and spaces,
#  return an empty list.

    if ( $text_string =~ /^[ ,]*$/ )
    {
        @array = ( ) ;


#-----------------------------------------------
#  Split the strings into an array.

    } else
    {
        @array = split( /,+/ , $text_string ) ;
    }


#-----------------------------------------------
#  Return the resulting array.

    return @array ;

}


