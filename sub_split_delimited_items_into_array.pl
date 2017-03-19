#-----------------------------------------------
#-----------------------------------------------
#         split_delimited_items_into_array
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that converts a text-format list
#  of text items separated by commas, spaces, or
#  line breaks into an array of separate
#  text strings.

sub split_delimited_items_into_array
{
    my ( $array ) ;
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

