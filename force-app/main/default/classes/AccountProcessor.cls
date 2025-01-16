public class AccountProcessor {
  @future
  public static void countContacts(List<Id> accId) {
    List<Account> accList = [
      SELECT Id, Name, (SELECT Id, Name FROM Contacts)
      FROM Account
      WHERE Id IN :accId
    ];

    for (Account acc : accList) {
      if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
        acc.Number_Of_Contacts__c = acc.Contacts.size();
      } else {
        acc.Number_Of_Contacts__c = 0;
      }
    }

    if (!accList.isEmpty()) {
      update accList;
    }
  }
}
