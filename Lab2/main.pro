% Copyright

implement main
    open core, stdio, file

domains
    gender = male; female.

class facts - db
    employee : (integer EmployeeId, string EmployeeName, gender EmployeeGender, string EmployeeBirth, string EmployeeDate).
    departament : (integer Id, string Name).
    job : (integer Id, string Name, integer Salary, string Desc, integer Dep_id).
    assign : (integer Employee_id, integer Job_id, string Date).

class facts
    stats : (real Sum, integer Count) single.

clauses
    stats(0, 0).

class predicates
    departEmployees : (string DepName, db Employee [out]) nondeterm.
    departSalaries : (string DepName, integer Salary [out]) nondeterm.
    writeMidSalary : ().
    earlierEmployees : (string Date, db Employee [out]) nondeterm.

clauses
    departEmployees(DepName, employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate)) :-
        departament(DepId, DepName),
        job(JobId, _, _, _, DepId),
        assign(EmployeeId, JobId, _),
        employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate).

    departSalaries(DepName, Salary) :-
        departament(DepId, DepName),
        job(_, _, Salary, _, DepId).

    writeMidSalary() :-
        assert(stats(0, 0)),
        job(_, _, Salary, _, _),
        stats(OldSum, OldCount),
        assert(stats(OldSum + Salary, OldCount + 1)),
        fail.

    writeMidSalary() :-
        stats(Sum, Count),
        write("\nMiddle salary: ", Sum / Count).

    earlierEmployees(Date, employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate)) :-
        employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate),
        EmployeeDate < Date.

clauses
    run() :-
        consult("../db.txt", db),
        fail.
    run() :-
        write("IT employees:\n"),
        fail.
    run() :-
        departEmployees("IT", Employee),
        write(Employee),
        nl,
        fail.
    run() :-
        write("\nIT salaries:\n"),
        fail.
    run() :-
        departSalaries("IT", Salary),
        write(Salary),
        nl,
        fail.
    run() :-
        writeMidSalary(),
        nl,
        fail.
    run() :-
        write("\nOld employees (2021/01/01):\n"),
        fail.
    run() :-
        earlierEmployees("2021/01/01", Employee),
        write(Employee),
        nl,
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
