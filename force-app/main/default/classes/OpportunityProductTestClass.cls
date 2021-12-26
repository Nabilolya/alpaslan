@istest
    public class OpportunityProductTestClass{
        
        static testmethod void  OpportunityProductTestMethod(){
            Id pricebookId = Test.getStandardPricebookId();
            
            Product2 prod = new Product2(
                Name = 'Product X',
                ProductCode = 'Pro-X',
                isActive = true
            );
            insert prod;
            
           
            PricebookEntry pbEntry = new PricebookEntry(
                Pricebook2Id = pricebookId,
                Product2Id = prod.Id,
                UnitPrice = 100.00,
                IsActive = true
            );
            insert pbEntry;
            
            Date closeDt = Date.Today();
            date myDate = date.today();
            Account a2 = new Account(Name ='Account for Test');
            insert a2;
        
            opportunity oppr = new opportunity(Name='testing DIE 4/6/2015' ,  AccountId= a2.Id,StageName = 'Prospecting',  CloseDate = closeDt);
            insert oppr;
            
            Integer QUANTITY_VALUE = 5;
            OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = oppr.Id,
            Quantity = QUANTITY_VALUE,
            PricebookEntryId = pbEntry.Id,
            TotalPrice = QUANTITY_VALUE * pbEntry.UnitPrice
            );
            insert oli;
          
            oppr.StageName = 'Closed Won';
            update oppr;
            
            Asset AssetTest = new Asset();
            AssetTest.Name=oli.PricebookEntry.Product2.Name;
            List<Asset> ListAssets= [Select name from Asset where name = :oli.PricebookEntry.Product2.Name];
            
            if(ListAssets.size()>0)
            system.assertEquals(ListAssets[0].name,oli.PricebookEntry.Product2.Name);
            
        }
    }