public without sharing class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Lead> updatedLeadSource = new List<Lead>();

    for (Lead ld : [SELECT Id, Name, LeadSource FROM Lead LIMIT 200]) {
      ld.LeadSource = 'DreamForce';

      updatedLeadSource.add(ld);
    }

    update updatedLeadSource;
  }
}
