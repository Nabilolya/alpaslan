public class PageHelper {

        public String CodeProduct;
        public String Prefix;
        public String chaine;
      
        public PageHelper(String Prefixx , String CodeProductt)
        {
            Prefix=Prefixx;
            CodeProduct=CodeProductt;
            chaine=Prefix+'-'+CodeProduct+'-%';
        }   
        
        public String TestCounterLastIndex()
        {
            List<Asset> Assets= new  List<Asset>();
            Assets=[Select External_Id__c from Asset where External_Id__c like :chaine];
            String MyString = String.valueOf(Assets.size()+1).leftPad(5, '0');
            return MyString;
        }
    
        Public String GenerateExternalId()
        {
            return Prefix+'-'+CodeProduct+'-'+TestCounterLastIndex();
        }
       
    
    }