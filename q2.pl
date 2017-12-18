/* COURSES */

/*1st year */
c(f,111,4,cs).
c(f,110,1,bio).
c(f,110,1,chem).
c(f,110,1,phy).
c(f,111,3,bio).
c(f,110,2,bits).
c(f,113,3,math).
c(f,111,3,chem).
c(f,111,3,phy).
c(f,110,2,me).
c(f,111,3,eee).
c(f,111,3,me).

/* 2nd year cs 1st sem */
c(f,211,3,math).
c(f,213,4,cs).
c(f,214,3,cs).
c(f,215,4,eee).
c(f,222,3,cs).

/* 2nd year cs 2nd sem */
c(f,211,4,cs). /* dsa*/
c(f,241,4,cs). /* mup*/
c(f,212,4,cs). /* dbms*/

/* 3rd year cs */
c(f,351,3,cs).   /*Theory of Computation*/
c(f,342,3,cs).  /*Computer Architecture */

/* 2nd year eee */
c(f,211,3,math).
c(f,211,4,eee).
c(f,212,3,eee).
c(f,214,3,eee).
c(f,215,4,eee).

/* 3rd year eee */
c(f,311,4,eee).
c(f,313,4,eee).

/* me cs cs  */
c(g,514,4,cs).
c(g,525,5,cs).
c(g,526,5,cs).
c(g,527,5,cs).
c(g,541,4,cs).
c(g,551,5,cs).
c(g,553,5,cs).
c(g,623,5,cs).

/* me cs eee */
c(g,512,4,eee).
c(g,522,5,eee).
c(g,572,5,eee).
c(g,581,5,eee).
c(g,591,5,eee).

/* STUDENT DATA */
clearedC(namo,c(f,110,1,chem),1,7).
clearedC(namo,c(f,110,1,phy),1,9).
clearedC(namo,c(f,111,3,bio),1,8).
clearedC(namo,c(f,110,2,bits),1,9).
clearedC(namo,c(f,112,2,bits),2,7).
clearedC(namo,c(f,111,3,math),1,9).
clearedC(namo,c(f,112,3,math),2,5).
clearedC(namo,c(f,111,3,phy),1,10).
clearedC(namo,c(f,110,2,me),2,10).
clearedC(jay,c(f,110,1,bio),2,9).
clearedC(jay,c(f,110,1,chem),1,10).
clearedC(jay,c(f,110,1,phy),1,10).
clearedC(jay,c(f,111,3,bio),1,10).
clearedC(jay,c(f,110,2,bits),1,8).
clearedC(jay,c(f,112,2,bits),2,9).
clearedC(jay,c(f,111,3,phy),1,9).
clearedC(jay,c(f,110,2,me),2,8).
clearedC(jay,c(f,111,3,eee),2,10).
notClearedC(jay,c(f,111,3,me),2).
notClearedC(jay,c(f,111,4,cs),2).
notClearedC(jay,c(f,111,3,math),1).
notClearedC(namo,c(f,111,3,eee),2).
notClearedC(namo,c(f,111,3,me),2).
notClearedC(namo,c(f,111,4,cs),2).
notClearedC(namo,c(f,110,1,bio),1).

prereq(Student, c(f,213,4,cs)) :-
(
    clearedC(Student,c(f,111,4,cs),_,_)
).

prereq(Student, c(f,211,4,cs)) :-
(
    clearedC(Student, c(f,222,3,cs),_,_);
    clearedC(Student, c(f,213,3,cs),_,_)
).

prereq(Student, c(f,351,3,cs)) :-
(
    clearedC(Student, c(f,222,3,cs),_,_),
    clearedC(Student, c(f,214,3,cs),_,_)
).

prereq(Student, c(f,342,3,cs)):-
(
    clearedC(Student, c(f,241,3,cs),_,_),
    clearedC(Student, c(f,215,4,cs),_,_)
).

prereq(Student, c(f,211,4,eee)):-
(
    clearedC(Student, c(f,111,3,eee),_,_)
).

studentDiscipline(namo,f,cs,1).
studentDiscipline(lakhan,f,math,1).
studentDiscipline(lakhan,f,cs,2).
studentDiscipline(ajinkya,m, mba,1).
duesPaid(naveen).
feesPaid(naveen).
gradeSheetWithheldPrecedingSemester(naveen).
incompleteReportPrecedingSemester(naveen).

debarredSemester(badnaveen).
gradeAwaitedReportPrecedingSemester(badnaveen).

/* dean permissions for a student condition in pre req for registration  and completion of reg*/
hasARCDeanApproval(naveen).
hasARCDeanApproval(badnaveen).
hasWILPDeanApproval(naveen).
hasPSDeanApproval(naveen).
hasPHDdeanApproval(naveen).
hasARdeanApproval(naveen).
hasIDdeanApproval(naveen).

/* some less used stuff*/
issuesPS(naveen).
issuesOFFCampus(naveen).
issuesThesis(naveen).
issuesDissertation(naveen).
faceDifficultyDEANPS(naveen).
faceDifficultyDEANAR(naveen).
lateRegistration(naveen).
deanARCDecisionFine(naveen).

/* 3.01 & 3.09 & 3.10 */
permittedRegistration(X):-
(
    (   
        duesPaid(X),
        feesPaid(X),
        not(gradeSheetWithheldPrecedingSemester(X)),
        not(incompleteReportPrecedingSemester(X)),
        not(debarredSemester(X))
    );
    (
        gradeAwaitedReportPrecedingSemester(X), 
        hasARCDeanApproval(X)
    );
    (
        hasDeanApproval(X)
    )
).

