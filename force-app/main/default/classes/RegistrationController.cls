public with sharing class RegistrationController {
    @AuraEnabled
    public static void registerUser(Map<String, Object> userData) {
        String userType = (String)userData.get('userType');
        String name = (String)userData.get('name');
        String email = (String)userData.get('email');
        String subjectTaught = (String)userData.get('subjectTaught');
        String experience = (String)userData.get('experience'); // Changed to String
        String gradeLevel = (String)userData.get('gradeLevel');
        String school = (String)userData.get('school');

        if (userType == 'Teacher') {
            // Create Teacher record
            Teacher__c newTeacher = new Teacher__c();
            newTeacher.Name = name;
            newTeacher.Email__c = email;
            newTeacher.Subject_Taught__c = subjectTaught;
            // Convert experience to Integer if necessary
            if (String.isNotBlank(experience)) {
                newTeacher.Experience__c = Integer.valueOf(experience);
            }
            insert newTeacher;
            System.debug(newTeacher);
        } else if (userType == 'Student') {
            // Create Student record
            Student__c newStudent = new Student__c();
            newStudent.Name = name;
            newStudent.Email__c = email;
            newStudent.Grade_Level__c = gradeLevel;
            newStudent.School__c = school;
            insert newStudent;
            System.debug(newStudent);
        }
    }
}
