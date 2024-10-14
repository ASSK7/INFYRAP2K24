@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_STUDENTU as select from zstudents_u
association to ZI_GENDER_U as _gender on _gender.Value = $projection.Gender
{
    key studentid as Studentid,
    studentname as Studentname,
    studentclass as Studentclass,
    studentage as Studentage,
    studentsection as Studentsection,
    schoolname as Schoolname,
    status as Status,
    gender as Gender,
    
//    Associations
    _gender,
    _gender.Description as GenderDesc
}
