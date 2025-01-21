@isTest
public class AddPrimaryContactTest {
  @TestSetup
  public static void setup() {
    List<Account> testAcc = new List<Account>();

    for (Integer i = 0; i < 200; i++) {
      testAcc.add(new Account(Name = 'Account Test ' + i, BillingState = 'NY'));
    }
    insert testAcc;
  }
  @isTest
  static void addPrimaryTest() {
    Contact contTest = new Contact(
      FirstName = 'James',
      LastName = 'Charles',
      Email = 'test@example.com'
    );
    AddPrimaryContact addPrimary = new AddPrimaryContact(contTest, 'NY');
    Test.StartTest();
    System.enqueueJob(addPrimary);
    Test.StopTest();

    List<Contact> countList = [
      SELECT Id, FirstName, LastName
      FROM Contact
      WHERE FirstName LIKE 'James%'
    ];
    System.assertEquals(
      200,
      countList.size(),
      'A quantidade de contatos não está correta'
    );
  }
}
