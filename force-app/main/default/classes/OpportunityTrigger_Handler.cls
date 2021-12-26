public class OpportunityTrigger_Handler {
        public static void OpporunityTriggerLogic(Set<Id> OppyIds){
             AssetCreationHelper AssetCreator= new AssetCreationHelper();
             List<Opportunity> Oppo = new List<Opportunity>();  
             Oppo=AssetCreator.GetOpportunitiesClosedWon(OppyIds);
             AssetCreator.SetAssetFromOppo(Oppo);

    }}