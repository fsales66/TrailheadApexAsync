public class AddPrimaryContact implements Queueable {
  private contact cont;
  private String st;
  public AddPrimaryContact(Contact contact, String state) {
    this.cont = cont;
    this.st = state;
  }

  List<Contact> contactsToClone = new List<Contact>();
  List<Account> selectedAcc = [
    SELECT Id, Name
    FROM Account
    WHERE BillingState = :st
    LIMIT 200
  ];
  public void execute(QueueableContext context) {
    for (Account acc : selectedAcc) {
      Contact clonnedContact = cont.clone(false, true, false);
      clonnedContact.accountId = acc.Id;

      contactsToClone.add(clonnedContact);
    }

    if (!contactsToClone.isEmpty()) {
      insert contactsToClone;
    }
  }
}
