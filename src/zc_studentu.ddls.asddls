@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection CDS View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_STUDENTU as projection on ZI_STUDENTU
{
    key Studentid,
    Studentname,
    Studentclass,
    Studentage,
    Studentsection,
    Schoolname,
    Status
}
