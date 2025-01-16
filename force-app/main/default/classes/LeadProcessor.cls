public class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {
  public Integer leadsUpdated = 0;
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('SELECT Id FROM Lead ');
  }

  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    List<lead> leadUpdate = new List<Lead>();
    for (Lead nLead : scope) {
      nLead.LeadSource = 'Dreamforce';

      leadUpdate.add(nLead);
      leadsUpdated++;
    }

    if (!leadUpdate.isEmpty()) {
      update leadUpdate;
    }
  }

  public void finish(Database.BatchableContext bc) {
    System.debug('No total, ' + leadsUpdated + ' Leads foram atualizadas');
  }
}
