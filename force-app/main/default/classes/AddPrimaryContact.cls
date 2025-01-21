public class AddPrimaryContact implements Queueable {
  private contact cont;
  private String st;
  public AddPrimaryContact(Contact contact, String state) {
    this.cont = contact;
    this.st = state;
  }

  public void execute(QueueableContext context) {
    List<Contact> contactsToClone = new List<Contact>();
    List<Account> selectedAcc = [
      SELECT Id, Name
      FROM Account
      WHERE BillingState = :st
      LIMIT 200
    ];
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
