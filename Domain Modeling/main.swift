//
//  main.swift
//  Domain Modeling
//
//  Created by Jill Lopez on 10/14/15.
//  Copyright © 2015 Jill Lopez. All rights reserved.
//

import Foundation

//CustomStringConvertible protocol
protocol CustomStringConvertible {
    var description : String { get }
}

//Mathematics protocol
//ensures that the class/struct has addTotal and subTotal
protocol Mathematics {
    mutating func addTotal(newAmount : Money) -> String
    mutating func subTotal(newAmount : Money) -> String
}



///////////////////////////////////////////
/////////////////MONEY////////////////////
///////////////////////////////////////////

//types of currencies
enum Currency {
    case USD
    case GBP
    case EUR
    case CAN
}

//extension of Double
//convert Doubles into a currency
extension Double {
    var USD: Money { return Money(amount: self, currency: .USD)}
    var GBP: Money { return Money(amount: self, currency: .GBP)}
    var EUR: Money { return Money(amount: self, currency: .EUR)}
    var CAN: Money { return Money(amount: self, currency: .CAN)}
}



//money struct contains:
//amount, currencies
//this struct has the ability to convert currencies, add and subtract currencies
struct Money:CustomStringConvertible, Mathematics {
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

    
    //func description adheres to the new protocol for CustomStringConvertable that returns the description for money
    var description : String {
        return ("\(currency)\(amount)")
    }
    
    //func addTotal adheres to the new protocol called mathematics that returns a string total of two Money objects being added together
    func addTotal(var newAmount: Money) -> String {
        if self.currency == newAmount.currency {
            return ("\(self.amount + newAmount.amount)")
        } else {
            newAmount.convert(self.currency)
            let amount = self.amount + newAmount.amount
            return("\(amount) \(newAmount.currency)")
        }
    }
    
    //func subTotal adheres to the new protocol called mathematics that returns a string total of two Money objects being subtracted together
    func subTotal(var newAmount: Money) -> String {
        if self.currency == newAmount.currency {
            return ("\(self.amount - newAmount.amount)")
        } else {
            newAmount.convert(self.currency)
            let amount = self.amount - newAmount.amount
            return("\(amount) \(newAmount.currency)")
        }
    }
    
    //old code
    /*
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
        
    }*/
    
}




///////////////////////////////////////////
///////////////////JOB////////////////////
/////////////////////////////////////////


//an enumdifferent types of salaries
enum SalaryType {
    case HOURLY
    case YEARLY
}

//class job takes in a job title, salary, and salary type
//this function can calculate income, raise
class Job:CustomStringConvertible {
    var jobTitle : String
    var jobSalary : Double
    var salaryType : SalaryType
    
    //initializes Job with title, salary, andt type
    init(title : String, salary: Double, type: SalaryType){
        jobTitle = title
        jobSalary = salary
        salaryType = type
    }
    
    //function to calculate income
    func calculateIncome (numHours : Int?) -> Double {
        if self.salaryType == .HOURLY {
            return (Double(numHours!) * jobSalary)
        } else {
           return self.jobSalary
        }
    }
    
    //function to calculate a raise
    //returns new salary
    func raise (percent : Double) -> Double {
        let rate = percent/100
        return (jobSalary * rate) + jobSalary
    }
    
    //calls the CustomStringConvert protocol
    //prints Job into a string
    var description:String {
        return ("Title: \(jobTitle)  Job Salary: \(jobSalary)   Salary Type: \(salaryType)")
    }
    
}


var businessAnalyst = Job(title: "Business Analyst", salary: 75000, type: SalaryType.YEARLY)
var marketAnalyst = Job(title: "Marketing Analyst", salary: 50000, type: SalaryType.YEARLY)
var hrAssistant = Job(title: "HR Assistant", salary: 12.25, type: SalaryType.HOURLY)



///////////////////////////////////////////
/////////////////PERSON///////////////////
///////////////////////////////////////////

//Person class takes first name, last name, age, job, and spouse
class Person:CustomStringConvertible {
    var firstName : String
    var lastName : String
    var age : Int32
    var job : Job?
    var spouse : String?
    
    //initializer for Person
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
    
    //initializer for first name, last name, and age
    init(fName : String, lName: String, currentAge : Int32){
        self.firstName = fName
        self.lastName = lName
        self.age = currentAge
    }
    
    //prints Person to string
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
    
    //adheres to the CustomStringConvert 
    //prints a string of a person type
    var description : String {
        return ("Name: \(firstName) \(lastName) | Age: \(age) | Job: \(self.job!.description) | Spouse: \(spouse!) ")
    }
    
    
}

var p1 = Person(fName: "Jill", lName: "Lopez", currentAge: 22, currJob: businessAnalyst, currSpouse: "")
var p2 = Person(fName: "Kevin", lName: "Adams", currentAge: 23, currJob: marketAnalyst, currSpouse: "Jill")
var p3 = Person(fName: "Jennifer", lName: "Joe", currentAge: 18, currJob: hrAssistant, currSpouse: "")


///////////////////////////////////////////
/////////////////FAMILY///////////////////
///////////////////////////////////////////

//class for Family that takes in an array of Person
class Family:CustomStringConvertible {
    var familyMembers : [Person] = []
    
    //initializes Family
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
    
