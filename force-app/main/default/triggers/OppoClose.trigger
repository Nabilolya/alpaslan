trigger OppoClose on Opportunity (After Update) {
        Set<Id> OppyIds = Trigger.oldMap.keyset();
        OpportunityTrigger_Handler.OpporunityTriggerLogic(OppyIds);
}