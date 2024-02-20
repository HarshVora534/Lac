trigger UpdateContactsWithAccountName on Contact (after update) {
    Set<Id> accountIds = new Set<Id>();
    Map<Id, String> accountIdToNewNameMap = new Map<Id, String>();

    for (Contact con : Trigger.new) {
        if (con.AccountId != null && Trigger.oldMap.get(con.Id).AccountId != con.AccountId) {
            accountIds.add(con.AccountId);
            accountIdToNewNameMap.put(con.AccountId, con.Account.Name);
        }
    }

    List<Account> accountsToUpdate = new List<Account>();
    for (Id accountId : accountIds) {
        String newAccountName = accountIdToNewNameMap.get(accountId);
        if (String.isNotBlank(newAccountName)) {
            Account acc = new Account(Id = accountId);
            acc.Name = newAccountName;
            accountsToUpdate.add(acc);
        }
    }

    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}