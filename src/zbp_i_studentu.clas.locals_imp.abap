CLASS lhc__students DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _students RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _students RESULT result.

    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION _students~setadmitted RESULT result.

ENDCLASS.

CLASS lhc__students IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD setAdmitted.   "action method

  MODIFY ENTITIES OF zi_studentu "INTERFACE VIEW
  IN LOCAL MODE  "in local model will not check the authorization (optional)
  ENTITY _students  "alias name in the Interface BDEF
  UPDATE FIELDS ( Status )   "Updating the status field
  WITH VALUE #( FOR key in keys ( %tky = key-%tky  Status = 'Passed' ) )
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

ENDCLASS.
