#!/usr/bin/perl

#                VoteFairNegotiationTool.cgi
#                ---------------------------
#
#  Implements the VoteFair Negotiation Tool
#  for use at the www.NegotiationTool.com
#  website.
#  Creates web pages as needed, and does
#  ranking calculations when results requested.
#
#
#  (c) Copyright 2003, 2004, 2005, 2006, 2007, 2008 by Richard Fobes
#  at WebHost@VoteFair.org
#
#  Solutions Through Innovation
#  PO Box 19003
#  Portland, OR 97280-0003
#
#  ALL RIGHTS RESERVED
#
#-----------------------------------------------

&f0o5b8e3s8 ;
exit ;
sub f0o5b8e3s8
{
&f2o5b8e3s5( "cgi-version" , "cgi-yes" ) ;
$f4o5b8e3s2 = 'Temp_FullNegotiationTool_Output.html' ;
if ( -e $f4o5b8e3s2 )
{
&f2o5b8e3s5( "local-version" , "local-yes" ) ;
&f2o5b8e3s5( "cgi-version" , "cgi-no" ) ;
$f5o5b8e3s9 .= "<main>Found local file: " . $f4o5b8e3s2 . "<\/main>" ;
}
$f7o5b8e3s6 = "[GenNegLog]" ;
&f9o5b8e3s3 ;
if ( $f1o6b8e3s0 =~ /test/ )
{
&f2o5b8e3s5( "test-version" , "yes" ) ;
} else
{
&f2o5b8e3s5( "test-version" , "no" ) ;
}
$f2o6b8e3s7 = "undefined" ;
$f4o6b8e3s4 = "entire-standard-web-page" ;
&f2o5b8e3s5( "web-page-content" , "" ) ;
&f2o5b8e3s5( "possible-user-error-message" , "" ) ;
$f6o6b8e3s1 = $f1o6b8e3s0 ;
&f7o6b8e3s8 ;
@f9o6b8e3s5 = &f1o7b8e3s2( $f2o7b8e3s9 ) ;
&f4o7b8e3s6 ;
&f2o5b8e3s5( "yes-no-permission-for-action-testcss" , "yes-permission" ) ;
&f2o5b8e3s5( "page-name-for-action-testcss" , "page-test-css" ) ;
&f2o5b8e3s5( "page-test-css" , &f6o7b8e3s3( "list-of-page-names" ) ) ;
$f8o7b8e3s0 = &f6o7b8e3s3( "page-test-css" ) ;
$f8o7b8e3s0 =~ s/ +/-\] \[-/g ;
$f8o7b8e3s0 =~ s/^ */\[-/ ;
$f8o7b8e3s0 =~ s/ *$/-\]/ ;
&f2o5b8e3s5( "page-test-css" , $f8o7b8e3s0 ) ;
if ( &f6o7b8e3s3( "test-version" ) =~ /yes/ )
{
&f2o5b8e3s5( "cgi-votefair-negotiation-tool" , "cgi-votefair-negotiation-tool-test-version" ) ;
&f2o5b8e3s5( "stylesheet-filename" , "stylesheet-filename-test-version" ) ;
$f5o5b8e3s9 .= "<main>Running in test CGI environment<\/main>" ;
}
if ( &f6o7b8e3s3( "local-version" ) =~ /yes/ )
{
&f2o5b8e3s5( "cgi-votefair-negotiation-tool" , "cgi-votefair-negotiation-tool-local-version" ) ;
&f2o5b8e3s5( "stylesheet-filename" , "stylesheet-filename-local-version" ) ;
$f5o5b8e3s9 .= "<main>Running in local environment<\/main>" ;
}
&f9o7b8e3s7 ;
$f5o5b8e3s9 .= "<main>Checking for errors<\/main>" ;
&f4o7b8e3s6 ;
if ( &f6o7b8e3s3( "cgi-version" ) =~ /yes/ )
{
$f1o8b8e3s4 = 'Content-type: text/html' . "\n\n" ;
} else
{
$f1o8b8e3s4 = "" ;
}
$f3o8b8e3s1 = &f6o7b8e3s3( "word-delete-all-log-files" ) ;
$f3o8b8e3s1 =~ s/[^a-z0-9]//sgi ;
if ( $f3o8b8e3s1 !~ /[a-z0-9]/i )
{
$f3o8b8e3s1 = "zoiciwmoawinfawer" ;
}
if ( &f6o7b8e3s3( "input-accessid" ) eq $f3o8b8e3s1 )
{
unlink( glob( $f4o8b8e3s8 . "log-*.txt" ) ) ;
$f5o5b8e3s9 .= "<main>Erased all log files!<\/main>" ;
$f6o8b8e3s5 .= "Log files erased." ;
&f4o7b8e3s6 ;  # Exits here
}
if ( &f6o7b8e3s3( "input-action" ) =~ /[a-z]/i )
{
$f2o6b8e3s7 = &f6o7b8e3s3( "input-action" ) ;
}
&f2o5b8e3s5( "output-requested-action" , $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<main>Action requested: " . $f2o6b8e3s7 . "<\/main>" ;
if ( &f6o7b8e3s3( "local-version" ) =~ /yes/ )
{
$f5o5b8e3s9 .= "<main>Using local environment<\/main>" ;
&f2o5b8e3s5( "default-test-case-number" , "656012speccase6959" ) ;
&f2o5b8e3s5( "default-test-case-number" , "24709-10153-34594" ) ;
&f2o5b8e3s5( "input-accessid" , &f6o7b8e3s3( "default-test-case-number" ) ) ;
$f5o5b8e3s9 .= "<main>Specified Access ID: " . &f6o7b8e3s3( "input-accessid" ) . "<\/main>" ;
&f2o5b8e3s5( "participant-participantid-for-userid-" . "6959" , 1 ) ;
&f2o5b8e3s5( "participant-participantid-for-userid-" . "1828" , 1 ) ;
&f2o5b8e3s5( "input-action" , "showoverallranking" ) ;
$f2o6b8e3s7 = &f6o7b8e3s3( "input-action" ) ;
$f5o5b8e3s9 .= "<main>Using default test ID " . &f6o7b8e3s3( "input-accessid" ) . " and default action of " . $f2o6b8e3s7 . "<\/main>" ;
}
if ( $f2o6b8e3s7 eq "newcase" )
{
&f8o8b8e3s2 ;
$f5o5b8e3s9 .= "<main>Created a new case, with case number " . $f9o8b8e3s9 . "<\/main>" ;
&f2o5b8e3s5( "input-accessid" , $f1o9b8e3s6 ) ;
&f2o5b8e3s5( "input-action" , "home" ) ;
}
&f3o9b8e3s3 ;
$f5o5b8e3s9 .= "<main>Case number is " . $f9o8b8e3s9 . "<\/main>" ;
$f5o5b8e3s9 .= "<main>User ID number is " . $f5o9b8e3s0 . "<\/main>" ;
&f2o5b8e3s5( "reference-number" , "" ) ;
if ( ( &f6o7b8e3s3( "input-accessid" ) =~ /[0-9a-z]/i ) && ( $f9o8b8e3s9 == 0 ) )
{
$f2o6b8e3s7 = "invalidaccessid" ;
$f6o9b8e3s7 .= &f6o7b8e3s3( "error-message-voting-id-invalid" ) . "<\/convertcaseuser>" ;
$f5o5b8e3s9 .= "<convertcaseuser>Access ID is not valid<\/convertcaseuser>" ;
}
if ( $f2o6b8e3s7 ne "newcase" )
{
if ( ( $f9o8b8e3s9 <= 0 ) || ( $f5o9b8e3s0 <= 0 ) )
{
$f9o8b8e3s9 = 0 ;
$f5o9b8e3s0 = 0 ;
$f2o6b8e3s7 = "welcome" ;
$f5o5b8e3s9 .= "<main>Action changed because case number or user ID is zero or less than zero<\/main>" ;
$f5o5b8e3s9 .= "<main>Action requested: " . $f2o6b8e3s7 . "<\/main>" ;
}
}
if ( ( $f9o8b8e3s9 > 0 ) && ( ( $f2o6b8e3s7 !~ /[a-z]/ ) || ( $f2o6b8e3s7 eq "undefined" ) ) )
{
$f5o5b8e3s9 .= "<main>Action changed because case number (" . $f9o8b8e3s9 . ") is specified but no action (" . $f2o6b8e3s7 . ") is specified<\/main>" ;
$f2o6b8e3s7 = "home" ;
$f5o5b8e3s9 .= "<main>Action requested: " . $f2o6b8e3s7 . "<\/main>" ;
}
$f5o5b8e3s9 .= "<main>Action requested: " . $f2o6b8e3s7 . "<\/main>" ;
&f4o7b8e3s6 ;
if ( ( &f6o7b8e3s3( "suppress-log-for-action-" . $f2o6b8e3s7 ) =~ /yes/i ) && ( &f6o7b8e3s3( "cgi-version" ) =~ /yes/ ) )
{
$f8o9b8e3s4 = $f0o0b9e3s1 ;
}
&f1o0b9e3s8 ;
$f3o0b9e3s5 = "" ;
if ( $f9o8b8e3s9 > 0 )
{
&f5o0b9e3s2 ;
if ( $f6o8b8e3s5 ne "" )
{
$f6o8b8e3s5 .= "error-message-no-access-for-this-voting-id" . "\n" ;
$f5o5b8e3s9 .= "<main>Failure opening -- for reading -- file named " . $f6o0b9e3s9 . "<\/main>" ;
$f5o5b8e3s9 .= "<main>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/main>" ;
$f6o8b8e3s5 = "" ;
$f6o9b8e3s7 .= &f6o7b8e3s3( "error-message-voting-id-invalid" ) . "<\/convertcaseuser>" ;
$f9o8b8e3s9 = 0 ;
$f5o9b8e3s0 = 0 ;
$f2o6b8e3s7 = "welcome" ;
$f5o5b8e3s9 .= "<main>Action changed because case file was not found<\/main>" ;
$f5o5b8e3s9 .= "<main>Action requested: " . $f2o6b8e3s7 . "<\/main>" ;
}
if ( $f9o8b8e3s9 > 0 )
{
$f6o6b8e3s1 = $f6o0b9e3s9 ;
&f7o6b8e3s8 ;
$f3o0b9e3s5 = $f2o7b8e3s9 ;
}
&f4o7b8e3s6 ;
&f8o0b9e3s6 ;
$f0o1b9e3s3 = $f3o0b9e3s5 ;
@f2o1b9e3s0 = ( ) ;
&f3o1b9e3s7 ;
&f5o1b9e3s4 ;
&f8o0b9e3s6 ;
}
$f7o1b9e3s1 = &f6o7b8e3s3( "case-info-language" ) ;
$f7o1b9e3s1 =~ s/ //g ;
if ( $f7o1b9e3s1 !~ /^[a-z][a-z]$/ )
{
$f7o1b9e3s1 = "en" ;
}
$f6o6b8e3s1 = $f8o1b9e3s8 . $f7o1b9e3s1 . $f0o2b9e3s5 ;
&f7o6b8e3s8 ;
&f1o7b8e3s2( $f2o7b8e3s9 ) ;
if ( $f6o8b8e3s5 =~ /[^ ]/ )
{
$f7o1b9e3s1 = "en" ;
$f6o6b8e3s1 = $f8o1b9e3s8 . $f7o1b9e3s1 . $f0o2b9e3s5 ;
&f7o6b8e3s8 ;
&f1o7b8e3s2( $f2o7b8e3s9 ) ;
}
&f4o7b8e3s6 ;
push( @f9o6b8e3s5 , @f2o2b9e3s2 ) ;
$f5o5b8e3s9 .= "<main>This user's ID is " . $f5o9b8e3s0 . "<\/main>" ;
$f3o2b9e3s9 = &f6o7b8e3s3( "participant-participantid-for-userid-" . $f5o9b8e3s0 ) ;
if ( $f3o2b9e3s9 < 1 )
{
$f3o2b9e3s9 = 0 ;
$f5o5b8e3s9 .= "<main>Participant number is not recognized, so set to zero<\/main>" ;
}
&f2o5b8e3s5( "users-participant-id" , $f3o2b9e3s9 ) ;
$f5o2b9e3s6 = $f3o2b9e3s9 ;
$f5o5b8e3s9 .= "<main>This user's participant ID number is " . $f3o2b9e3s9 . "<\/main>" ;
$f7o2b9e3s3 = &f6o7b8e3s3( "participant-permissioncategory-for-participantid-" . $f3o2b9e3s9 ) ;
$f5o5b8e3s9 .= "<main>User's permission category is " . $f7o2b9e3s3 . "<\/main>" ;
if ( $f7o2b9e3s3 eq "" )
{
$f5o5b8e3s9 .= "<main>Access ID does not correspond to any participant in this case, so the welcome page will be shown, with an error message.<\/main>" ;
$f9o2b9e3s0 = "page-welcome" ;
&f2o5b8e3s5( "possible-error-message-about-access-id-not-recognized" , "error-message-about-access-id-not-recognized" ) ;
}
$f5o5b8e3s9 .= "<main>Action requested: [" . $f2o6b8e3s7 . "]<\/main>" ;
&f1o0b9e3s8 ;
if ( ( $f2o6b8e3s7 eq "welcome" ) || ( $f9o2b9e3s0 eq "page-welcome" ) )
{
$f9o2b9e3s0 = "page-welcome" ;
$f5o5b8e3s9 .= "<main>Generating page named " . $f9o2b9e3s0 . "<\/main>" ;
&f2o5b8e3s5( "web-page-content" , &f0o3b9e3s7( $f9o2b9e3s0 ) ) ;
$f2o3b9e3s4 = &f4o3b9e3s1( $f4o6b8e3s4 ) ;
print $f1o8b8e3s4 ;
print $f2o3b9e3s4 ;
$f5o5b8e3s9 .= "[\/GenNegLog]" ;
&f5o3b9e3s8 ;
&f1o0b9e3s8 ;
exit ;
}
@f7o3b9e3s5 = &f9o3b9e3s2( &f0o3b9e3s7( "list-of-non-permission-action-names" ) ) ;
foreach $f0o4b9e3s9 ( @f7o3b9e3s5 )
{
&f2o5b8e3s5( "yes-no-permission-for-action-" . $f0o4b9e3s9 , "yes-permission" ) ;
}
@f7o3b9e3s5 = &f9o3b9e3s2( &f0o3b9e3s7( "list-of-actions-that-require-permission" ) ) ;
foreach $f0o4b9e3s9 ( @f7o3b9e3s5 )
{
&f2o5b8e3s5( "yes-no-permission-for-action-" . $f0o4b9e3s9 , "no-permission" ) ;
}
@f7o3b9e3s5 = &f9o3b9e3s2( &f0o3b9e3s7( "list-of-actions-permitted-for-category-" . $f7o2b9e3s3 ) ) ;
foreach $f0o4b9e3s9 ( @f7o3b9e3s5 )
{
&f2o5b8e3s5( "yes-no-permission-for-action-" . $f0o4b9e3s9 , "yes-permission" ) ;
}
&f2o5b8e3s5( "yes-no-permission" , "no-permission" ) ;
if ( &f6o7b8e3s3( "yes-no-permission-for-action-" . $f2o6b8e3s7 ) eq "yes-permission" )
{
&f2o5b8e3s5( "yes-no-permission" , "yes-permission" ) ;
}
$f5o5b8e3s9 .= "<main>Permission for this action: " . &f6o7b8e3s3( "yes-no-permission" ) . "<\/main>" ;
if ( $f7o2b9e3s3 eq "inactive" )
{
if ( ( $f2o6b8e3s7 eq "home" ) || ( &f6o7b8e3s3( "yes-no-permission" ) eq "no-permission" ) )
{
$f5o5b8e3s9 .= "<main>Participant is inactive, or does not have permission for action " . $f2o6b8e3s7 . " so pageinactive action specified instead<\/main>" ;
$f2o6b8e3s7 = "pageinactive" ;
&f2o5b8e3s5( "yes-no-permission" , "yes-permission" ) ;
}
}
&f1o0b9e3s8 ;
if ( &f6o7b8e3s3( "yes-no-permission" ) eq "no-permission" )
{
if ( &f6o7b8e3s3( "yes-no-permission-for-action-" . "home" ) =~ /y/ )
{
$f2o6b8e3s7 = "home" ;
&f6o7b8e3s3( "user-error-message-wording" ) .= " " . "no-permission-for-this-action-usage-user-error-messaage" ;
$f5o5b8e3s9 .= "<main>Participant does not have permission for action " . $f2o6b8e3s7 . " so home page will be displayed<\/main>" ;
} else
{
$f2o6b8e3s7 = "error" ;
}
}
$f9o2b9e3s0 = &f6o7b8e3s3( "page-name-for-action-" . $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<main>For action " . $f2o6b8e3s7 . " page name is " . $f9o2b9e3s0 . "<\/main>" ;
&f1o0b9e3s8 ;
if ( ( $f7o2b9e3s3 eq "administrator" ) && ( &f6o7b8e3s3( "input-participantid" ) == $f3o2b9e3s9 ) && ( $f9o2b9e3s0 eq "page-show-participant-access-id" ) )
{
$f9o2b9e3s0 = "page-show-admin-access-id" ;
}
if ( $f9o2b9e3s0 !~ /[^ ]/ )
{
$f2o6b8e3s7 = "home" ;
$f9o2b9e3s0 = &f6o7b8e3s3( "page-name-for-action-" . $f2o6b8e3s7 ) ;
}
$f5o5b8e3s9 .= "<main>Page name: " . $f9o2b9e3s0 . "<\/main>" ;
if ( $f2o6b8e3s7 eq "getproposaladded" )
{
if ( ( &f6o7b8e3s3( "input-aliastitle" ) !~ /[^ \n]/ ) && ( &f6o7b8e3s3( "input-description" ) =~ /[^ \n]/ ) )
{
&f2o5b8e3s5( "input-aliastitle" , &f6o7b8e3s3( "input-description" ) ) ;
$f5o5b8e3s9 .= "<main>Copied proposal description into empty aliastitle value<\/main>" ;
} elsif ( ( &f6o7b8e3s3( "input-description" ) !~ /[^ \n]/ ) && ( &f6o7b8e3s3( "input-aliastitle" ) =~ /[^ \n]/ ) )
{
&f2o5b8e3s5( "input-description" , &f6o7b8e3s3( "input-aliastitle" ) ) ;
$f5o5b8e3s9 .= "<main>Copied proposal title into empty description value<\/main>" ;
}
}
&f2o4b9e3s6 ;
if ( $f4o4b9e3s3 == $f6o4b9e3s0 )
{
&f2o5b8e3s5( "possible-significant-error-message-on-home-page" , "significant-error-message-on-home-page" ) ;
$f2o6b8e3s7 = "home" ;
$f9o2b9e3s0 = &f6o7b8e3s3( "page-name-for-action-" . $f2o6b8e3s7 ) ;
}
$f7o4b9e3s7 = int( &f6o7b8e3s3( "input-validated-participantid" ) ) ;
if ( $f7o4b9e3s7 <= 0 )
{
$f7o4b9e3s7 = $f3o2b9e3s9 ;
}
&f2o5b8e3s5( "parameter-participant-id" , $f7o4b9e3s7 ) ;
&f2o5b8e3s5( "participant-shortname-for-input-participantid" , "participant-shortname-for-participantid-" . $f7o4b9e3s7 ) ;
&f2o5b8e3s5( "participant-fullname-for-input-participantid" , "participant-fullname-for-participantid-" . $f7o4b9e3s7 ) ;
$f5o5b8e3s9 .= "<main>Input specifies participant ID " . $f7o4b9e3s7 . "<\/main>" ;
$f9o4b9e3s4 = int( &f6o7b8e3s3( "input-validated-proposalid" ) ) ;
if ( $f9o4b9e3s4 < 0 )
{
$f9o4b9e3s4 = 0 ;
}
&f2o5b8e3s5( "parameter-proposal-id" , $f9o4b9e3s4 ) ;
$f5o5b8e3s9 .= "<main>Input specifies proposal ID " . $f9o4b9e3s4 . "<\/main>" ;
$f1o5b9e3s1 = int( &f6o7b8e3s3( "input-validated-aliasid" ) ) ;
if ( $f1o5b9e3s1 > 0 )
{
$f9o4b9e3s4 = &f6o7b8e3s3( "alias-proposalid-for-aliasid-" . $f1o5b9e3s1 ) ;
&f2o5b8e3s5( "input-validated-proposalid" , $f9o4b9e3s4 ) ;
&f2o5b8e3s5( "xml-content-proposalid" , $f9o4b9e3s4 ) ;
$f5o5b8e3s9 .= "<main>Revised proposal ID " . $f9o4b9e3s4 . " based on supplied alias ID " . $f1o5b9e3s1 . "<\/main>" ;
}
foreach $f2o5b9e3s8 ( "aliastitle" , "description" , "exiturl" )
{
&f2o5b8e3s5( "form-output-" . $f2o5b9e3s8 , &f6o7b8e3s3( "input-validated-" . $f2o5b9e3s8 ) ) ;
}
$f4o5b9e3s5 = &f6o7b8e3s3( "source-action-name-for-action-" . $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<main>Source action was " . $f4o5b9e3s5 . "<\/main>" ;
if ( $f4o5b9e3s5 =~ /[^ ]/ )
{
if ( $f6o5b9e3s2 == $f0o0b9e3s1 )
{
&f7o5b9e3s9 ;
&f2o5b8e3s5( "possible-validation-error-message" , "" ) ;
} else
{
$f5o5b8e3s9 .= "<main>There was a validation error!<\/main>" ;
if ( $f4o5b9e3s5 =~ /[a-z]/ )
{
$f2o6b8e3s7 = $f4o5b9e3s5 ;
$f5o5b8e3s9 .= "<main>Revised action is " . $f2o6b8e3s7 . "<\/main>" ;
$f9o2b9e3s0 = &f6o7b8e3s3( "page-name-for-action-" . $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<main>Revised page name is " . $f9o2b9e3s0 . "<\/main>" ;
} else
{
$f9o2b9e3s0 = "error" ;
$f5o5b8e3s9 .= "<main>Revised page name is " . $f9o2b9e3s0 . " , which is intentionally invalid, so an error will be triggered<\/main>" ;
}
foreach $f2o5b9e3s8 ( "aliastitle" , "description" , "exiturl" )
{
&f2o5b8e3s5( "form-output-" . $f2o5b9e3s8 , &f6o7b8e3s3( "input-validated-" . $f2o5b9e3s8 ) ) ;
}
}
}
@f9o5b9e3s6 = &f9o3b9e3s2( &f0o3b9e3s7( "extra-case-files-for-" . $f9o2b9e3s0 ) ) ;
$f5o5b8e3s9 .= "<main>Extra case files to read: " . join( "," , @f9o5b9e3s6 ) . "<\/main>" ;
foreach $f1o6b9e3s3 ( @f9o5b9e3s6 )
{
$f3o6b9e3s0 = $f4o6b9e3s7 . $f9o8b8e3s9 . "-" . $f1o6b9e3s3 . $f6o6b9e3s4 ;
$f5o5b8e3s9 .= "<main>Will read file: " . $f3o6b9e3s0 . "<\/main>" ;
$f6o6b8e3s1 = $f3o6b9e3s0 ;
&f4o7b8e3s6 ;
&f7o6b8e3s8 ;
$f6o8b8e3s5 = "" ;
$f8o6b9e3s1 = $f2o7b8e3s9 ;
if ( $f8o6b9e3s1 =~ /[^ ]/ )
{
$f0o1b9e3s3 = $f8o6b9e3s1 ;
@f2o1b9e3s0 = ( ) ;
&f3o1b9e3s7 ;
}
}
@f9o6b9e3s8 = &f9o3b9e3s2( &f0o3b9e3s7( "page-names-that-need-incompatibility-info" ) ) ;
foreach $f1o7b9e3s5 ( @f9o6b9e3s8 )
{
if ( $f9o2b9e3s0 eq $f1o7b9e3s5  )
{
$f5o5b8e3s9 .= "<main>Getting incompatibility info<\/main>" ;
&f3o7b9e3s2 ;
last ;
}
}
if ( $f2o6b8e3s7 eq "exportimport" )
{
$f5o5b8e3s9 .= "<main>Export requested<\/main>" ;
&f4o7b9e3s9 ;
} elsif ( $f2o6b8e3s7 eq "getimported" )
{
$f5o5b8e3s9 .= "<main>Import requested<\/main>" ;
&f6o7b9e3s6 ;
}
if ( $f9o2b9e3s0 eq "page-overall-ranked-proposals" )
{
$f5o5b8e3s9 .= "<main>Sorting proposals<\/main>" ;
&f1o0b9e3s8 ;
&f8o7b9e3s3 ;
$f5o5b8e3s9 .= "<main>Done sorting proposals<\/main>" ;
&f1o0b9e3s8 ;
} elsif ( ( $f9o2b9e3s0 eq "page-my-ranking" ) || ( $f9o2b9e3s0 eq "page-other-voter-ranked-proposals" ) || ( $f9o2b9e3s0 eq "page-move-my-proposal" ) || ( $f9o2b9e3s0 eq "page-move-other-voter-proposal" ) )
{
$f5o5b8e3s9 .= "<main>Getting voter-specific vote info<\/main>" ;
&f0o8b9e3s0 ;
} elsif ( ( $f9o2b9e3s0 eq "page-tie-break-ranked-proposals" ) || ( $f9o2b9e3s0 eq "page-move-tie-break-proposals" ) )
{
$f5o5b8e3s9 .= "<main>Getting tie-break rankings<\/main>" ;
&f1o8b9e3s7 ;
@f3o8b9e3s4 = @f5o8b9e3s1 ;
@f6o8b9e3s8 = @f8o8b9e3s5 ;
@f0o9b9e3s2 = @f1o9b9e3s9 ;
$f5o5b8e3s9 .= "<main>Back from getting tie-break rankings<\/main>" ;
}
if ( &f6o7b8e3s3( "yes-lists-proposals-" . $f9o2b9e3s0 ) =~ /y/ )
{
$f5o5b8e3s9 .= "<main>Page lists proposals<\/main>" ;
&f3o9b9e3s6 ;
}
&f2o5b8e3s5( "list-of-recent-changes" , "" ) ;
if ( $f2o6b8e3s7 eq "home" )
{
$f5o5b8e3s9 .= "<main>Getting recent changes<\/main>" ;
&f5o9b9e3s3 ;
}
@f9o6b9e3s8 = &f9o3b9e3s2( &f0o3b9e3s7( "page-names-that-need-aliased-info" ) ) ;
$f5o5b8e3s9 .= "<main>List of pages needing aliased titles: " . join( " , " , @f9o6b9e3s8 ) . "<\/main>" ;
foreach $f1o7b9e3s5 ( @f9o6b9e3s8 )
{
if ( $f9o2b9e3s0 eq $f1o7b9e3s5  )
{
&f7o9b9e3s0 ;
last ;
}
}
if ( $f2o6b8e3s7 eq "getemailadmin" )
{
$f5o5b8e3s9 .= "<main>Need to send email<\/main>" ;
&f8o9b9e3s7 ;
}
&f2o5b8e3s5( "page-name" , $f9o2b9e3s0 ) ;
$f5o5b8e3s9 .= "<main>Web page to display: " . $f9o2b9e3s0 . "<\/main>" ;
if ( $f9o2b9e3s0 !~ /[a-z]/ )
{
$f5o5b8e3s9 .= "<main>No web page content<\/main>" ;
$f6o8b8e3s5 .= "ERROR: No web page content.  Contact the website administrator for assistance." ;
&f4o7b8e3s6 ;
}
&f2o5b8e3s5( "output-page-name" , $f9o2b9e3s0 ) ;
$f5o5b8e3s9 .= "<main>Generating page named " . $f9o2b9e3s0 . "<\/main>" ;
&f2o5b8e3s5( "web-page-content" , &f0o3b9e3s7( $f9o2b9e3s0 ) ) ;
if ( &f6o7b8e3s3( "admin-access-id-needed" ) =~ /y/ )
{
$f5o5b8e3s9 .= "<main>Need admin access ID<\/main>" ;
$f5o2b9e3s6 = $f3o2b9e3s9 ;
&f0o0b0e4s4 ;
}
if ( &f6o7b8e3s3( "participant-access-id-needed" ) =~ /y/ )
{
$f5o5b8e3s9 .= "<main>Need participant access ID<\/main>" ;
$f5o2b9e3s6 = $f7o4b9e3s7 ;
&f0o0b0e4s4 ;
}
$f5o5b8e3s9 .= "<main>Checking for need to mark radio buttons<\/main>" ;
&f2o0b0e4s1 ;
@f3o0b0e4s8 = &f9o3b9e3s2( &f6o7b8e3s3( "debugging-list-of-next-actions" ) ) ;
&f2o5b8e3s5( "debug-list-of-non-permission-next-action-names" , "" ) ;
foreach $f0o4b9e3s9 ( @f3o0b0e4s8 )
{
if ( &f6o7b8e3s3( "yes-no-permission-for-action-" . $f0o4b9e3s9 ) !~ /y/ )
{
if ( &f6o7b8e3s3( "debug-list-of-non-permission-next-action-names" ) eq "" )
{
&f2o5b8e3s5( "debug-list-of-non-permission-next-action-names" , "paragraph-standard-begin" . "  " . "NO PERMISSION FOR ACTIONS: " ) ;
}
&f6o7b8e3s3( "debug-list-of-non-permission-next-action-names" ) .= $f0o4b9e3s9 . ", " ;
$f5o5b8e3s9 .= "<main>DEBUG WARNING! Link to " . $f0o4b9e3s9 . " does not match permissions.<\/main>" ;
} else
{
$f5o5b8e3s9 .= "<main>Link to " . $f0o4b9e3s9 . " matches permissions.<\/main>" ;
}
}
if ( &f6o7b8e3s3( "debug-list-of-non-permission-next-action-names" ) ne "" )
{
&f2o5b8e3s5( "debug-list-of-non-permission-next-action-names" , " " ) . "paragraph-end" ;
}
$f5o5b8e3s9 .= "<main>Writing log information<\/main>" ;
&f8o0b9e3s6 ;
&f1o0b9e3s8 ;
&f4o7b8e3s6 ;
$f5o5b8e3s9 .= "<main>Logging new replacements<\/main>" ;
&f5o3b9e3s8 ;
if ( &f6o7b8e3s3( "web-page-content" ) =~ /^ *$/s )
{
$f5o5b8e3s9 .= "<main>No web page content<\/main>" ;
$f6o8b8e3s5 .= "ERROR: No web page content.  Contact the website administrator for assistance." ;
&f1o0b9e3s8 ;
&f4o7b8e3s6 ;
}
if ( $f6o9b8e3s7 ne "" )
{
$f5o5b8e3s9 .= "<main>User error string is not empty<\/main>" ;
&f6o7b8e3s3( "user-error-message-wording" ) .= " " . $f6o9b8e3s7 ;
}
if ( &f6o7b8e3s3( "user-error-message-wording" ) ne "" )
{
$f5o5b8e3s9 .= "<main>Getting user error message<\/main>" ;
&f2o5b8e3s5( "possible-user-error-message" , "user-error-message" ) ;
}
if ( $f5o0b0e4s5 =~ /[^ ]/ )
{
$f5o5b8e3s9 .= "<main>Warning message string is not empty<\/main>" ;
$f7o0b0e4s2 = "warning-message-prefix\n" . $f5o0b0e4s5 . "\nwarning-message-suffix" . &f6o7b8e3s3( "web-page-content" ) . "\n"
&f2o5b8e3s5( "web-page-content" , $f7o0b0e4s2 ) ;
}
$f5o5b8e3s9 .= "<main>Generating web page<\/main>" ;
$f2o3b9e3s4 = &f4o3b9e3s1( $f4o6b8e3s4 ) ;
$f2o3b9e3s4 =~ s/<eol \/>/\n/sg ;
if ( $f2o3b9e3s4 =~ /^(.*)texttoexport(.*)$/s )
{
$f8o0b0e4s9 = $1 ;
$f0o1b0e4s6 = $2 ;
$f2o3b9e3s4 = $f8o0b0e4s9 . $f2o1b0e4s3 . $f0o1b0e4s6 ;
$f5o5b8e3s9 .= "<main>Inserted text to export: " . $f2o1b0e4s3 . "<\/main>" ;
}
print $f1o8b8e3s4 ;
print $f2o3b9e3s4 ;
$f5o5b8e3s9 .= "[\/GenNegLog]" ;
&f1o0b9e3s8 ;
}
sub f3o9b8e3s3
{
my ( $f4o1b0e4s0 ) ;
my ( $f5o1b0e4s7 ) ;
my ( $f7o1b0e4s4 ) ;
my ( $f9o1b0e4s1 ) ;
my ( $f0o2b0e4s8 ) ;
my ( $f2o2b0e4s5 ) ;
my ( $f4o2b0e4s2 ) ;
$f5o2b0e4s9 = 0 ;
$f5o5b8e3s9 .= "<convertcaseuser>Supplied Access ID: " . &f6o7b8e3s3( "input-accessid" ) . "<\/convertcaseuser>" ;
if ( &f6o7b8e3s3( "input-accessid" ) =~ /^ *([0-9]+)speccase([0-9]+) *$/ )
{
$f9o8b8e3s9 = $1 ;
$f5o9b8e3s0 = $2 ;
$f5o5b8e3s9 .= "<convertcaseuser>Special Access ID converted to specific case number and user ID<\/convertcaseuser>" ;
&f2o5b8e3s5( "parameter-access-id" , "unknown" ) ;
$f5o5b8e3s9 .= "<convertcaseuser>Access ID = " . &f6o7b8e3s3( "input-accessid" ) . "<\/convertcaseuser>" ;
$f5o5b8e3s9 .= "<convertcaseuser>Case number is " . $f9o8b8e3s9 . "<\/convertcaseuser>" ;
$f5o5b8e3s9 .= "<convertcaseuser>User ID number is " . $f5o9b8e3s0 . "<\/convertcaseuser>" ;
&f7o2b0e4s6 ;
$f5o5b8e3s9 .= "<convertcaseuser>Access ID is " . $f1o9b8e3s6 . "<\/convertcaseuser>" ;
return ;
}
if ( ( &f6o7b8e3s3( "input-accessid" ) =~ /[a-z]/ )  && ( &f6o7b8e3s3( "accessid-alias-" . &f6o7b8e3s3( "input-accessid" ) ) =~ /[0-9][0-9][0-9]/ ) )
{
$f4o1b0e4s0 = &f6o7b8e3s3( "input-accessid" ) ;
&f2o5b8e3s5( "input-accessid" , &f6o7b8e3s3( "accessid-alias-" . &f6o7b8e3s3( "input-accessid" ) ) ) ;
$f5o5b8e3s9 .= "<convertcaseuser>Alias " . $f4o1b0e4s0 .  " converted to Access ID " . &f6o7b8e3s3( "input-accessid" ) . "<\/convertcaseuser>" ;
}
$f9o8b8e3s9 = 0 ;
$f5o9b8e3s0 = 0 ;
$f5o1b0e4s7 = &f6o7b8e3s3( "input-accessid" ) ;
$f5o1b0e4s7 =~ s/[^0-9]+//g ;
$f5o5b8e3s9 .= "<convertcaseuser>Revised copy of Access ID is " . $f5o1b0e4s7 . "<\/convertcaseuser>" ;
if ( $f5o1b0e4s7 =~ /[0-9][0-9]/ )
{
$f5o5b8e3s9 .= "<convertcaseuser>Access ID here is " . &f6o7b8e3s3( "input-accessid" ) . "<\/convertcaseuser>" ;
&f9o2b0e4s3 ;
} else
{
$f5o5b8e3s9 .= "<convertcaseuser>Access ID not supplied<\/convertcaseuser>" ;
}
$f5o5b8e3s9 .= "<convertcaseuser>Case number is " . $f9o8b8e3s9 . "<\/convertcaseuser>" ;
&f2o5b8e3s5( "parameter-user-id" , $f5o9b8e3s0 ) ;
$f5o5b8e3s9 .= "<convertcaseuser>User ID number is " . $f5o9b8e3s0 . "<\/convertcaseuser>" ;
if ( &f6o7b8e3s3( "input-accessid" ) =~ /[0-9]/ )
{
&f2o5b8e3s5( "parameter-access-id" , &f6o7b8e3s3( "input-accessid" ) ) ;
} else
{
&f2o5b8e3s5( "parameter-access-id" , "unknown" ) ;
}
$f5o5b8e3s9 .= "<convertcaseuser>Access ID = " . &f6o7b8e3s3( "input-accessid" ) . "<\/convertcaseuser>" ;
$f5o5b8e3s9 .= "<convertcaseuser>Case number = " . $f9o8b8e3s9 . "<\/convertcaseuser>" ;
}
sub f0o0b0e4s4
{
my ( $f1o3b0e4s0 ) ;
$f2o3b0e4s7 = $f5o9b8e3s0 ;
$f4o3b0e4s4 = &f6o7b8e3s3( "input-accessid" ) ;
$f5o5b8e3s9 .= "<getparticipantid>Input specifies participant ID " . $f5o2b9e3s6 . "<\/getparticipantid>" ;
&f1o0b9e3s8 ;
&f6o3b0e4s1 ;
&f1o0b9e3s8 ;
$f7o3b0e4s8 = "participant-userid-for-participantid-" . $f5o2b9e3s6 ;
if ( &f6o7b8e3s3( $f7o3b0e4s8 ) =~ /[1-9]/ )
{
$f5o9b8e3s0 = &f6o7b8e3s3( $f7o3b0e4s8 ) ;
$f5o5b8e3s9 .= "<getparticipantid>Based on replacement info, participant's USER ID number is " . $f5o9b8e3s0 . "<\/getparticipantid>" ;
&f1o0b9e3s8 ;
} elsif ( $f5o2b9e3s6 == $f3o2b9e3s9 )
{
$f5o9b8e3s0 = $f2o3b0e4s7 ;
$f5o5b8e3s9 .= "<getparticipantid>User is participant, participant's USER ID number is " . $f5o9b8e3s0 . "<\/getparticipantid>" ;
&f1o0b9e3s8 ;
} else
{
$f5o9b8e3s0 = 0 ;
$f5o5b8e3s9 .= "<getparticipantid>Using participant USER ID number of zero<\/getparticipantid>" ;
&f1o0b9e3s8 ;
}
$f5o5b8e3s9 .= "<getparticipantid>Participant's USER ID number is " . $f5o9b8e3s0 . "<\/getparticipantid>" ;
&f1o0b9e3s8 ;
&f7o2b0e4s6 ;
$f1o3b0e4s0 = $f1o9b8e3s6 ;
&f1o0b9e3s8 ;
$f5o9b8e3s0 = $f2o3b0e4s7 ;
$f1o9b8e3s6 = $f4o3b0e4s4 ;
&f2o5b8e3s5( "output-access-id" , $f1o9b8e3s6 ) ;
&f2o5b8e3s5( "input-accessid" , $f1o9b8e3s6 ) ;
&f2o5b8e3s5( "access-id-for-participantid-" . $f5o2b9e3s6 , $f1o3b0e4s0 ) ;
$f5o5b8e3s9 .= "<getparticipantid>Participant's access ID number is " . $f1o3b0e4s0 . "<\/getparticipantid>" ;
&f1o0b9e3s8 ;
return
}
sub f6o3b0e4s1
{
my ( $f9o3b0e4s5 ) ;
@f1o4b0e4s2 = (
6, 1, 2, 1, 4, 2, 1, 3, 2, 1, 2, 1, 4, 1, 2, 2, 1, 6,
7, 5, 2, 1, 2, 3, 1, 2, 4, 2, 1, 2, 1, 3, 2, 1, 1, 7,
8, 2, 1, 4, 2, 1, 2, 1, 3, 1, 1, 2, 2, 2, 1, 2, 1, 8 ) ;
foreach $f9o3b0e4s5 ( 1 .. 8 )
{
@f2o4b0e4s9[ $f9o3b0e4s5 ] = 0 ;
}
foreach $f9o3b0e4s5 ( @f1o4b0e4s2 )
{
@f2o4b0e4s9[ $f9o3b0e4s5 ] ++ ;
}
foreach $f9o3b0e4s5 ( 1 .. 8 )
{
}
$f4o4b0e4s6 = 2 ** $f2o4b0e4s9[ 1 ] ;
$f5o5b8e3s9 .= "<bitsequence>Packing bits done, limit is: " . $f4o4b0e4s6 . "<\/bitsequence>" ;
}
sub f7o2b0e4s6
{
my ( $f9o3b0e4s5 ) ;
my ( $f6o4b0e4s3 ) ;
my ( @f8o4b0e4s0 ) ;
my ( @f9o4b0e4s7 ) ;
$f8o4b0e4s0[ 1 ] = 1 ;
$f8o4b0e4s0[ 2 ] = 1 ;
$f8o4b0e4s0[ 3 ] = 1 ;
$f8o4b0e4s0[ 4 ] = 1 ;
$f8o4b0e4s0[ 5 ] = 1 ;
$f8o4b0e4s0[ 6 ] = 1 ;
$f8o4b0e4s0[ 7 ] = 1 ;
$f8o4b0e4s0[ 8 ] = 1 ;
$f9o8b8e3s9 %= 2 ** $f2o4b0e4s9[ 1 ] ;
$f5o5b8e3s9 .= "<idpack>Case number = " . $f9o8b8e3s9 . "<\/idpack>" ;
$f5o9b8e3s0 %= 2 ** $f2o4b0e4s9[ 2 ] ;
$f5o5b8e3s9 .= "<idpack>User id = " . $f5o9b8e3s0 . "<\/idpack>" ;
$f1o5b0e4s4 = unpack( "%4b*" , $f9o8b8e3s9 ) ;
$f3o5b0e4s1 = unpack( "%4b*" , $f5o9b8e3s0 ) ;
$f9o4b0e4s7[ 1 ] = $f9o8b8e3s9 ;
$f9o4b0e4s7[ 2 ] = $f5o9b8e3s0 ;
$f9o4b0e4s7[ 3 ] = $f1o5b0e4s4 ;
$f9o4b0e4s7[ 4 ] = $f3o5b0e4s1 ;
$f9o4b0e4s7[ 5 ] = $f4o5b0e4s8 ;
$f9o4b0e4s7[ 6 ] = 0 ;
$f9o4b0e4s7[ 7 ] = 0 ;
$f9o4b0e4s7[ 8 ] = 0 ;
foreach $f9o3b0e4s5 ( 1 .. 8 )
{
}
foreach $f9o3b0e4s5 ( @f1o4b0e4s2 )
{
if ( $f9o3b0e4s5 > 5 )
{
$f6o4b0e4s3 = $f9o3b0e4s5 ;
next ;
}
$f9o4b0e4s7[ $f6o4b0e4s3 ] = ( $f9o4b0e4s7[ $f6o4b0e4s3 ] * 2 ) + ( $f9o4b0e4s7[ $f9o3b0e4s5 ] % 2 ) ;
$f9o4b0e4s7[ $f9o3b0e4s5 ] = int( $f9o4b0e4s7[ $f9o3b0e4s5 ] / 2 ) ;
$f8o4b0e4s0[ $f9o3b0e4s5 ] *= 2 ;
$f8o4b0e4s0[ $f6o4b0e4s3 ] *= 2 ;
}
$f1o9b8e3s6 = sprintf( "%05d" , $f9o4b0e4s7[ 8 ] ) . "-" . sprintf( "%05d" , $f9o4b0e4s7[ 7 ] ) . "-" . sprintf( "%05d" , $f9o4b0e4s7[ 6 ] ) ;
&f2o5b8e3s5( "output-access-id" , $f1o9b8e3s6 ) ;
&f2o5b8e3s5( "input-accessid" , $f1o9b8e3s6 ) ;
}
sub f9o2b0e4s3
{
my ( @f9o4b0e4s7 ) ;
my ( $f9o3b0e4s5 ) ;
my ( $f6o5b0e4s5 ) ;
my ( $f8o5b0e4s2 ) ;
my ( $f9o5b0e4s9 ) ;
$f9o4b0e4s7[ 1 ] = 0 ;
$f9o4b0e4s7[ 2 ] = 0 ;
$f9o4b0e4s7[ 3 ] = 0 ;
$f9o4b0e4s7[ 4 ] = 0 ;
$f9o4b0e4s7[ 5 ] = 0 ;
$f6o5b0e4s5 = &f6o7b8e3s3( "input-accessid" ) ;
&f2o5b8e3s5( "output-access-id" , $f6o5b0e4s5 ) ;
$f5o5b8e3s9 .= "<unpack>Unpacking Access ID = " . $f6o5b0e4s5 . "<\/unpack>" ;
$f6o5b0e4s5 =~ s/[^0-9]+//g ;
$f8o5b0e4s2 = reverse( $f6o5b0e4s5 ) ;
$f8o5b0e4s2 =~ s/([0-9][0-9][0-9][0-9][0-9])(?=[0-9])/$1-/ ;
$f8o5b0e4s2 =~ s/([0-9][0-9][0-9][0-9][0-9])(?=[0-9])/$1-/ ;
$f6o5b0e4s5 = reverse( $f8o5b0e4s2 ) ;
( $f9o4b0e4s7[ 8 ] , $f9o4b0e4s7[ 7 ] , $f9o4b0e4s7[ 6 ] ) = split( "-" , $f6o5b0e4s5 ) ;
$f9o4b0e4s7[ 6 ] += 0 ;
$f9o4b0e4s7[ 7 ] += 0 ;
$f9o4b0e4s7[ 8 ] += 0 ;
foreach $f9o3b0e4s5 ( reverse( @f1o4b0e4s2 ) )
{
if ( $f9o3b0e4s5 > 5 )
{
$f9o5b0e4s9 = $f9o3b0e4s5 ;
next ;
}
$f9o4b0e4s7[ $f9o3b0e4s5 ] = ( $f9o4b0e4s7[ $f9o3b0e4s5 ] * 2 ) + ( $f9o4b0e4s7[ $f9o5b0e4s9 ] % 2 ) ;
$f9o4b0e4s7[ $f9o5b0e4s9 ] = int( $f9o4b0e4s7[ $f9o5b0e4s9 ] / 2 ) ;
}
foreach $f9o3b0e4s5 ( 1 .. 8 )
{
}
$f9o8b8e3s9 = $f9o4b0e4s7[ 1 ] + 0 ;
$f5o9b8e3s0 = $f9o4b0e4s7[ 2 ] + 0 ;
$f1o5b0e4s4 = $f9o4b0e4s7[ 3 ] ;
$f3o5b0e4s1 = $f9o4b0e4s7[ 4 ] ;
$f4o5b0e4s8 = $f9o4b0e4s7[ 5 ] ;
&f2o5b8e3s5( "user-id-number" , $f5o9b8e3s0 ) ;
$f5o5b8e3s9 .= "<unpack>Case number = " . $f9o8b8e3s9 . "<\/unpack>" ;
$f1o6b0e4s6 = unpack( "%4b*" , $f9o8b8e3s9 ) ;
$f3o6b0e4s3 = unpack( "%4b*" , $f5o9b8e3s0 ) ;
if ( ( $f1o5b0e4s4 != $f1o6b0e4s6 ) || ( $f3o5b0e4s1 != $f3o6b0e4s3 ) || ( $f9o4b0e4s7[ 6 ] != 0 ) || ( $f9o4b0e4s7[ 7 ] != 0 ) || ( $f9o4b0e4s7[ 8 ] != 0 ) )
{
$f9o8b8e3s9 = 0 ;
$f5o9b8e3s0 = 0 ;
$f5o5b8e3s9 .= "<unpack>CRC values not correct or remainders not zero, so Access ID is invalid, so regarding user as unknown<\/unpack>" ;
} else
{
$f5o5b8e3s9 .= "<unpack>Special checks of Access ID are valid<\/unpack>" ;
}
return ;
}
sub f5o6b0e4s0
{
( $f6o6b0e4s7 ) = @_ ;
$f6o6b0e4s7 =~ s/&/[;;]amp;/sg ;
$f6o6b0e4s7 =~ s/\[;;\]/&/sg ;
$f5o5b8e3s9 .= "<cleanuptext>Without typed-in ampersands: " . $f6o6b0e4s7 . "<\/cleanuptext>" ;
$f6o6b0e4s7 =~ s/\-/&#045;/sg ;
$f5o5b8e3s9 .= "<cleanuptext>Without hyphens: " . $f6o6b0e4s7 . "<\/cleanuptext>" ;
$f6o6b0e4s7 =~ s/<eol *\/>/ line-break /sg ;
$f5o5b8e3s9 .= "<cleanuptext>With [eol] directives replaced: " . $f6o6b0e4s7 . "<\/cleanuptext>" ;
$f6o6b0e4s7 =~ s/([^ ]):/$1 no-space :/sg ;
$f5o5b8e3s9 .= "<cleanuptext>With colons isolated: " . $f6o6b0e4s7 . "<\/cleanuptext>" ;
$f6o6b0e4s7 =~ s/</&#60;/sg ;
$f6o6b0e4s7 =~ s/>/&#62;/sg ;
$f6o6b0e4s7 =~ s/\n+/ line-break /sg ;
$f6o6b0e4s7 =~ s/\t+/ non-breaking-space /sg ;
$f6o6b0e4s7 =~ s/\//&#047;/sg ;
$f6o6b0e4s7 =~ s/\\/&#092;/sg ;
$f6o6b0e4s7 =~ s/  +/ /sg ;
$f6o6b0e4s7 =~ s/^ +// ;
$f6o6b0e4s7 =~ s/ +$// ;
$f5o5b8e3s9 .= "<cleanuptext>After cleanup: " . $f6o6b0e4s7 . "<\/cleanuptext>" ;
return $f6o6b0e4s7 ;
}
sub f2o5b8e3s5
{
my ( $f8o6b0e4s4 ) ;
my ( $f0o7b0e4s1 ) ;
$f8o6b0e4s4 = $_[ 0 ] ;
$f0o7b0e4s1 = $_[ 1 ] ;
$f8o6b0e4s4 =~ s/^ +// ;
$f8o6b0e4s4 =~ s/ +$// ;
$f1o7b0e4s8{ $f8o6b0e4s4 } = $f0o7b0e4s1 ;
return 1 ;
}
sub f1o7b8e3s2
{
my ( $f4o2b0e4s2 ) ;
my ( $f3o7b0e4s5 ) ;
my ( $f5o7b0e4s2 ) ;
my ( $f6o7b0e4s9 ) ;
my ( $f8o7b0e4s6 ) ;
my ( $f0o8b0e4s3 ) ;
my ( $f2o8b0e4s0 ) ;
my ( $f3o8b0e4s7 ) ;
my ( $f5o8b0e4s4 ) ;
my ( @f7o8b0e4s1 ) ;
my ( @f8o8b0e4s8 ) ;
$f6o7b0e4s9 = $_[ 0 ] ;
@f7o8b0e4s1 = ( ) ;
$f6o7b0e4s9 =~ s/[\n\r]/ /sg ;
$f6o7b0e4s9 =~ s/[\n\r]/ /sg ;
$f6o7b0e4s9 =~ s/  +/ /sg ;
$f6o7b0e4s9 =~ s/\*\-\-\-+\*/ /g ;
while ( $f6o7b0e4s9 =~ /^(.*?)(\*\-\-+)(.*)$/ )
{
$f8o7b0e4s6 = $1 ;
$f1o7b0e4s8{ "comments_ignored" } .= "  " . $2 ;
$f0o8b0e4s3 = $3 ;
$f2o8b0e4s0 = "" ;
if ( $f0o8b0e4s3 =~ /^(.*?\-\-+\*)(.*)$/ )
{
$f1o7b0e4s8{ "comments_ignored" } .= $1 . "  " ;
$f2o8b0e4s0 = $2 ;
}
$f6o7b0e4s9 = $f8o7b0e4s6 . " " . $f2o8b0e4s0 ;
}
$f6o7b0e4s9 =~ s/  +/ /g ;
@f8o8b0e4s8 = split( / / , $f6o7b0e4s9 ) ;
$f4o2b0e4s2 = "" ;
foreach $f5o7b0e4s2 ( @f8o8b0e4s8 )
{
if ( $f5o7b0e4s2 =~ /^ *$/ )
{
$f3o8b0e4s7 ++ ;
} elsif ( $f5o7b0e4s2 eq 'define-begin' )
{
$f3o8b0e4s7 ++ ;
} elsif ( ( $f5o7b0e4s2 eq 'define-end' ) || ( $f5o7b0e4s2 =~ /^---+$/ ) )
{
$f3o7b0e4s5 = $f1o7b0e4s8{ $f4o2b0e4s2 } ;
$f3o7b0e4s5 =~ s/ +$// ;
if ( $f3o7b0e4s5 =~ /[^ \n\r]/ )
{
$f1o7b0e4s8{ $f4o2b0e4s2 } = $f3o7b0e4s5 ;
} else
{
$f1o7b0e4s8{ $f4o2b0e4s2 } = "" ;
}
$f4o2b0e4s2 = "" ;
} elsif ( $f4o2b0e4s2 eq "" )
{
$f4o2b0e4s2 = $f5o7b0e4s2 ;
$f4o2b0e4s2 =~ s/\:$//  ;
$f1o7b0e4s8{ $f4o2b0e4s2 } = "" ;
push( @f7o8b0e4s1 , $f4o2b0e4s2 ) ;
} elsif ( $f5o7b0e4s2 ne "" )
{
if ( $f5o7b0e4s2 eq $f4o2b0e4s2 )
{
$f1o7b0e4s8{ $f4o2b0e4s2 } = "ERROR: Replacement for hyphenated phrase [" . $f4o2b0e4s2 . "] includes itself, which would cause an endless replacement loop." . "\n" ;
$f5o5b8e3s9 .= "<dashrep>Warning: Replacement for hyphenated phrase " . $f4o2b0e4s2 . " includes itself, which would cause an endless replacement loop." . "\n" . "<\/dashrep>" ;
} else
{
$f1o7b0e4s8{ $f4o2b0e4s2 } = $f1o7b0e4s8{ $f4o2b0e4s2 } . $f5o7b0e4s2 . "  " ;
}
}
}
return $#f7o8b0e4s1 + 1 ;
}
sub f6o7b8e3s3
{
my ( $f8o6b0e4s4 ) ;
my ( $f0o7b0e4s1 ) ;
if ( scalar( @_ ) == 1 )
{
$f8o6b0e4s4 = $_[ 0 ] ;
} else
{
return 0 ;
}
$f0o7b0e4s1 = $f1o7b0e4s8{ $f8o6b0e4s4 } ;
return $f0o7b0e4s1 ;
}
sub f0o9b0e4s5
{
my ( @f2o9b0e4s2 ) ;
@f2o9b0e4s2 = keys( %f1o7b0e4s8 ) ;
return @f2o9b0e4s2 ;
}
sub f0o3b9e3s7
{
my ( $f3o9b0e4s9 ) ;
my ( $f5o9b0e4s6 ) ;
my ( $f7o9b0e4s3 ) ;
my ( $f9o9b0e4s0 ) ;
my ( $f0o0b1e4s7 ) ;
my ( $f2o0b1e4s4 ) ;
my ( $f4o0b1e4s1 ) ;
my ( $f0o4b9e3s9 ) ;
my ( $f5o0b1e4s8 ) ;
my ( $f7o0b1e4s5 ) ;
my ( $f9o0b1e4s2 ) ;
my ( $f0o1b1e4s9 ) ;
my ( $f2o1b1e4s6 ) ;
my ( $f4o1b1e4s3 ) ;
my ( $f6o1b1e4s0 ) ;
my ( $f7o1b1e4s7 ) ;
my ( $f9o1b1e4s4 ) ;
my ( $f1o2b1e4s1 ) ;
my ( $f2o2b1e4s8 ) ;
my ( $f4o2b1e4s5 ) ;
my ( $f6o2b1e4s2 ) ;
my ( $f7o2b1e4s9 ) ;
my ( @f9o2b1e4s6 ) ;
my ( @f1o3b1e4s3 ) ;
my ( @f3o3b1e4s0 ) ;
my ( %f4o3b1e4s7 ) ;
if ( scalar( @_ ) == 1 )
{
$f3o9b0e4s9 = $_[ 0 ] ;
} else
{
return 0 ;
}
$f5o9b0e4s6 = $f1o7b0e4s8{ $f3o9b0e4s9 } ;
@f3o3b1e4s0 = ( ) ;
$f7o9b0e4s3 = $f0o0b9e3s1 ;
while ( $f7o9b0e4s3 == $f0o0b9e3s1 )
{
$f7o9b0e4s3 = $f6o4b9e3s0 ;
while ( $f5o9b0e4s6 =~ /^(.*?)\[\-([^ \n\[\]\:=]+) *= *([^ \n\[\]\:=]+) *-?\](.*)$/ )
{
$f9o9b0e4s0 = $1 ;
$f0o0b1e4s7 = $2 ;
$f2o0b1e4s4 = $3 ;
$f4o0b1e4s1 = $4 ;
$f2o0b1e4s4 =~ s/\-+$// ;
if ( length( $f0o0b1e4s7 ) > 0 )
{
$f1o7b0e4s8{ $f0o0b1e4s7 } = $f2o0b1e4s4 ;
} else
{
}
$f5o9b0e4s6 = $f9o9b0e4s0 . " " . $f4o0b1e4s1 ;
$f7o9b0e4s3 = $f0o0b9e3s1 ;
if ( length( $f0o0b1e4s7 ) > 0 )
{
$f4o3b1e4s7{ $f0o0b1e4s7 } ++ ;
}
$f4o3b1e4s7{ $f2o0b1e4s4 } ++ ;
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 + 100 )
{
&f9o3b1e4s8( %f4o3b1e4s7 ) ;
$f5o5b8e3s9 .= "<dashrep>Error: The f0o3b9e3s7 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
}
while ( $f5o9b0e4s6 =~ /^(.*?)\[\-([^ \n\[\]\:=]+) *: *([^\[\]]*) *-?\](.*)$/ )
{
$f9o9b0e4s0 = $1 ;
$f0o4b9e3s9 = $2 ;
$f5o0b1e4s8 = $3 ;
$f4o0b1e4s1 = $4 ;
$f5o0b1e4s8 =~ s/\-+$// ;
if ( $f0o4b9e3s9 eq "zero-one-multiple-count-of-list" )
{
@f9o2b1e4s6 = &f1o4b1e4s5( $f5o0b1e4s8 ) ;
$f7o0b1e4s5 = $#f9o2b1e4s6 + 1 ;
if ( $f7o0b1e4s5 == 0 )
{
$f7o2b1e4s9 = "zero" ;
} elsif ( $f7o0b1e4s5 == 1 )
{
$f7o2b1e4s9 = "one" ;
} elsif ( $f7o0b1e4s5 > 1 )
{
$f7o2b1e4s9 = "multiple" ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f7o2b1e4s9 . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 eq "zero-one-multiple" )
{
if ( $f5o0b1e4s8 + 0 <= 0 )
{
$f9o0b1e4s2 = "zero" ;
} elsif ( $f5o0b1e4s8 + 0 == 1 )
{
$f9o0b1e4s2 = "one" ;
} else
{
$f9o0b1e4s2 = "multiple" ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f9o0b1e4s2 . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 eq "empty-or-nonempty" )
{
if ( $f5o0b1e4s8 =~ /[^ ]/ )
{
$f0o1b1e4s9 = "nonempty" ;
} else
{
$f0o1b1e4s9 = "empty" ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f0o1b1e4s9 . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 eq "same-or-not-same" )
{
$f2o1b1e4s6 = length( $f5o0b1e4s8 ) ;
$f4o1b1e4s3 = int( $f2o1b1e4s6 / 2 ) ;
$f6o1b1e4s0 = substr( $f5o0b1e4s8 , 0 , $f4o1b1e4s3 ) ;
$f7o1b1e4s7 = substr( $f5o0b1e4s8 , $f2o1b1e4s6 - $f4o1b1e4s3 , $f4o1b1e4s3 ) ;
if ( $f6o1b1e4s0 eq $f7o1b1e4s7 )
{
$f9o1b1e4s4 = "same" ;
} else
{
$f9o1b1e4s4 = "not-same" ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f9o1b1e4s4 . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 eq "sort-numbers" )
{
if ( $f5o0b1e4s8 =~ /[1-9]/ )
{
$f5o0b1e4s8 =~ s/ +/,/gs ;
$f5o0b1e4s8 =~ s/^,// ;
$f5o0b1e4s8 =~ s/,$// ;
@f9o2b1e4s6 = split( /,+/ , $f5o0b1e4s8 ) ;
@f1o3b1e4s3 = sort { $a <=> $b } @f9o2b1e4s6 ;
$f1o2b1e4s1 = join( "," , @f1o3b1e4s3 ) ;
} else
{
$f1o2b1e4s1 = " " ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f1o2b1e4s1 . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 =~ /^auto-increment/ )
{
if ( exists( $f1o7b0e4s8{ $f5o0b1e4s8 } ) )
{
$f1o7b0e4s8{ $f5o0b1e4s8 } = $f1o7b0e4s8{ $f5o0b1e4s8 } + 1 ;
} else
{
$f1o7b0e4s8{ $f5o0b1e4s8 } = 1 ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . " " . $f4o0b1e4s1 ;
} elsif ( $f0o4b9e3s9 eq "create-list-named" )
{
push ( @f3o4b1e4s2 , $f5o0b1e4s8 ) ;
$f5o9b0e4s6 = $f9o9b0e4s0 . " " . $f4o0b1e4s1 ;
} else
{
$f5o9b0e4s6 = $f9o9b0e4s0 . " " . $f4o0b1e4s1 ;
}
$f7o9b0e4s3 = $f0o0b9e3s1 ;
$f4o3b1e4s7{ $f0o4b9e3s9 } ++ ;
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 + 100 )
{
&f9o3b1e4s8( %f4o3b1e4s7 ) ;
$f5o5b8e3s9 .= "<dashrep>Error: The f0o3b9e3s7 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
}
if ( $f5o9b0e4s6 =~ /^(.*?)\[\-([^ \n\[\]]+)\-\](.*)$/ )
{
$f9o9b0e4s0 = $1 ;
$f2o2b1e4s8 = $2 ;
$f4o0b1e4s1 = $3 ;
if ( exists( $f1o7b0e4s8{ $f2o2b1e4s8 } ) )
{
$f4o2b1e4s5 = $f1o7b0e4s8{ $f2o2b1e4s8 } ;
} else
{
$f4o2b1e4s5 = "" ;
}
$f5o9b0e4s6 = $f9o9b0e4s0 . $f4o2b1e4s5 . $f4o0b1e4s1 ;
$f7o9b0e4s3 = $f0o0b9e3s1 ;
if ( $f2o2b1e4s8 =~ /^auto-increment-/ )
{
push( @f3o3b1e4s0 , $f2o2b1e4s8 ) ;
}
$f4o3b1e4s7{ $f2o2b1e4s8 } ++ ;
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 + 100 )
{
&f9o3b1e4s8( %f4o3b1e4s7 ) ;
$f5o5b8e3s9 .= "<dashrep>Error: The f0o3b9e3s7 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
}
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 )
{
&f9o3b1e4s8( %f4o3b1e4s7 ) ;
$f5o5b8e3s9 .= "<dashrep>Error: The f0o3b9e3s7 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
}
foreach $f2o2b1e4s8 ( @f3o3b1e4s0 )
{
$f1o7b0e4s8{ $f2o2b1e4s8 } ++ ;
}
@f3o3b1e4s0 = ( ) ;
return $f5o9b0e4s6 ;
}
sub f4o4b1e4s9
{
my ( $f6o4b1e4s6 ) ;
my ( $f8o4b1e4s3 ) ;
my ( $f0o5b1e4s0 ) ;
my ( $f6o2b1e4s2 ) ;
my ( $f1o5b1e4s7 ) ;
my ( $f3o5b1e4s4 ) ;
my ( $f5o5b1e4s1 ) ;
my ( $f6o5b1e4s8 ) ;
my ( $f8o5b1e4s5 ) ;
my ( $f0o6b1e4s2 ) ;
my ( $f1o6b1e4s9 ) ;
my ( @f3o6b1e4s6 ) ;
my ( @f5o6b1e4s3 ) ;
my ( %f4o3b1e4s7 ) ;
$f8o4b1e4s3 = $_[ 0 ] ;
&f7o6b1e4s0 ;
@f3o6b1e4s6 = ( ) ;
push( @f3o6b1e4s6 , $f8o4b1e4s3 ) ;
$f0o5b1e4s0 = "" ;
while( $#f3o6b1e4s6 >= 0 )
{
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 )
{
&f9o3b1e4s8( %f4o3b1e4s7 ) ;
$f5o5b8e3s9 .= "<dashrep>Error: The f4o4b1e4s9 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
$f6o4b1e4s6 = pop( @f3o6b1e4s6 ) ;
$f6o4b1e4s6 =~ s/^ +// ;
$f6o4b1e4s6 =~ s/ +$// ;
if ( $f6o4b1e4s6 eq "" )
{
next ;
}
if ( $f6o4b1e4s6 =~ /^ *([^ ]+)[ \n\r]+(.*)$/ )
{
$f1o5b1e4s7 = $1 ;
$f3o5b1e4s4 = $2 ;
if ( $f3o5b1e4s4 =~ /[^ ]/ )
{
push( @f3o6b1e4s6 , $f3o5b1e4s4 ) ;
}
push( @f3o6b1e4s6 , $f1o5b1e4s7 ) ;
next ;
}
if ( exists( $f1o7b0e4s8{ $f6o4b1e4s6 } ) )
{
$f5o5b1e4s1 = $f1o7b0e4s8{ $f6o4b1e4s6 } ;
if ( $f5o5b1e4s1 =~ /[^ ]/ )
{
@f5o6b1e4s3 = split( /[ \n\r]+/ , $f5o5b1e4s1 ) ;
push( @f3o6b1e4s6 , reverse( @f5o6b1e4s3 ) ) ;
$f4o3b1e4s7{ $f6o4b1e4s6 } ++ ;
next ;
}
next ;
}
$f0o5b1e4s0 .= $f6o4b1e4s6 . " " ;
}
$f1o6b1e4s9 = $f1o7b0e4s8{ "non-breaking-space" } ;
while ( $f0o5b1e4s0 =~ /^(.*)\bspan-non-breaking-spaces-begin\b *(.*?) *\bspan-non-breaking-spaces-end\b(.*)$/sgi )
{
$f6o5b1e4s8 = $1 ;
$f8o5b1e4s5 = $2 ;
$f0o6b1e4s2 = $3 ;
$f8o5b1e4s5 =~ s/ +/ ${f1o6b1e4s9} /sgi ;
$f0o5b1e4s0 = $f6o5b1e4s8 . $f8o5b1e4s5 . $f0o6b1e4s2 ;
}
return $f0o5b1e4s0 ;
}
sub f4o3b9e3s1
{
my ( $f8o6b1e4s7 ) ;
my ( $f8o4b1e4s3 ) ;
$f8o4b1e4s3 = $_[ 0 ] ;
$f8o6b1e4s7 = &f4o4b1e4s9( $f8o4b1e4s3 ) ;
$f8o6b1e4s7 =~ s/ *\bempty-line\b */\n\n/sg ;
$f8o6b1e4s7 =~ s/ *\bnew-line\b */\n/sg ;
$f8o6b1e4s7 =~ s/\bone-space\b/<onespace>/sgi ;
$f8o6b1e4s7 =~ s/\bno-space\b/<nospace>/sgi ;
$f8o6b1e4s7 =~ s/([ \t]*<nospace>)+[ \t]*//sgi ;
$f8o6b1e4s7 =~ s/[ \t]*(<nospace>[ \t]*)+//sgi ;
$f8o6b1e4s7 =~ s/([ \t]*<onespace>)+[ \t]*//sgi ;
$f8o6b1e4s7 =~ s/[ \t]*(<onespace>[ \t]*)+//sgi ;
return $f8o6b1e4s7 ;
}
sub f7o6b1e4s0
{
my ( $f0o7b1e4s4 ) ;
my ( $f2o7b1e4s1 ) ;
my ( $f3o7b1e4s8 ) ;
my ( $f3o8b0e4s7 ) ;
my ( $f5o7b1e4s5 ) ;
my ( $f7o7b1e4s2 ) ;
my ( $f8o7b1e4s9 ) ;
my ( $f7o3b0e4s8 ) ;
my ( $f0o8b1e4s6 ) ;
my ( $f2o8b1e4s3 ) ;
my ( $f4o8b1e4s0 ) ;
my ( $f6o2b1e4s2 ) ;
my ( @f5o8b1e4s7 ) ;
my ( %f7o8b1e4s4 ) ;
foreach $f0o7b1e4s4 ( @f3o4b1e4s2 )
{
if ( exists( $f7o8b1e4s4{ $f0o7b1e4s4 } ) )
{
if ( $f7o8b1e4s4{ $f0o7b1e4s4 } == $f6o4b9e3s0 )
{
next ;
}
}
$f7o8b1e4s4{ $f0o7b1e4s4 } = $f6o4b9e3s0 ;
$f2o7b1e4s1 = "generated-list-named-" . $f0o7b1e4s4 ;
$f3o7b1e4s8 = $f1o7b0e4s8{ "parameter-name-for-list-named-" . $f0o7b1e4s4 } ;
if ( exists( $f1o7b0e4s8{ "prefix-for-list-named-" . $f0o7b1e4s4 } ) )
{
$f3o8b0e4s7 ++ ;
} else
{
$f1o7b0e4s8{ "prefix-for-list-named-" . $f0o7b1e4s4 } = "" ;
}
$f5o7b1e4s5 = &f0o3b9e3s7( "prefix-for-list-named-" . $f0o7b1e4s4 ) . "\n" ;
if ( exists( $f1o7b0e4s8{ "separator-for-list-named-" . $f0o7b1e4s4 } ) )
{
$f3o8b0e4s7 ++ ;
} else
{
$f1o7b0e4s8{ "separator-for-list-named-" . $f0o7b1e4s4 } = "" ;
}
$f7o7b1e4s2 = &f0o3b9e3s7( "separator-for-list-named-" . $f0o7b1e4s4 ) . "\n" ;
if ( exists( $f1o7b0e4s8{ "suffix-for-list-named-" . $f0o7b1e4s4 } ) )
{
$f3o8b0e4s7 ++ ;
} else
{
$f1o7b0e4s8{ "suffix-for-list-named-" . $f0o7b1e4s4 } = "" ;
}
$f8o7b1e4s9 = &f0o3b9e3s7( "suffix-for-list-named-" . $f0o7b1e4s4 ) . "\n" ;
$f7o3b0e4s8 = "list-of-parameter-values-for-list-named-" . $f0o7b1e4s4 ;
$f0o8b1e4s6 = &f0o3b9e3s7( "list-of-parameter-values-for-list-named-" . $f0o7b1e4s4 ) ;
@f5o8b1e4s7 = &f1o4b1e4s5( $f0o8b1e4s6 ) ;
$f1o7b0e4s8{ "logged-list-of-parameter-values-for-list-named-" . $f0o7b1e4s4 } = join( "," , @f5o8b1e4s7 ) ;
$f1o7b0e4s8{ $f2o7b1e4s1 } = $f5o7b1e4s5 . "\n" ;
for ( $f2o8b1e4s3 = 0 ; $f2o8b1e4s3 <= $#f5o8b1e4s7 ; $f2o8b1e4s3 ++ )
{
$f4o8b1e4s0 = $f5o8b1e4s7[ $f2o8b1e4s3 ] ;
$f1o7b0e4s8{ $f3o7b1e4s8 } = $f4o8b1e4s0 ;
$f6o2b1e4s2 = "item-for-list-" . $f0o7b1e4s4 . "-and-parameter-" . $f4o8b1e4s0 ;
$f1o7b0e4s8{ $f2o7b1e4s1 } .= $f6o2b1e4s2 . "\n" ;
$f1o7b0e4s8{ $f6o2b1e4s2 } = &f0o3b9e3s7( "template-for-list-named-" . $f0o7b1e4s4 ) ;
if ( $f2o8b1e4s3 < $#f5o8b1e4s7 )
{
$f1o7b0e4s8{ $f2o7b1e4s1 } .= $f7o7b1e4s2 . "\n" ;
}
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 )
{
$f5o5b8e3s9 .= "<dashrep>Error: The f7o6b1e4s0 subroutine encountered an endless loop.<\/dashrep>" ;
&f4o7b8e3s6 ;
}
}
$f1o7b0e4s8{ $f2o7b1e4s1 } .= $f8o7b1e4s9 . "\n" ;
}
return 1 ;
}
sub f9o3b1e4s8
{
my ( $f6o2b1e4s2 ) ;
my ( $f9o8b1e4s1 ) ;
my ( $f0o9b1e4s8 ) ;
my ( %f4o3b1e4s7 ) ;
$f9o8b1e4s1 = - 1 ;
foreach $f6o2b1e4s2 ( keys( %f4o3b1e4s7 ) )
{
if ( $f4o3b1e4s7{ $f6o2b1e4s2 } > $f9o8b1e4s1 )
{
$f9o8b1e4s1 = $f4o3b1e4s7{ $f6o2b1e4s2 } ;
$f0o9b1e4s8 = $f6o2b1e4s2 ;
}
}
$f5o5b8e3s9 .= "<dashrep>Too many cycles of replacement.\n" . "Hyphenated phrase with highest replacement count (" . $f9o8b1e4s1 . ") is:\n" . "    " . $f0o9b1e4s8 . "\n" . "<\/dashrep>" ;
return 1 ;
}
sub f1o4b1e4s5
{
my ( $f2o9b1e4s5 ) ;
my ( @f4o9b1e4s2 ) ;
$f2o9b1e4s5 = $_[ 0 ] ;
if ( $f2o9b1e4s5 =~ /[\n\r]/ )
{
$f2o9b1e4s5 =~ s/[\n\r][\n\r]+/,/gs ;
$f2o9b1e4s5 =~ s/[\n\r][\n\r]+/,/gs ;
}
$f2o9b1e4s5 =~ s/ +/,/gs ;
$f2o9b1e4s5 =~ s/,,+/,/gs ;
$f2o9b1e4s5 =~ s/^,// ;
$f2o9b1e4s5 =~ s/,$// ;
if ( $f2o9b1e4s5 =~ /^[ ,]*$/ )
{
@f4o9b1e4s2 = ( ) ;
} else
{
@f4o9b1e4s2 = split( /,+/ , $f2o9b1e4s5 ) ;
}
return @f4o9b1e4s2 ;
}
sub f8o9b9e3s7
{
$f5o9b1e4s9 = &f0o3b9e3s7( "case-info-emailadmin" ) ;
$f5o5b8e3s9 .= "<emailsend>Email address: " . $f5o9b1e4s9 . "<\/emailsend>" ;
$f7o9b1e4s6 = &f0o3b9e3s7( "email-return-address" ) ;
$f5o5b8e3s9 .= "<emailsend>Email return address: " . $f7o9b1e4s6 . "<\/emailsend>" ;
$f9o9b1e4s3 = &f0o3b9e3s7( "email-subject" ) ;
$f5o5b8e3s9 .= "<emailsend>Email subject: " . $f9o9b1e4s3 . "<\/emailsend>" ;
$f1o0b2e4s0 = &f6o7b8e3s3( "users-participant-id" ) ;
$f2o0b2e4s7 = &f0o3b9e3s7( "words-message-from-participant" ) . " " . $f1o0b2e4s0 . ", " . &f6o7b8e3s3( "participant-shortname-for-participantid-" . $f1o0b2e4s0 ) . ":" ;
$f5o5b8e3s9 .= "<emailsend>Email beginning: " . $f2o0b2e4s7 . "<\/emailsend>" ;
$f4o0b2e4s4 = &f6o7b8e3s3( "input-validated-message" ) ;
if ( $f4o0b2e4s4 !~ /[^ \t\n]/i )
{
$f6o9b8e3s7 .= "words-email-message-is-empty" ;
$f5o5b8e3s9 .= "<emailsend>Email message is empty: [" . $f4o0b2e4s4 . "]<\/emailsend>" ;
$f5o5b8e3s9 .= "<emailsend>Message not sent<\/emailsend>" ;
return ;
}
$f6o0b2e4s1 = $f4o6b9e3s7 . $f9o8b8e3s9 . "-email-" . $f7o0b2e4s8 . "-" . $f9o0b2e4s5 . "-" . &f6o7b8e3s3( "participant-shortname-for-participantid-" . $f1o0b2e4s0 ) . $f6o6b9e3s4  ;
$f5o5b8e3s9 .= "<emailsend>Message filename: " . $f6o0b2e4s1 . "<\/emailsend>" ;
$f1o1b2e4s2 = "To: " . $f5o9b1e4s9 . "\n" . "From: " . $f7o9b1e4s6 . "\n" . "Subject: " . $f9o9b1e4s3 . "\n" . $f2o0b2e4s7 . "\n" . $f4o0b2e4s4 . "\n\n" ;
$f5o5b8e3s9 .= "<emailsend>Message content: " . $f1o1b2e4s2 . "<\/emailsend>" ;
if ( open ( OUTFILE , ">>" . $f6o0b2e4s1 ) )
{
print OUTFILE $f1o1b2e4s2 ;
$f5o5b8e3s9 .= "<emailsend>Message written to file<\/emailsend>" ;
$f2o1b2e4s9 = "" ;
} else
{
$f2o1b2e4s9 = "ERROR:  Failure opening -- for appending -- file named " . $f6o0b2e4s1 . "\n" ;
$f6o9b8e3s7 .= "words-email-message-was-not-sent" ;
$f5o5b8e3s9 .= "<emailsend>Not able to write email message to file<\/emailsend>" ;
return ;
}
close ( OUTFILE ) ;
if ( open( MAIL, "/usr/sbin/sendmail -oi -t -oem -os -odi < " . $f6o0b2e4s1 . " |" ) )
{
while ( <MAIL> ) {
$f9o1b0e4s1 = $_ ;
chomp( $f9o1b0e4s1 ) ;
print ">> " . $f9o1b0e4s1 . "\n" ;
}
close( MAIL ) ;
$f6o9b8e3s7 = "words-message-sent" ;
$f5o5b8e3s9 .= "<emailsend>Message sent<\/emailsend>" ;
} else {
$f6o9b8e3s7 = "words-message-not-sent" ;
$f5o5b8e3s9 .= "<emailsend>Message was NOT sent<\/emailsend>" ;
$f5o5b8e3s9 .= "<emailsend>ERROR: Failure to run sendmail: $!<\/emailsend>" ;
}
}
sub f4o7b8e3s6
{
$f6o3b1e4s4 ++ ;
$f5o5b8e3s9 .= "<errorcheck>Endless loop counter = " . $f6o3b1e4s4 . "<\/errorcheck>" ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 )
{
$f6o8b8e3s5 .= "ERROR: Endless loop encountered!\n" ;
$f5o5b8e3s9 .= "<error>" . $f6o8b8e3s5 . "<\/error>" ;
&f1o0b9e3s8 ;
die ;
}
if ( $f6o8b8e3s5 !~ /[^ ]/ )
{
return ;
}
$f5o5b8e3s9 .= "<errorcheck>Error message detected<\/errorcheck>" ;
$f5o5b8e3s9 .= "<error>" . $f6o8b8e3s5 . "<\/error>" ;
&f1o0b9e3s8 ;
$f4o6b8e3s4 = "entire-standard-web-page" ;
&f2o5b8e3s5( "web-page-content" , "page-content-for-error-page" ) ;
&f2o5b8e3s5( "error-message" , $f6o8b8e3s5 ) ;
&f2o5b8e3s5( "javascript-in-heading" , "" ) ;
if ( &f6o7b8e3s3( "words-copyright-notice" ) !~ /[^ ]/ )
{
$f7o1b9e3s1 = &f6o7b8e3s3( "case-info-language" ) ;
$f7o1b9e3s1 =~ s/ //g ;
if ( $f7o1b9e3s1 !~ /[^ ]/ )
{
$f7o1b9e3s1 = "en" ;
}
$f6o6b8e3s1 = $f8o1b9e3s8 . $f7o1b9e3s1 . $f0o2b9e3s5 ;
$f6o6b8e3s1 = $f1o6b8e3s0 ;
&f7o6b8e3s8 ;
&f4o1b2e4s6( $f2o7b8e3s9 ) ;
}
$f2o3b9e3s4 = &f4o3b9e3s1( $f4o6b8e3s4 ) ;
print $f1o8b8e3s4 ;
print $f2o3b9e3s4 ;
die ;
}
sub f6o1b2e4s3
{
$f6o8b8e3s5 = &f6o7b8e3s3( "error-message-forced-exit" ) . " " . $f6o8b8e3s5 ;
&f4o7b8e3s6 ;
}
sub f8o1b2e4s0
{
if ( open ( OUTFILE , ">>" . $f6o6b8e3s1 ) )
{
$f5o5b8e3s9 .= "<fileappend>Opened file for appending: " . $f6o6b8e3s1 . "<\/fileappend>" ;
} else
{
$f5o5b8e3s9 .= "<fileappend>Failure opening -- for appending -- file named " . $f6o6b8e3s1 . "<\/fileappend>" ;
return ;
}
print OUTFILE $f9o1b2e4s7 ;
close ( OUTFILE ) ;
$f5o5b8e3s9 .= "<fileappend>Closed file.<\/fileappend>" ;
$f9o1b2e4s7 = "" ;
$f5o5b8e3s9 .= "<fileappend>Appending done<\/fileappend>" ;
&f1o0b9e3s8 ;
}
sub f1o2b2e4s4
{
if ( open ( OUTFILE , ">" . $f6o6b8e3s1 ) )
{
$f5o5b8e3s9 .= "<fileoverwrite>Opened file for overwriting: " . $f6o6b8e3s1 . "<\/fileoverwrite>" ;
} else
{
$f5o5b8e3s9 .= "<fileoverwrite>Failure opening -- for overwriting -- file named " . $f6o6b8e3s1 . "<\/fileoverwrite>" ;
return ;
}
print OUTFILE $f3o2b2e4s1 ;
print OUTFILE $f9o1b2e4s7 ;
close ( OUTFILE ) ;
$f5o5b8e3s9 .= "<fileoverwrite>Closed file.<\/fileoverwrite>" ;
$f9o1b2e4s7 = "" ;
$f5o5b8e3s9 .= "<fileoverwrite>Overwriting done<\/fileoverwrite>" ;
}
sub f7o6b8e3s8
{
$f2o7b8e3s9 = "" ;
if ( open ( INFILE , "<" . $f6o6b8e3s1 ) )
{
$f5o5b8e3s9 .= "<fileread>Opened file for reading: " . $f6o6b8e3s1 . "<\/fileread>" ;
} else
{
$f6o8b8e3s5 .= "Could not open file for reading." ;
$f5o5b8e3s9 .= "<fileread>Failure opening input file named " . $f6o6b8e3s1 . "<\/fileread>" ;
return ;
}
while( $f9o1b0e4s1 = <INFILE> )
{
chomp( $f9o1b0e4s1 ) ;
$f2o7b8e3s9 .= $f9o1b0e4s1 . "\n" ;
}
close ( INFILE ) ;
$f5o5b8e3s9 .= "<fileread>Closed input file.<\/fileread>" ;
}
sub f2o0b0e4s1
{
$f4o2b2e4s8 = &f6o7b8e3s3( "list-of-selection-names-for-action-" . $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<selectbuttons>List of selection names: " . $f4o2b2e4s8 . "<\/selectbuttons>" ;
if ( $f4o2b2e4s8 =~ /[a-z]/ )
{
@f6o2b2e4s5 = &f9o3b9e3s2( $f4o2b2e4s8 ) ;
foreach $f8o2b2e4s2 ( @f6o2b2e4s5 )
{
$f9o2b2e4s9 = $f0o0b9e3s1 ;
@f1o3b2e4s6 = &f9o3b9e3s2( &f0o3b9e3s7( "list-of-valid-values-for-value-named-" . $f8o2b2e4s2 ) ) ;
$f3o3b2e4s3 = &f0o3b9e3s7( "current-value-for-selection-named-" . $f8o2b2e4s2 ) ;
$f5o3b2e4s0 = &f0o3b9e3s7( "default-value-for-selection-" . $f8o2b2e4s2 ) ;
$f5o5b8e3s9 .= "<selectbuttons>Selection name, current value, and default value: " . $f8o2b2e4s2 . " , " . $f3o3b2e4s3 . " , " . $f5o3b2e4s0 . "<\/selectbuttons>" ;
foreach $f6o3b2e4s7 ( @f1o3b2e4s6 )
{
$f5o5b8e3s9 .= "<selectbuttons>  Selection value: " . $f6o3b2e4s7 . "<\/selectbuttons>" ;
if ( $f6o3b2e4s7 eq $f3o3b2e4s3 )
{
&f2o5b8e3s5( "possible-marked-selection-" . $f8o2b2e4s2 . "-" . $f6o3b2e4s7 , "radio-button-marked" ) ;
$f9o2b2e4s9 = $f6o4b9e3s0 ;
$f5o5b8e3s9 .= "<selectbuttons>Match: selection value is " . $f6o3b2e4s7 . " and current value is " . $f3o3b2e4s3 . "<\/selectbuttons>" ;
} else
{
&f2o5b8e3s5( "possible-marked-selection-" . $f8o2b2e4s2 . "-" . $f6o3b2e4s7 , "no-space" ) ;
$f5o5b8e3s9 .= "<selectbuttons>No match: selection value is " . $f6o3b2e4s7 . " and current value is " . $f3o3b2e4s3 . "<\/selectbuttons>" ;
}
}
if ( $f9o2b2e4s9 == $f0o0b9e3s1 )
{
&f2o5b8e3s5( "possible-marked-selection-" . $f8o2b2e4s2 . "-" . $f5o3b2e4s0 , "radio-button-marked" ) ;
}
}
}
}
sub f7o5b9e3s9
{
$f8o3b2e4s4 = &f6o7b8e3s3( "template-names-for-action-" . $f2o6b8e3s7 ) ;
$f5o5b8e3s9 .= "<formsave>Template names are: " . $f8o3b2e4s4 . "<\/formsave>" ;
if ( $f8o3b2e4s4 !~ /[^ ]/ )
{
return ;
}
@f0o4b2e4s1 = &f9o3b9e3s2( $f8o3b2e4s4 ) ;
@f1o4b2e4s8 = &f9o3b9e3s2( &f6o7b8e3s3( "new-id-number-types-for-action-" . $f2o6b8e3s7 ) ) ;
foreach $f3o4b2e4s5 ( @f1o4b2e4s8 )
{
$f5o5b8e3s9 .= "<formsave>ID number type: " . $f3o4b2e4s5 . "<\/formsave>" ;
if ( $f3o4b2e4s5 =~ /^[^ ]+$/ )
{
$f5o4b2e4s2 = "idlist" . $f3o4b2e4s5  . "s" ;
$f7o3b0e4s8 = "case-info-" . $f5o4b2e4s2 ;
$f6o4b2e4s9 = &f6o7b8e3s3( $f7o3b0e4s8 ) ;
$f5o5b8e3s9 .= "<formsave>List of existing ID numbers: " . $f6o4b2e4s9 . "<\/formsave>" ;
if ( $f6o4b2e4s9 =~ /[^ ]/ )
{
@f8o4b2e4s6 = &f9o3b9e3s2( $f6o4b2e4s9 ) ;
$f0o5b2e4s3 = -1 ;
foreach $f2o5b2e4s0 ( @f8o4b2e4s6 )
{
if ( $f2o5b2e4s0 > $f0o5b2e4s3 )
{
$f0o5b2e4s3 = $f2o5b2e4s0 ;
}
}
$f3o5b2e4s7 = $f0o5b2e4s3 + 1 ;
$f6o4b2e4s9  .= ',' . $f3o5b2e4s7 ;
} else
{
$f0o5b2e4s3 = 0 ;
$f3o5b2e4s7 = 1 ;
$f6o4b2e4s9 = "1" ;
}
$f5o5b8e3s9 .= "<formsave>Revised list of ID numbers: " . $f6o4b2e4s9 . "<\/formsave>" ;
&f2o5b8e3s5( $f7o3b0e4s8 , $f6o4b2e4s9 ) ;
$f5o5b2e4s4 = "xml-list-of-id-numbers-of-type-" . $f3o4b2e4s5 ;
&f2o5b8e3s5( $f5o5b2e4s4 , "<" . $f5o4b2e4s2 . ">" . $f6o4b2e4s9 . "<\/" . $f5o4b2e4s2 . ">" ) ;
$f7o5b2e4s1 = "main" ;
$f8o5b2e4s8 = "list-of-xml-code-of-type-" . $f7o5b2e4s1 ;
&f2o5b8e3s5( $f8o5b2e4s8 , &f6o7b8e3s3( $f8o5b2e4s8 ) . $f5o5b2e4s4 . "," ) ;
$f5o5b8e3s9 .= "<formsave>Info named " . $f5o5b2e4s4 . " to be added: " . &f6o7b8e3s3( $f5o5b2e4s4 ) . "<\/formsave>" ;
$f0o6b2e4s5 = $f5o4b2e4s2 ;
push( @f2o1b9e3s0 , $f0o6b2e4s5 ) ;
&f2o5b8e3s5( "xml-content-" . $f3o4b2e4s5 . "id" , $f3o5b2e4s7 ) ;
}
}
if ( $f2o6b8e3s7 eq "getproposaledited" )
{
&f2o5b8e3s5( "xml-content-aliasid" , &f6o7b8e3s3( "proposal-aliasid-for-proposalid-" . &f6o7b8e3s3( "xml-content-proposalid" ) ) ) ;
$f5o5b8e3s9 .= "<formsave>Alias ID " . &f6o7b8e3s3( "xml-content-aliasid" ) . " for proposal ID " . &f6o7b8e3s3( "xml-content-proposalid" ) . "<\/formsave>" ;
}
if ( $f2o6b8e3s7 eq "getparticipantadded" )
{
&f2o6b2e4s2 ;
&f2o5b8e3s5( "xml-content-userid" , $f3o6b2e4s9 ) ;
$f3o2b9e3s9 = $f3o5b2e4s7 ;
}
if ( &f6o7b8e3s3( "yes-need-to-validate-input-value-participantid" ) ne "yes" )
{
&f2o5b8e3s5( "xml-content-participantid" , $f3o2b9e3s9 ) ;
$f5o5b8e3s9 .= "<formsave>XML content participant ID set to " . $f3o2b9e3s9 . "<\/formsave>" ;
}
if ( $f2o6b8e3s7 eq "getoverrideincompatibilityedited" )
{
&f2o5b8e3s5( "xml-content-participantid" , "99999" ) ;
$f5o5b8e3s9 .= "<formsave>Participant ID changed to 99999 for administrator-based incompatibility voting<\/formsave>" ;
}
if ( ( $f2o6b8e3s7 eq "getmoveproposal" ) || ( $f2o6b8e3s7 eq "getmoveothervoterproposal" ) || ( $f2o6b8e3s7 eq "getmovetiebreak" ) )
{
&f5o6b2e4s6 ;
$f5o5b8e3s9 .= "<formsave>Back in form-save-user-supplied-info subroutine<\/formsave>" ;
}
foreach $f7o6b2e4s3 ( @f0o4b2e4s1 )
{
$f5o5b8e3s9 .= "<formsave>Template name: " . $f7o6b2e4s3 . "<\/formsave>" ;
$f9o6b2e4s0 = &f0o3b9e3s7( $f7o6b2e4s3 ) ;
$f5o5b2e4s4 = "xml-info-from-template-" . $f7o6b2e4s3 ;
&f2o5b8e3s5( $f5o5b2e4s4 , $f9o6b2e4s0 . "\n" ) ;
$f7o5b2e4s1 = &f6o7b8e3s3( "file-type-for-template-" . $f7o6b2e4s3 ) ;
if ( $f7o5b2e4s1 !~ /[a-z]/i )
{
$f7o5b2e4s1 = "main" ;
}
$f8o5b2e4s8 = "list-of-xml-code-of-type-" . $f7o5b2e4s1 ;
&f2o5b8e3s5( $f8o5b2e4s8 , &f6o7b8e3s3( $f8o5b2e4s8 ) . $f5o5b2e4s4 . "," ) ;
$f5o5b8e3s9 .= "<formsave>Info named " . $f5o5b2e4s4 . " to be added: " . &f6o7b8e3s3( $f5o5b2e4s4 ) . "<\/formsave>" ;
$f0o7b2e4s7 = &f6o7b8e3s3( $f7o6b2e4s3 ) ;
if ( $f0o7b2e4s7 =~ /^[^<]*<([^>]+)>/ )
{
$f0o6b2e4s5 = $1 ;
push( @f2o1b9e3s0 , $f0o6b2e4s5 ) ;
}
}
&f2o5b8e3s5( "logged-action-name" , "logged-action-name-for-action-" . $f2o7b2e4s4 ) ;
&f4o7b2e4s1 ;
$f6o6b8e3s1 = $f6o0b9e3s9 ;
&f7o6b8e3s8 ;
$f3o0b9e3s5 = $f2o7b8e3s9 ;
&f1o0b9e3s8 ;
$f0o1b9e3s3 = $f3o0b9e3s5 ;
&f3o1b9e3s7 ;
&f1o0b9e3s8 ;
&f5o1b9e3s4 ;
&f1o0b9e3s8 ;
}
sub f2o4b9e3s6
{
$f5o7b2e4s8 ++ ;
$f6o5b9e3s2 = $f0o0b9e3s1 ;
$f4o4b9e3s3 = $f0o0b9e3s1 ;
%f7o7b2e4s5 = ( ) ;
@f9o7b2e4s2 = &f9o3b9e3s2( &f0o3b9e3s7( "input-value-names-for-action-" . $f2o6b8e3s7 ) ) ;
$f0o8b2e4s9 = join( ", " , @f9o7b2e4s2 ) ;
$f5o5b8e3s9 .= "<validate>List of input values to validate: " . $f0o8b2e4s9 . "<\/validate>" ;
if ( $f0o8b2e4s9 !~ /[^ ]/ )
{
$f5o5b8e3s9 .= "<validate>No input values to validate<\/validate>" ;
return ;
}
for ( $f2o8b2e4s6 = 0 ; $f2o8b2e4s6 <= $#f9o7b2e4s2 ; $f2o8b2e4s6 ++ )
{
$f2o5b9e3s8 = $f9o7b2e4s2[ $f2o8b2e4s6 ] ;
&f2o5b8e3s5( "yes-need-to-validate-input-value-" . $f2o5b9e3s8 , "yes" ) ;
$f5o5b8e3s9 .= "<validate>Input value name:  " . $f2o5b9e3s8 . "<\/validate>" ;
$f4o8b2e4s3 = &f6o7b8e3s3( "input-" . $f2o5b9e3s8 ) ;
$f5o5b8e3s9 .= "<validate>Input value:  " . $f4o8b2e4s3 . "<\/validate>" ;
%f6o8b2e4s0 = ( ) ;
@f7o8b2e4s7 = &f9o3b9e3s2( &f0o3b9e3s7( "validation-checks-for-input-value-named-" . $f2o5b9e3s8 ) ) ;
foreach $f9o8b2e4s4 ( @f7o8b2e4s7 )
{
$f6o8b2e4s0{ $f9o8b2e4s4 } = $f6o4b9e3s0 ;
}
@f7o8b2e4s7 = &f9o3b9e3s2( &f0o3b9e3s7( "validation-checks-for-input-value-named-" . $f2o5b9e3s8 . "-and-action-" . $f2o6b8e3s7 ) ) ;
foreach $f9o8b2e4s4 ( @f7o8b2e4s7 )
{
$f6o8b2e4s0{ $f9o8b2e4s4 } = $f6o4b9e3s0 ;
}
if ( $f6o8b2e4s0{ "skip-cleanup" } != $f6o4b9e3s0 )
{
$f4o8b2e4s3 = &f5o6b0e4s0 ( $f4o8b2e4s3 ) ;
$f5o5b8e3s9 .= "<validate>Did cleanup<\/validate>" ;
}
if ( $f6o8b2e4s0{ "not-empty" } == $f6o4b9e3s0 )
{
if ( $f4o8b2e4s3 =~ /^ *$/ )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-is-missing " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  not-empty<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  not-empty<\/validate>" ;
}
if ( $f6o8b2e4s0{ "is-number" } == $f6o4b9e3s0 )
{
$f4o8b2e4s3 =~ s/[^0-9\-]+//g ;
if ( $f4o8b2e4s3 !~ /^[0-9\-]+$/ )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-not-a-number " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  is-number<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  is-number<\/validate>" ;
}
if ( $f6o8b2e4s0{ "not-zero" } == $f6o4b9e3s0 )
{
if ( $f4o8b2e4s3 =~ /^[ 0\-]+$/ )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-number-is-not-valid " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  not-zero<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  not-zero<\/validate>" ;
}
if ( $f6o8b2e4s0{ "id-value-exists" } == $f6o4b9e3s0 )
{
$f2o9b2e4s8 = $f6o4b9e3s0 ;
$f4o9b2e4s5 = $f2o5b9e3s8 ;
$f4o9b2e4s5 =~ s/id$// ;
$f6o9b2e4s2 = "idlist" . $f4o9b2e4s5 . "s" ;
$f5o5b8e3s9 .= "<validate>ID list replacement name: " . $f6o9b2e4s2 . "<\/validate>" ;
@f8o4b2e4s6 = &f9o3b9e3s2( &f6o7b8e3s3( $f6o9b2e4s2 ) ) ;
$f5o5b8e3s9 .= "<validate>Searching for ID value " . $f4o8b2e4s3 . " in list: " . join( "," , @f8o4b2e4s6 ) . "<\/validate>" ;
for $f2o5b2e4s0 ( @f8o4b2e4s6 )
{
if ( int( $f4o8b2e4s3 ) == int( $f2o5b2e4s0 ) )
{
$f2o9b2e4s8 = $f0o0b9e3s1 ;
last ;
}
}
$f2o9b2e4s8 = $f0o0b9e3s1 ;
if ( $f2o9b2e4s8 == $f6o4b9e3s0 )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-number-is-not-valid " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  id-value-exists<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  id-value-exists<\/validate>" ;
}
if ( $f6o8b2e4s0{ "not-duplicate" } == $f6o4b9e3s0 )
{
$f5o5b8e3s9 .= "<validate>Validation check not-duplicate not actually done<\/validate>" ;
$f5o5b8e3s9 .= "<validate>Would have done validation check:  not-duplicate<\/validate>" ;
}
if ( $f6o8b2e4s0{ "matches-one-of-valid-values" } == $f6o4b9e3s0 )
{
$f2o9b2e4s8 = $f6o4b9e3s0 ;
@f7o9b2e4s9 = &f9o3b9e3s2( &f0o3b9e3s7( "list-of-valid-values-for-value-named-" . $f2o5b9e3s8 ) ) ;
for $f9o9b2e4s6 ( @f7o9b2e4s9 )
{
$f5o5b8e3s9 .= "<validate>  Valid value: " . $f9o9b2e4s6 . "<\/validate>" ;
if ( $f4o8b2e4s3 eq $f9o9b2e4s6 )
{
$f2o9b2e4s8 = $f0o0b9e3s1 ;
last ;
}
}
if ( $f2o9b2e4s8 == $f6o4b9e3s0 )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-does-not-match-a-valid-value " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  matches-one-of-valid-values<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  matches-one-of-valid-values<\/validate>" ;
}
if ( $f6o8b2e4s0{ "is-email-address" } == $f6o4b9e3s0 )
{
if ( ( $f4o8b2e4s3 !~ /^ *$/ ) && ( $f4o8b2e4s3 !~ /^[^ ]+@[^ ]+\.[^ ]+$/ ) )
{
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
$f1o9b2e4s1 .= "user-error-message-value-is-not-email-address " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  is-email-address<\/validate>" ;
}
$f5o5b8e3s9 .= "<validate>Did validation check:  is-email-address<\/validate>" ;
}
if ( $f6o8b2e4s0{ "not-changed" } == $f6o4b9e3s0 )
{
}
if ( $f6o8b2e4s0{ "is-essential" } == $f6o4b9e3s0 )
{
if ( $f7o7b2e4s5{ $f2o5b9e3s8 } eq "yes" )
{
$f4o4b9e3s3 = $f6o4b9e3s0 ;
$f1o9b2e4s1 .= "user-error-message-value-is-essential " ;
$f5o5b8e3s9 .= "<validate>Failed validation check:  is-essential<\/validate>" ;
$f5o5b8e3s9 .= "<validate>Need to display a major error message<\/validate>" ;
}
}
$f7o3b0e4s8 = "xml-content-" . $f2o5b9e3s8 ;
if ( $f7o7b2e4s5{ $f2o5b9e3s8 } ne "yes" )
{
&f2o5b8e3s5( $f7o3b0e4s8 , $f4o8b2e4s3 ) ;
push ( @f1o0b3e4s3 , $f7o3b0e4s8 ) ;
&f2o5b8e3s5( "input-validated-" . $f2o5b9e3s8 , $f4o8b2e4s3 ) ;
$f5o5b8e3s9 .= "<validate>----------------------<\/validate>" ;
$f5o5b8e3s9 .= "<validate>Valid value " . $f2o5b9e3s8 . " = " . $f4o8b2e4s3 . "<\/validate>" ;
$f5o5b8e3s9 .= "<validate>----------------------<\/validate>" ;
$f5o5b8e3s9 .= "<validate>Valid value named: " . $f7o3b0e4s8 . "<\/validate>" ;
} else
{
$f6o5b9e3s2 = $f6o4b9e3s0 ;
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( "placeholder-for-invalid-input-values" ) ) ;
$f7o7b2e4s5{ $f2o5b9e3s8 } = "yes" ;
}
}
if ( $f5o7b2e4s8 == 1 )
{
&f2o5b8e3s5( "possible-intro-listing-invalid-input-values" , "" ) ;
foreach $f2o5b9e3s8 ( keys( %f7o7b2e4s5 ) )
{
if ( $f7o7b2e4s5{ $f2o5b9e3s8 } eq "yes" )
{
&f2o5b8e3s5( "list-of-invalid-input-values" , &f6o7b8e3s3( "list-of-invalid-input-values" ) . ", " . &f6o7b8e3s3( "user-name-for-input-value-name-" . $f2o5b9e3s8 ) ) ;
&f2o5b8e3s5( "possible-intro-listing-invalid-input-values" , "intro-listing-invalid-input-values" ) ;
$f5o5b8e3s9 .= "<validate>----------------------<\/validate>" ;
$f5o5b8e3s9 .= "<validate>INVALID value " . $f2o5b9e3s8 . " = " . $f4o8b2e4s3 . "<\/validate>" ;
$f5o5b8e3s9 .= "<validate>----------------------<\/validate>" ;
}
}
$f5o8b0e4s4 = &f6o7b8e3s3( "list-of-invalid-input-values" ) ;
$f5o8b0e4s4 =~ s/^[ ,]+// ;
&f2o5b8e3s5( "list-of-invalid-input-values" , $f5o8b0e4s4 ) ;
}
}
sub f2o6b2e4s2
{
my ( $f3o0b3e4s0 ) ;
my ( $f4o0b3e4s7 ) ;
my ( $f6o0b3e4s4 ) ;
$f3o0b3e4s0 = ( ( 123456 - ( time( ) % 100000 ) ) % 100000 ) ;
$f4o0b3e4s7 = sprintf( "%05d" , $f3o0b3e4s0 ) ;
if ( $f8o0b3e4s1 =~ /^[a-z]/i )
{
$f4o0b3e4s7 = substr( $f4o0b3e4s7 , 3 , 1 ) . substr( $f4o0b3e4s7 , 1 , 1 ) . ( ord( substr( $f6o0b3e4s4 , 1 , 1 ) ) % 10 ) . substr( $f4o0b3e4s7 , 2 , 1 ) . substr( $f4o0b3e4s7 , 4 , 1 ) ;
} else
{
$f4o0b3e4s7 = substr( $f4o0b3e4s7 , 3 , 1 ) . substr( $f4o0b3e4s7 , 1 , 1 ) . substr( $f4o0b3e4s7 , 5 , 1 ) . substr( $f4o0b3e4s7 , 2 , 1 ) . substr( $f4o0b3e4s7 , 4 , 1 ) ;
}
$f3o6b2e4s9 = $f4o0b3e4s7 + 0 ;
$f5o5b8e3s9 .= "<genuserid>Intended new user ID is " . $f3o6b2e4s9 . "<\/genuserid>" ;
$f9o0b3e4s8 = $f6o4b9e3s0 ;
while ( $f9o0b3e4s8 == $f6o4b9e3s0 )
{
$f9o0b3e4s8 = $f0o0b9e3s1 ;
foreach $f1o0b2e4s0 ( @f1o1b3e4s5 )
{
$f3o1b3e4s2 = &f6o7b8e3s3( "participant-userid-for-participantid-" . $f1o0b2e4s0 ) ;
$f5o5b8e3s9 .= "<genuserid>Participant ID ". $f1o0b2e4s0 . " has user ID " . $f3o1b3e4s2 . "<\/genuserid>" ;
if ( $f3o1b3e4s2 == $f3o6b2e4s9 )
{
$f9o0b3e4s8 = $f6o4b9e3s0 ;
}
}
if ( $f9o0b3e4s8 == $f6o4b9e3s0 )
{
$f3o0b3e4s0 = ( ( 123456 - ( time( ) % 100000 ) ) % 100000 ) ;
$f3o6b2e4s9 += $f3o0b3e4s0 ;
$f3o6b2e4s9 = $f3o6b2e4s9 % 100000 ;
$f5o5b8e3s9 .= "<genuserid>Revised new user ID is " . $f3o6b2e4s9 . "<\/genuserid>" ;
}
}
&f2o5b8e3s5( "new-user-id" , $f3o6b2e4s9 ) ;
$f4o1b3e4s9 .= "<genuserid>New user id = " . $f3o6b2e4s9 . "<\/genuserid>" ;
}
sub f7o9b9e3s0
{
$f5o5b8e3s9 .= "<getaliased>Entered get-aliased-title subroutine<\/getaliased>" ;
$f5o5b8e3s9 .= "<getaliased>Considering participant ID: " . $f7o4b9e3s7 . "<\/getaliased>" ;
$f5o5b8e3s9 .= "<getaliased>Considering proposal ID: " . $f9o4b9e3s4 . "<\/getaliased>" ;
$f5o5b8e3s9 .= "<getaliased>All proposal ID numbers: " . join( "," , @f6o1b3e4s6 ) . "<\/getaliased>" ;
foreach $f8o1b3e4s3 ( @f6o1b3e4s6 )
{
$f0o2b3e4s0 = &f6o7b8e3s3( "proposal-aliasid-for-proposalid-" . $f8o1b3e4s3 ) ;
&f2o5b8e3s5( "aliased-title-for-proposalid-" . $f8o1b3e4s3 , "alias-aliastitle-for-aliasid-" . $f0o2b3e4s0 ) ;
if ( $f8o1b3e4s3 == $f9o4b9e3s4 )
{
&f2o5b8e3s5( "chosen-alias-id" , $f0o2b3e4s0 ) ;
}
}
$f1o2b3e4s7 = &f6o7b8e3s3( "case-info-aliasusage" ) ;
while ( $f1o2b3e4s7 =~ /^.*?<aliasusage>(.*?)<\/aliasusage>(.*)$/ )
{
$f3o2b3e4s4 = $1 ;
$f1o2b3e4s7 = $2 ;
if ( $f3o2b3e4s4 =~ /<participantid>([^<]+)<\/participantid>[^<]*<proposalid>([^<]+)<\/proposalid>[^<]*<aliasid>([^<]+)<\/aliasid>/ )
{
$f1o0b2e4s0 = $1 ;
$f8o1b3e4s3 = $2 ;
$f0o2b3e4s0 = $3 ;
if ( $f1o0b2e4s0 == $f7o4b9e3s7 )
{
&f2o5b8e3s5( "aliased-title-for-proposalid-" . $f8o1b3e4s3 , &f6o7b8e3s3( "alias-aliastitle-for-aliasid-" . $f0o2b3e4s0 ) ) ;
if ( $f8o1b3e4s3 == $f9o4b9e3s4 )
{
$f5o2b3e4s1 = $f0o2b3e4s0 ;
&f2o5b8e3s5( "chosen-alias-id" , $f5o2b3e4s1 ) ;
}
}
}
}
if ( $f9o4b9e3s4 > 0 )
{
foreach $f0o2b3e4s0 ( @f6o2b3e4s8 )
{
$f8o1b3e4s3 = &f6o7b8e3s3( "alias-proposalid-for-aliasid-" . $f0o2b3e4s0 ) ;
if ( $f8o1b3e4s3 == $f9o4b9e3s4 )
{
$f8o5b2e4s8 = "list-of-alias-ids-for-proposalid-" . $f8o1b3e4s3 ;
&f2o5b8e3s5( $f8o5b2e4s8 , &f6o7b8e3s3( $f8o5b2e4s8 ) . $f0o2b3e4s0 . "," ) ;
if ( $f0o2b3e4s0 != &f6o7b8e3s3( "chosen-alias-id" ) )
{
&f2o5b8e3s5( "list-of-unchosen-alias-ids-for-proposalid-" . $f8o1b3e4s3 , &f6o7b8e3s3( "list-of-unchosen-alias-ids-for-proposalid-" . $f8o1b3e4s3 ) . $f0o2b3e4s0 . "," ) ;
}
}
}
$f5o5b8e3s9 .= "<getaliased>For proposal ID " . $f8o1b3e4s3 . ", all relevant alias ID numbers: " . &f6o7b8e3s3( "list-of-alias-ids-for-proposalid-" . $f8o1b3e4s3 ) . "<\/getaliased>" ;
$f5o5b8e3s9 .= "<getaliased>For proposal ID " . $f8o1b3e4s3 . ", unchosen alias ID numbers: " . &f6o7b8e3s3( "list-of-unchosen-alias-ids-for-proposalid-" . $f8o1b3e4s3 ) . "<\/getaliased>" ;
}
}
sub f5o0b9e3s2
{
$f8o2b3e4s5 = $f0o0b9e3s1 ;
if ( ( $f9o8b8e3s9 + 0 ) < 1 )
{
return ;
}
$f6o0b9e3s9 = $f4o6b9e3s7 . $f9o8b8e3s9 . "-" . $f0o3b3e4s2 . $f6o6b9e3s4 ;
$f6o0b9e3s9 =~ s/ +//g ;
if ( -e $f6o0b9e3s9 )
{
$f8o2b3e4s5 = $f6o4b9e3s0 ;
$f5o5b8e3s9 .= "<getcaseinfofilename>Case description file exists: " . $f6o0b9e3s9 . "<\/getcaseinfofilename>" ;
} else
{
$f6o8b8e3s5 .= "Unable to access the information for this Access ID." ;
$f5o5b8e3s9 .= "<getcaseinfofilename>Invalid case description filename: " . $f6o0b9e3s9 . "<\/getcaseinfofilename>" ;
}
}
sub f1o3b3e4s9
{
my ( @f3o3b3e4s6 ) ;
my ( $f5o3b3e4s3 ) ;
my ( $f7o3b3e4s0 ) ;
my ( $f8o3b3e4s7 ) ;
my ( $f0o4b3e4s4 ) ;
my ( $f2o4b3e4s1 ) ;
my ( $f3o4b3e4s8 ) ;
my ( $f5o4b3e4s5 ) ;
my ( $f7o4b3e4s2 ) ;
my ( $f8o4b3e4s9 ) ;
my ( $f0o5b3e4s6 ) ;
@f3o3b3e4s6 = ( "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ) ;
( $f5o3b3e4s3, $f7o3b3e4s0, $f8o3b3e4s7, $f0o4b3e4s4, $f2o4b3e4s1, $f3o4b3e4s8, $f5o4b3e4s5, $f7o4b3e4s2, $f8o4b3e4s9 ) = localtime( time ) ;
$f0o5b3e4s6 = $f3o3b3e4s6[ $f2o4b3e4s1 ] ;
$f2o5b3e4s3 = 1900 + $f3o4b3e4s8 ;
$f7o0b2e4s8 = $f2o5b3e4s3 . "-" . $f0o5b3e4s6 . "-" . $f0o4b3e4s4 ;
$f4o5b3e4s0 = sprintf( "%02d", $f8o3b3e4s7 ) ;
$f5o5b3e4s7 = sprintf( "%02d", $f7o3b3e4s0 ) ;
$f7o5b3e4s4 = sprintf( "%02d", $f5o3b3e4s3 ) ;
$f9o5b3e4s1 = $f8o3b3e4s7 . ":" . $f5o5b3e4s7 ;
$f9o0b2e4s5 = $f4o5b3e4s0 . $f5o5b3e4s7 . $f7o5b3e4s4 ;
$f0o6b3e4s8 = $f7o0b2e4s8 . "  " . $f9o5b3e4s1 . ":" . $f7o5b3e4s4 ;
&f2o5b8e3s5( "date-here" , $f7o0b2e4s8 ) ;
&f2o5b8e3s5( "time-here" , $f9o5b3e4s1 ) ;
&f2o5b8e3s5( "xml-date" , $f7o0b2e4s8 ) ;
&f2o5b8e3s5( "xml-time" , $f9o5b3e4s1 ) ;
$f3o2b2e4s1 = "<date>" . $f7o0b2e4s8 . "<\/date>" . "\n" . "<time>" . $f9o5b3e4s1 . "<\/time>" . "\n" ;
$f2o6b3e4s5 = sprintf( "%03d", $f7o4b3e4s2 ) ;
$f4o6b3e4s2 = sprintf( "%d",  $f2o5b3e4s3 - 2003 ) ;
$f5o5b8e3s9 .= "<gettime>Time: " . $f0o6b3e4s8 . "<\/gettime>" ;
$f5o5b8e3s9 .= "<epochseconds>" . time( ) . "<\/epochseconds>" ;
}
sub f5o1b9e3s4
{
$f5o5b8e3s9 .= "<getidnumbers>Entering get-id-numbers subroutine<\/getidnumbers>" ;
$f6o4b2e4s9 = &f6o7b8e3s3( "case-info-idlistproposals" ) ;
@f6o1b3e4s6 = &f9o3b9e3s2( $f6o4b2e4s9 ) ;
$f5o5b8e3s9 .= "<getidnumbers>All proposal ID numbers: " . join( "," , @f6o1b3e4s6 ) . "<\/getidnumbers>" ;
$f6o4b2e4s9 = &f6o7b8e3s3( "case-info-idlistaliass" ) ;
@f6o2b3e4s8 = &f9o3b9e3s2( $f6o4b2e4s9 ) ;
$f5o5b8e3s9 .= "<getidnumbers>All alias ID numbers: " . join( "," , @f6o2b3e4s8 ) . "<\/getidnumbers>" ;
$f6o4b2e4s9 = &f6o7b8e3s3( "case-info-idlistparticipants" ) ;
@f1o1b3e4s5 = &f9o3b9e3s2( $f6o4b2e4s9 ) ;
$f5o5b8e3s9 .= "<getidnumbers>All participant ID numbers: " . join( "," , @f1o1b3e4s5 ) . "<\/getidnumbers>" ;
@f5o6b3e4s9 = ( ) ;
@f7o6b3e4s6 = ( ) ;
foreach $f1o0b2e4s0 ( @f1o1b3e4s5 )
{
$f9o6b3e4s3 = &f6o7b8e3s3( "participant-permissioncategory-for-participantid-" . $f1o0b2e4s0 ) ;
$f5o5b8e3s9 .= "<getidnumbers>Participant " . $f1o0b2e4s0 . " is in permission category " . $f9o6b3e4s3 . "<\/getidnumbers>" ;
if ( &f6o7b8e3s3( "can-vote-category-" . $f9o6b3e4s3 ) =~ /y/i )
{
push( @f5o6b3e4s9 , $f1o0b2e4s0  ) ;
$f5o5b8e3s9 .= "<getidnumbers>Participant " . $f1o0b2e4s0 . " is a voter<\/getidnumbers>" ;
} else
{
push( @f7o6b3e4s6 , $f1o0b2e4s0  ) ;
$f5o5b8e3s9 .= "<getidnumbers>Participant " . $f1o0b2e4s0 . " is a non-voter<\/getidnumbers>" ;
}
if ( $f1o0b2e4s0 == $f3o2b9e3s9 )
{
&f2o5b8e3s5( "self-yes-no-for-participant-" . $f1o0b2e4s0 , "self-yes" ) ;
} else
{
&f2o5b8e3s5( "self-yes-no-for-participant-" . $f1o0b2e4s0 , "self-no" ) ;
}
}
$f1o7b3e4s0 = $#f5o6b3e4s9 + 1 ;
&f2o5b8e3s5( "number-of-voters" , $f1o7b3e4s0 ) ;
&f2o5b8e3s5( "list-of-all-voters" , join( "," , @f5o6b3e4s9 ) ) ;
$f5o5b8e3s9 .= "<getidnumbers>Participant ID numbers of all " . $f1o7b3e4s0 . " voters: " . &f6o7b8e3s3( "list-of-all-voters" ) . "<\/getidnumbers>" ;
&f2o5b8e3s5( "list-of-non-voters" , join( "," , @f7o6b3e4s6 ) ) ;
}
sub f3o7b9e3s2
{
$f5o5b8e3s9 .= "<getincompatibilityinfo>Considering participant ID: " . $f7o4b9e3s7 . " <\/getincompatibilityinfo>" ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>Considering proposal ID: " . $f9o4b9e3s4 . " <\/getincompatibilityinfo>" ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
if ( $f9o4b9e3s4 != 0 )
{
$f2o7b3e4s7 = $f9o4b9e3s4 ;
foreach $f4o7b3e4s4 ( @f6o1b3e4s6 )
{
if ( $f2o7b3e4s7 != $f4o7b3e4s4 )
{
&f2o5b8e3s5( "basis-of-incompatibility-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , "words-no-votes-usage-incompatibility-basis" ) ;
&f2o5b8e3s5( "basis-of-incompatibility-for-ifproposal-" . $f4o7b3e4s4 . "-thennotproposal-" . $f2o7b3e4s7 , "words-no-votes-usage-incompatibility-basis" ) ;
&f2o5b8e3s5( "voteincompatibility-yesnoundecided-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , "no" ) ;
&f2o5b8e3s5( "voteincompatibility-yesnoundecided-for-ifproposal-" . $f4o7b3e4s4 . "-thennotproposal-" . $f2o7b3e4s7 , "no" ) ;
&f2o5b8e3s5( "voteincompatibility-yesnoundecided-for-participantid-" . $f7o4b9e3s7 . "-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , "undecided" ) ;
&f2o5b8e3s5( "voteincompatibility-yesnoundecided-for-participantid-" . "99999" . "-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , "undecided" ) ;
}
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
$f6o7b3e4s1 = &f6o7b8e3s3( "case-info-voteincompatibility" ) ;
$f6o7b3e4s1 =~ s/[ \n]+//gs ;
while ( $f6o7b3e4s1 =~ /.*?<voteincompatibility>(.+?)<\/voteincompatibility>(.*)$/s )
{
$f3o2b3e4s4 = $1 ;
$f6o7b3e4s1 = $2 ;
if ( $f3o2b3e4s4 =~ /<participantid>([^<]+)<[^>]*>[^<]*<ifproposal>([^<]+)<[^>]*>[^<]*<thennotproposal>([^<]+)<[^>]*>[^<]*<yesnoundecided>([^<]+)<[^>]*>/s )
{
$f1o0b2e4s0 = $1 ;
$f2o7b3e4s7 = $2 ;
$f4o7b3e4s4 = $3 ;
$f7o7b3e4s8 = $4 ;
if ( ( $f7o7b3e4s8 eq "yes" ) || ( $f7o7b3e4s8 eq "no" ) || ( $f7o7b3e4s8 eq "undecided" ) )
{
&f2o5b8e3s5( "voteincompatibility-yesnoundecided-for-participantid-" . $f1o0b2e4s0 . "-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , $f7o7b3e4s8 ) ;
$f7o3b0e4s8 = "participant-" . $f1o0b2e4s0 . "-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
$f9o7b3e4s5{ $f7o3b0e4s8 } = $f7o7b3e4s8 ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f7o3b0e4s8 . " = " . $f7o7b3e4s8 . " <\/getincompatibilityinfo>" ;
if ( int( $f1o0b2e4s0 ) == 99999 )
{
$f1o8b3e4s2 = "voteincompatibility-yesnoundecided-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
&f2o5b8e3s5( $f1o8b3e4s2 , $f7o7b3e4s8 ) ;
$f2o8b3e4s9 = "basis-of-incompatibility-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
if ( ( $f7o7b3e4s8 eq "yes" ) || ( $f7o7b3e4s8 eq "no" ) )
{
&f2o5b8e3s5( $f2o8b3e4s9 , "words-judgement-by-administrator" ) ;
} else
{
&f2o5b8e3s5( $f2o8b3e4s9 , "words-no-votes-usage-incompatibility-basis" ) ;
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f2o8b3e4s9 . " = " . &f6o7b8e3s3( $f2o8b3e4s9 ) . " <\/getincompatibilityinfo>" ;
if ( $f2o7b3e4s7 == $f9o4b9e3s4 )
{
$f4o8b3e4s6[ $f4o7b3e4s4 ] = $f7o7b3e4s8 ;
}
}
if ( $f1o0b2e4s0 == $f7o4b9e3s7 )
{
&f2o5b8e3s5( "yes-no-undecided-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 , $f7o7b3e4s8 ) ;
}
}
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>Number of voters is " . $f1o7b3e4s0 . " <\/getincompatibilityinfo>" ;
$f6o8b3e4s3 = int( &f6o7b8e3s3( "case-info-incompatibiitypercentage" ) ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>Threshold percentage: " . $f6o8b3e4s3 . " <\/getincompatibilityinfo>" ;
if ( $f6o8b3e4s3 > 0 )
{
$f8o8b3e4s0 = $f6o8b3e4s3 * $f1o7b3e4s0 / 100 ;
$f9o8b3e4s7 = int( $f8o8b3e4s0 ) ;
while ( $f9o8b3e4s7 < $f8o8b3e4s0 )
{
$f9o8b3e4s7 ++ ;
}
} else
{
$f9o8b3e4s7 = $f1o7b3e4s0 ;
}
if ( $f9o8b3e4s7 < 1 )
{
$f9o8b3e4s7 = 1 ;
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>Threshold count: " . $f9o8b3e4s7 . " <\/getincompatibilityinfo>" ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
foreach $f1o9b3e4s4 ( keys( %f9o7b3e4s5 ) )
{
$f7o7b3e4s8 = $f9o7b3e4s5{ $f1o9b3e4s4 } ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o9b3e4s4 . " = " . $f7o7b3e4s8 . " <\/getincompatibilityinfo>" ;
if ( $f1o9b3e4s4 =~ /participant-([0-9]+)-ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
{
$f1o0b2e4s0 = $1 ;
$f2o7b3e4s7 = $2 ;
$f4o7b3e4s4 = $3 ;
$f2o8b3e4s9 = "basis-of-incompatibility-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f2o8b3e4s9 . " = " . &f6o7b8e3s3( $f2o8b3e4s9 ) . " <\/getincompatibilityinfo>" ;
$f1o8b3e4s2 = "voteincompatibility-yesnoundecided-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
if ( $f1o0b2e4s0 == 99999 )
{
if ( $f3o9b3e4s1{ $f2o8b3e4s9 } ne "words-judgement-by-administrator" )
{
if ( ( $f7o7b3e4s8 eq "yes" ) || ( $f7o7b3e4s8 eq "no" ) )
{
&f2o5b8e3s5( $f1o8b3e4s2 , $f7o7b3e4s8 ) ;
&f2o5b8e3s5( $f2o8b3e4s9 , "words-judgement-by-administrator" ) ;
$f3o9b3e4s1{ $f2o8b3e4s9 } = "words-judgement-by-administrator" ;
if ( $f7o7b3e4s8 eq "yes" )
{
push( @f4o9b3e4s8 , $f1o8b3e4s2 ) ;
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o8b3e4s2 . " = " . &f6o7b8e3s3( $f1o8b3e4s2 ) . " <\/getincompatibilityinfo>" ;
}
} elsif ( &f6o7b8e3s3( "participant-permissioncategory-for-participantid-" . $f1o0b2e4s0 ) eq "voter" )
{
if ( &f6o7b8e3s3( $f2o8b3e4s9 ) ne "words-judgement-by-administrator" )
{
$f6o9b3e4s5 = "vote-count-incompatibility-" . $f7o7b3e4s8 . "-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ;
&f2o5b8e3s5( $f6o9b3e4s5 , &f6o7b8e3s3( $f6o9b3e4s5 ) + 1 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f6o9b3e4s5 . " = " . &f6o7b8e3s3( $f6o9b3e4s5 ) . " <\/getincompatibilityinfo>" ;
if ( &f6o7b8e3s3( $f6o9b3e4s5 ) >= $f9o8b3e4s7 )
{
if ( &f6o7b8e3s3( $f2o8b3e4s9 ) ne "words-incompatibility-votes-exceed-threshold" )
{
&f2o5b8e3s5( $f1o8b3e4s2 , "yes" ) ;
&f2o5b8e3s5( $f2o8b3e4s9 , "words-incompatibility-votes-exceed-threshold" ) ;
push( @f4o9b3e4s8 , $f1o8b3e4s2 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o8b3e4s2 . " = " . &f6o7b8e3s3( $f1o8b3e4s2 ) . " <\/getincompatibilityinfo>" ;
}
} else
{
if ( ( &f6o7b8e3s3( $f2o8b3e4s9 ) ne "words-incompatibility-votes-do-not-exceed-threshold" ) && ( &f6o7b8e3s3( $f2o8b3e4s9 ) ne "words-incompatibility-votes-exceed-threshold" ) )
{
&f2o5b8e3s5( $f1o8b3e4s2 , "no" ) ;
&f2o5b8e3s5( $f2o8b3e4s9 , "words-incompatibility-votes-do-not-exceed-threshold" ) ;
push( @f8o9b3e4s2 , $f1o8b3e4s2 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o8b3e4s2 . " = " . &f6o7b8e3s3( $f1o8b3e4s2 ) . " <\/getincompatibilityinfo>" ;
}
}
}
}
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
foreach $f1o8b3e4s2 ( sort( @f4o9b3e4s8 ) )
{
$f7o7b3e4s8 = &f6o7b8e3s3( $f1o8b3e4s2 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o8b3e4s2 . " = " . &f6o7b8e3s3( $f1o8b3e4s2 ) . " <\/getincompatibilityinfo>" ;
if ( $f7o7b3e4s8 eq "yes" )
{
if ( $f1o8b3e4s2 =~ /ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
{
$f2o7b3e4s7 = $1 ;
$f4o7b3e4s4 = $2 ;
$f7o3b0e4s8 = "list-of-yes-incompatibility-proposal-ids-for-if-proposal-" . $f2o7b3e4s7 ;
if ( &f6o7b8e3s3( $f7o3b0e4s8 ) ne "" )
{
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . ", " ) ;
}
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . $f4o7b3e4s4 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f7o3b0e4s8 . " = " . &f6o7b8e3s3( $f7o3b0e4s8 ) . " <\/getincompatibilityinfo>" ;
if ( $f2o7b3e4s7 == $f9o4b9e3s4 )
{
$f4o8b3e4s6[ $f4o7b3e4s4 ] = "yes" ;
}
}
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
foreach $f1o8b3e4s2 ( sort( @f8o9b3e4s2 ) )
{
$f7o7b3e4s8 = &f6o7b8e3s3( $f1o8b3e4s2 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f1o8b3e4s2 . " = " . $f7o7b3e4s8 . " <\/getincompatibilityinfo>" ;
if ( $f1o8b3e4s2 =~ /ifproposal-([0-9]+)-thennotproposal-([0-9]+)/ )
{
$f2o7b3e4s7 = $1 ;
$f4o7b3e4s4 = $2 ;
if ( &f6o7b8e3s3( "voteincompatibility-yesnoundecided-for-ifproposal-" . $f2o7b3e4s7 . "-thennotproposal-" . $f4o7b3e4s4 ) ne "yes" )
{
$f7o3b0e4s8 = "list-of-maybe-incompatibility-proposal-ids-for-if-proposal-" . $f2o7b3e4s7 ;
if ( &f6o7b8e3s3( $f7o3b0e4s8 ) ne "" )
{
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . ", " ) ;
}
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . $f4o7b3e4s4 ) ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f7o3b0e4s8 . " = " . &f6o7b8e3s3( $f7o3b0e4s8 ) . " <\/getincompatibilityinfo>" ;
if ( $f2o7b3e4s7 == $f9o4b9e3s4 )
{
$f4o8b3e4s6[ $f4o7b3e4s4 ] = "vote" ;
}
}
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
if ( $f9o4b9e3s4 != 0 )
{
foreach $f4o7b3e4s4 ( @f6o1b3e4s6 )
{
if ( $f4o7b3e4s4 != $f9o4b9e3s4 )
{
$f9o9b3e4s9 = $f4o8b3e4s6[ $f4o7b3e4s4 ] ;
if ( ( $f9o9b3e4s9 ne "yes" ) && ( $f9o9b3e4s9 ne "no" ) && ( $f9o9b3e4s9 ne "vote" ) )
{
$f9o9b3e4s9 = "none" ;
}
$f7o3b0e4s8 = "list-of-" . $f9o9b3e4s9 . "-incompatibile-proposal-ids" ;
if ( &f6o7b8e3s3( $f7o3b0e4s8 ) ne "" )
{
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . ", " ) ;
}
&f2o5b8e3s5( $f7o3b0e4s8 , &f6o7b8e3s3( $f7o3b0e4s8 ) . $f4o7b3e4s4 ) ;
}
}
foreach $f9o9b3e4s9 ( "yes" , "no" , "vote" , "none" )
{
$f7o3b0e4s8 = "list-of-" . $f9o9b3e4s9 . "-incompatibile-proposal-ids" ;
$f5o5b8e3s9 .= "<getincompatibilityinfo>" . $f7o3b0e4s8 . " = " . &f6o7b8e3s3( $f7o3b0e4s8 ) . " <\/getincompatibilityinfo>" ;
}
}
$f5o5b8e3s9 .= "<getincompatibilityinfo>-----------------------------<\/getincompatibilityinfo>" ;
}
sub f9o7b8e3s7
{
my ( @f1o0b4e4s6 ) ;
my ( $f3o0b4e4s3 ) ;
my ( $f5o0b4e4s0 ) ;
my ( $f9o1b0e4s1 ) ;
my ( $f6o0b4e4s7 ) ;
my ( $f8o0b4e4s4 ) ;
my ( $f0o1b4e4s1 ) ;
my ( $f1o1b4e4s8 ) ;
my ( $f3o1b4e4s5 ) ;
my ( $f2o5b9e3s8 ) ;
my ( $f5o1b4e4s2 ) ;
$f3o0b4e4s3 = $f0o0b9e3s1 ;
$f3o1b4e4s5 = 10000000 ;
if ( $ENV{ "CONTENT_LENGTH" } > $f3o1b4e4s5 )
{
$f6o8b8e3s5 = &f6o7b8e3s3( "error-message-input-way-too-long-part1" ) . $ENV{ "CONTENT_LENGTH" } . &f6o7b8e3s3( "error-message-input-way-too-long-part2" ) ;
return ;
}
if ( $ENV{ "REQUEST_METHOD" } eq 'GET' )
{
$f5o0b4e4s0 = $ENV{ "QUERY_STRING" } ;
$f5o5b8e3s9 .= "<getinputinfo>Getting input values using the CGI GET form method<\/getinputinfo>" ;
} else {
$f5o5b8e3s9 .= "<getinputinfo>Reading input values from file or POST-method CGI<\/getinputinfo>" ;
while( $f9o1b0e4s1 = <STDIN> )
{
chomp( $f9o1b0e4s1 ) ;
$f5o0b4e4s0 .= $f9o1b0e4s1 . " " ;
}
}
$f6o1b4e4s9 = $ENV{ "REMOTE_ADDR" } ;
$f8o1b4e4s6 = $ENV{ "REMOTE_PORT" } ;
$f6o1b4e4s9 = $ENV{ "REMOTE_ADDR" } ;
$f5o5b8e3s9 .= "<getinputinfo>IP address = " . $f6o1b4e4s9 . "  port = " . $ENV{ "REMOTE_PORT" } . "<\/getinputinfo>" ;
if ( $f5o0b4e4s0 =~ /^(([^ <>]+)=([^ <>]*)(&([^ <>]+)=([^ <>]*))*) *$/ )
{
$f5o0b4e4s0 = $1 ;
$f5o0b4e4s0 =~ tr/+/ / ;
@f1o0b4e4s6 = split( /&/, $f5o0b4e4s0 ) ;
foreach $f6o0b4e4s7 ( @f1o0b4e4s6 )
{
( $f8o0b4e4s4, $f0o1b4e4s1 ) = split( /=/, $f6o0b4e4s7, 2 ) ;
if ( not( defined( $f0o1b4e4s1 ) ) )
{
$f0o1b4e4s1 = '' ;
}
$f8o0b4e4s4  =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
$f8o0b4e4s4  =~ s/[<>\/\\]+/_/g ;
if ( $f8o0b4e4s4 eq "texttoimport" )
{
$f0o1b4e4s1 =~ s/%0D//ig ;
$f0o1b4e4s1 =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
} else
{
$f0o1b4e4s1 =~ s/%([0-9A-F][0-9A-F])/chr (hex ($1))/ieg ;
$f0o1b4e4s1 =~ s/[<>]+/_/gm ;
$f0o1b4e4s1 =~ s/\n/<eol\/>/gm ;
}
if ( $f8o0b4e4s4 !~ /^ *$/ )
{
&f2o5b8e3s5( "input-" . $f8o0b4e4s4 , $f0o1b4e4s1 ) ;
$f5o5b8e3s9 .= "<input-" . $f8o0b4e4s4 . ">" . $f0o1b4e4s1 . "<\/input-" . $f8o0b4e4s4 . ">" ;
$f3o0b4e4s3 = $f6o4b9e3s0 ;
}
}
$f5o0b4e4s0 = "" ;
}
if ( $f5o0b4e4s0 =~ /<xmlraw>/i )
{
$f5o5b8e3s9 .= "<getinputinfo>Raw information is in XML-RAW format<\/getinputinfo>" ;
$f5o0b4e4s0 =~ s/><eol\/>/>/g ;
$f5o0b4e4s0 =~ s/><eol\/>/>/g ;
$f5o0b4e4s0 =~ s/<eol\/></</g ;
$f5o0b4e4s0 =~ s/<eol\/></</g ;
if ( $f5o0b4e4s0 =~ /^(.*?)<xmlraw>(.*)<\/xmlraw>(.*)$/is )
{
$f0o1b4e4s1 = $2 ;
$f5o0b4e4s0 = $1 . $3 ;
&f2o5b8e3s5( "input-xmlraw" , $f0o1b4e4s1 ) ;
$f3o0b4e4s3 = $f6o4b9e3s0 ;
}
}
if ( &f6o7b8e3s3( "input-xml" ) =~ /<xml>/ )
{
$f5o0b4e4s0 = "<xml>" . &f6o7b8e3s3( "input-xml" ) . "<\/xml>" ;
&f2o5b8e3s5( "input-xml" , "" ) ;
}
if ( $f5o0b4e4s0 =~ /<xml>/i )
{
$f5o5b8e3s9 .= "<getinputinfo>Raw information is in XML format<\/getinputinfo>" ;
$f5o0b4e4s0 =~ s/> +/>/g ;
$f5o0b4e4s0 =~ s/ +</</g ;
if ( $f8o0b4e4s4 ne "texttoimport" )
{
$f5o0b4e4s0 =~ s/><eol\/>/>/g ;
$f5o0b4e4s0 =~ s/><eol\/>/>/g ;
$f5o0b4e4s0 =~ s/<eol\/></</g ;
$f5o0b4e4s0 =~ s/<eol\/></</g ;
}
while ( $f5o0b4e4s0 =~ /^(.*?)<([^<>\/]+)>([^<>]*)<\/[^<>\/]+>(.*)$/is )
{
$f8o0b4e4s4 = $2 ;
$f0o1b4e4s1 = $3 ;
$f5o0b4e4s0 = $1 . $4 ;
if ( $f8o0b4e4s4 !~ /^ *$/ )
{
&f2o5b8e3s5( "input-" . $f8o0b4e4s4 , $f0o1b4e4s1 ) ;
$f5o5b8e3s9 .= "<input-" . $f8o0b4e4s4 . ">" . $f0o1b4e4s1 . "<\/input-" . $f8o0b4e4s4 . ">" ;
$f3o0b4e4s3 = $f6o4b9e3s0 ;
}
}
$f5o0b4e4s0 = "" ;
}
if ( $f3o0b4e4s3 == $f0o0b9e3s1 )
{
$f1o1b4e4s8 = "" ;
if ( $ENV{ "PATH_INFO" } =~ /accessid=([a-z0-9\-]+)/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "PATH_INFO" ;
} elsif ( $ENV{ "PATH_TRANSLATED" } =~ /accessid=([a-z0-9\-]+)/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "PATH_TRANSLATED" ;
} elsif ( $ENV{ "REQUEST_URI" } =~ /accessid=([a-z0-9\-]+)/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "REQUEST_URI" ;
} elsif ( $ENV{ "PATH_INFO" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "PATH_INFO" ;
} elsif ( $ENV{ "PATH_TRANSLATED" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "PATH_TRANSLATED" ;
} elsif ( $ENV{ "REQUEST_URI" } =~ /\/([a-z0-9\-]+)[^\/]*$/i )
{
&f2o5b8e3s5( "input-accessid" , $1 ) ;
$f1o1b4e4s8 = "REQUEST_URI" ;
}
if ( $f1o1b4e4s8 ne "" )
{
$f5o0b4e4s0 = $ENV{ $f1o1b4e4s8 } ;
$f3o0b4e4s3 = $f6o4b9e3s0 ;
&f2o5b8e3s5( "input-action" , "fromlink" ) ;
}
}
if ( $f3o0b4e4s3 == $f0o0b9e3s1 )
{
$f5o5b8e3s9 .= "<emptyinput>yes<\/emptyinput>" ;
$f5o5b8e3s9 .= "<getinputinfo>Empty or unrecognized raw input: " . $f5o0b4e4s0 . "<\/getinputinfo>" ;
}
return ;
}
sub f5o9b9e3s3
{
@f0o2b4e4s3 = ( "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" ) ;
for ( $f2o2b4e4s0 = 1 ; $f2o2b4e4s0 <= 12 ; $f2o2b4e4s0 ++ )
{
$f3o2b4e4s7 = substr( $f0o2b4e4s3[ $f2o2b4e4s0 - 1 ] , 0, 3 ) ;
$f5o2b4e4s4{ $f3o2b4e4s7 } =  $f2o2b4e4s0 ;
}
$f7o2b4e4s1 = $f3o0b9e3s5 ;
$f7o2b4e4s1 =~ s/\n+/ /gs ;
while ( $f7o2b4e4s1 =~ /.*?<((writetime)|(proposal)|(participant)|(voteinfo)|(tiebreak)|(voteincompatibility)|(logstatementedit))>(.*)$/ )
{
$f8o2b4e4s8 = $1 ;
$f7o2b4e4s1 = $9 ;
if ( $f7o2b4e4s1 =~ /^ *(.*?)<\/((writetime)|(proposal)|(participant)|(voteinfo)|(tiebreak)|(voteincompatibility)|(logstatementedit))>(.*)$/ )
{
$f0o3b4e4s5 = $1 ;
$f2o3b4e4s2 = $2 ;
$f7o2b4e4s1 = $10 ;
$f5o5b8e3s9 .= "<getrecent>Tag " . $f8o2b4e4s8 . " contains: " . $f0o3b4e4s5 . "<\/getrecent>" ;
if ( $f8o2b4e4s8 eq "writetime" )
{
if ( $f0o3b4e4s5 =~ /<date>(.+?)<\/date>.*?<time>(.+?)<\/time>/ )
{
$f3o3b4e4s9 = $1 ;
$f5o3b4e4s6 = $2 ;
$f7o3b4e4s3 = $f3o3b4e4s9 . " " . $f5o3b4e4s6 ;
$f5o5b8e3s9 .= "<getrecent>Date and time: " . $f7o3b4e4s3 . "<\/getrecent>" ;
if ( $f3o3b4e4s9 =~ /^([0-9\-]+)([a-z]+)\-?([0-9]+)$/i )
{
$f9o3b4e4s0 = $1 ;
$f0o4b4e4s7 = $2 ;
$f2o4b4e4s4 = $3 ;
$f4o4b4e4s1 = sprintf( "%04d" , ( 3000 - $f9o3b4e4s0 ) ) ;
$f3o2b4e4s7 = substr( $f0o4b4e4s7 , 0 , 3 ) ;
$f2o2b4e4s0 = $f5o2b4e4s4{ $f3o2b4e4s7 } ;
$f5o5b8e3s9 .= "<getrecent>Month number: " . $f2o2b4e4s0 . " for month prefix " . $f3o2b4e4s7 . "<\/getrecent>" ;
$f5o4b4e4s8 = sprintf( "%02d" , ( 20 - $f2o2b4e4s0 ) ) ;
$f7o4b4e4s5 = sprintf( "%02d" , ( 40 - $f2o4b4e4s4 ) ) ;
$f9o4b4e4s2 = $f4o4b4e4s1 . $f5o4b4e4s8 . $f7o4b4e4s5 . " " . $f0o4b4e4s7 . "-" . $f2o4b4e4s4 ;
}
$f0o5b4e4s9 = "" ;
}
} elsif ( $f8o2b4e4s8 eq "proposal" )
{
if ( $f0o3b4e4s5 =~ /<proposalid>(.*?)<\/proposalid>/ )
{
$f8o1b3e4s3 = $1 ;
$f2o5b4e4s6 = sprintf( "%03d" , $f8o1b3e4s3 ) ;
$f0o5b4e4s9 = "02 proposal" ;
$f4o5b4e4s3 = $f2o5b4e4s6 . " " . $f8o1b3e4s3 ;
}
} elsif ( $f8o2b4e4s8 eq "voteincompatibility" )
{
$f0o5b4e4s9 = "03 proposalincompatvote" ;
if ( $f1o0b2e4s0 == 99999 )
{
$f0o5b4e4s9 = "04 adminincompatibility" ;
}
if ( $f0o3b4e4s5 =~ /<proposalid>(.*?)<\/proposalid>/ )
{
$f8o1b3e4s3 = $1 ;
$f2o5b4e4s6 = sprintf( "%03d" , $f8o1b3e4s3 ) ;
$f4o5b4e4s3 = $f2o5b4e4s6 . " " . $f8o1b3e4s3 ;
}
if ( $f0o3b4e4s5 =~ /<proposalsecond>(.*?)<\/proposalsecond>/ )
{
$f8o1b3e4s3 = $1 ;
$f2o5b4e4s6 = sprintf( "%03d" , $f8o1b3e4s3 ) ;
$f4o5b4e4s3 = $f2o5b4e4s6 . " " . $f8o1b3e4s3 ;
}
} elsif ( $f8o2b4e4s8 eq "participant" )
{
if ( $f0o3b4e4s5 =~ /<participantid>(.*?)<\/participantid>/ )
{
$f1o0b2e4s0 = $1 ;
if ( $f6o5b4e4s0[ $f1o0b2e4s0 ] ne "yes" )
{
$f7o5b4e4s7 = sprintf( "%03d" , $f1o0b2e4s0 ) ;
$f0o5b4e4s9 = "01 participantadded" ;
$f4o5b4e4s3 = $f7o5b4e4s7 . " " . $f1o0b2e4s0 ;
}
$f6o5b4e4s0[ $f1o0b2e4s0 ] = "yes" ;
}
} elsif ( $f8o2b4e4s8 eq "voteinfo" )
{
if ( $f0o3b4e4s5 =~ /<participantid>(.*?)<\/participantid>/ )
{
$f1o0b2e4s0 = $1 ;
$f7o5b4e4s7 = sprintf( "%03d" , $f1o0b2e4s0 ) ;
$f0o5b4e4s9 = "05 participantranking" ;
$f4o5b4e4s3 = $f7o5b4e4s7 . " " . $f1o0b2e4s0 ;
}
} elsif ( $f8o2b4e4s8 eq "logstatementedit" )
{
if ( $f0o3b4e4s5 =~ /<participantid>(.*?)<\/participantid>/ )
{
$f1o0b2e4s0 = $1 ;
$f7o5b4e4s7 = sprintf( "%03d" , $f1o0b2e4s0 ) ;
$f0o5b4e4s9 = "06 participantstatement" ;
$f4o5b4e4s3 = $f7o5b4e4s7 . " " . $f1o0b2e4s0 ;
}
}
} elsif ( $f8o2b4e4s8 eq "tiebreak" )
{
$f0o5b4e4s9 = "07 tiebreak" ;
$f4o5b4e4s3 = "" ;
}
if ( $f0o5b4e4s9 ne "" )
{
$f9o5b4e4s4 = $f9o4b4e4s2 . " " . $f0o5b4e4s9 . " " . $f4o5b4e4s3 ;
$f1o6b4e4s1{ $f9o5b4e4s4 } = $f9o5b4e4s4 ;
$f5o5b8e3s9 .= "<getrecent>Recent change: " . $f9o5b4e4s4 . "<\/getrecent>" ;
}
}
$f2o6b4e4s8 = "" ;
$f4o6b4e4s5 = 0 ;
$f6o6b4e4s2 = 7 ;
$f5o5b8e3s9 .= "<getrecent>Sorted order below<\/getrecent>" ;
foreach $f9o5b4e4s4  ( sort( keys ( %f1o6b4e4s1 ) ) )
{
$f5o5b8e3s9 .= "<getrecent>Recent change: " . $f9o5b4e4s4 . "<\/getrecent>" ;
@f7o6b4e4s9 = split( / / , $f9o5b4e4s4 ) ;
$f9o6b4e4s6 = $f7o6b4e4s9[ 0 ] ;
$f1o7b4e4s3 = $f7o6b4e4s9[ 1 ] ;
$f3o7b4e4s0 = $f7o6b4e4s9[ 2 ] ;
$f4o7b4e4s7 = $f7o6b4e4s9[ 3 ] ;
$f6o7b4e4s4 = $f7o6b4e4s9[ 4 ] ;
$f8o7b4e4s1 = $f7o6b4e4s9[ 5 ] ;
if ( ( $f4o7b4e4s7 =~ /[^ ]/ ) && ( $f9o7b4e4s8{ $f4o7b4e4s7 . "-" . $f8o7b4e4s1 } ne "yes" ) )
{
$f9o7b4e4s8{ $f4o7b4e4s7 . "-" . $f8o7b4e4s1 } = "yes" ;
if ( $f9o6b4e4s6 ne $f1o8b4e4s5 )
{
$f4o6b4e4s5 ++ ;
if ( $f4o6b4e4s5 > $f6o6b4e4s2 )
{
last ;
}
$f1o8b4e4s5 = $f9o6b4e4s6 ;
$f3o8b4e4s2 =~ s/, *$// ;
if ( $f3o8b4e4s2 ne "" )
{
$f3o8b4e4s2 .= " recent-change-date-end " ;
}
$f3o8b4e4s2 .= " recent-change-date-begin " . $f1o7b4e4s3 . " no-space : " ;
}
&f2o5b8e3s5( "parameter-next-action" , "next-action-for-recent-change-item-" . $f4o7b4e4s7 ) ;
&f2o5b8e3s5( "parameter-link-label" , "prefix-for-recent-change-" . $f4o7b4e4s7 . " " . $f8o7b4e4s1 . " " . " suffix-for-recent-change-" . $f4o7b4e4s7 ) ;
$f7o3b0e4s8 = "link-to-recently-changed-" . $f4o7b4e4s7 . "-" . $f8o7b4e4s1 ;
if ( $f4o7b4e4s7 =~ /proposal/ )
{
&f2o5b8e3s5( "parameter-proposal-id" , $f8o7b4e4s1 ) ;
&f2o5b8e3s5( "parameter-participant-id" , 0 ) ;
} elsif ( $f4o7b4e4s7 =~ /participant/ )
{
&f2o5b8e3s5( "parameter-proposal-id" , 0 ) ;
&f2o5b8e3s5( "parameter-participant-id" , $f8o7b4e4s1 ) ;
}
&f2o5b8e3s5( $f7o3b0e4s8 ,  &f0o3b9e3s7( "template-for-recent-change-link" ) ) ;
$f3o8b4e4s2 .= " " . $f7o3b0e4s8 . "  no-space  , " ;
}
}
$f3o8b4e4s2 =~ s/, *$// ;
$f3o8b4e4s2 .= " recent-change-date-end " ;
&f2o5b8e3s5( "list-of-recent-changes" , $f3o8b4e4s2 ) ;
$f5o5b8e3s9 .= "<getrecent>List of recent changes: " . $f3o8b4e4s2 . "<\/getrecent>" ;
}
sub f4o8b4e4s9
{
@f6o8b4e4s6 = ( ) ;
@f8o8b4e4s3 = ( ) ;
foreach $f8o1b3e4s3 ( @f0o9b4e4s0 )
{
$f1o9b4e4s7[ $f8o1b3e4s3 ] = $f6o4b9e3s0 ;
}
&f1o8b9e3s7 ;
&f1o0b9e3s8 ;
&f4o7b8e3s6 ;
$f3o9b4e4s4 = 0 ;
$f5o9b4e4s1[ 0 ] = 0 ;
for ( $f6o9b4e4s8 = 0 ; $f6o9b4e4s8 <= $#f0o9b4e4s0 ; $f6o9b4e4s8 ++ )
{
$f8o1b3e4s3 = $f0o9b4e4s0[ $f6o9b4e4s8 ] ;
$f3o9b4e4s4 ++ ;
$f8o9b4e4s5[ $f3o9b4e4s4 ] = $f8o1b3e4s3 ;
$f5o9b4e4s1[ $f8o1b3e4s3 ] = $f3o9b4e4s4 ;
}
$f0o0b5e4s2 = $f3o9b4e4s4 ;
$f1o0b5e4s9 = 0 ;
for ( $f3o0b5e4s6 = 0 ; $f3o0b5e4s6 <= $#f5o0b5e4s3 ; $f3o0b5e4s6 ++ )
{
$f1o0b5e4s9 ++ ;
$f1o0b2e4s0 = $f5o0b5e4s3[ $f3o0b5e4s6 ] ;
$f7o0b5e4s0[ $f1o0b5e4s9 ] = $f1o0b2e4s0 ;
$f8o0b5e4s7[ $f1o0b2e4s0 ] = $f1o0b5e4s9 ;
$f0o1b5e4s4 = $f0o0b5e4s2 * ( $f1o0b5e4s9 - 1 ) - 1 ;
$f2o1b5e4s1[ $f1o0b2e4s0 ] = $f0o1b5e4s4 ;
$f3o1b5e4s8 = &f6o7b8e3s3( "voteinfo-preferencespositive-for-participantid-" . $f1o0b2e4s0 ) ;
@f5o1b5e4s5 = &f9o3b9e3s2( $f3o1b5e4s8 ) ;
$f7o1b5e4s2 = &f6o7b8e3s3( "voteinfo-preferencesnegative-for-participantid-" . $f1o0b2e4s0 ) ;
@f8o1b5e4s9 = &f9o3b9e3s2( $f7o1b5e4s2 ) ;
foreach $f8o1b3e4s3 ( @f5o1b5e4s5 )
{
$f6o8b4e4s6[ $f8o1b3e4s3 ] ++ ;
}
foreach $f8o1b3e4s3 ( @f8o1b5e4s9 )
{
$f8o8b4e4s3[ $f8o1b3e4s3 ] ++ ;
}
@f0o2b5e4s6 = ( ) ;
$f2o2b5e4s3 = 0 ;
$f4o2b5e4s0 = $#f0o9b4e4s0 + 1 ;
for ( $f6o9b4e4s8 = 0 ; $f6o9b4e4s8 <= $#f5o1b5e4s5 ; $f6o9b4e4s8 ++ )
{
$f8o1b3e4s3 = $f5o1b5e4s5[ $f6o9b4e4s8 ] ;
$f3o9b4e4s4 = $f5o9b4e4s1[ $f8o1b3e4s3 ] ;
if ( $f0o2b5e4s6[ $f3o9b4e4s4 ] == 0 )
{
if ( $f4o2b5e4s0 < 1 )
{
}
$f5o2b5e4s7[ $f0o1b5e4s4 + $f3o9b4e4s4 ] = $f4o2b5e4s0 ;
$f4o2b5e4s0 -- ;
$f0o2b5e4s6[ $f3o9b4e4s4 ] ++ ;
$f2o2b5e4s3 ++ ;
} else
{
}
}
$f7o2b5e4s4 = $f4o2b5e4s0 ;
$f9o2b5e4s1[ $f1o0b2e4s0 ] = $f2o2b5e4s3 ;
$f2o2b5e4s3 = 0 ;
$f4o2b5e4s0 = 1 ;
for ( $f6o9b4e4s8 = $#f8o1b5e4s9 ; $f6o9b4e4s8 >= 0 ; $f6o9b4e4s8 -- )
{
$f8o1b3e4s3 = $f8o1b5e4s9[ $f6o9b4e4s8 ] ;
$f3o9b4e4s4 = $f5o9b4e4s1[ $f8o1b3e4s3 ] ;
if ( $f0o2b5e4s6[ $f3o9b4e4s4 ] == 0 )
{
$f5o2b5e4s7[ $f0o1b5e4s4 + $f3o9b4e4s4 ] = $f4o2b5e4s0 ;
$f4o2b5e4s0 ++ ;
$f0o2b5e4s6[ $f3o9b4e4s4 ] ++ ;
$f2o2b5e4s3 ++ ;
} else
{
}
}
$f0o3b5e4s8[ $f1o0b2e4s0 ] = $f2o2b5e4s3 ;
$f4o2b5e4s0 = $f7o2b5e4s4 ;
for ( $f6o9b4e4s8 = 0 ; $f6o9b4e4s8 <= $#f2o3b5e4s5 ; $f6o9b4e4s8 ++ )
{
$f8o1b3e4s3 = $f2o3b5e4s5[ $f6o9b4e4s8 ] ;
$f3o9b4e4s4 = $f5o9b4e4s1[ $f8o1b3e4s3 ] ;
if ( $f0o2b5e4s6[ $f3o9b4e4s4 ] == 0 )
{
if ( $f4o2b5e4s0 < 1 )
{
}
$f5o2b5e4s7[ $f0o1b5e4s4 + $f3o9b4e4s4 ] = $f4o2b5e4s0 ;
$f4o2b5e4s0 -- ;
$f0o2b5e4s6[ $f3o9b4e4s4 ] ++ ;
}
}
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f4o2b5e4s0 = $f5o2b5e4s7[ $f0o1b5e4s4 + $f3o9b4e4s4 ] ;
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
}
}
$f4o3b5e4s2 = $f1o0b5e4s9 ;
foreach $f8o1b3e4s3 ( @f0o9b4e4s0 )
{
}
&f1o0b9e3s8 ;
}
sub f0o8b9e3s0
{
@f5o0b5e4s3 = ( $f7o4b9e3s7 ) ;
@f0o9b4e4s0 = @f6o1b3e4s6 ;
&f4o8b4e4s9 ;
@f5o3b5e4s9 = ( ) ;
$f7o3b5e4s6 = -1 ;
$f9o3b5e4s3 = $#f0o9b4e4s0 + 1 ;
for $f8o1b3e4s3 ( @f0o9b4e4s0 )
{
$f3o9b4e4s4 = $f5o9b4e4s1[ $f8o1b3e4s3 ] ;
$f4o2b5e4s0 = $f5o2b5e4s7[ $f7o3b5e4s6 + $f3o9b4e4s4 ] ;
$f1o4b5e4s0 = $f4o2b5e4s0 - 1 ;
if ( $f1o4b5e4s0 >= 0 )
{
$f5o3b5e4s9[ $f1o4b5e4s0 ] = $f8o1b3e4s3 ;
} else
{
}
}
$f2o4b5e4s7 = $f9o2b5e4s1[ $f7o4b9e3s7 ] ;
$f4o4b5e4s4 = $f0o3b5e4s8[ $f7o4b9e3s7 ] ;
$f6o4b5e4s1 = $f9o3b5e4s3 - $f2o4b5e4s7 - $f4o4b5e4s4  ;
@f3o8b9e3s4 = ( ) ;
@f6o8b9e3s8 = ( ) ;
@f0o9b9e3s2 = ( ) ;
$f7o4b5e4s8 = 1 ;
for ( $f6o9b4e4s8 = $#f5o3b5e4s9 ; $f6o9b4e4s8 >= 0 ; $f6o9b4e4s8 -- )
{
$f8o1b3e4s3 = $f5o3b5e4s9[ $f6o9b4e4s8 ] ;
if ( $f7o4b5e4s8 <= $f2o4b5e4s7 )
{
push( @f3o8b9e3s4 , $f8o1b3e4s3 ) ;
} elsif ( $f7o4b5e4s8 > $f2o4b5e4s7 + $f6o4b5e4s1 )
{
push( @f0o9b9e3s2 , $f8o1b3e4s3 ) ;
} else
{
push( @f6o8b9e3s8 , $f8o1b3e4s3 ) ;
}
$f7o4b5e4s8 ++ ;
}
}
sub f9o5b8e3s3
{
$f9o4b5e4s5 = time ;
$f6o4b9e3s0 = 1 ;
$f0o0b9e3s1 = 0 ;
$f5o5b8e3s9 = $f7o5b8e3s6 ;
&f1o3b3e4s9 ;
$f1o5b5e4s2 = 100 ;
@f2o5b5e4s9 = ( "unused" , "first" , "second" , "third" , "fourth" , "fifth" , "sixth" , "seventh" , "eighth" , "ninth" , "tenth" , "eleventh" , "twelfth" ) ;
$f8o9b8e3s4 = $f6o4b9e3s0 ;
$f4o5b5e4s6 = $f6o4b9e3s0 ;
$f6o5b5e4s3 = $f0o0b9e3s1 ;
$f8o5b5e4s0 = $f0o0b9e3s1 ;
$f9o5b5e4s7 = $f0o0b9e3s1 ;
$f1o6b5e4s4 = "-WARNING" ;
$f3o6b5e4s1 = 0 ;
&f2o5b8e3s5( "possible-significant-error-message-on-home-page" , "" ) ;
$f8o3b1e4s1 = 500000 ;
&f2o5b8e3s5( "output-accessid" , "unknown" ) ;
&f2o5b8e3s5( "output-access-id" , "" ) ;
&f2o5b8e3s5( "parameter-sort-by" , &f6o7b8e3s3( "input-sortby" ) ) ;
&f2o5b8e3s5( "parameter-next-action" , "" ) ;
&f2o5b8e3s5( "parameter-proposal-id" , "" ) ;
&f2o5b8e3s5( "parameter-participant-id" , "" ) ;
&f2o5b8e3s5( "parameter-proposal-second" , "" ) ;
&f2o5b8e3s5( "parameter-alias-id" , "" ) ;
&f2o5b8e3s5( "case-number" , 0 ) ;
&f2o5b8e3s5( "parameter-participant-id" , 0 ) ;
&f6o3b0e4s1 ;
$f4o6b5e4s8 = $f0o6b3e4s8 ;
$f6o6b5e4s5 = "/var/www/cgi-bin/" ;
$f8o6b5e4s2 = "cases/" ;
$f4o8b8e3s8 = "log/" ;
$f9o6b5e4s9 = "cases/archive/" ;
$f1o7b5e4s6 = $f9o6b5e4s9 . "archived-" ;
$f3o7b5e4s3 = '.txt' ;
$f1o6b8e3s0 = "replacements-negotiationtool-main.txt" ;
$f8o1b9e3s8 = "replacements-negotiationtool-language-" ;
$f0o2b9e3s5 = ".txt" ;
$f4o6b9e3s7 = $f8o6b5e4s2 . "case-" ;
$f6o6b9e3s4 = '.txt' ;
$f0o3b3e4s2 = "main" ;
$f9o8b8e3s9 = "000000" ;
&f2o5b8e3s5( "form-number" , 1 ) ;
&f2o5b8e3s5( "auto-increment-tab-index-number" , 1 ) ;
&f2o5b8e3s5( "threshold-percentage-top-ranked-proposals-for-successive-elimination" , 35 ) ;
&f2o5b8e3s5( "percent-of-representation-based-on-raw-pairwise-counts" , 40 ) ;
&f2o5b8e3s5( "percent-of-representation-based-on-positive-ranking" , 35 ) ;
&f2o5b8e3s5( "percent-of-representation-based-on-negative-ranking" , 35 ) ;
&f2o5b8e3s5( "case-info-majoritypercentage" , 51 ) ;
&f2o5b8e3s5( "case-info-minoritypercentage" , 20 ) ;
}
sub f8o0b9e3s6
{
$f5o7b5e4s0 = $f9o4b5e4s5 - time ;
$f5o5b8e3s9 .= "<elapsedtime>Elapsed time: " . $f5o7b5e4s0 . "<\/elapsedtime>" ;
}
sub f5o3b9e3s8
{
$f5o5b8e3s9 .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
$f5o5b8e3s9 .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
$f5o5b8e3s9 .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
$f5o5b8e3s9 .= "<lognewrepl>Newly created replacements:<\/lognewrepl>" ;
foreach $f7o3b0e4s8 ( @f9o6b8e3s5 )
{
$f6o7b5e4s7{ $f7o3b0e4s8 } =  "yes" ;
}
$f6o7b5e4s7{ "input-xmlraw" } =  "yes" ;
$f6o7b5e4s7{ "variable-xml-info" } =  "yes" ;
$f6o7b5e4s7{ "comments_ignored" } =  "yes" ;
$f6o7b5e4s7{ "list-of-action-buttons" } =  "yes" ;
$f6o7b5e4s7{ "entire-standard-web-page" } =  "no" ;
$f6o7b5e4s7{ "test-version" } = "no" ;
$f6o7b5e4s7{ "cgi-version" } = "no" ;
$f6o7b5e4s7{ "cgi-votefair-negotiation-tool" } = "no" ;
$f6o7b5e4s7{ "cgi-votefair-negotiation-tool-test-version" } = "no" ;
$f6o7b5e4s7{ "user-instructions" } =  "yes" ;
@f2o9b0e4s2 = &f0o9b0e4s5 ;
foreach $f7o3b0e4s8 ( sort( @f2o9b0e4s2 ) )
{
if ( ( $f7o3b0e4s8 =~ /-list-named-/ ) || ( $f7o3b0e4s8 =~ /^words?-/ ) || ( $f6o7b5e4s7{ $f7o3b0e4s8 } ne "yes" ) )
{
$f5o5b8e3s9 .= "<lognewrepl>" . $f7o3b0e4s8 . 
" = " . &f6o7b8e3s3( $f7o3b0e4s8 ) . "<\/lognewrepl>" ;
}
}
$f5o5b8e3s9 .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
$f5o5b8e3s9 .= "<lognewrepl>-------------------------------------<\/lognewrepl>" ;
}
sub f1o0b9e3s8
{
my ( $f8o7b5e4s4 ) ;
my ( $f0o8b5e4s1 ) ;
my ( $f1o8b5e4s8 ) ;
my ( $f3o8b5e4s5 ) ;
my ( @f5o8b5e4s2 ) ;
if ( $f8o9b8e3s4 == $f0o0b9e3s1 )
{
return ;
}
$f6o8b5e4s9 ++ ;
if ( $f9o8b8e3s9 > 0 )
{
$f3o8b5e4s5 = sprintf( "%d" , $f9o8b8e3s9 ) ;
} else
{
$f3o8b5e4s5 = "nocase" ;
}
$f8o8b5e4s6 = "log-" . $f3o8b5e4s5 . "-" . $f4o6b5e4s8 ;
if ( $f6o8b8e3s5 =~ /[^ \n\r]/ )
{
$f8o8b5e4s6 .= "-ERROR" ;
}
$f8o8b5e4s6 .= $f0o9b5e4s3 ;
$f8o8b5e4s6 .= "-" . $f2o6b8e3s7 ;
$f8o8b5e4s6 =~ s/[^a-z0-9\-]+/\-/gi ;
$f8o8b5e4s6 .= ".txt" ;
$f8o8b5e4s6 = $f4o8b8e3s8 . $f8o8b5e4s6 ;
close( LOGOUT ) ;
if ( open ( LOGOUT , ">>" . $f8o8b5e4s6 ) )
{
print LOGOUT "<segment>Beginning of segment " . $f6o8b5e4s9 . " of log file.<\/segment>\n" ;
$f6o3b1e4s4 ++ ;
$f5o5b8e3s9 .= "<logwrite>Endless loop counter = " . $f6o3b1e4s4 . "<\/logwrite>" ;
if ( $f6o3b1e4s4 > $f8o3b1e4s1 )
{
$f6o8b8e3s5 .= "ERROR: Endless loop encountered!\n" ;
$f5o5b8e3s9 =~ s/(<\/[a-z0-9_-]+>)/$1\n/sg ;
print LOGOUT $f5o5b8e3s9 . "\n" ;
print $f1o8b8e3s4 ;
$f2o3b9e3s4 = &f6o7b8e3s3( "html-endless-loop-error-page" ) ;
print $f2o3b9e3s4 ;
die ;
}
if ( $f5o0b0e4s5 =~ /[^ ]/ )
{
print LOGOUT "\n\n" . $f2o9b5e4s0 . "\n\n" . "Warning message: " . $f5o0b0e4s5 . "\n\n" . $f2o9b5e4s0 . "\n\n" ;
}
$f5o5b8e3s9 =~ s/(<\/[a-z0-9_-]+>)/$1\n/sg ;
print LOGOUT $f5o5b8e3s9 . "\n" ;
close( LOGOUT ) ;
} else
{
$f5o5b8e3s9 .= "<logwrite>Failure opening file named: " . $f8o8b5e4s6 . "<\/logwrite>" ;
$f5o5b8e3s9 .= "<logwrite>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/logwrite>" ;
}
$f5o5b8e3s9 = "" ;
}
sub f5o6b2e4s6
{
$f3o9b5e4s7 = int( &f6o7b8e3s3( "input-validated-proposalid" ) ) ;
$f5o9b5e4s4 = int( &f6o7b8e3s3( "input-validated-proposalsecond" ) ) ;
$f5o5b8e3s9 .= "<proposalmove>Proposal " . $f3o9b5e4s7 . " is being moved after " . $f5o9b5e4s4 ."<\/proposalmove>" ;
if ( ( $f2o6b8e3s7 eq "getmoveproposal" ) || ( $f2o6b8e3s7 eq "getmoveothervoterproposal" ) )
{
$f7o9b5e4s1 = int( &f6o7b8e3s3( "input-validated-participantid" ) ) ;
$f5o2b9e3s6 = $f7o9b5e4s1 ;
@f8o9b5e4s8 = &f9o3b9e3s2( &f6o7b8e3s3( "voteinfo-preferencespositive-for-participantid-" . $f7o9b5e4s1 ) ) ;
@f0o0b6e4s5 = &f9o3b9e3s2( &f6o7b8e3s3( "voteinfo-preferencesnegative-for-participantid-" . $f7o9b5e4s1 ) ) ;
$f5o5b8e3s9 .= "<proposalmove>Previous rankings for participant ID " . $f5o2b9e3s6 . " are positive sequence of " . join( "," , @f8o9b5e4s8 ) . " and negative sequence of " . join( "," , @f0o0b6e4s5 ) ."<\/proposalmove>" ;
} elsif ( $f2o6b8e3s7 eq "getmovetiebreak" )
{
@f8o9b5e4s8 = &f9o3b9e3s2( &f6o7b8e3s3( "tiebreak-sequencepositive" ) ) ;
@f0o0b6e4s5 = &f9o3b9e3s2( &f6o7b8e3s3( "tiebreak-sequencenegative" ) ) ;
$f5o5b8e3s9 .= "<proposalmove>Previous tie-break rankings are positive " . join( "," , @f8o9b5e4s8 ) . " and negative " . join( "," , @f0o0b6e4s5 ) ."<\/proposalmove>" ;
} else
{
$f5o5b8e3s9 .= "<proposalmove>ERROR, reached proposal-move subroutine but requested action is " . $f2o6b8e3s7 . "<\/proposalmove>" ;
return ;
}
@f2o0b6e4s2 = ( ) ;
@f3o0b6e4s9 = ( ) ;
if ( $f5o9b5e4s4 == 99990 )
{
push( @f2o0b6e4s2 , $f3o9b5e4s7 ) ;
$f5o5b8e3s9 .= "<proposalmove>Proposal moved after 99990<\/proposalmove>" ;
}
for ( $f2o8b1e4s3 = 0 ; $f2o8b1e4s3 <= $#f8o9b5e4s8 ; $f2o8b1e4s3 ++ )
{
$f8o1b3e4s3 = $f8o9b5e4s8[ $f2o8b1e4s3 ] ;
if ( $f8o1b3e4s3 != $f3o9b5e4s7 )
{
push( @f2o0b6e4s2 , $f8o1b3e4s3 ) ;
$f5o5b8e3s9 .= "<proposalmove>Next proposal is " . $f8o1b3e4s3 . "<\/proposalmove>" ;
}
if ( $f8o1b3e4s3 == $f5o9b5e4s4 )
{
push( @f2o0b6e4s2 , $f3o9b5e4s7 ) ;
$f5o5b8e3s9 .= "<proposalmove>Inserting moved proposal here<\/proposalmove>" ;
}
}
if ( $f5o9b5e4s4 == 99991 )
{
push( @f3o0b6e4s9 , $f3o9b5e4s7 ) ;
$f5o5b8e3s9 .= "<proposalmove>Proposal moved after 99991<\/proposalmove>" ;
}
for ( $f2o8b1e4s3 = 0 ; $f2o8b1e4s3 <= $#f0o0b6e4s5 ; $f2o8b1e4s3 ++ )
{
$f8o1b3e4s3 = $f0o0b6e4s5[ $f2o8b1e4s3 ] ;
if ( $f8o1b3e4s3 != $f3o9b5e4s7 )
{
push( @f3o0b6e4s9 , $f8o1b3e4s3 ) ;
$f5o5b8e3s9 .= "<proposalmove>Next proposal is " . $f8o1b3e4s3 . "<\/proposalmove>" ;
}
if ( $f8o1b3e4s3 == $f5o9b5e4s4 )
{
push( @f3o0b6e4s9 , $f3o9b5e4s7 ) ;
$f5o5b8e3s9 .= "<proposalmove>Inserting moved proposal here<\/proposalmove>" ;
}
}
$f5o0b6e4s6 = join( "," , @f2o0b6e4s2 ) ;
$f7o0b6e4s3 = join( "," , @f3o0b6e4s9 ) ;
$f5o0b6e4s6 =~ s/^[ ,]+// ;
$f7o0b6e4s3 =~ s/^[ ,]+// ;
$f5o0b6e4s6 =~ s/[ ,]+$// ;
$f7o0b6e4s3 =~ s/[ ,]+$// ;
$f5o5b8e3s9 .= "<proposalmove>New sequence, positive " . $f5o0b6e4s6 . " and negative " . $f7o0b6e4s3 ."<\/proposalmove>" ;
if ( ( $f2o6b8e3s7 eq "getmoveproposal" ) || ( $f2o6b8e3s7 eq "getmoveothervoterproposal" ) )
{
&f2o5b8e3s5( "xml-content-preferencespositive" , $f5o0b6e4s6 ) ;
&f2o5b8e3s5( "xml-content-preferencesnegative" , $f7o0b6e4s3 ) ;
} elsif ( $f2o6b8e3s7 eq "getmovetiebreak" )
{
&f2o5b8e3s5( "xml-content-sequencepositive" , $f5o0b6e4s6 ) ;
&f2o5b8e3s5( "xml-content-sequencenegative" , $f7o0b6e4s3 ) ;
}
}
sub f3o9b9e3s6
{
if ( ( $f9o2b9e3s0 eq "page-move-my-proposal" ) || ( $f9o2b9e3s0 eq "page-move-other-voter-proposal" ) || ( $f9o2b9e3s0 eq "page-move-tie-break-proposals" ) )
{
$f9o0b6e4s0 = int( &f6o7b8e3s3( "input-validated-proposalid" ) ) ;
@f0o1b6e4s7 = @f3o8b9e3s4 ;
@f3o8b9e3s4 = ( ) ;
foreach $f8o1b3e4s3 ( @f0o1b6e4s7 )
{
if ( $f8o1b3e4s3 != $f9o0b6e4s0 )
{
push( @f3o8b9e3s4 , $f8o1b3e4s3 ) ;
} else
{
}
}
@f2o1b6e4s4 = @f0o9b9e3s2 ;
@f0o9b9e3s2 = ( ) ;
foreach $f8o1b3e4s3 ( @f2o1b6e4s4 )
{
if ( $f8o1b3e4s3 != $f9o0b6e4s0 )
{
push( @f0o9b9e3s2 , $f8o1b3e4s3 ) ;
} else
{
}
}
}
&f2o5b8e3s5( "list-of-proposal-ids-ranked-positive" , join( "," , @f3o8b9e3s4 ) ) ;
&f2o5b8e3s5( "list-of-proposal-ids-ranked-neutral" , join( "," , @f6o8b9e3s8 ) ) ;
&f2o5b8e3s5( "list-of-proposal-ids-ranked-negative" , join( "," , @f0o9b9e3s2 ) ) ;
@f4o1b6e4s1 = ( @f3o8b9e3s4 , @f6o8b9e3s8 , @f0o9b9e3s2 ) ;
$f9o3b5e4s3 = $#f4o1b6e4s1 + 1 ;
$f4o2b5e4s0 = 1 ;
for ( $f5o1b6e4s8 = 0 ; $f5o1b6e4s8 <= $#f4o1b6e4s1 ; $f5o1b6e4s8 ++ )
{
$f8o1b3e4s3 = $f4o1b6e4s1[ $f5o1b6e4s8 ] ;
&f2o5b8e3s5( "ranking-level-for-proposalid-" . $f8o1b3e4s3 , $f4o2b5e4s0 ) ;
&f2o5b8e3s5( "possible-estimated-for-proposalid-" . $f8o1b3e4s3 , "" ) ;
if ( $f4o2b5e4s0 == 1 )
{
&f2o5b8e3s5( "possible-words-highest-lowest-for-proposalid-" . $f8o1b3e4s3 , "words-highest-proposal-usage-in-ranking-column" ) ;
} elsif ( $f4o2b5e4s0 == $f9o3b5e4s3  )
{
&f2o5b8e3s5( "possible-words-highest-lowest-for-proposalid-" . $f8o1b3e4s3 , "words-lowest-proposal-usage-in-ranking-column" ) ;
} else
{
&f2o5b8e3s5( "possible-words-highest-lowest-for-proposalid-" . $f8o1b3e4s3 , "" ) ;
}
$f4o2b5e4s0 ++ ;
&f2o5b8e3s5( "overall-ranking-level-for-proposalid-" . $f8o1b3e4s3 , "(?)" ) ;
}
for ( $f5o1b6e4s8 = 0 ; $f5o1b6e4s8 <= $#f6o8b9e3s8 ; $f5o1b6e4s8 ++ )
{
$f8o1b3e4s3 = $f6o8b9e3s8[ $f5o1b6e4s8 ] ;
&f2o5b8e3s5( "possible-estimated-for-proposalid-" . $f8o1b3e4s3 , "words-estimated-ranking-usage-in-ranking-column" ) ;
}
for ( $f5o1b6e4s8 = 0 ; $f5o1b6e4s8 <= $#f4o1b6e4s1 ; $f5o1b6e4s8 ++ )
{
$f8o1b3e4s3 = $f4o1b6e4s1[ $f5o1b6e4s8 ] ;
if ( $f5o1b6e4s8 <= $#f3o8b9e3s4 )
{
&f2o5b8e3s5( "positive-neutral-negative-capitalized-for-proposalid-" . $f8o1b3e4s3 , "Positive" ) ;
} elsif ( $f5o1b6e4s8 > $#f3o8b9e3s4 + 1 + $#f6o8b9e3s8 )
{
&f2o5b8e3s5( "positive-neutral-negative-capitalized-for-proposalid-" . $f8o1b3e4s3 , "Negative" ) ;
} else
{
&f2o5b8e3s5( "positive-neutral-negative-capitalized-for-proposalid-" . $f8o1b3e4s3 , "Neutral" ) ;
}
}
$f7o1b6e4s5 = &f6o7b8e3s3( "rankoverall-preferencesaccepted" ) . "," . &f6o7b8e3s3( "rankoverall-preferencesunpopular" ) ;
@f9o1b6e4s2 = &f9o3b9e3s2( $f7o1b6e4s5 ) ;
for ( $f2o8b1e4s3 = 0 ; $f2o8b1e4s3 <= $#f9o1b6e4s2 ; $f2o8b1e4s3 ++ )
{
$f8o1b3e4s3 = $f9o1b6e4s2 [ $f2o8b1e4s3 ] ;
$f4o2b5e4s0 = $f2o8b1e4s3 + 1 ;
&f2o5b8e3s5( "overall-ranking-level-for-proposalid-" . $f8o1b3e4s3 , $f4o2b5e4s0 ) ;
}
$f7o1b6e4s5 = &f6o7b8e3s3( "rankoverall-preferencesincompatible" ) ;
@f9o1b6e4s2 = &f9o3b9e3s2( $f7o1b6e4s5 ) ;
for ( $f2o8b1e4s3 = 0 ; $f2o8b1e4s3 <= $#f9o1b6e4s2 ; $f2o8b1e4s3 ++ )
{
$f8o1b3e4s3 = $f9o1b6e4s2 [ $f2o8b1e4s3 ] ;
&f2o5b8e3s5( "overall-ranking-level-for-proposalid-" . $f8o1b3e4s3 , "words-incompatible-usage-overall-level" ) ;
}
}
sub f8o7b9e3s3
{
&f1o0b9e3s8 ;
&f4o7b8e3s6 ;
$f0o2b6e4s9 = int( &f6o7b8e3s3( "percent-of-representation-based-on-raw-pairwise-counts" ) ) ;
if ( $f0o2b6e4s9 < 1 )
{
$f0o2b6e4s9 = 0 ;
} elsif ( $f0o2b6e4s9 > 99 )
{
$f0o2b6e4s9 = 100 ;
}
$f2o2b6e4s6 = int( &f6o7b8e3s3( "percent-of-representation-based-on-positive-ranking" ) ) ;
if ( $f2o2b6e4s6 < 1 )
{
$f2o2b6e4s6 = 0 ;
} elsif ( $f2o2b6e4s6 > 99 )
{
$f2o2b6e4s6 = 100 ;
}
$f4o2b6e4s3 = int( &f6o7b8e3s3( "percent-of-representation-based-on-negative-ranking" ) ) ;
if ( $f4o2b6e4s3 < 1 )
{
$f4o2b6e4s3 = 0 ;
} elsif ( $f4o2b6e4s3 > 99 )
{
$f4o2b6e4s3 = 100 ;
}
$f6o2b6e4s0 = $f0o2b6e4s9 + $f2o2b6e4s6 + $f4o2b6e4s3 ;
if ( $f6o2b6e4s0 > 100 )
{
$f0o2b6e4s9 = int( 100 * $f0o2b6e4s9 / $f6o2b6e4s0 );
$f2o2b6e4s6 = int( 100 * $f2o2b6e4s6 / $f6o2b6e4s0 );
$f4o2b6e4s3 = int( 100 * $f4o2b6e4s3 / $f6o2b6e4s0 );
}
$f7o2b6e4s7 = int( &f6o7b8e3s3( "case-info-majoritypercentage" ) ) ;
&f2o5b8e3s5( "majority-threshold-percent" , $f7o2b6e4s7 ) ;
&f2o5b8e3s5( "majority-threshold" , "word-unknown-in-brackets" ) ;
$f9o2b6e4s4 = int( &f6o7b8e3s3( "case-info-minoritypercentage" ) ) ;
&f2o5b8e3s5( "minority-threshold-percent" , $f9o2b6e4s4 ) ;
@f1o3b6e4s1 = ( ) ;
@f2o3b6e4s8 = ( ) ;
@f4o3b6e4s5 = ( ) ;
@f3o8b9e3s4 = @f1o3b6e4s1 ;
@f6o8b9e3s8 = @f4o3b6e4s5 ;
@f0o9b9e3s2 = @f2o3b6e4s8 ;
@f0o9b4e4s0 = @f6o1b3e4s6 ;
$f0o0b5e4s2 = $#f0o9b4e4s0 + 1 ;
$f4o2b5e4s0 = $f0o0b5e4s2 ;
for ( $f6o9b4e4s8 = 0 ; $f6o9b4e4s8 <= $#f2o3b5e4s5 ; $f6o9b4e4s8 ++ )
{
$f8o1b3e4s3 = $f2o3b5e4s5[ $f6o9b4e4s8 ] ;
$f6o3b6e4s2[ $f8o1b3e4s3 ] = $f4o2b5e4s0 ;
$f4o2b5e4s0 -- ;
}
$f7o3b6e4s9 = $f0o0b9e3s1 ;
if ( &f6o7b8e3s3( "parameter-category-ranking-type" ) =~ "overallpopularity" )
{
$f7o3b6e4s9 = $f6o4b9e3s0 ;
}
$f9o3b6e4s6 = 1 ;
$f1o4b6e4s3 = 2 ;
if ( &f6o7b8e3s3( "case-info-acceptancecriteria" ) =~ /average/i )
{
$f3o4b6e4s0 = $f9o3b6e4s6 ;
&f2o5b8e3s5( "acceptance-criteria" , "Average" ) ;
} elsif ( &f6o7b8e3s3( "case-info-acceptancecriteria" ) =~ /each/i )
{
$f3o4b6e4s0 = $f1o4b6e4s3 ;
&f2o5b8e3s5( "acceptance-criteria" , "Each" ) ;
} else
{
$f3o4b6e4s0 = $f1o4b6e4s3 ;
&f2o5b8e3s5( "acceptance-criteria" , "Each" ) ;
}
if ( $f0o0b5e4s2 < 1 )
{
&f1o0b9e3s8 ;
&f4o7b8e3s6 ;
return ;
}
$f1o7b3e4s0 = $#f5o6b3e4s9 + 1 ;
if ( $f1o7b3e4s0 < 1 )
{
&f1o8b9e3s7 ;
@f4o4b6e4s7 = ( ) ;
foreach $f8o1b3e4s3 ( @f0o9b4e4s0 )
{
$f4o4b6e4s7[ $f8o1b3e4s3 ] = $f6o4b9e3s0
}
for ( $f6o9b4e4s8 = 0 ; $f6o9b4e4s8 <= $#f2o3b5e4s5 ; $f6o9b4e4s8 ++ )
{
$f8o1b3e4s3 = $f2o3b5e4s5[ $f6o9b4e4s8 ] ;
if ( $f4o4b6e4s7[ $f8o1b3e4s3 ] == $f6o4b9e3s0 )
{
push ( @f4o3b6e4s5 , $f8o1b3e4s3 ) ;
&f2o5b8e3s5( "percentage-positive-only-votes-for-proposalid-" . $f8o1b3e4s3 , "0" ) ;
$f6o4b6e4s4[ $f8o1b3e4s3 ] = "no-votes-yet" ;
}
}
@f6o8b9e3s8 = @f4o3b6e4s5 ;
&f2o5b8e3s5( "table-overall-proposals-multiple" , &f6o7b8e3s3( "table-overall-proposals-no-votes" ) ) ;
&f3o9b9e3s6 ;
return ;
}
&f1o0b9e3s8 ;
@f5o0b5e4s3 = @f5o6b3e4s9 ;
&f4o8b4e4s9 ;
&f1o0b9e3s8 ;
@f8o4b6e4s1 = @f5o2b5e4s7 ;
$f9o4b6e4s8 = 0 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f1o5b6e4s5 = $f6o4b9e3s0 ;
$f5o5b8e3s9 .= $f8o4b6e4s1[ $f9o4b6e4s8 ] ;
$f3o5b6e4s2 = $f0o0b5e4s2 - $f3o9b4e4s4 + 1;
if ( $f3o5b6e4s2 == $f0o3b5e4s8[ $f1o0b2e4s0 ] )
{
$f5o5b8e3s9 .= "*" ;
$f1o5b6e4s5 = $f0o0b9e3s1 ;
}
if ( $f3o5b6e4s2 == $f0o0b5e4s2 - $f9o2b5e4s1[ $f1o0b2e4s0 ] )
{
$f5o5b8e3s9 .= "*" ;
$f1o5b6e4s5 = $f0o0b9e3s1 ;
}
if ( $f1o5b6e4s5 == $f6o4b9e3s0 )
{
$f5o5b8e3s9 .= "," ;
}
$f9o4b6e4s8 ++ ;
}
}
$f4o5b6e4s9 = 0 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
if ( &f6o7b8e3s3( "weight-for-voter-id-" . $f1o0b2e4s0 ) =~ /([0-9\.]+)/ )
{
$f6o5b6e4s6 = $1 ;
} else
{
$f6o5b6e4s6 = 1 ;
}
if ( $f6o5b6e4s6 < 1 )
{
$f6o5b6e4s6 = 1 ;
}
$f4o5b6e4s9 += $f6o5b6e4s6 ;
$f8o5b6e4s3[ $f1o0b5e4s9 ] = $f6o5b6e4s6 ;
}
$f0o6b6e4s0 = 1 / $f4o5b6e4s9 ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
$f1o6b6e4s7 = 0 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
$f3o6b6e4s4 = $f0o0b5e4s2 - $f9o2b5e4s1[ $f1o0b2e4s0 ] + 1 ;
$f0o1b5e4s4 = $f0o0b5e4s2 * ( $f1o0b5e4s9 - 1 ) - 1 ;
$f3o5b6e4s2 = $f5o2b5e4s7[ $f0o1b5e4s4 + $f3o9b4e4s4 ] ;
if ( $f3o5b6e4s2 >= $f3o6b6e4s4 )
{
$f1o6b6e4s7 += $f8o5b6e4s3[ $f1o0b5e4s9 ] ;
} else
{
}
}
$f5o6b6e4s1[ $f8o1b3e4s3 ] = int( ( 100 * $f1o6b6e4s7 / $f4o5b6e4s9 ) + 0.5 ) ;
&f2o5b8e3s5( "percentage-positive-only-votes-for-proposalid-" . $f8o1b3e4s3 , $f5o6b6e4s1[ $f8o1b3e4s3 ] ) ;
}
for ( $f6o6b6e4s8 = 1 ; $f6o6b6e4s8 <= $f0o0b5e4s2 ; $f6o6b6e4s8 ++ )
{
$f8o6b6e4s5 = $f8o9b4e4s5[ $f6o6b6e4s8 ] ;
for ( $f0o7b6e4s2 = 1 ; $f0o7b6e4s2 <= $f0o0b5e4s2 ; $f0o7b6e4s2 ++ )
{
$f1o7b6e4s9 = $f8o9b4e4s5[ $f0o7b6e4s2 ] ;
$f3o7b6e4s6[ ( $f0o7b6e4s2 - 1 ) * $f0o0b5e4s2 + $f6o6b6e4s8 ] = $f0o0b9e3s1 ;
$f7o3b0e4s8 = "voteincompatibility-yesnoundecided-for-ifproposal-" . $f8o6b6e4s5 . "-thennotproposal-" . $f1o7b6e4s9 ;
if ( &f6o7b8e3s3( $f7o3b0e4s8 ) =~ /y/ )
{
$f3o7b6e4s6[ ( $f0o7b6e4s2 - 1 ) * $f0o0b5e4s2 + $f6o6b6e4s8 ] = $f6o4b9e3s0 ;
}
}
}
$f7o2b6e4s7 = int( &f6o7b8e3s3( "case-info-majoritypercentage" ) ) ;
if ( $f7o2b6e4s7 > 50 )
{
$f5o7b6e4s3 = $f1o7b3e4s0 * $f7o2b6e4s7 / 100. ;
$f7o7b6e4s0 = int( $f5o7b6e4s3 ) ;
while ( $f7o7b6e4s0 < $f5o7b6e4s3 )
{
$f7o7b6e4s0 ++ ;
}
} else
{
$f7o7b6e4s0 = int( $f1o7b3e4s0 / 2 ) ;
}
if ( $f1o7b3e4s0 == 2 )
{
$f7o7b6e4s0 = 2 ;
}
while ( ( $f7o7b6e4s0 * 2 ) <= $f1o7b3e4s0 )
{
$f7o7b6e4s0 ++ ;
}
&f2o5b8e3s5( "majority-threshold" , $f7o7b6e4s0 ) ;
&f2o5b8e3s5( "majority-threshold-percent" , $f7o2b6e4s7 ) ;
$f8o7b6e4s7 = 100 * $f7o7b6e4s0 / $f4o5b6e4s9 ;
if ( ( $f3o4b6e4s0 == $f9o3b6e4s6 ) && ( $f8o7b6e4s7 > 40 ) )
{
$f8o7b6e4s7 = 40 ;
}
$f0o8b6e4s4 = &f6o7b8e3s3( "threshold-percentage-top-ranked-proposals-for-successive-elimination" ) ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f2o8b6e4s1[ $f3o9b4e4s4 ] = $f6o4b9e3s0 ;
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
}
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f3o8b6e4s8[ $f1o0b5e4s9 ] = 0 ;
$f5o8b6e4s5[ $f1o0b5e4s9 ] = 0 ;
$f7o8b6e4s2[ $f1o0b5e4s9 ] = 0 ;
$f8o8b6e4s9[ $f1o0b5e4s9 ] = 0 ;
}
$f0o9b6e4s6 = 1 ;
$f7o9b0e4s3 = 2 ;
$f2o9b6e4s3 = $f0o9b6e4s6 ;
$f6o3b1e4s4 = 0 ;
while ( $f2o9b6e4s3 != $f7o9b0e4s3 )
{
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > 300 )
{
$f2o9b6e4s3 = $f7o9b0e4s3 ;
last ;
}
$f4o9b6e4s0 = $#f1o3b6e4s1 + 1 ;
$f5o9b6e4s7 = $#f4o3b6e4s5 + 1 ;
$f7o9b6e4s4 = $#f2o3b6e4s8 + 1 ;
$f9o9b6e4s1 = $f0o0b5e4s2 - $f4o9b6e4s0 - $f5o9b6e4s7 - $f7o9b6e4s4 ;
if ( $f9o9b6e4s1 < 1 )
{
$f2o9b6e4s3 = $f7o9b0e4s3 ;
last ;
}
$f0o0b7e4s8 = 1 ;
if ( $f7o3b6e4s9 == $f6o4b9e3s0 )
{
$f0o0b7e4s8 = 2 ;
}
while ( $f0o0b7e4s8 <= 2 )
{
$f6o3b1e4s4 ++ ;
if ( $f6o3b1e4s4 > 300 )
{
$f0o0b7e4s8 = 99999 ;
last ;
}
$f9o9b6e4s1 = 0 ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f9o9b6e4s1 ++ ;
}
}
$f2o0b7e4s5 = $f0o8b6e4s4 * 0.01 ;
if ( $f0o0b7e4s8 == 1 )
{
$f4o0b7e4s2 = int( $f9o9b6e4s1 * $f0o8b6e4s4 * 0.01 ) ;
} else
{
$f4o0b7e4s2 = 1 ;
}
if ( $f4o0b7e4s2 < 1 )
{
$f4o0b7e4s2 = 1 ;
}
if ( $f9o9b6e4s1 == 1 )
{
$f4o0b7e4s2 = 1 ;
}
if ( $f4o0b7e4s2 == 1 )
{
$f0o0b7e4s8 = 2 ;
}
$f5o0b7e4s9 = 1 ;
if ( $f4o9b6e4s0 > 0 )
{
$f5o0b7e4s9 = 1 / $f4o9b6e4s0 ;
}
$f7o0b7e4s6 = 0 ;
if ( $f4o9b6e4s0 > 0 )
{
}
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
if ( $f4o9b6e4s0 < 1 )
{
$f9o0b7e4s3[ $f1o0b5e4s9 ] = 100 ;
} else
{
$f1o1b7e4s0 = int( $f3o8b6e4s8[ $f1o0b5e4s9 ] * 0.01 * $f0o2b6e4s9 ) ;
$f2o1b7e4s7 = int( $f5o8b6e4s5[ $f1o0b5e4s9 ] * 0.01 * $f0o2b6e4s9 ) ;
$f4o1b7e4s4 = $f7o8b6e4s2[ $f1o0b5e4s9 ] * $f2o2b6e4s6 ;
$f6o1b7e4s1 = ( $f4o9b6e4s0 - $f8o8b6e4s9[ $f1o0b5e4s9 ] ) * $f4o2b6e4s3 ;
$f9o0b7e4s3[ $f1o0b5e4s9 ] = int( 100 - ( $f8o5b6e4s3[ $f1o0b5e4s9 ] * ( $f1o1b7e4s0 + $f4o1b7e4s4 + $f6o1b7e4s1 ) ) ) ;
$f7o1b7e4s8 = $f7o8b6e4s2[ $f1o0b5e4s9 ] * $f5o0b7e4s9 * 100 ;
$f9o1b7e4s5 = ( $f4o9b6e4s0 - $f8o8b6e4s9[ $f1o0b5e4s9 ] ) * $f5o0b7e4s9 * 100 ;
}
$f7o0b7e4s6 += $f9o0b7e4s3[ $f1o0b5e4s9 ] ;
$f1o2b7e4s2[ $f1o0b5e4s9 ] = 0 ;
}
if ( $f7o0b7e4s6 < ( $f4o5b6e4s9 * $f9o2b6e4s4 ) )
{
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
if ( $f4o9b6e4s0 < 1 )
{
$f9o0b7e4s3[ $f1o0b5e4s9 ] = 100 ;
}
}
}
@f8o4b6e4s1 = @f5o2b5e4s7 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
$f0o1b5e4s4 = $f0o0b5e4s2 * ( $f1o0b5e4s9 - 1 ) - 1 ;
for ( $f3o5b6e4s2 = 1 ; $f3o5b6e4s2 <= $f0o0b5e4s2 ; $f3o5b6e4s2 ++ )
{
$f2o2b7e4s9[ $f3o5b6e4s2 ] = 0 ;
}
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f3o5b6e4s2 = $f8o4b6e4s1[ $f0o1b5e4s4 + $f3o9b4e4s4 ] ;
$f2o2b7e4s9[ $f3o5b6e4s2 ] = $f3o9b4e4s4 ;
}
}
$f3o5b6e4s2 = 1 ;
for ( $f4o2b7e4s6 = 1 ; $f4o2b7e4s6 <= $f0o0b5e4s2 ; $f4o2b7e4s6 ++ )
{
$f3o9b4e4s4 = $f2o2b7e4s9[ $f4o2b7e4s6 ] ;
if ( $f3o9b4e4s4 > 0 )
{
$f8o4b6e4s1[ $f0o1b5e4s4 + $f3o9b4e4s4 ] = $f3o5b6e4s2 ;
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
$f3o5b6e4s2 ++ ;
}
}
$f6o2b7e4s3 = $f3o5b6e4s2 - 1 ;
}
if ( $f6o2b7e4s3 < 1 )
{
$f6o2b7e4s3 = 1 ;
}
if ( $f9o9b6e4s1 > 1 )
{
$f8o2b7e4s0 = 100 / ( $f9o9b6e4s1 - 1 ) ;
} else
{
$f8o2b7e4s0 = 100 ;
}
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f9o2b7e4s7 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f1o3b7e4s4[ $f3o9b4e4s4 ] = 0 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
$f0o1b5e4s4 = $f0o0b5e4s2 * ( $f1o0b5e4s9 - 1 ) - 1 ;
$f3o5b6e4s2 = $f8o4b6e4s1[ $f0o1b5e4s4 + $f3o9b4e4s4 ] ;
$f3o6b6e4s4 = $f0o0b5e4s2 - $f9o2b5e4s1[ $f1o0b2e4s0 ] + 1 ;
$f3o3b7e4s1 = $f0o3b5e4s8[ $f1o0b2e4s0 ] ;
$f4o3b7e4s8 = $f3o3b7e4s1 + 1 ;
if ( ( $f3o5b6e4s2 > $f3o3b7e4s1 ) && ( $f3o5b6e4s2 < $f3o6b6e4s4 ) )
{
$f3o5b6e4s2 = $f4o3b7e4s8 ;
}
$f6o3b7e4s5 = ( ( $f3o5b6e4s2 - 1 ) * $f8o2b7e4s0 ) * $f9o0b7e4s3[ $f1o0b5e4s9 ] ;
$f1o3b7e4s4[ $f3o9b4e4s4 ] += $f6o3b7e4s5 ;
$f1o2b7e4s2[ $f1o0b5e4s9 ] = $f6o3b7e4s5 ;
$f8o3b7e4s2 = ( $f3o5b6e4s2 - 1 ) * $f8o2b7e4s0 * $f9o0b7e4s3[ $f1o0b5e4s9 ] ;
if ( $f8o3b7e4s2 > 0 )
{
$f9o3b7e4s9[ $f3o9b4e4s4 ] += $f8o3b7e4s2 ;
} else
{
$f3o8b0e4s7 ++ ;
}
}
$f1o3b7e4s4[ $f3o9b4e4s4 ] *= $f0o6b6e4s0 ;
}
}
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f9o2b7e4s7 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
}
}
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
}
$f1o4b7e4s6 = 999999 ;
$f3o4b7e4s3 = -999999 ;
$f5o4b7e4s0 = 0 ;
$f8o9b4e4s5[ 0 ] = 0 ;
$f6o4b7e4s7 = 0 ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f9o2b7e4s7 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f8o4b7e4s4 = $f1o3b7e4s4[ $f3o9b4e4s4 ] ;
if ( $f8o4b7e4s4 > $f3o4b7e4s3 )
{
$f5o4b7e4s0 = $f3o9b4e4s4 ;
$f3o4b7e4s3 = $f8o4b7e4s4 ;
$f6o4b7e4s7 = 0 ;
} elsif ( $f8o4b7e4s4 == $f3o4b7e4s3 )
{
$f6o4b7e4s7 ++ ;
} elsif ( $f8o4b7e4s4 < $f1o4b7e4s6 )
{
$f1o4b7e4s6 = $f8o4b7e4s4 ;
}
}
}
if ( $f1o4b7e4s6 + 4 > $f3o4b7e4s3 )
{
$f1o4b7e4s6 = $f3o4b7e4s3 - 4 ;
}
$f0o5b7e4s1 = ( ( $f3o4b7e4s3 - $f1o4b7e4s6 ) *  $f2o0b7e4s5 ) + $f1o4b7e4s6 ;
if ( $f4o0b7e4s2 > 1 )
{
$f1o5b7e4s8 = 0 ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f9o2b7e4s7 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( $f1o3b7e4s4[ $f3o9b4e4s4 ] <= $f0o5b7e4s1 )
{
$f1o5b7e4s8 ++ ;
$f3o5b7e4s5[ $f1o5b7e4s8 ] = $f3o9b4e4s4 ;
$f2o8b6e4s1[ $f3o9b4e4s4 ] = $f0o0b9e3s1 ;
}
}
}
$f0o0b7e4s8 ++ ;
next ;
}
if ( $f6o4b7e4s7 == 1 )
{
$f5o5b7e4s2 = $f8o9b4e4s5[ $f5o4b7e4s0 ] ;
} else
{
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
$f9o2b7e4s7 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
if ( ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 ) && ( $f3o9b4e4s4 != $f5o4b7e4s0 ) )
{
$f5o5b7e4s2 = $f8o9b4e4s5[ $f5o4b7e4s0 ] ;
if ( $f1o3b7e4s4[ $f3o9b4e4s4 ] == $f3o4b7e4s3 )
{
$f6o5b7e4s9 = $f6o8b4e4s6[ $f5o5b7e4s2 ] ;
$f8o5b7e4s6 = $f6o8b4e4s6[ $f9o2b7e4s7 ] ;
if ( $f8o5b7e4s6 > $f6o5b7e4s9 )
{
$f5o4b7e4s0 = $f3o9b4e4s4 ;
} elsif ( $f8o5b7e4s6 < $f6o5b7e4s9 )
{
} else
{
$f0o6b7e4s3 = $f6o4b9e3s0 ;
$f2o6b7e4s0 = $f6o3b6e4s2[ $f9o2b7e4s7 ] ;
$f3o6b7e4s7 = $f6o3b6e4s2[ $f5o5b7e4s2 ] ;
if ( $f2o6b7e4s0 > $f3o6b7e4s7 )
{
$f5o4b7e4s0 = $f3o9b4e4s4 ;
}
}
}
}
}
$f0o0b7e4s8 = 99999 ;
last ;
}
$f0o0b7e4s8 ++ ;
}
$f5o5b7e4s2 = $f8o9b4e4s5[ $f5o4b7e4s0 ] ;
$f5o6b7e4s4 = 0 ;
if ( $f1o5b7e4s8 > 0 )
{
for ( $f6o9b4e4s8 = 1 ; $f6o9b4e4s8 <= $f1o5b7e4s8 ; $f6o9b4e4s8 ++ )
{
$f3o9b4e4s4 = $f3o5b7e4s5[ $f6o9b4e4s8 ] ;
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
$f2o8b6e4s1[ $f3o9b4e4s4 ] = $f6o4b9e3s0 ;
}
}
$f1o5b7e4s8 = 0 ;
$f4o9b6e4s0 = $#f1o3b6e4s1 + 1 ;
if ( $f4o9b6e4s0 == 0 )
{
$f7o6b7e4s1 = $f5o6b6e4s1[ $f5o5b7e4s2 ] ;
} else
{
$f7o6b7e4s1 = ( ( $f7o6b7e4s1 * $f4o9b6e4s0 ) + $f5o6b6e4s1[ $f5o5b7e4s2 ] ) / ( $f4o9b6e4s0 + 1 ) ;
}
if ( $f7o3b6e4s9 == $f6o4b9e3s0 )
{
$f5o6b7e4s4 = $f5o5b7e4s2 ;
} elsif ( $f3o4b6e4s0 == $f1o4b6e4s3 )
{
if ( $f5o6b6e4s1[ $f5o5b7e4s2 ] >= $f8o7b6e4s7 )
{
$f5o6b7e4s4 = $f5o5b7e4s2 ;
} else
{
$f5o6b7e4s4 = 0 ;
}
} else
{
if ( $f5o6b6e4s1[ $f5o5b7e4s2 ] >= $f8o7b6e4s7 )
{
$f5o6b7e4s4 = $f5o5b7e4s2 ;
} else
{
if ( $f7o6b7e4s1 >= $f7o2b6e4s7 )
{
$f5o6b7e4s4 = $f5o5b7e4s2 ;
} else
{
$f5o6b7e4s4 = 0 ;
}
}
}
if ( $f5o6b7e4s4 == 0 )
{
push( @f4o3b6e4s5 , $f5o5b7e4s2 ) ;
$f2o8b6e4s1[ $f5o4b7e4s0 ] = $f0o0b9e3s1 ;
} else
{
$f8o6b7e4s8 = $f5o9b4e4s1[ $f5o6b7e4s4 ] ;
push( @f1o3b6e4s1 , $f5o6b7e4s4 ) ;
$f2o8b6e4s1[ $f8o6b7e4s8 ] = $f0o0b9e3s1 ;
$f4o9b6e4s0 ++ ;
if ( $f7o3b6e4s9 != $f6o4b9e3s0 )
{
for ( $f0o7b6e4s2 = 1 ; $f0o7b6e4s2 <= $f0o0b5e4s2 ; $f0o7b6e4s2 ++ )
{
$f1o7b6e4s9 = $f8o9b4e4s5[ $f0o7b6e4s2 ] ;
if ( $f2o8b6e4s1[ $f0o7b6e4s2 ] == $f6o4b9e3s0 )
{
if ( $f3o7b6e4s6[ ( $f0o7b6e4s2 - 1 ) * $f0o0b5e4s2 + $f8o6b7e4s8 ] == $f6o4b9e3s0 )
{
push( @f2o3b6e4s8 , $f1o7b6e4s9 ) ;
$f2o8b6e4s1[ $f0o7b6e4s2 ] = $f0o0b9e3s1 ;
}
}
}
}
}
$f9o9b6e4s1 = 0 ;
$f0o7b7e4s5 = "" ;
for ( $f3o9b4e4s4 = 1 ; $f3o9b4e4s4 <= $f0o0b5e4s2 ; $f3o9b4e4s4 ++ )
{
if ( $f2o8b6e4s1[ $f3o9b4e4s4 ] == $f6o4b9e3s0 )
{
$f9o9b6e4s1 ++ ;
$f8o1b3e4s3 = $f8o9b4e4s5[ $f3o9b4e4s4 ] ;
$f0o7b7e4s5 .= "," . $f8o1b3e4s3 ;
} else
{
}
}
if ( $f9o9b6e4s1 < 1 )
{
$f2o9b6e4s3 = $f7o9b0e4s3 ;
last ;
}
@f2o7b7e4s2 = ( @f1o3b6e4s1 , @f2o3b6e4s8 , @f4o3b6e4s5 ) ;
if ( $#f2o7b7e4s2 > $f0o0b5e4s2 )
{
$f2o9b6e4s3 = $f7o9b0e4s3 ;
last ;
}
if ( ( $f5o6b7e4s4 > 0 ) && ( $f7o3b6e4s9 != $f6o4b9e3s0 ) )
{
if ( $f6o2b7e4s3 < 1 )
{
$f6o2b7e4s3 = 1 ;
}
$f3o7b7e4s9 = 100 / $f6o2b7e4s3 ;
for ( $f1o0b5e4s9 = 1 ; $f1o0b5e4s9 <= $f1o7b3e4s0 ; $f1o0b5e4s9 ++ )
{
$f1o0b2e4s0 = $f7o0b5e4s0[ $f1o0b5e4s9 ] ;
$f0o1b5e4s4 = $f0o0b5e4s2 * ( $f1o0b5e4s9 - 1 ) - 1 ;
$f5o7b7e4s6 = $f8o4b6e4s1[ $f0o1b5e4s4 + $f8o6b7e4s8 ] ;
$f7o7b7e4s3 = $f5o2b5e4s7[ $f0o1b5e4s4 + $f8o6b7e4s8 ] ;
if ( $f5o7b7e4s6 > $f6o2b7e4s3 )
{
}
$f9o7b7e4s0 = 100 * $f5o7b7e4s6 / $f6o2b7e4s3 ;
if ( $f4o9b6e4s0 < 2 )
{
$f3o8b6e4s8[ $f1o0b5e4s9 ] = int( $f9o7b7e4s0 + 0.5 ) ;
} else
{
$f3o8b6e4s8[ $f1o0b5e4s9 ] = int( ( ( ( $f3o8b6e4s8[ $f1o0b5e4s9 ] * ( $f4o9b6e4s0 - 1 ) ) + $f9o7b7e4s0 ) / $f4o9b6e4s0 ) + 0.5 ) ;
}
if ( $f7o7b7e4s3 <= $f0o3b5e4s8[ $f1o0b2e4s0 ] )
{
$f8o8b6e4s9[ $f1o0b5e4s9 ] ++ ;
}
if ( $f7o7b7e4s3 >= $f0o0b5e4s2 - $f9o2b5e4s1[ $f1o0b2e4s0 ] + 1 )
{
$f7o8b6e4s2[ $f1o0b5e4s9 ] ++ ;
}
}
}
}
@f3o8b9e3s4 = @f1o3b6e4s1 ;
@f6o8b9e3s8 = @f4o3b6e4s5 ;
@f0o9b9e3s2 = @f2o3b6e4s8 ;
&f2o5b8e3s5( "xml-content-preferencesaccepted" , join( "," , @f1o3b6e4s1 ) ) ;
&f2o5b8e3s5( "xml-content-preferencesunpopular" , join( "," , @f4o3b6e4s5 ) ) ;
&f2o5b8e3s5( "xml-content-preferencesincompatible" , join( "," , @f2o3b6e4s8 ) ) ;
$f9o6b2e4s0 = &f0o3b9e3s7( "xml-template-rankoverall" ) ;
$f5o5b2e4s4 = "xml-overall-rankoverall" ;
&f2o5b8e3s5( $f5o5b2e4s4 , $f9o6b2e4s0 . "\n" ) ;
&f2o5b8e3s5( "list-of-xml-code-of-type-" . "main" , $f5o5b2e4s4  ) ;
push ( @f0o8b7e4s7 , $f5o5b2e4s4 ) ;
&f4o7b2e4s1 ;
}
sub f1o8b9e3s7
{
my ( $f8o1b3e4s3 ) ;
$f5o5b8e3s9 .= "<sorttie>Entered sort-tie-resolution-ranking subroutine<\/sorttie>" ;
$f5o5b8e3s9 .= "<sorttie>List of proposal IDs: " . join( "," , @f6o1b3e4s6 ) ."<\/sorttie>" ;
@f5o8b9e3s1 = ( ) ;
@f1o9b9e3s9 = ( ) ;
if ( &f6o7b8e3s3( "tiebreak-sequencepositive" ) =~ /[0-9]/ )
{
@f5o8b9e3s1 = &f9o3b9e3s2( &f6o7b8e3s3( "tiebreak-sequencepositive" ) ) ;
}
if ( &f6o7b8e3s3( "tiebreak-sequencenegative" ) =~ /[0-9]/ )
{
@f1o9b9e3s9 = &f9o3b9e3s2( &f6o7b8e3s3( "tiebreak-sequencenegative" ) ) ;
}
@f0o2b5e4s6 = ( ) ;
foreach $f8o1b3e4s3 ( @f5o8b9e3s1 , @f1o9b9e3s9 )
{
if ( $f0o2b5e4s6[ $f8o1b3e4s3 ] == 0 )
{
$f0o2b5e4s6[ $f8o1b3e4s3 ] ++ ;
}
}
@f8o8b9e3s5 = ( ) ;
foreach $f8o1b3e4s3 ( sort( @f6o1b3e4s6 ) )
{
if ( $f0o2b5e4s6[ $f8o1b3e4s3 ] == 0 )
{
push( @f8o8b9e3s5 , $f8o1b3e4s3 ) ;
$f0o2b5e4s6[ $f8o1b3e4s3 ] ++ ;
}
}
@f2o3b5e4s5 = ( @f5o8b9e3s1 , @f8o8b9e3s5 , @f1o9b9e3s9  ) ;
$f5o5b8e3s9 .= "<sorttie>Tie resolution ranking: " . join( "," , @f2o3b5e4s5 ) ."<\/sorttie>" ;
}
sub f9o3b9e3s2
{
my ( $f4o9b1e4s2 ) ;
$f2o9b1e4s5 = $_[ 0 ] ;
if ( $f2o9b1e4s5 =~ /[\n\r]/ )
{
$f2o9b1e4s5 =~ s/[\n\r][\n\r]+/,/gs ;
$f2o9b1e4s5 =~ s/[\n\r][\n\r]+/,/gs ;
}
$f2o9b1e4s5 =~ s/ +/,/gs ;
$f2o9b1e4s5 =~ s/,,+/,/gs ;
$f2o9b1e4s5 =~ s/^,// ;
$f2o9b1e4s5 =~ s/,$// ;
if ( $f2o9b1e4s5 =~ /^[ ,]*$/ )
{
@f4o9b1e4s2 = ( ) ;
} else
{
@f4o9b1e4s2 = split( /,+/ , $f2o9b1e4s5 ) ;
}
return @f4o9b1e4s2 ;
}
sub f8o8b8e3s2
{
&f2o6b2e4s2 ;
$f5o9b8e3s0 = $f3o6b2e4s9 ;
&f2o5b8e3s5( "user-id" , $f5o9b8e3s0 ) ;
$f2o8b7e4s4 = $f5o9b8e3s0 ;
&f2o5b8e3s5( "administrator-user-id" , $f3o6b2e4s9 ) ;
$f5o5b8e3s9 .= "<newcase>User id = " . $f5o9b8e3s0 . "<\/newcase>" ;
$f5o5b8e3s9 .= "<newcase>Day of year =  " . $f2o6b3e4s5 . "<\/newcase>" ;
$f4o8b7e4s1 = sprintf( "%02d" , ( ( 369 - $f2o6b3e4s5 ) % 100 ) ) ;
$f5o5b8e3s9 .= "<newcase>Day-of-year based digits =  " . $f4o8b7e4s1 . "<\/newcase>" ;
$f5o8b7e4s8 = 10000 ;
$f3o0b3e4s0 = $f5o8b7e4s8 - 1 - ( time( ) % $f5o8b7e4s8 ) ;
&f4o7b8e3s6 ;
$f6o3b1e4s4 = 1 ;
while ( $f6o4b9e3s0 )
{
$f3o0b3e4s0 -= 100 ;
if ( $f3o0b3e4s0 < 1 )
{
$f3o0b3e4s0 = $f5o8b7e4s8 - 1 ;
}
$f4o0b3e4s7 = sprintf( "%04d" , $f3o0b3e4s0 ) ;
$f5o5b8e3s9 .= "<newcase>Random number =  " . $f4o0b3e4s7 . "<\/newcase>" ;
$f9o8b8e3s9 = ( $f4o8b7e4s1 . $f4o0b3e4s7 ) + 0 ;
$f9o8b8e3s9 %= $f4o4b0e4s6 ;
$f7o8b7e4s5 = $f8o6b5e4s2 . "case-" . $f9o8b8e3s9 . "-main.txt" ;
$f5o5b8e3s9 .= "<newcase>Checking possible new file name: " . $f7o8b7e4s5 . " for existence<\/newcase>" ;
$f6o3b1e4s4 ++ ;
if ( -e $f7o8b7e4s5 )
{
if ( $f6o3b1e4s4 > 100 )
{
$f6o8b8e3s5 .= &f6o7b8e3s3( "error-message-unable-to-create-file" ) ;
return ;
&f1o0b9e3s8 ;
}
} else
{
last ;
}
}
if ( open ( OUTFILE , ">" . $f7o8b7e4s5 ) )
{
$f5o5b8e3s9 .= "<newcase>Created new info file named " . $f7o8b7e4s5 . "<\/newcase>" ;
} else
{
$f6o8b8e3s5 .= &f6o7b8e3s3( "error-message-unable-to-create-file" ) ;
$f5o5b8e3s9 .= "<newcase>Failure creating file named " . $f7o8b7e4s5 . "<\/newcase>" ;
$f5o5b8e3s9 .= "<newcase>NOTE: Make sure the specified subdirectory exists. If it does not, create it.<\/newcase>" ;
return ;
&f1o0b9e3s8 ;
}
close( OUTFILE ) ;
&f7o2b0e4s6 ;
&f2o5b8e3s5( "input-accessid" , $f1o9b8e3s6 ) ;
&f2o5b8e3s5( "language-specific-case-title" , &f6o7b8e3s3( "default-case-title" ) ) ;
&f2o5b8e3s5( "admin-user-id" , $f2o8b7e4s4 ) ;
$f5o5b2e4s4 = "xml-for-new-case" ;
$f9o8b7e4s2 = &f0o3b9e3s7( "new-case-xml") . "\n" ;
$f9o8b7e4s2 =~ s/<eol *\/>/\n/gs ;
$f9o8b7e4s2 =~ s/^ +//gs ;
&f2o5b8e3s5( $f5o5b2e4s4 , $f9o8b7e4s2 ) ;
$f7o5b2e4s1 = "main" ;
&f2o5b8e3s5( "list-of-xml-code-of-type-" . $f7o5b2e4s1 , &f6o7b8e3s3( "list-of-xml-code-of-type-" . $f7o5b2e4s1 ) . $f5o5b2e4s4 . "," ) ;
$f5o5b8e3s9 .= "<newcase>Info named " . $f5o5b2e4s4 . " to be added: " . &f6o7b8e3s3( $f5o5b2e4s4 ) . "<\/newcase>" ;
$f5o5b2e4s4 = "xml-for-empty-statement" ;
$f9o8b7e4s2 = &f0o3b9e3s7( "new-case-xml-empty-statement" ) . "\n" ;
$f9o8b7e4s2 =~ s/<eol *\/>/\n/gs ;
$f9o8b7e4s2 =~ s/^ +//gs ;
&f2o5b8e3s5( $f5o5b2e4s4 , $f9o8b7e4s2 ) ;
$f7o5b2e4s1 = "statements" ;
&f2o5b8e3s5( "list-of-xml-code-of-type-" . $f7o5b2e4s1 , &f6o7b8e3s3( "list-of-xml-code-of-type-" . $f7o5b2e4s1 ) . $f5o5b2e4s4 . "," ) ;
$f5o5b8e3s9 .= "<newcase>Info named " . $f5o5b2e4s4 . " to be added: " . &f6o7b8e3s3( $f5o5b2e4s4 ) . "<\/newcase>" ;
&f4o7b2e4s1 ;
}
sub f4o7b9e3s9
{
$f6o6b8e3s1 = $f6o0b9e3s9 ;
$f5o5b8e3s9 .= "<export>Filename: " . $f6o6b8e3s1 . "<\/export>" ;
&f7o6b8e3s8 ;
$f0o9b7e4s9 = $f2o7b8e3s9 ;
&f4o7b8e3s6 ;
$f2o1b0e4s3 = &f6o7b8e3s3( "xml-template-begin" ) . $f0o9b7e4s9 . &f6o7b8e3s3( "xml-template-end" ) ;
}
sub f6o7b9e3s6
{
&f5o0b9e3s2 ;
$f6o6b8e3s1 = $f6o0b9e3s9 ;
&f7o6b8e3s8 ;
$f9o1b2e4s7 = $f2o7b8e3s9 ;
$f6o6b8e3s1 = $f1o7b5e4s6 . $f9o8b8e3s9 . "-" . $f7o0b2e4s8 . $f3o7b5e4s3 ;
&f8o1b2e4s0 ;
if ( $f6o8b8e3s5 ne "" )
{
$f5o5b8e3s9 .= "<import>Ignoring this error message: " . $f6o8b8e3s5 . "<\/import>" ;
$f6o8b8e3s5 = "" ;
}
$f5o5b8e3s9 .= "<import>Importing XML supplied by participant<\/import>" ;
&f2o5b8e3s5( "input-xmlraw" , &f6o7b8e3s3( "input-texttoimport" ) ) ;
$f2o9b7e4s6 = &f6o7b8e3s3( "input-xmlraw" ) ;
$f6o7b9e3s6 =~ s/<xmlraw>//sg ;
$f6o7b9e3s6 =~ s/<\/?xmlraw>//sg ;
$f6o7b9e3s6 =~ s/<votefairnegotiationvoting>//sg ;
$f6o7b9e3s6 =~ s/<\/?votefairnegotiationvoting>//sg ;
$f6o7b9e3s6 =~ s/^ +//sg ;
$f6o7b9e3s6 =~ s/ +$//sg ;
$f6o7b9e3s6 = &f6o7b8e3s3( "xml-template-begin" ) . $f6o7b9e3s6 . &f6o7b8e3s3( "xml-template-end" ) ;
$f6o6b8e3s1 = $f6o0b9e3s9 ;
$f9o1b2e4s7 = $f2o9b7e4s6 ;
&f1o2b2e4s4 ;
$f5o5b8e3s9 .= "<import>Done importing XML.<\/import>" ;
}
sub f3o1b9e3s7
{
$f2o9b7e4s6 = $f0o1b9e3s3 ;
$f2o9b7e4s6 =~ s/[\n\r]+/ /gs ;
@f4o9b7e4s3 = &f9o3b9e3s2( &f6o7b8e3s3( "list-of-level-one-tag-names" ) ) ;
foreach $f6o9b7e4s0 ( @f4o9b7e4s3 )
{
$f7o9b7e4s7{ $f6o9b7e4s0 } = $f6o4b9e3s0 ;
}
@f9o9b7e4s4 = &f9o3b9e3s2( &f6o7b8e3s3( "list-of-templates-with-second-level-elements-but-no-id" ) ) ;
foreach $f1o0b8e4s1 ( @f9o9b7e4s4 )
{
$f2o0b8e4s8{ $f1o0b8e4s1 } = $f6o4b9e3s0 ;
}
@f4o0b8e4s5 = &f9o3b9e3s2( &f6o7b8e3s3( "list-of-templates-types-to-accumulate-xml" ) ) ;
foreach $f6o0b8e4s2 ( @f4o0b8e4s5 )
{
&f2o5b8e3s5( "accumulate-xml-for-tag-" . $f6o0b8e4s2 , "yes" ) ;
&f2o5b8e3s5( "case-info-" . $f6o0b8e4s2 , "" ) ;
}
@f7o0b8e4s9 = &f0o9b0e4s5( ) ;
$f5o5b8e3s9 .= "<replfromxml>There are " . ( $#f7o0b8e4s9 + 1 ) . " phrases at beginning of subroutine.<\/replfromxml>" ;
$f9o0b8e4s6 = 0 ;
@f1o1b8e4s3 = ( ) ;
while ( $f2o9b7e4s6 =~ /^([^<>]*)<(\/?)([^>]+)>(.*)$/ )
{
$f3o1b8e4s0 = $1 ;
$f4o1b8e4s7 = $2 ;
$f6o1b8e4s4 = $3 ;
$f2o9b7e4s6 = $4 ;
if ( $f4o1b8e4s7 eq '/' )
{
$f8o1b8e4s1 = $f6o4b9e3s0 ;
} else
{
$f8o1b8e4s1 = $f0o0b9e3s1 ;
}
if ( $f6o1b8e4s4 =~ /^((\?xml )|(.DOCTYPE ))/ )
{
$f5o5b8e3s9 .= "<replfromxml>Ignoring tag:  " . $f6o1b8e4s4 . "<\/replfromxml>" ;
next ;
}
if ( $f8o1b8e4s1 == $f0o0b9e3s1 )
{
$f8o2b4e4s8 = $f6o1b8e4s4 ;
$f9o0b8e4s6 ++ ;
if ( $f7o9b7e4s7{ $f8o2b4e4s8 } == $f6o4b9e3s0 )
{
$f9o0b8e4s6 = 1 ;
$f1o1b8e4s3[ $f9o0b8e4s6 ] = $f8o2b4e4s8 ;
&f2o5b8e3s5( "xml-content-" . $f8o2b4e4s8 , "" ) ;
@f9o1b8e4s8 = ( ) ;
if ( &f6o7b8e3s3( "accumulate-xml-for-tag-" . $f8o2b4e4s8 ) =~ /y/ )
{
&f2o5b8e3s5( "case-info-" . $f8o2b4e4s8 , &f6o7b8e3s3( "case-info-" . $f8o2b4e4s8 ) . "<" . $f8o2b4e4s8 . ">" ) ;
$f1o2b8e4s5 = $f6o4b9e3s0 ;
while ( $f1o2b8e4s5 == $f6o4b9e3s0 )
{
if ( $f2o9b7e4s6 =~ /^(.*?)(<\/([^\/>]+)>)(.+)$/ )
{
$f3o1b8e4s0 = $1 ;
$f3o2b8e4s2 = $2 ;
$f4o2b8e4s9 = $3 ;
$f2o9b7e4s6 = $4 ;
&f2o5b8e3s5( "case-info-" . $f8o2b4e4s8 , &f6o7b8e3s3( "case-info-" . $f8o2b4e4s8 ) . $f3o1b8e4s0 . $f3o2b8e4s2 ) ;
if ( $f4o2b8e4s9 eq $f8o2b4e4s8 )
{
$f1o2b8e4s5 = $f0o0b9e3s1 ;
}
} else
{
$f1o2b8e4s5 = $f0o0b9e3s1 ;
}
}
}
}
} else
{
$f6o2b8e4s6 = $f6o1b8e4s4 ;
&f2o5b8e3s5( "xml-content-" . $f6o2b8e4s6 , $f3o1b8e4s0 ) ;
if ( $f9o0b8e4s6 == 2 )
{
push( @f9o1b8e4s8 , $f6o2b8e4s6 ) ;
} elsif ( $f9o0b8e4s6 == 1 )
{
$f0o6b2e4s5 = $f1o1b8e4s3[ $f9o0b8e4s6 ] ;
$f8o2b8e4s3 = &f6o7b8e3s3( "unique-id-name-for-tag-" . $f0o6b2e4s5 ) ;
$f0o3b8e4s0 = &f6o7b8e3s3( "inverse-unique-id-name-for-tag-" . $f0o6b2e4s5 ) ;
$f1o3b8e4s7 = $f2o0b8e4s8{ $f0o6b2e4s5  } ;
if ( ( $f8o2b8e4s3 !~ /[^ ]/ ) && ( $f1o3b8e4s7 == $f0o0b9e3s1 ) )
{
$f7o3b0e4s8 = "case-info-" . $f0o6b2e4s5 ;
$f3o3b8e4s4 = &f6o7b8e3s3( "xml-content-" . $f0o6b2e4s5 ) ;
if ( $f0o6b2e4s5 =~ /[^ ]/ )
{
&f2o5b8e3s5( $f7o3b0e4s8 , $f3o3b8e4s4 ) ;
}
} elsif ( $f1o3b8e4s7 == $f6o4b9e3s0 )
{
foreach $f5o3b8e4s1 ( @f9o1b8e4s8 )
{
$f3o3b8e4s4 = &f6o7b8e3s3( "xml-content-" . $f5o3b8e4s1 ) ;
$f7o3b0e4s8 = $f0o6b2e4s5 . "-" . $f5o3b8e4s1 ;
if ( $f7o3b0e4s8 =~ /[^ ]/ )
{
&f2o5b8e3s5( $f7o3b0e4s8 , $f3o3b8e4s4 ) ;
}
}
} else
{
foreach $f5o3b8e4s1 ( @f9o1b8e4s8 )
{
$f3o3b8e4s4 = &f6o7b8e3s3( "xml-content-" . $f5o3b8e4s1 ) ;
if ( $f5o3b8e4s1 ne $f8o2b8e4s3 )
{
$f7o3b0e4s8 = $f0o6b2e4s5 . "-" . $f5o3b8e4s1 . "-for-" . $f8o2b8e4s3 . "-" . &f6o7b8e3s3( "xml-content-" . $f8o2b8e4s3 ) ;
if ( $f7o3b0e4s8 =~ /[^ ]/ )
{
&f2o5b8e3s5( $f7o3b0e4s8 , $f3o3b8e4s4 ) ;
}
} elsif ( $f0o3b8e4s0 =~ /[^ ]/ )
{
$f7o3b0e4s8 = $f0o6b2e4s5 . "-" . $f8o2b8e4s3 . "-for-" . $f0o3b8e4s0 . "-" . &f6o7b8e3s3( "xml-content-" . $f0o3b8e4s0 ) ;
&f2o5b8e3s5( $f7o3b0e4s8 , $f3o3b8e4s4 ) ;
}
}
}
}
$f9o0b8e4s6 -- ;
}
}
@f6o3b8e4s8 = &f0o9b0e4s5( ) ;
$f5o5b8e3s9 .= "<replfromxml>There are " . ( $#f6o3b8e4s8 + 1 ) . " phrases at end of subroutine.<\/replfromxml>" ;
if ( &f6o7b8e3s3( "cgi-version" ) eq "cgi-yes" )
{
%f8o3b8e4s5 = ( ) ;
foreach $f0o4b8e4s2 ( @f7o0b8e4s9 )
{
$f8o3b8e4s5{ $f0o4b8e4s2 } = $f6o4b9e3s0 ;
}
foreach $f0o4b8e4s2 ( @f6o3b8e4s8 )
{
if ( $f8o3b8e4s5{ $f0o4b8e4s2 } != $f6o4b9e3s0 )
{
$f3o3b8e4s4 = &f6o7b8e3s3( $f0o4b8e4s2 ) ;
$f5o5b8e3s9 .= "<replfromxml>" . $f0o4b8e4s2 . "\n\n" . $f3o3b8e4s4 . "\n---------------\n\n<\/replfromxml>" ;
}
}
}
}
sub f4o7b2e4s1
{
foreach $f1o4b8e4s9 ( "main" , "statements" )
{
$f5o5b8e3s9 .= "<xmlwrite>Checking case info type " . $f1o4b8e4s9 . "<\/xmlwrite>" ;
@f3o4b8e4s6 = &f9o3b9e3s2( &f6o7b8e3s3( "list-of-xml-code-of-type-" . $f1o4b8e4s9 ) ) ;
$f5o5b8e3s9 .= "<xmlwrite>List of replacements to write: " . join( "  " , @f3o4b8e4s6 ) . "<\/xmlwrite>" ;
if ( $#f3o4b8e4s6 >= 0 )
{
$f9o1b2e4s7 = "" ;
&f2o5b8e3s5( "xml-date-time" , "<writetime><date>" . $f7o0b2e4s8 . "<\/date><time>" . $f9o5b3e4s1 . "</time><ipaddress>" . $f6o1b4e4s9 . " </ipaddress></writetime>" ) ;
if ( $f3o4b8e4s6[ 0 ] !~ /<\?xml / )
{
unshift ( @f3o4b8e4s6 , "xml-date-time" ) ;
unshift ( @f3o4b8e4s6 , "xml-logged-action-name" ) ;
}
while ( $#f3o4b8e4s6 >= 0 )
{
$f5o4b8e4s3 = shift( @f3o4b8e4s6 ) ;
$f3o2b3e4s4 = &f6o7b8e3s3( $f5o4b8e4s3 ) ;
$f3o2b3e4s4 =~ s/^ +// ;
$f3o2b3e4s4 =~ s/\n +/\n/gs ;
$f9o1b2e4s7 .= $f3o2b3e4s4 . "\n" ;
$f5o5b8e3s9 .= "<xmlwrite>Wrote replacement named " . $f5o4b8e4s3 . "<\/xmlwrite>" ;
}
$f6o6b8e3s1 = $f4o6b9e3s7 . $f9o8b8e3s9 . "-" . $f1o4b8e4s9 . $f6o6b9e3s4 ;
&f8o1b2e4s0 ;
}
}
}
