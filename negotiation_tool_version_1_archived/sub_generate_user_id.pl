#-----------------------------------------------
#-----------------------------------------------
#             generate_user_id
#-----------------------------------------------
#-----------------------------------------------
#  Generate a new internal user ID.
#  The user ID numbers should not be revealed
#  to anyone, except the case administrator can
#  see it in exported XML.

sub generate_user_id
{



# ... (code removed)



#-----------------------------------------------
#  Make the new user ID available.

    &dashrep_define( "new-user-id" , $global_new_user_id ) ;


#-----------------------------------------------
#  End of subroutine.

    $global_lot_output .= "<genuserid>New user id = " . $global_new_user_id . "<\/genuserid>" ;

}

