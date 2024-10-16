CLASS lhc__students DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _students RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _students RESULT result.

    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION _students~setadmitted RESULT result.
    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR _students~validateage.
    METHODS mycustomdetermination FOR DETERMINE ON SAVE
      IMPORTING keys FOR _students~mycustomdetermination.
    METHODS mycustomdeterminationformodify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _students~mycustomdeterminationformodify.

ENDCLASS.

CLASS lhc__students IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.  "action method for changing the state(enalbe/disable) of action button

    READ ENTITIES OF zi_studentu
    IN LOCAL MODE
    ENTITY _students
    FIELDS ( Status )
    WITH CORRESPONDING  #( keys )
    RESULT DATA(tempStudentsData)
    FAILED failed.

    result =
    VALUE #(
      FOR student IN tempstudentsdata
      LET statusVal = COND #( WHEN student-status = 'Passed'
                            THEN if_abap_behv=>fc-o-disabled
                            ELSE if_abap_behv=>fc-o-enabled )

                            IN ( %tky = student-%tky
                                 %action-setAdmitted = statusval )
     ).

  ENDMETHOD.

  METHOD setAdmitted.   "action method

    MODIFY ENTITIES OF zi_studentu "INTERFACE VIEW
    IN LOCAL MODE  "in local model will not check the authorization (optional)
    ENTITY _students  "alias name in the Interface BDEF
    UPDATE FIELDS ( Status )   "Updating the status field
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky  Status = 'Passed' ) )
    FAILED failed
    REPORTED reported. "All error messages in reported

    "Read the data after update and pass the data to UI
    READ ENTITIES OF zi_studentu
    IN LOCAL MODE "in local model will not check the authorization (optional)
    ENTITY _students
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(tempStudentsData).

    result = VALUE #( FOR student IN tempstudentsdata ( %tky = student-%tky  %param = student ) ).




  ENDMETHOD.

  METHOD validateAge.

    READ ENTITIES OF zi_studentu
    IN LOCAL MODE
    ENTITY _students  "Entity alias name in BDEF
    FIELDS ( Studentage )
    WITH CORRESPONDING #( keys )
    RESULT DATA(resultData).

    LOOP AT resultdata INTO DATA(result_wa).
      IF result_wa-Studentage < 21.
        APPEND VALUE #( %tky = result_wa-%tky ) TO failed-_students.  "This statement will collect the errors

        "this statement will show error in the UI
        APPEND VALUE #( %tky = result_wa-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Age should not be less than 21'
                         ) ) TO reported-_students.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD myCustomDetermination.

  READ ENTITIES OF zi_studentu
  IN LOCAL MODE
  ENTITY _students
  FIELDS ( Studentclass ) WITH CORRESPONDING #( keys )
  RESULT DATA(studentData).

  LOOP AT studentdata INTO DATA(ls_data).
   IF ls_data-Studentclass = 'A'.
        MODIFY ENTITIES OF zi_studentu
        IN LOCAL MODE
        ENTITY _students "Alias name in BDEF
        UPDATE FIELDS ( Studentsection ) WITH VALUE #( ( %tky = keys[ 1 ]-%tky Studentsection = 7 ) ).
   ENDIF.
  ENDLOOP.

  ENDMETHOD.


  METHOD myCustomDeterminationForModify.

  READ ENTITIES OF ZI_STUDENTU
  IN LOCAL MODE
  ENTITY _students "Alias name in BDEF
  FIELDS ( Studentclass )
  WITH CORRESPONDING #( keys )
  RESULT DATA(resultData).

  LOOP AT resultData INTO DATA(ls_data).
    IF ls_data-Studentclass = 'B'.
        MODIFY ENTITIES OF zi_studentu
        IN LOCAL MODE
        ENTITY _students "Alias name in BDEF
        UPDATE FIELDS ( Studentsection ) WITH VALUE #( ( %tky = keys[ 1 ]-%tky Studentsection = 9 ) ).
    ENDIF.
  ENDLOOP.

  ENDMETHOD.

ENDCLASS.
