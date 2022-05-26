% employee(id, name, gender, birth, employment)
employee(1, "Ivan", "m", "19.01.2001",  "2020/10/01").
employee(2, "Alena", "f", "07.09.2002",  "2021/05/12").
employee(3, "Stepa", "m", "05.04.2001",  "2021/02/21").
employee(4, "Nikita", "m", "31.08.2002",  "2020/03/13").
employee(5, "Roman", "m", "09.07.2002",  "2021/02/14").

% departament(id, name)
departament(1, "IT").
departament(2, "Risks").
departament(3, "Finance").

% job(id, name, salary, desc, dep_id)
job(1, "junior", 100, "IT specialist with experience < 2 years", 1).
job(2, "middle", 200, "IT specialist with experience 2-5 years", 1).
job(3, "senior", 300, "IT specialist with experience >5 years", 1).
job(4, "analyst", 250, "Analytics specialist with experience >3 years", 2).
job(5, "manager", 275, "Financial specialist with experience >3 years", 3).

% assign(employee_id, job_id, date)
assign(1, 1, "01.10.2020").
assign(2, 4, "12.05.2021").
assign(3, 2, "15.01.2022").
assign(4, 3, "11.04.2021").
assign(5, 5, "14.02.2021").

% departEmployees("IT", Employee)
departEmployees(DepName, employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate)) :-
    departament(DepId, DepName),
    job(JobId, _, _, _, DepId),
    assign(EmployeeId, JobId, _),
    employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate).

% departSalaries("IT", Salary)
departSalaries(DepName, Salary) :- departament(DepId, DepName), job(_, _, Salary, _, DepId).

% olds("2021/01/01", Employee)
earlierEmployees(Date, employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate)) :-
    employee(EmployeeId, EmployeeName, EmployeeGender, EmployeeBirth, EmployeeDate), 
    EmployeeDate < Date.
