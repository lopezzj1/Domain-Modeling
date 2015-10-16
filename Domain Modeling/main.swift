//
//  main.swift
//  Domain Modeling
//
//  Created by Jill Lopez on 10/14/15.
//  Copyright © 2015 Jill Lopez. All rights reserved.
//

import Foundation


/////////////MONEY//////////////////

//types of currencies
enum Currency {
    case USD
    case GBP
    case EUR
    case CAN
}

//money struct contains:
//amount, currencies
//this struct has the ability to convert currencies, add and subtract currencies
struct Money {
    var amount : Double
    var currency : Currency

    //currency conversion function
    mutating func convert (newCurrency : Currency) -> String {
        switch self.currency {
            case .USD :
                if newCurrency == .GBP {
                    currency = .GBP
                    amount *= 0.5
                }
                if newCurrency == .EUR {
                    currency = .EUR
                    amount *= 1.5
                }
                if newCurrency == .CAN {
                    currency = .CAN
                    amount *= 1.25
                }
            case .GBP :
                if newCurrency == .USD {
                    currency = .USD
                    amount *= 2
                }
                if newCurrency == .EUR {
                    currency = .EUR
                    amount *= 3
                }
                if newCurrency == .CAN {
                    currency = .CAN
                    amount *= 2.5
                }
            case .EUR :
                if newCurrency == .USD {
                    currency = .USD
                    amount *= 0.66
                }
                if newCurrency == .GBP {
                    currency = .GBP
                    amount *= 0.33
                }
                if newCurrency == .CAN {
                    currency = .CAN
                    amount *= 0.83
                }
            case .CAN :
                if newCurrency == .USD {
                    currency = .USD
                    amount *= 0.80
                }
                if newCurrency == .GBP {
                    currency = .GBP
                    amount *= 0.40
                }
                if newCurrency == .EUR {
                    currency = .EUR
                    amount *= 1.2
                }
        }
        
        return ("\(self.amount) \(currency)")
    }
    
    //returns the new total after adding the two currencies
    //if the currencies are different, the default is the first currency type
    mutating func add(var newAmount : Money) -> String{
        if self.currency == newAmount.currency {
            return ("\(self.amount + newAmount.amount)")
        } else {
            newAmount.convert(self.currency)
            let amount = self.amount + newAmount.amount
            return("\(amount) \(newAmount.currency)")
        }
        
    }

    //returns the new total after subtracting the two currencies
    //if the currencies are different, the default is the first currency type
    mutating func sub(var newAmount : Money) -> String{
        if self.currency == newAmount.currency {
            return ("\(self.amount - newAmount.amount)")
        } else {
            newAmount.convert(self.currency)
            let amount = self.amount - newAmount.amount
            return("\(amount) \(newAmount.currency)")
        }
        
    }
    
}





////////////////////////
//////////JOB//////////
///////////////////////

//different types of salaries
enum SalaryType {
    case HOURLY
    case YEARLY
}


//class job takes in a job title, salary, and salary type
//this function can calculate income, raise
class Job {
    var jobTitle : String
    var jobSalary : Double
    var salaryType : SalaryType
    
    
    init(title : String, salary: Double, type: SalaryType){
        jobTitle = title
        jobSalary = salary
        salaryType = type
    }
    
    func calculateIncome (numHours : Int?) -> Double {
        if self.salaryType == .HOURLY {
            return (Double(numHours!) * jobSalary)
        } else {
           return self.jobSalary
        }
    }
    
    func raise (percent : Double) -> Double {
        let rate = percent/100
        return (jobSalary * rate) + jobSalary
    }
    
}



var businessAnalyst = Job(title: "Business Analyst", salary: 75000, type: SalaryType.YEARLY)
var marketAnalyst = Job(title: "Marketing Analyst", salary: 50000, type: SalaryType.YEARLY)
var hrAssistant = Job(title: "HR Assistant", salary: 12.25, type: SalaryType.HOURLY)



//////////PERSON////////////

class Person {
    var firstName : String
    var lastName : String
    var age : Int32
    var job : Job?
    var spouse : String?
    
    init (fName : String, lName : String, currentAge : Int32, currJob : Job, currSpouse : String?) {
        firstName = fName
        lastName = lName
        age = currentAge
        
        if age >= 16 {
            job = currJob
        } else if age < 16 {
            job = nil
            print("\(firstName) \(lastName) cannot have a job since they are under the age of 16")
        }
        
        if age >= 18 {
            spouse = currSpouse
        } else if age < 18 {
            spouse = nil
            print("\(firstName) \(lastName) cannot be married under the age of 18")
        }
    }
    
    init(fName : String, lName: String, currentAge : Int32){
        self.firstName = fName
        self.lastName = lName
        self.age = currentAge
    }
    
    func toString() {
        print("Name: \(firstName) \(lastName)")
        print("Age: \(age)")
        
        if age>=16 {
            print("Job: \(job)")
        } else if age < 16 {
            print("Job: N/A")
        }
        
        if age >= 18 {
            print("Spouse: \(spouse)")
        } else if age < 18 {
            print("Spouse: N/A")
        }
    }
    
}

