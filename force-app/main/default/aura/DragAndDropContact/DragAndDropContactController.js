// ({
//     searchAccounts1 : function(component, event, helper) {
//         var searchKeyword = component.get("v.searchKeyword1");
//         var action = component.get("c.searchAccounts");
//         action.setParams({
//             "searchKeyword": searchKeyword
//         });
//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 component.set("v.searchResults1", response.getReturnValue());
//                 component.set("v.contactCount1", helper.getContactCount(response.getReturnValue()));
//             }
//         });
//         $A.enqueueAction(action);
//     },
    
//     searchAccounts2 : function(component, event, helper) {
//         var searchKeyword = component.get("v.searchKeyword2");
//         var action = component.get("c.searchAccounts");
//         action.setParams({
//             "searchKeyword": searchKeyword
//         });
//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 component.set("v.searchResults2", response.getReturnValue());
//                 component.set("v.contactCount2", helper.getContactCount(response.getReturnValue()));
//             }
//         });
//         $A.enqueueAction(action);
//     },
//     handleDragStart: function(component, event, helper) {
//         event.dataTransfer.setData("text", event.target.dataset.parentaccount);
//     },
//     allowDrop : function (component, event, helper) 
//     {
//         event.preventDefault();
//     },
//     handleDrop: function(component, event, helper) {
//         event.preventDefault();
//         var accountId = event.target.dataset.accountid;
//         var contactId = event.dataTransfer.getData("text");

//         var action = component.get("c.updateParentAccount");
//         action.setParams({
//             "accountId": accountId,
//             "contactId": contactId
//         });

//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 var updatedContacts = response.getReturnValue();
//                 var contacts = component.get("v.contacts");
//                 for (var i = 0; i < contacts.length; i++) {
//                     if (contacts[i].Id === contactId) {
//                         contacts[i].AccountId = accountId;
//                         break;
//                     }
//                 }
//                 component.set("v.contacts", contacts);
//             } else {
//                 console.log('Error');
//             }
//         });
//         $A.enqueueAction(action);
//     }
// })


// // ondragover - occurs when a dragged element is over the drop target
// // ondrop - occurs when a dragged element is dropped over the drop target






    ({
        searchAccounts1: function(component, event, helper) {
            var searchKeyword = component.get("v.searchKeyword1");
            var action = component.get("c.searchAccounts");
            action.setParams({
                "searchKeyword": searchKeyword
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.searchResults1", response.getReturnValue());
                    component.set("v.contactCount1", helper.getContactCount(response.getReturnValue()));
                }
            });
            $A.enqueueAction(action);
        },
        
        searchAccounts2: function(component, event, helper) {
            var searchKeyword = component.get("v.searchKeyword2");
            var action = component.get("c.searchAccounts");
            action.setParams({
                "searchKeyword": searchKeyword
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.searchResults2", response.getReturnValue());
                    component.set("v.contactCount2", helper.getContactCount(response.getReturnValue()));
                }
            });
            $A.enqueueAction(action);
        },
    
        handleDragStart: function(component, event, helper) {
            event.dataTransfer.setData("text", event.target.accid);
            console.log('handleDragStart:- '+ event.target.id);
            component.set("v.contactid", event.target.id);
        },
        
        allowDrop: function(component, event, helper) {
            event.preventDefault();
        },
        
        handleDrop: function(component, event, helper) {
            event.preventDefault();
            var accountId = event.target.accid;
            var contactId = component.get("v.contactid");
            console.log('accountId--> ',accountId);
            console.log('contactId--> ',contactId);
            var action = component.get("c.updateParentAccount");
            action.setParams({
                "accountId": accountId,
                "contactId": contactId
            });
        
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('--> ',response.getState());
                if (state === "SUCCESS") {
                    var updatedContacts = response.getReturnValue();
                    console.log('------>',updatedContacts);
                    var contacts = component.get("v.contact");
                    console.log('-->',contacts.length);
                    for (var i = 0; i < contacts.length; i++) {
                        if (contacts[i].Id === contactId) {
                            console.log('---->',contacts[i].AccountId);
                            contacts[i].AccountId = accountId;
                            break;
                        }
                    }
                    console.log('-->',contacts);
                    component.set("v.contacts", contacts);
                    debugger
                    
                    // Refresh the view
                    $A.get('e.force:refreshView').fire();
                    
                    // Refresh sections after updating the parent account
                    $A.enqueueAction(component.get("c.searchAccounts1"));
                    $A.enqueueAction(component.get("c.searchAccounts2"));
                }
                else {
                    console.error('Error:', response.getError());
                }
            });
            $A.enqueueAction(action);
        }
    })