({
	doInit : function(component, event, helper) {
		 var action = component.get("c.getProductandPriceDetails");
        action.setParams({ "caseId": component.get("v.recordId") });
         action.setCallback( this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               component.set("v.ProductInfoList", response.getReturnValue());               
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})