({
    getContactCount: function(searchResults) {
        var count = 0;
        for (var i = 0; i < searchResults.length; i++) {
            count += searchResults[i].relatedContacts.length;
        }
        return count;
    },
    
})
