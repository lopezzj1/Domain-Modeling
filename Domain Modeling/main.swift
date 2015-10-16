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
        
        return ("New amount: \(self.amount) \(currency)")
    }
    
    //returns the new total after adding the two currencies
    //if the currencies are different, the default is the first currency type
    mutating func add(var newAmount : Money) -> String{
        if self.currency == newAmount.currency {
            return ("New amount \(self.amount) \(self.currency) + \(newAmount.amount) \(newAmount.currency) = \(self.amount + newAmount.amount)")
        } else {
            print("New amount is \(self.amount) \(self.currency) + \(newAmount.amount) \(newAmount.currency) =")
            newAmount.convert(self.currency)
            let amount = self.amount + newAmount.amount
            return("\t \(amount) \(newAmount.currency)")
        }
        
    }

    //returns the new total after subtracting the two currencies
    //if the currencies are different, the default is the first currency type
    mutating func sub(var newAmount : Money) -> String{
        if self.currency == newAmount.currency {
            return ("New amount \(self.amount) \(self.currency) + \(newAmount.amount) \(newAmount.currency) = \(self.amount - newAmount.amount)")
        } else {
            print("New amount is \(self.amount) \(self.currency) + \(newAmount.amount) \(newAmount.currency) =")
            newAmount.convert(self.currency)
            let amount = self.amount - newAmount.amount
            return("\t \(amount) \(newAmount.currency)")
        }
        
    }
    
}


var money = Money(amount: 1.0, currency: Currency.USD)

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

print(businessAnalyst.raise(2.5))



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
            print("You cannot have a job under the age of 16")
        }
        
        if age >= 18 {
            spouse = currSpouse
        } else if age < 18 {
            spouse = nil
            print("You cannot be married under the age of 18")
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
        familyMembers.append(Person(fName: firstName, lName: lastName, currentAge: 0))
    }
    
}



var familyArray = [p1, p2, p3]
var newFam = Family(members: familyArray)

//print(newFam!.householdIncome())
newFam!.haveChild("Aleyna", lastName: "Yamaguchi")

print("")
print("")
