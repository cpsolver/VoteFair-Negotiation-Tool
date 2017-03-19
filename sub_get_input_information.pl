#-----------------------------------------------
#-----------------------------------------------
#           get_input_information
#-----------------------------------------------
#-----------------------------------------------
#  Subroutine that gets form data from previous
#  web page, or else gets the input information
#  from the standard input.  Put the information
#  into the "replacement" array elements --
#  with the prefix "input-" added to the element
#  name.  Also put the information into the XML
#  output (primarily for logging purposes).

sub get_input_information
{

    my ( @name_value_pairs ) ;

    my ( $input_encountered ) ;
    my ( $raw_input ) ;
    my ( $input_line ) ;
    my ( $name_value ) ;
    my ( $name ) ;
    my ( $value ) ;
    my ( $env_variable_name ) ;
    my ( $cgi_length_limit ) ;
    my ( $input_value_name ) ;
    my ( $choice_number ) ;


#-----------------------------------------------
#  Initialization.

    $input_encountered = $global_false ;


#-----------------------------------------------
#  Protect against an excessively long input string.

    $cgi_length_limit = 10000000 ;

    if ( $ENV{ "CONTENT_LENGTH" } > $cgi_length_limit )
    {
        $global_error_message = &dashrep_get_replacement( "error-message-input-way-too-long-part1" ) . $ENV{ "CONTENT_LENGTH" } . &dashrep_get_replacement( "error-message-input-way-too-long-part2" ) ;
        return ;
    }


#-----------------------------------------------
#  Read the input text.
#  If it is not available through the CGI-supplied "GET"
#  approach, read it from the input file,
#  which also might be CGI-supplied information
#  (using the "POST" approach).
#  If it is in multiple lines, replace the
#  newline code with a space.

#  Note:  The "GET" method is needed in order to
#  recognize environment variables after the
#  question mark in a URL such as:
#      www.votefair.org?accessid=123

    if ( $ENV{ "REQUEST_METHOD" } eq 'GET' )
    {
        $raw_input = $ENV{ "QUERY_STRING" } ;
        $global_log_output .= "<getinputinfo>Getting input values using the CGI GET form method<\/getinputinfo>" ;

    } else {

        $global_log_output .= "<getinputinfo>Reading input values from file or POST-method CGI<\/getinputinfo>" ;
        while( $input_line = <STDIN> )
        {
            chomp( $input_line ) ;
            $raw_input .= $input_line . " " ;
        }

    }

#    $global_log_output .= "<getinputinfo>Raw input information: " . $raw_input . "<\/getinputinfo>" ;


#-----------------------------------------------
#  Write all the environment values to the log file.

#    $global_log_output .= "<env-variable>------------------------<\/env-variable>" ;
#    foreach $name ( sort( keys( %ENV ) ) )
#    {
#        $global_log_output .= "<env-variable>" . $name . " = " . $ENV{ $name } . "<\/env-variable>" ;
#    }
#    $global_log_output .= "<env-variable>------------------------<\/env-variable>" ;


#-----------------------------------------------
#  Get the user's IP address and port number.

    $global_ip_address = $ENV{ "REMOTE_ADDR" } ;
    $global_port = $ENV{ "REMOTE_PORT" } ;
    $global_ip_address = $ENV{ "REMOTE_ADDR" } ;
    $global_log_output .= "<getinputinfo>IP address = " . $global_ip_address . "  port = " . $ENV{ "REMOTE_PORT" } . "<\/getinputinfo>" ;


#    &log_write ;


#-----------------------------------------------
#  If the information is CGI form data, translate it,
#  separate the values, and put them into both the
#  "replacement" array and the XML output.

    if ( $raw_input =~ /^(([^ <>]+)=([^ <>]*)(&([^ <>]+)=([^ <>]*))*) *$/ )
    {
        $raw_input = $1 ;

        $raw_input =~ tr/+/ / ;

        @name_value_pairs = split( /&/, $raw_input ) ;
        foreach $name_value ( @name_value_pairs )
        {
            ( $name, $value ) = split( /=/, $name_value, 2 ) ;
            if ( not( defined( $value ) ) )
            {
                $value = '' ;
            }
            $name  =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
            $name  =~ s/[<>\/\\]+/_/g ;

            if ( $name eq "texttoimport" )
            {
#               Special preservation of tabs, line breaks, etc. for imported text:
                $value =~ s/%0D//ig ;
                $value =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
            } else
            {
                $value =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
                $value =~ s/[<>]+/_/gm ;
                $value =~ s/\n/<eol\/>/gm ;
#                $value =~ s/\n/<eol\/>/g ;
            }

            if ( $name !~ /^ *$/ )
            {
                &dashrep_define( "input-" . $name , $value ) ;
                $global_log_output .= "<input-" . $name . ">" . $value . "<\/input-" . $name . ">" ;
                $input_encountered = $global_true ;
            }
        }
        $raw_input = "" ;
    }


#-----------------------------------------------
#  If the information contains data tagged as
#  <xmlraw>, put it into a "replacement" array,
#  without interpreting any interior XML tags.

    if ( $raw_input =~ /<xmlraw>/i )
    {
        $global_log_output .= "<getinputinfo>Raw information is in XML-RAW format<\/getinputinfo>" ;

        $raw_input =~ s/><eol\/>/>/g ;
        $raw_input =~ s/><eol\/>/>/g ;
        $raw_input =~ s/<eol\/></</g ;
        $raw_input =~ s/<eol\/></</g ;

        if ( $raw_input =~ /^(.*?)<xmlraw>(.*)<\/xmlraw>(.*)$/is )
        {
            $value = $2 ;
            $raw_input = $1 . $3 ;
            &dashrep_define( "input-xmlraw" , $value ) ;
#            $global_log_output .= "<input-xmlraw>" . $value . "<\/input-xmlraw>" ;
            $input_encountered = $global_true ;
        }

#        $global_log_output .= $raw_input ;
    }


#-----------------------------------------------
#  If one of the CGI input parameters was "xml",
#  put that parameter value back into the input
#  text string so that it can be split up in the
#  next section.

    if ( &dashrep_get_replacement( "input-xml" ) =~ /<xml>/ )
    {
        $raw_input = "<xml>" . &dashrep_get_replacement( "input-xml" ) . "<\/xml>" ;
        &dashrep_define( "input-xml" , "" ) ;
    }


#-----------------------------------------------
#  If the information is in XML format,
#  remove spaces that are adjacent to XML tags,
#  and remove <eol/> tags that are adjacent to another
#  tag, then extract the information and put it
#  into both the "replacement" array and the
#  XML output.

    if ( $raw_input =~ /<xml>/i )
    {
        $global_log_output .= "<getinputinfo>Raw information is in XML format<\/getinputinfo>" ;
        $raw_input =~ s/> +/>/g ;
        $raw_input =~ s/ +</</g ;
        if ( $name ne "texttoimport" )
        {
            $raw_input =~ s/><eol\/>/>/g ;
            $raw_input =~ s/><eol\/>/>/g ;
            $raw_input =~ s/<eol\/></</g ;
            $raw_input =~ s/<eol\/></</g ;
        }

        while ( $raw_input =~ /^(.*?)<([^<>\/]+)>([^<>]*)<\/[^<>\/]+>(.*)$/is )
        {
            $name = $2 ;
            $value = $3 ;
            $raw_input = $1 . $4 ;
            if ( $name !~ /^ *$/ )
            {
                &dashrep_define( "input-" . $name , $value ) ;
                $global_log_output .= "<input-" . $name . ">" . $value . "<\/input-" . $name . ">" ;
                $input_encountered = $global_true ;
            }
        }

#        $global_log_output .= $raw_input ;
        $raw_input = "" ;
    }


#-----------------------------------------------
#  If the input information is empty or unrecognized,
#  try getting the Access ID number from a different
#  environment variable -- due to access from an external
#  link.

    if ( $input_encountered == $global_false )
    {
        $env_variable_name = "" ;

        if ( $ENV{ "PATH_INFO" } =~ /accessid=([a-z0-9\-]+)/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "PATH_INFO" ;

        } elsif ( $ENV{ "PATH_TRANSLATED" } =~ /accessid=([a-z0-9\-]+)/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "PATH_TRANSLATED" ;

        } elsif ( $ENV{ "REQUEST_URI" } =~ /accessid=([a-z0-9\-]+)/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "REQUEST_URI" ;

        } elsif ( $ENV{ "PATH_INFO" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "PATH_INFO" ;

        } elsif ( $ENV{ "PATH_TRANSLATED" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "PATH_TRANSLATED" ;

        } elsif ( $ENV{ "REQUEST_URI" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
        {
            &dashrep_define( "input-accessid" , $1 ) ;
            $env_variable_name = "REQUEST_URI" ;

        }

        if ( $env_variable_name ne "" )
        {
#            $global_log_output .= "<input-accessid>" . &dashrep_get_replacement( "input-accessid" ) . "<\/input-accessid>" ;
            $raw_input = $ENV{ $env_variable_name } ;
#            $global_log_output .= "<getinputinfo>" . $env_variable_name . ": " . $raw_input . "<\/getinputinfo>" ;
            $input_encountered = $global_true ;
            &dashrep_define( "input-action" , "fromlink" ) ;
        }

    }


#-----------------------------------------------
#  If the input information is still empty or unrecognized,
#  log this fact -- which is not necessarily an error.

    if ( $input_encountered == $global_false )
    {
        $global_log_output .= "<emptyinput>yes<\/emptyinput>" ;
        $global_log_output .= "<getinputinfo>Empty or unrecognized raw input: " . $raw_input . "<\/getinputinfo>" ;
    }


#-----------------------------------------------
#  End of subroutine.

    return ;

}


