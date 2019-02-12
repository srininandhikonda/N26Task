@isTest
public class ProductInfoController_Test {

public testmethod static void testMethod1(){
//insert a new product
Product2 p = new product2(name='x');
insert p;

Product2 p2 = new product2(name='y');
insert p2;

//define the standart price for the product
Pricebook2 stdPb = new Pricebook2();
stdPb.id=Test.getStandardPricebookId();
insert new PricebookEntry(pricebook2id = stdPb.id, product2id = p.id,unitprice=1.0, isActive=true);

Pricebook2 pb = new pricebook2(name='test');
insert pb;

PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id, product2id=p.id,unitprice=1.0, isActive=true);
insert pbe;


Account AcntRec = new Account(name = 'Acc', Type = 'Customer', Industry = 'Automotive');
insert AcntRec;

Contact con=new Contact(language__c='DE', Lastname='Srini',Product__c=p.id,Home_Country__c='DE');
insert con;

Case cas=new Case(AccountID=AcntRec.id, ContactId=con.id);
insert cas;
ProductInfoController.getProductandPriceDetails(cas.id);

}
}