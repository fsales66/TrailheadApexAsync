@isTest
public class AccountProcessorTest {
  //Falta concluir esse setup
  @testSetup
  static void testData() {
    List<Account> lAcc = new List<Account>();
    lAcc.add(new Account(Name = 'Test Account 1'));
    lAcc.add(new Account(Name = 'Test Account 2'));
    lAcc.add(new Account(Name = 'Test Account 3'));

    insert lAcc;

    List<Contact> lCon = new List<Contact>();
    lCon.add(
      new Contact(FirstName = 'John', LastName = 'Doe', AccountId = lAcc[0].Id)
    );
    lCon.add(
      new Contact(
        FirstName = 'Jane',
        LastName = 'Smith',
        AccountId = lAcc[0].Id
      )
    );
    lCon.add(
      new Contact(
        FirstName = 'Alice',
        LastName = 'Johnson',
        AccountId = lAcc[1].Id
      )
    );
    lCon.add(
      new Contact(FirstName = 'Bob', LastName = 'Brown', AccountId = lAcc[1].Id)
    );
    lCon.add(
      new Contact(
        FirstName = 'Charlie',
        LastName = 'Williams',
        AccountId = lAcc[1].Id
      )
    );

    insert lCon;
  }

  @isTest
  public static void countContactsTest() {
    List<Id> listId = new List<Id>();
    for (Account actId : [SELECT Id FROM Account]) {
      listId.add(actId.Id);
    }

    Test.startTest();
    AccountProcessor.countContacts(listId);
    Test.stopTest();

    List<Account> updatedAccount = [
      SELECT Id, Name, Number_Of_Contacts__c
      FROM Account
    ];

    System.assertEquals(
      2,
      updatedAccount[0].Number_Of_Contacts__c,
      'Account 1 should have 2 contacts'
    );
    System.assertEquals(
      3,
      updatedAccount[1].Number_Of_Contacts__c,
      'Account 2 should have 3 contacts'
    );
    System.assertEquals(
      0,
      updatedAccount[2].Number_Of_Contacts__c,
      'Account 3 should have 0 contacts'
    );
  }
}
