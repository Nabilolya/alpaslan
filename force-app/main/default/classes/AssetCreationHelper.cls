public class AssetCreationHelper {
    
    public AssetCreationHelper() {}
     Public List<Opportunity> GetOpportunitiesClosedWon(Set<Id> OppyIds)
     {
                Return [Select Id,AccountId,CloseDate,(Select Quantity,UnitPrice,PricebookEntry.Product2.ProductCode,PricebookEntry.Product2Id, PricebookEntry.Product2.Name,PricebookEntry.Product2.RecordType.Name, Description from OpportunityLineItems)from
                        Opportunity
                        where Id IN: OppyIds AND Opportunity.iswon = true AND Opportunity.hasOpportunitylineitem = true];
     }
     Public Map<Id,String>  MappPrefixOpp(List<Opportunity> OLI)
        {
             Map<Id,String> mapPrefixByOppy = new Map<Id,String>();                      
             Map<String,AssetPrefixMapping__mdt> mapPrefix = AssetPrefixMapping__mdt.getAll();
              for(Opportunity opp : OLI){
              mapPrefixByOppy.put(opp.Id , String.valueOf(mapPrefix.get(opp.opportunityLineItems[0].PricebookEntry.Product2.RecordType.Name)));
              }
             return mapPrefixByOppy;
        }
    
     Public Void SetAssetFromOppo(List<Opportunity> OLI)
     {
         Map<Id,String> mapPrefixByOppy = new Map<Id,String>(); 
         mapPrefixByOppy=MappPrefixOpp(OLI);
         List<Asset> assetList = new List<Asset>();  
         asset a = new asset();
            if(OLI.size()>0){
            for(Opportunity op:OLI){ 
            a.AccountId=op.AccountId;
            a.Quantity=op.opportunityLineItems[0].quantity;     
            a.Product2Id=op.opportunityLineItems[0].PricebookEntry.Product2Id;  
            a.name=op.opportunityLineItems[0].PricebookEntry.Product2.Name;
            a.opportunity__c=(Id)op.Id;
            a.PurchaseDate=op.CloseDate;
            a.Opportunity_Product__c=op.opportunityLineItems[0].id;
            if(mapPrefixByOppy.get(op.Id)!=null){a.RecordType.Name=mapPrefixByOppy.get(op.Id); } 
            a.price=op.opportunityLineItems[0].UnitPrice;
            a.PurchaseDate=op.CloseDate;
            PageHelper PageHelp = new PageHelper(mapPrefixByOppy.get(op.Id),op.opportunityLineItems[0].PricebookEntry.Product2.ProductCode);
            a.External_Id__c=PageHelp.GenerateExternalId();
            assetList.add(a);   
        }       
           insert assetList; 
     }
        }
}