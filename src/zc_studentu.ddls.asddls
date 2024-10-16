@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection CDS View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_STUDENTU
  provider contract transactional_query as projection on ZI_STUDENTU
{
    key Studentid,
    Studentname,
    Studentclass,
    Studentage,
    Studentsection,
    Schoolname,
    Status,
    Gender,
    GenderDesc,
    Lastchangedat,
//    Associations
    _course,
    _gender
}
