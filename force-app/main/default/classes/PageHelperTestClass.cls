@istest
public class PageHelperTestClass {
    static testmethod void  PageHelperTestClassMethod(){
        PageHelper ph= new PageHelper('GPU','1');
        string ExternalIdTest= ph.GenerateExternalId();
        System.assertEquals('GPU-1-00001', ExternalIdTest);
    }      
}