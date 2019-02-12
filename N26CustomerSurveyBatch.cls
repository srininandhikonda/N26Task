/*****************************************************************************************
 * Author: SrinivasReddy
 * Class Name: N26CustomerSurveyBatch
 * Test Class Name: N26CustomerSurveyBatch_Test
 * Description: To Send Emails to the Customers for survey 
 * 
 * *****************************************************************************************/
global class N26CustomerSurveyBatch implements Database.Batchable<SObject>,Schedulable{
    global String customQuery;
    global Date todayDate;
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query;    
        if(customQuery==null)
             query = getQuery();
        else
            query=customQuery;
        return Database.getQueryLocator(query);
        }
    
    global void execute(Database.BatchableContext BC,List<Contact> conList) {
    	List<Contact> updateConList = new List<Contact>();
        Contact con;
        List<ID> conIds=new List<Id>();
        EmailTemplate et=[Select id,name from EmailTemplate where name ='N26 Customer Survey' limit 1];
    	for(Contact objCon : conList) {            
        //   if(objCon.srinilighten__Survey_Date__c!=null && Date.ValueOf(objCon.srinilighten__Survey_Date__c)==System.today()){
                conIds.add(objCon.id);
                con=new Contact(id=objCon.id);
                con.srinilighten__Survey_Date__c=null;
                updateConList.add(con);
          //  }
            
    	}
        try{
             Messaging.reserveMassEmailCapacity(updateConList.size());
            if(updateConList != null && updateConList.size() > 0) {
                Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
                if(!conIds.isEmpty() && conIds.size()>0)
                 mail.setTargetObjectIds(conIds);
                 mail.setSenderDisplayName('N26 Customer Survey');
                 mail.setTemplateId(et.id);
                 Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
                Database.SaveResult[] DSR=Database.update(updateConList,false); 
            }
        }Catch(Exception e){
            //insert a record into the exception error log record or throw a exception
            System.Debug('Exception occured during batch execution'+e.getMessage());
        }
               
    }
    
     global void finish(Database.BatchableContext BC) {
         AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email, ExtendedStatus from AsyncApexJob where Id = :BC.getJobId()];  
       	 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         String[] toAddresses = new String[] {a.CreatedBy.Email};
         mail.setToAddresses(toAddresses);
         mail.setSubject('BatchJob Status: ' + a.Status);
         mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures. ExtendedStatus: ' + a.ExtendedStatus);       
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });         
     }
     
     private String getQuery() {
        todayDate =date.today();
     	String query = 'select ID, srinilighten__Language__c,srinilighten__Survey_Date__c from Contact'; 
    	query = query + ' where srinilighten__Survey_Date__c = Today';
        System.Debug(query);
     	return query;
     }
     
     global void execute(SchedulableContext SC){
        N26CustomerSurveyBatch conBatch = new N26CustomerSurveyBatch(); 
        Database.executebatch(conBatch, 200);
    }
}