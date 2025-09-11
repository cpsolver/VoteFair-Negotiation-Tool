#-----------------------------------------------
#-----------------------------------------------
#            clean_up_user_text
#-----------------------------------------------
#-----------------------------------------------
#  Modifies user-entered text to replace special
#  characters such as "<", ">", "&", "-",
#  leading and trailing spaces, extra spaces,
#  etc.


sub clean_up_user_text
{

    ( $text_to_clean_up ) = @_ ;

    $text_to_clean_up =~ s/&/[;;]amp;/sg ;
#    $text_to_clean_up =~ s/ & / [;;]amp; /sg ;
    $text_to_clean_up =~ s/\[;;\]/&/sg ;
    $global_log_output .= "<cleanuptext>Without typed-in ampersands: " . $text_to_clean_up . "<\/cleanuptext>" ;

    $text_to_clean_up =~ s/\-/&#045;/sg ;
#    $text_to_clean_up =~ s/\-/[;;]shy;/sg ;
    $global_log_output .= "<cleanuptext>Without hyphens: " . $text_to_clean_up . "<\/cleanuptext>" ;

    $text_to_clean_up =~ s/<eol *\/>/ line-break /sg ;
    $global_log_output .= "<cleanuptext>With [eol] directives replaced: " . $text_to_clean_up . "<\/cleanuptext>" ;

    $text_to_clean_up =~ s/([^ ]):/$1 no-space :/sg ;
    $global_log_output .= "<cleanuptext>With colons isolated: " . $text_to_clean_up . "<\/cleanuptext>" ;

    $text_to_clean_up =~ s/</&#60;/sg ;
    $text_to_clean_up =~ s/>/&#62;/sg ;

    $text_to_clean_up =~ s/\n+/ line-break /sg ;

    $text_to_clean_up =~ s/\t+/ non-breaking-space /sg ;

    $text_to_clean_up =~ s/\//&#047;/sg ;
    $text_to_clean_up =~ s/\\/&#092;/sg ;

    $text_to_clean_up =~ s/  +/ /sg ;
    $text_to_clean_up =~ s/^ +// ;
    $text_to_clean_up =~ s/ +$// ;
#    $global_log_output .= "<cleanuptext>Without extra spaces: " . $text_to_clean_up . "<\/cleanuptext>" ;

    $global_log_output .= "<cleanuptext>After cleanup: " . $text_to_clean_up . "<\/cleanuptext>" ;

    return $text_to_clean_up ;

}

