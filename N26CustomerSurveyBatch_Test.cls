@isTest
public class N26CustomerSurveyBatch_Test {
    
    public static testmethod void Testmethod1(){
        Test.startTest();
        Account ac=new Account(Name='TestN26Account');
        insert ac;
        Contact con=new Contact(AccountID=ac.id, LastName='Reddy', FirstName='Srini', srinilighten__Language__c='DE', srinilighten__Survey_Date__c=System.today());
        insert con;
        N26CustomerSurveyBatch conBatch = new N26CustomerSurveyBatch(); 
        Database.executebatch(conBatch, 200);
        Test.stopTest();
        List<Contact> contactList=[Select id,srinilighten__Survey_Date__c from Contact where id=:con.id limit 1];
        System.assertEquals(contactList[0].srinilighten__Survey_Date__c, null);
    }
     public static testmethod void TestmethodNegative(){
        Test.startTest();
        Account ac=new Account(Name='TestN26Account');
        insert ac;
        Contact con=new Contact(AccountID=ac.id, LastName='Reddy', FirstName='Srini', srinilighten__Language__c='DE', srinilighten__Survey_Date__c=System.today()+1);
        insert con;
        N26CustomerSurveyBatch conBatch = new N26CustomerSurveyBatch(); 
        Database.executebatch(conBatch, 200);
        Test.stopTest();
        List<Contact> contactList=[Select id,srinilighten__Survey_Date__c from Contact where id=:con.id limit 1];
        System.assertEquals(contactList[0].srinilighten__Survey_Date__c, System.today()+1);
    }

}