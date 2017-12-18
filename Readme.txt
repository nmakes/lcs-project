=======================================
Prolog Assignment.
Submitted by:
	Naveen Venkat (2015A7PS078P)
	Jay Virendra Pokarna (2015A7PS067P)
=======================================

===============================
Q1. A simple expression reducer
===============================

This prolog program simplifies (reduces) a given SOP or POS expression. For eg.

2*x*6*y + x*9*3 + x*y*1 = 27*x + 13*x*y
(x+8+2)*(7+y+x+9) = (x+10)*(16+x+y)

This is represented in the model as follows:
	s([  p([2,6,xy]),  p([x,9,3]),  p([xy,1])  ])
and
	p([  s([x,8,2]),  s([7,y,x,9])  ])

NOTE:
1. x,y used above are variables.
2. The s() predicate takes a list and represents the sum of the list elements.
3. The p() predicate takes a list and represents the product of the list elements.
4. A variable x in mathematics can be represented by s([0,x]) or p([1,x]) in this program.
5. There must be at least one number in the list.

IMPORTANT NOTE: 
When giving an input expression, the product of variables x*y*z is to be written as a single variable xyz in the list of the product predicate.

--

To get the reduced expression, we use the reduce predicate which is of the form reduce(Expr, Result).
This will set the Result variable to the reduced form of the expression represented by Expr.
Hence, 

?- reduce(s([  p([2,6,xy]),  p([x,9,3]),  p([xy,1])  ]), RESULT).
RESULT = s([p([xy, 12]), p([x, 27]), p([xy, 1])]).

?- reduce(p([  s([x,8,2]),  s([7,y,x,9])  ]), RESULT).
RESULT = p([s([x, 10]), s([y, x, 16])]).

--

Equality of two expressions can be tested by using the equal predicate defined. For eg.

?- equal(s([p([3,x])]), s([p([1,x]), p([3,x])])).
false.


==========================
Q2. Student Knowledge base
==========================

This program will give the details about a student and the courses availible at BITS. This has also covered various registration norms, like late registration etc. We have given a sample set of data in the program itself. For this sample data, some of the queries that can be asked are as follows:

?- eligiblePs1(namo).
false.

?- allowedToRegister(jay,c(g,512,4,eee)).
false.

?- registerForC(jay, c(f,351,3,cs)).
false.

--

Some of the predicates and their meanings:

c(A,B,C,D):
Represents a course.
A - first / higher degree
B - course number
C - no of units
D - Department 

clearedC(X,c(A,B,C,D),N,U):
Represents student X clearing course c(A,B,C,D).
X - Name of Student
c(A,B,C,D) - course
N - the semester in which it is offered.
U - grade in that course

notClearedC(X, c(A,B,C,D),N):
Represents student X not clearing course c(A,B,C,D).
X - Name of Student
c(A,B,C,D) - course
N - the semester in which it is offered.

prereq(Student, c(A,B,C,D)):
Checks if Student can do a course c(A,B,C,D) which has prerequisites. 

studentDiscipline(X,Y,Z,A):
X - name of student
Y- first / higher degree
Z - department
A - first degree (1) / dual degree(2) 

--

duesPaid(X):
X has paid dues.

feesPaid(X):
X has paid fees.

gradeSheetWithheldPrecedingSemester(X):
Grade sheet of X is withheld.

incompleteReportPrecedingSemester(X):
X has an incomplete report in preceding semester. 

registrationOffCampusComplete(X):
Registration has been completed Off campus.

registrationOnCampusComplete(X):
Registration has been completed Off campus.

registrationPhdGuided(X):
Registration has been completed by PHD.

--

debarredSemester(X):
Student X is debarred from registering in the semester.

gradeAwaitedReportPrecedingSemester(X):
X has grade report awaited in preceding semester. 

hasARCDeanApproval(X):
Student X has ARC dean approval.

hasWILPDeanApproval(X):
Student X has WILP Dean approval.

hasPSDeanApproval(X):
Student X has PS Dean approval.

hasPHDdeanApproval(X):
Student X has PHD Dean approval.

hasARdeanApproval(X):
Student X has AR Dean approval.

hasIDdeanApproval(X):
Student X has ID Dean approval.

--

issuesPS(X):
Late registration in PS for X

issuesOFFCampus(X):
Late registration in OFFCampus for X

issuesThesis(X):
Late registration in Thesis for X

issuesDissertation(X):
Late registration in Dissertation for X

faceDifficultyDEANPS(X):
PS Dean faces difficulty. 

faceDifficultyDEANAR(X):
AR Dean faces difficulty.

lateRegistration(X):
Late registration  for X.

--

deanARCDecidesFine(X):
Dean ARCD decides a fine for X.

registrationAlteredByStudent(X):
Registration altered by student X.

registrationAlteredByOtherEvents(X):
Registration altered by other events for student X.

isAmendedRegistration(X):
X has an amended registration.

isRevisedRegistration(X):
X has an revised registration.

isOrignalRegistration(X):
Checks whether X has an orignal registration.

registeredEarly(X):
X has an early registration. 

departedNormalSemesterPattern(X,Y):
Student X has departed from normal semester pattern for course Y. 

satisfyPrereq(X,Y):
Student X satisfies prerequisites for courses Y. 

clearedAllCsInSem(X,N):
Student X has cleared all courses in sem N. 

clearedAllCsTillSem(X,N):
Student X has cleared all courses till sem N.

eligiblePs1(X):
Student X is eligible for PS1.

eligiblePs2(X,N):
Student X is eligible for PS2 in sem N( different for single and dual degree as they have PS2’s in different years).

eligibleTs(X,N):
Student X is eligible for TS in sem N( different for single and dual degree as they have TS in different years ).

eligiblePrescribedSem(X,N):
Student X is eligible for prescribed sem no N.

cDiscipline(X,Y):
Returns branch of Student X. 

cDegree(X,Y):
Returns degree of Student X.

hasSameDiscipline(X,Y):
Student X belongs to same discipline as course Y. 

hasSameDegree(X,Y):
Student X belongs to same degree as course Y.

allowedToRegister(X,Y):
Student X is allowed to register for course Y. 

shouldBeExaminedC(X,Y,N) :
Student X should be examined for course Y in sem N.

timetableClash(X):
Student X has a timetabe clash. 

replaceableBy(X,Y):
Course X can be replaced by course Y. 

hasCeased(X):
X course has been ceased to be offered. 