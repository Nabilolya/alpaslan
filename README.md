# Apsynergy Salesforce exercises

Quick Salesforce coding exercises

## Set up a developement environment
1. Fork this repo
2. If you do not already have one, [create a developer hub](https://developer.salesforce.com/docs/atlas.en-us.packagingGuide.meta/packagingGuide/dev_hub_intro.htm) 
1. Create a scratch org  
`sfdx force:org:create -a sfexercise1 -v myDevHub -s -f config/project-scratch-def.json`
1. Push the existing metadata to your scratch org  
`sfdx force:source:push -u sfexercise1` 
1. Assign the 'ProductAsset' permission set to your user   
`sfdx force:user:permset:assign -n ProductAsset -u sfexercise1`
1. Complete the exercises outlined below
2. Push the changes to your repo and share it with Apsynergy

---
## Challenge

PCCW is a computer components wholesale company, They use Account, Opportunity, Product, ProductLineItem, Asset to manage their sales.

### 1. Add opportunity products as assets when an opportunity is closed won
The Product and Asset Objects have 4 record types (Graphic card, Processor, Motherboard, Other), additionally each product has a unique product code (ProductCode) and each asset has a unique reference (External_Id__c).  

When an opportunity becomes closed won, all of the products linked to the opportunity through the object ProductLineItem should be added to the opportunity's parent account as assets.

Implement code to do the following when an opportunity become closed won:  
* Create a custom metadata type called **AssetPrefixMapping** with the following fields:  
  * RecordTypeDeveloperName
  * Prefix
* Create 4 AssetPrefixMapping__mdt records with the following RecordTypeDeveloperName to Prefix mapping:  
    * Graphic_Card > GC
    * Processor > CPU
    * Motherboard > MB
    * Other > O
* for every individual item OpportunityLineItem create an Asset
* The Asset field to populate are  
  * Name: Product's name
  * Account: Opportunity's parent account
  * RecordType: Same record type as the Product
  * Opportunity__c: Opportunity's 'Id
  * Opportunity_Product__c: OpportunityLineItem's Id
  * Product2Id: Product's Id
  * Price: OpportunityLineItem.UnitPrice
  * PurchaseDate: Opportunity close date
* Additionally the Asset's should have an External_Id__c generated with this format `{prefix}-{product code}-{increment}`  
  * prefix: use the AssetPrefixMapping__mdt metadata type to get the prefix depending on the Product/Asset record type
  *  product code: value of the field ProductCode from the Product2 Object
  *  Increment: an incremental number in this form {00000}, for each asset with the same prefix and product code.
    