    //calculate the household income
    func householdIncome () -> Double {
        var total = 0.0
        for var i = 0; i < familyMembers.count; i++ {
            total += familyMembers[i].job!.calculateIncome(2080)
        }
        return total
    }
    
    //function to add child
    func haveChild(firstName : String, lastName : String) {
        let child = Person(fName: firstName, lName: lastName, currentAge: 0)
        familyMembers.append(child)
        print("New Child name: \(child.firstName) \(child.lastName), age: \(child.age)")
    }
    
    //adhers to the CustomStringConvert
    //prints string of Family
    var description : String {
        var person = ""
        
        for eachMember in familyMembers {
            person += " Name: \(eachMember.firstName) \(eachMember.lastName) | Job: \(eachMember.job!.description) | Age: \(eachMember.age) | Spouse: \(eachMember.spouse!) |"
        }
        
        return person
    }
    
}


var familyArray = [p1, p2, p3]
var newFam = Family(members: familyArray)



print("Test Cases - Money:")
var money = Money(amount: 2.0, currency: Currency.USD)
var money2 = Money(amount: 4.0, currency: Currency.GBP)

/*
print("Money = \(money.amount) \(money.currency)")
print("Money = \(money2.amount) \(money2.currency)")
print("Convert \(money.amount) \(money.currency) to EUR = \(money.convert(Currency.EUR))")
money = Money(amount: 2.0, currency: Currency.USD)
print("Convert \(money.amount) \(money.currency) to GBP = \(money.convert(Currency.GBP))")
money = Money(amount: 2.0, currency: Currency.USD)
print("Convert \(money.amount) \(money.currency) to CAN = \(money.convert(Currency.CAN))")

money = Money(amount: 2.0, currency: Currency.USD)

//print("Add \(money.amount) \(money.currency) + \(money2.amount) \(money2.currency) = \(money.add(money2))")

money = Money(amount: 4.0, currency: Currency.USD)
money2 = Money(amount: 1.0, currency: Currency.GBP)
//print("Add \(money.amount) \(money.currency)  \(money2.amount) \(money2.currency) = \(money.sub(money2))")*/

print("Protocol CustomStringConvert case: " + money.description)
print("Protocol CustomStringConvert case: " + money2.description)
print("Protocol Mathematics Add case: " + money.addTotal(money2))
print("Protocol Mathematics Subtract case: " + money2.subTotal(money))
print("Extension Double case: " + 10.0.USD.description)
print("Extension Double case: " + 10.0.EUR.description)
print("Extension Double case: " + 10.0.GBP.description)
print("Extension Double case: " + 10.0.CAN.description)

print("")

print("Test Cases - Job")
/*print("Job: \(businessAnalyst.jobTitle), Job Salary: $\(businessAnalyst.jobSalary), Salary Type: \(businessAnalyst.salaryType)")
print("Job: \(marketAnalyst.jobTitle), Job Salary: $\(marketAnalyst.jobSalary), Salary Type: \(marketAnalyst.salaryType)")
print("Job: \(hrAssistant.jobTitle), Job Salary: \(hrAssistant.jobSalary), Salary Type: \(hrAssistant.salaryType)")

print("Calculate Income for Marketing Analyst: $\(marketAnalyst.calculateIncome(0))")
print("Calculate Income for HR Assistant with 40 hours of work: $\(hrAssistant.calculateIncome(40))")

print("Calculate 2.5% raise for Business Analyst: $\(businessAnalyst.raise(2.5))")
print("Calculate 2.5% raise for HR Assistant: $\(hrAssistant.raise(2.5))")*/

print("Protocol CustomStringConvert case: " + marketAnalyst.description)
print("Protocol CustomStringConvert case: " + businessAnalyst.description)
print("Protocol CustomStringConvert case: " + hrAssistant.description)

print("")


print("Test Cases - Person")
var p4 = Person(fName: "Kevin", lName: "Adams", currentAge: 23, currJob: marketAnalyst, currSpouse: "Jill")
var p5 = Person(fName: "Jill", lName: "Lopez", currentAge: 22, currJob: hrAssistant, currSpouse: "Kevin")
/*
print("Name: \(p4.firstName) \(p4.lastName), Current Age: \(p4.age), Current Job: \(p4.age), Spouse: \(p4.spouse!)")
print("Name: \(p5.firstName) \(p5.lastName), Current Age: \(p5.age), Current Job: \(p5.age), Spouse: \(p5.spouse!)")

print("Mary Cobb, age: 15, spouse: none")
var p6 = Person(fName: "Mary", lName: "Cobb", currentAge: 15, currJob: hrAssistant, currSpouse: "none")*/

print("Protocol CustomStringConvert case: " + p4.description)
print("Protocol CustomStringConvert case: " + p5.description)

print("")

print("Test Cases - Family")
var famArray1 = [p1, p2, p3]
var newFam1 = Family(members: famArray1)

/*print("Family Members:")
for var i = 0;  i < famArray1.count; i++ {
    print("\(famArray1[i].firstName) \(famArray1[i].lastName), Age: \(famArray1[i].age),  Job Title: \(famArray1[i].job!.jobTitle), Salary: \(famArray1[i].job!.jobSalary) ")
}

print("Total Household Income \(newFam!.householdIncome())")
print("Added new child - Mary Cobb")
newFam1?.haveChild("Mary", lastName: "Cobb")*/

print("Protocol CustomStringConvert case: " + newFam1!.description)

print("")
print("")