/* 3.02 */
hasDeanApproval(X):-
(    
    hasARCDeanApproval(X); /* has highest authority */
    hasWILPDeanApproval(X);
    hasPSDeanApproval(X);
    hasPHDdeanApproval(X);
    hasARdeanApproval(X);
    hasIDdeanApproval(X)
).

registered(X) :-
(
    permittedRegistration(X),
    (
        registrationOnCampusComplete(X);
        registrationOffCampusComplete(X);
        registrationPhdGuided(X);
        registrationThesisGuided(X);
        registrationSeminarGuided(X);
        registrationDissertationGuided(X);
        registrationPSGuided(X);
        registrationTeachingPracticeGuided(X);
        registrationPracticeLectureGuided(X)
    )
).

/* 3.05  & 3.06*/
lateRegistrationPermitted(X):-
(
    hasARCDeanApproval(X), 
    not(registered(X)),
    (         
        not(registrationBeyond1WeekClassBeginning(X));   
        (
            registrationBeyond1WeekClassBeginning(X),
            hasIDdeanApproval(X)
        )
    )
).

lateRegistrationFine(X):-
(
    lateRegistrationPermitted(X), 
    deanARCDecidesFine(X)
).

recommendationARCDean(X):-
(
    issuesPS(X);
    issuesOFFCampus(X);
    issuesThesis(X);
    issuesDissertation(X);
    faceDifficultyDEANPS(X);
    faceDifficultyDEANAR(X)
).

registrationAlteredByStudent(jay).
registrationAlteredByOtherEvents(namo).

/* 3.07 */
isAmendedRegistration(X) :-
(
    registrationAlteredByStudent(X)
).

isRevisedRegistration(X) :-
(
    registrationAlteredByOtherEvents(X)
).

isOrignalRegistration(X):-
(
    registered(X),
    not(isAmendedRegistration(X)),
    not(isRevisedRegistration(X))
).


registeredEarly(namo).


/* 3.12 */
departedNormalSemesterPattern(X,Y):-
(   
    registeredEarly(X);
    unregisteredScheduledCs(X,Y)
).

/*3.13*/
satisfyPrereq(X,Y) :-
(
    prereq(X,Y); 
    not( prereq(_,Y) )
).

/*3.14*/
clearedAllCsInSem(X,N):-
(
    not(notClearedC(X,c(_,_,_,_),N))
).

clearedAllCsTillSem(_,0).

clearedAllCsTillSem(X,N) :-
(
    clearedAllCsInSem(X,N),
    clearedAllCsTillSem(X,Z), 
    (Z is N-1)
).

eligiblePs1(X) :-
(
    clearedAllCsTillSem(X,4)
).

eligiblePs2(X,N) :-
(   
    clearedAllCsTillSem(X,N)
).

eligibleTs(X,N) :-
( 
    clearedAllCsTillSem(X,N)
).

eligiblePrescribedSem(X,N):-
(
    Z is N-1,
    (
        clearedAllCsTillSem(X,Z);
        (
            not(clearedAllCsTillSem(X,Z)),
            hasARCDeanApproval(X)
        )
    )
).

/* 3.15 */
equal(X,X).

cDiscipline(X,Y):-
(
    equal(X,c(_,_,_,Y))
).

cDegree(X,Y):-
(
    equal(X,c(Y,_,_,_))
).

studentDisciplineNum(X,B,Y):-
(
    studentDiscipline(X,_,B,Z),
    equal(Z,Y)
).

hasSameDiscipline(X,Y):-
(
    cDiscipline(Y,CD),
    studentDiscipline(X,_,SD,_),
    equal(CD,SD)
).

hasSameDegree(X,Y):-
(
    cDegree(Y,CD),
    studentDiscipline(X,SD,_,_),
    equal(CD,SD)
).

allowedToRegister(X,Y) :-
(
    satisfyPrereq(X,Y),
    (
        ( 
            (
                hasSameDiscipline(X,Y), 
                hasSameDegree(X,Y))
            );
            (    
                not(hasSameDiscipline(X,Y)), 
                hasSameDegree(X,Y),  
                clearedAllCsTillSem(X,4)  
            );
            ( 
                not(hasSameDegree(X,Y)),
                hasSameDiscipline(X,Y),
                (    
                    cDiscipline(X,B),
                    studentDisciplineNum(X,B,N),
                    M is (N+1)*2, /* For dual degree student, if he has a branch Maths + CS, then according to the rules, he can take a Maths higher degree elective after his 2nd year (sem 4) and CS higher degree elective after 3rd year (sem 6).*/
                    clearedAllCsTillSem(X,M)  
                )
            )
        ),
        not(clearedC(X,Y,_,_)
    )
).

/*3.16*/
/*  The description mentioned is very vague and hence cannot be made into predicates. */
/*  It’s about taking care while you are registering. */

/*3.17 */
shouldBeExaminedC(X,Y,N) :-
(
    notClearedC(X,Y,_ );
    (
        M is N-1,  
        clearedC(X,Y,M,_ )
    )
).

/*3.18 , 3.19*/
registerForC(X,Y) :-
(
    allowedToRegister(X,Y),
    not(timetableClash(X))
).
    
    /* Over Preparedness isn’t specified properly*/
    /* Timetable data available from ERP data*/

/*3.20*/
hasCeased(c(g,581,5,eee)).
hasCeased(c(g,553,5,cs)).
hasCeased(c(g,623,5,cs)).
hasCeased(c( f,211, 3, math)).
replaceableBy(c( f,211, 3, math),c(f,212,3,math)).
replaceableBy(c(g,581,5,eee),c(g,623,5,cs)).

replaceC(X,Y) :-
(
    hasCeased(X), 
    replaceableBy(X,Y)
).