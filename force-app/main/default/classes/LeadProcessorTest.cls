@isTest
public class LeadProcessorTest {
  @testSetup
  static void setup() {
    List<Lead> leadTest = new List<Lead>();

    for (Integer i = 0; i < 200; i++) {
      leadTest.add(
        new Lead(
          FirstName = 'Test',
          LastName = 'Lead ' + i,
          Company = 'Test Company ' + i,
          LeadSource = 'Web',
          Industry = 'Technology'
        )
      );
    }
    insert leadTest;
  }

  @isTest
  static void test1() {
    Test.startTest();
    LeadProcessor lpTest = new LeadProcessor();
    Id batchId = Database.executeBatch(lpTest, 200);
    Test.stopTest();

    Integer leadCount = [SELECT COUNT() FROM Lead];
    System.assertEquals(
      200,
      leadCount,
      'Deve existir exatamente 200 registros do tipo lead'
    );

    for (Lead ld : [SELECT Id, FirstName, LeadSource FROM Lead]) {
      System.assertEquals(
        'Dreamforce',
        ld.LeadSource,
        'o LeadSource de ' + ld.FirstName + ' deve ser Dreamforce'
      );
    }
  }
}
