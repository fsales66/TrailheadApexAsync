@isTest
public with sharing class DailyLeadProcessorTest {
  public static String CRON_EXP = '0 0 0 15 3 ? 2042';
  @testSetup
  public static void setup() {
    List<Lead> newLeads = new List<Lead>();

    for (Integer i = 0; i < 200; i++) {
      newLeads.add(
        new Lead(
          LastName = 'Lead Test ' + i,
          Company = 'Test Comp',
          MobilePhone = '55555555',
          Status = 'Open - Not Contacted',
          Industry = 'Agriculture',
          LeadSource = 'Other'
        )
      );
    }
    insert newLeads;
  }

  @isTest
  public static void test1() {
    Test.startTest();
    String jobId = System.schedule(
      'DailyLeadProcessor',
      CRON_EXP,
      new DailyLeadProcessor()
    );
    Test.stopTest();

    List<Lead> updLeads = [
      SELECT Id, Name, LeadSource
      FROM Lead
      WHERE LeadSource = 'Dreamforce'
    ];

    System.assertEquals(
      200,
      updLeads.size(),
      'O tamanho da lista não foi o esperado'
    );
  }
}
