/*****************************************************************************************
 * Author: SrinivasReddy
 * Class Name: ProductInfoController 
 * Test Class Name: ProductInfoController_Test
 * Description: To Support the ProductInfo Aura Component.
 * 
 * *****************************************************************************************/
public class ProductInfoController {
    
    @AuraEnabled
    public static ProductInfo getProductandPriceDetails(String caseId){
     //Fetching contact from the Case, As we are showing on the  Case Record page so need single record 
        Case cas=[select id,ContactID from Case where Id=:caseId Limit 1];
        String conId=cas.contactId;
         Contact con=[Select id, srinilighten__Home_Country__c,srinilighten__Product__c,srinilighten__Product__r.Id from Contact where ID=:conId Limit 1];
        List<PriceBookEntry> lstPBE;
        //based on Home Country based price book fetching the Price book entries to display product and its related price info on the Case layout.
        String qry ='Select id, Name, Product2.name,PriceBook2.Name,UnitPrice from PriceBookEntry where PriceBook2.Name like \'%_'+con.srinilighten__Home_Country__c+'%\' and UseStandardPrice=false';
       // if(con.srinilighten__Product__c!=null) 
        qry+=' and Product2.ID=\''+con.srinilighten__Product__r.Id+'\'';
        lstPBE=Database.query(qry);
        System.Debug('***********'+lstPBE);
        ProductInfo objprodInfo=new ProductInfo(lstPBE,con,cas);
        return objprodInfo;
    }
    //Took wrapper incase if we want to display information from Contact,Case along with PBE
    public class ProductInfo{
       @AuraEnabled
        public List<PriceBookEntry> pbeList;
       @AuraEnabled
        public Contact con;
       @AuraEnabled
        public Case cas;
        public ProductInfo(List<PriceBookEntry> pbeList1,Contact objcon,Case objcas){
            this.pbeList=pbeList1;
            this.con=objcon;
            this.cas=objcas;            
        }
    }
   

}