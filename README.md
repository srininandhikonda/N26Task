# N26Task

N26 Customer Survey:

N26 customer- Used standard Contact Object.
Created a New Picklist Field called “language__c" to store language values as of now i gave DE,EN.
Field is Required at Created Level.
“survey_date__c” Field created as to store date for the custom survey sent

Created same text Email Template as per the task
   based on Contact Language__c field the template will be displayed to user in that language.
   
Implemneted Batch to send survey emails to the n26 customers.
Should be enabled in org:
Deliverability>Access level = All Email
Respect SendEmail API - Enabled
SendEmail API - Enabled

Showing Product & Pricing info on Case Page Layout
===============
created 2 fields on Contact object (‘Product__c’ and ‘Home_Country__c’)
Product__c lookup to Product2 Object
Home_Country__c Picklist with Country Names

Product & Pricing Defined in the tables
Took Price Books taken based Country + Service charge Type 
So 5 PriceBooks for each charge
15 price book entries for each charge.

Created Lightning component and add it to the Case Record page using Liginging App builder(Edit Page).

based on pricing and product configuration shown the product related pricing for the country shown in Case page layout in Lightning.