var p1 = Person(fName: "Jill", lName: "Lopez", currentAge: 22, currJob: businessAnalyst, currSpouse: "")
var p2 = Person(fName: "Kevin", lName: "Adams", currentAge: 23, currJob: marketAnalyst, currSpouse: "Jill")
var p3 = Person(fName: "Jennifer", lName: "Joe", currentAge: 18, currJob: hrAssistant, currSpouse: "")



/////////////////FAMILY//////////////////

class Family {
    var familyMembers : [Person] = []
    
    init? (members : [Person]) {
        var legal : Bool = false
        for member in members {
            if member.age > 20 {
                legal = true
            }
        }
        
        if legal == false {
            return nil
        }
        
        self.familyMembers = members
    }
    
    func householdIncome () -> Double {
        var total = 0.0
        for var i = 0; i < familyMembers.count; i++ {
            total += familyMembers[i].job!.calculateIncome(2080)
        }
        return total
    }
    
    func haveChild(firstName : String, lastName : String) {
        let child = Person(fName: firstName, lName: lastName, currentAge: 0)
        familyMembers.append(child)
        print("New Child name: \(child.firstName) \(child.lastName), age: \(child.age)")
    }
    
}



var familyArray = [p1, p2, p3]
var newFam = Family(members: familyArray)



print("Test Cases - Money:")
var money = Money(amount: 2.0, currency: Currency.USD)
var money2 = Money(amount: 4.0, currency: Currency.GBP)

print("Money = \(money.amount) \(money.currency)")
print("Money = \(money2.amount) \(money2.currency)")
print("Convert \(money.amount) \(money.currency) to EUR = \(money.convert(Currency.EUR))")
money = Money(amount: 2.0, currency: Currency.USD)
print("Convert \(money.amount) \(money.currency) to GBP = \(money.convert(Currency.GBP))")
money = Money(amount: 2.0, currency: Currency.USD)
print("Convert \(money.amount) \(money.currency) to CAN = \(money.convert(Currency.CAN))")

money = Money(amount: 2.0, currency: Currency.USD)

print("Add \(money.amount) \(money.currency) + \(money2.amount) \(money2.currency) = \(money.add(money2))")

money = Money(amount: 4.0, currency: Currency.USD)
money2 = Money(amount: 1.0, currency: Currency.GBP)
print("Add \(money.amount) \(money.currency)  \(money2.amount) \(money2.currency) = \(money.sub(money2))")
print("")

print("Test Cases - Job")
print("Job: \(businessAnalyst.jobTitle), Job Salary: $\(businessAnalyst.jobSalary), Salary Type: \(businessAnalyst.salaryType)")
print("Job: \(marketAnalyst.jobTitle), Job Salary: $\(marketAnalyst.jobSalary), Salary Type: \(marketAnalyst.salaryType)")
print("Job: \(hrAssistant.jobTitle), Job Salary: \(hrAssistant.jobSalary), Salary Type: \(hrAssistant.salaryType)")

print("Calculate Income for Marketing Analyst: $\(marketAnalyst.calculateIncome(0))")
print("Calculate Income for HR Assistant with 40 hours of work: $\(hrAssistant.calculateIncome(40))")

print("Calculate 2.5% raise for Business Analyst: $\(businessAnalyst.raise(2.5))")
print("Calculate 2.5% raise for HR Assistant: $\(hrAssistant.raise(2.5))")
print("")


print("Test Cases - Person")
var p4 = Person(fName: "Kevin", lName: "Adams", currentAge: 23, currJob: marketAnalyst, currSpouse: "Jill")
var p5 = Person(fName: "Jill", lName: "Lopez", currentAge: 22, currJob: hrAssistant, currSpouse: "Kevin")
print("Name: \(p4.firstName) \(p4.lastName), Current Age: \(p4.age), Current Job: \(p4.age), Spouse: \(p4.spouse!)")
print("Name: \(p5.firstName) \(p5.lastName), Current Age: \(p5.age), Current Job: \(p5.age), Spouse: \(p5.spouse!)")

print("Mary Cobb, age: 15, spouse: none")
var p6 = Person(fName: "Mary", lName: "Cobb", currentAge: 15, currJob: hrAssistant, currSpouse: "none")

print("")

print("Test Cases - Family")
var famArray1 = [p1, p2, p3]
var newFam1 = Family(members: famArray1)

print("Family Members;")
for var i = 0;  i < famArray1.count; i++ {
    print("\(famArray1[i].firstName) \(famArray1[i].lastName), Age: \(famArray1[i].age),  Job Title: \(famArray1[i].job!.jobTitle), Salary: \(famArray1[i].job!.jobSalary) ")
}

print("Total Household Income \(newFam!.householdIncome())")
print("Added new child - Mary Cobb")
newFam1?.haveChild("Mary", lastName: "Cobb")




print("")
print("")

