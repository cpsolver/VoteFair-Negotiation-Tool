#-----------------------------------------------
#-----------------------------------------------
#          email_send
#-----------------------------------------------
#-----------------------------------------------
#  Send an email message to the administrator.


sub email_send
{

#-----------------------------------------------
#  Get the email address and other information.

    $email_to = &dashrep_expand_parameters( "case-info-emailadmin" ) ;
    $global_log_output .= "<emailsend>Email address: " . $email_to . "<\/emailsend>" ;

    $email_from = &dashrep_expand_parameters( "email-return-address" ) ;
    $global_log_output .= "<emailsend>Email return address: " . $email_from . "<\/emailsend>" ;

    $email_subject = &dashrep_expand_parameters( "email-subject" ) ;
    $global_log_output .= "<emailsend>Email subject: " . $email_subject . "<\/emailsend>" ;

    $participant_id = &dashrep_get_replacement( "users-participant-id" ) ;
    $email_beginning = &dashrep_expand_parameters( "words-message-from-participant" ) . " " . $participant_id . ", " . &dashrep_get_replacement( "participant-shortname-for-participantid-" . $participant_id ) . ":" ;

    $global_log_output .= "<emailsend>Email beginning: " . $email_beginning . "<\/emailsend>" ;


#-----------------------------------------------
#  Get the message.

    $message_text = &dashrep_get_replacement( "input-validated-message" ) ;
    if ( $message_text !~ /[^ \t\n]/i )
    {
        $global_user_error_message .= "words-email-message-is-empty" ;
        $global_log_output .= "<emailsend>Email message is empty: [" . $message_text . "]<\/emailsend>" ;
        $global_log_output .= "<emailsend>Message not sent<\/emailsend>" ;
        return ;
    }


#-----------------------------------------------
#  Put the message in a file
#  (for tracking purposes, backup, and as
#  the input for sendmail).

    $message_filename = $global_case_filename_prefix . $global_case_number . "-email-" . $global_date . "-" . $global_hour_minute_second . "-" . &dashrep_get_replacement( "participant-shortname-for-participantid-" . $participant_id ) . $global_case_filename_suffix  ;
    $global_log_output .= "<emailsend>Message filename: " . $message_filename . "<\/emailsend>" ;

    $message_file_content = "To: " . $email_to . "\n" . "From: " . $email_from . "\n" . "Subject: " . $email_subject . "\n" . $email_beginning . "\n" . $message_text . "\n\n" ;
    $global_log_output .= "<emailsend>Message content: " . $message_file_content . "<\/emailsend>" ;

    if ( open ( OUTFILE , ">>" . $message_filename ) )
    {
        print OUTFILE $message_file_content ;
        $global_log_output .= "<emailsend>Message written to file<\/emailsend>" ;
        $error_message = "" ;

    } else
    {
        $error_message = "ERROR:  Failure opening -- for appending -- file named " . $message_filename . "\n" ;
        $global_user_error_message .= "words-email-message-was-not-sent" ;
        $global_log_output .= "<emailsend>Not able to write email message to file<\/emailsend>" ;
        return ;
    }

    close ( OUTFILE ) ;


#-----------------------------------------------
#  Send the file contents as an email message.

        if ( open( MAIL, "/usr/lib/sendmail -oi -t -oem -os -odi < " . $message_filename . " |" ) )
        {

# -oi = Ignore leading dots in message
# -t = Get recipients from message header
# -oem = Mail error notification to the sender
# -os = Supersafe mode; message stays in queue until delivery is completed/successful
# -odi = Delivery mode is interactive
#
# -d11.1 = Debug, trace delivery
# -d99.100 = Do not run sendmail in background (so sendmail output will not be lost)
# -v = Verbose mode

            while ( <MAIL> ) {
                $input_line = $_ ;
                chomp( $input_line ) ;
                print ">> " . $input_line . "\n" ;
            }

            close( MAIL ) ;
            $global_user_error_message = "words-message-sent" ;
            $global_log_output .= "<emailsend>Message sent<\/emailsend>" ;
#            $global_log_output .= "<emailsend>Message not really sent<\/emailsend>" ;

        } else {
            $global_user_error_message = "words-message-not-sent" ;
            $global_log_output .= "<emailsend>Message was NOT sent<\/emailsend>" ;
            $global_log_output .= "<emailsend>ERROR: Failure to run sendmail: $!<\/emailsend>" ;
        }


#-----------------------------------------------
#  End of subroutine.


}

