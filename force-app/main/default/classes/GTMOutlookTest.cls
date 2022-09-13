@isTest
private class GTMOutlookTest{
    public static User argentinaUser = createuser();
    static testMethod void validateData(){
        Id gtmOutlookRecordType = Schema.SObjectType.GTM_Details__c.getRecordTypeInfosByName().get('Outlook').getRecordTypeId();
        Id disstributorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
        Id leadCustomerRecordLead = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Lead Customer').getRecordTypeId();
        String year='2021-2022';
        Sales_Org__c salesOrgObj = new Sales_Org__c(
            Name='Argentina',
            Company_Code__c='5631',
            Sales_Org_Code__c='5631',
            Country_Code__c='AR'
        );
        insert salesOrgObj;
        
        //SELECT Id, Name, For_Contry__c, Sales_Org_Code__c FROM Login_Country__c;
        Login_Country__c logCountryObj = new Login_Country__c();
        logCountryObj.Name ='Argentina'; 
        logCountryObj.For_Contry__c ='Argentina';
        logCountryObj.Sales_Org_Code__c ='5631';
        insert logCountryObj;
        
     
        
        
        System.runAs(argentinaUser){
        
            Account accObj = new Account(
            Sales_Org__c = salesOrgObj.Id,                       // Sales Org
            Depot_Code__c = 'AR13',                              // Depot Code
            Name = 'ABENAMA S.A.',                               // Account Name
            RecordTypeId = disstributorRecordTypeId,             // Account Record Type
            Account_Type__c = 'Sold To Party',                   // Account Type           
            Last_Name__c = 'ABENAMA S.A.',                       // Last Name            
            Is_Community_Active__c = false,                      // Is Community Active
            //Lead_Customer__c = '9758',                         // Lead Customer
            Lead_Customer_Type__c = 'Dealer',                  // Lead Customer Type
            Lead_Customer_Ownership__c= argentinaUser.Id,
            Path_Finder__c = false                               // Path Finder
        );
        insert accObj;
       
         GTM__c  gtm=new GTM__c();
            gtm.Fiscal_Year__c='2022-2023';
            gtm.Email__c='prashant.kumbhar@skinternational.com';
            gtm.GTM_Status__c='test';
            gtm.Sales_Rep_Name__c='test';
            gtm.Role__c='Manager';
             insert gtm;
         GTM_Details__c gtmdet =new GTM_Details__c(); 
            gtmdet.GTM_Customer__c=accObj.id;
            gtmdet.GTM__c = gtm.Id;
            gtmdet.isSubmitted__c=True;
            gtmdet.Is_Duplicate_GTM_Record__c = false; 
            gtmdet.Sales_Org__c=salesOrgObj.Id;
            gtmdet.RecordTypeId=gtmOutlookRecordType;
            insert gtmdet;
            GTMOutlook.getGTMOutlook(year);
       GTM_Details__c gtmDetails = [Select Id,RecordTypeId,Is_Duplicate_Gtm_Record__C From GTM_Details__c Where recordTypeId=:gtmOutlookRecordType and Is_Duplicate_GTM_Record__C = false];
     GTMOutlook.updateGtmDetails('Estimated_Growth_PY_to_CY__c', '123', gtmDetails.Id);
       GTMOutlook.updateGtmDetails('Estimated_Growth_PY_to_NY__c', '123', gtmDetails.Id);
       GTMOutlook.updateGtmDetails('Estimated_Growth_NY_to_2NY__c', '123', gtmDetails.Id);
        GTMOutlook.getInstructions();
        GTMOutlook.getFaq();
        }
    }   
    public static User createuser() {
        User argentinaUsr = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Territory Manager Argentina'].Id,
            LastName = 'Santiago',
            Email = 'sandeep.vishwakarma@skinternational.com',
            Username = 'test@test.com' + System.currentTimeMillis(),
            CompanyName = 'SK international',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Country = 'Argentina'
        );
        insert argentinaUsr;
        return argentinaUsr;
    }
   }