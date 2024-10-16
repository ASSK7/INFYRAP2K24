@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COURSE'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_COURSE_U as select from ztab_course_u
association to parent ZI_STUDENTU as _student on _student.Studentid = $projection.Studentid
{
    key studentid as Studentid,
    key course as Course,
    key semester as Semester,
    semresult as Semresult,
    _student
}
