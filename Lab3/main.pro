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

class predicates
    count : (_*) -> integer N.
    sum : (real*) -> real Sum.
    print : (_*) nondeterm.

clauses
    count([]) = 0.
    count([_ | T]) = count(T) + 1.

    sum([]) = 0.
    sum([H | T]) = sum(T) + H.

    print([]).
    print([H | T]) :-
        write(H),
        nl,
        print(T).

class predicates
    departEmployees : (string DepName) -> db* Employees.
    departSalaries : (string DepName) -> integer* Salaries.
    midSalary : () -> real.
    earlierEmployees : (string Date) -> db* Employees.

clauses
    departEmployees(DepName) = List :-
        List =
            [ employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate) ||
                departament(DepId, DepName),
                job(JobId, _, _, _, DepId),
                assign(EmployeeId, JobId, _),
                employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate)
            ].

    departSalaries(DepName) = List :-
        List =
            [ Salary ||
                departament(DepId, DepName),
                job(_, _, Salary, _, DepId)
            ].

    midSalary() = sum(List) / count(List) :-
        List = [ Salary || job(_, _, Salary, _, _) ].

    earlierEmployees(Date) = List :-
        List =
            [ employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate) ||
                employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate),
                EmployeeDate < Date
            ].

clauses
    run() :-
        consult("../db.txt", db),
        fail.
    run() :-
        write("\nIT employees:\n"),
        print(departEmployees("IT")),
        fail.
    run() :-
        write("\nIT salaries:\n"),
        print(departSalaries("IT")),
        fail.
    run() :-
        writef("\nMiddle salary: %\n", midSalary()),
        fail.
    run() :-
        write("\nOld employees (2021/01/01):\n"),
        print(earlierEmployees("2021/01/01")),
        nl,
        fail.
    run().

end implement main

goal
    console::runUtf8(main::run).
