//
//  main.swift
//  Domain Modeling
//
//  Created by Jill Lopez on 10/14/15.
//  Copyright © 2015 Jill Lopez. All rights reserved.
//

import Foundation


/////////////MONEY//////////////////


struct Money {
    var amount = 0.0
    var currency = ""
    
    mutating func currency (currCurrency : String) {
        if currCurrency == "USD" || currCurrency == "EUR" || currCurrency == "GBP" || currCurrency == "CAN" {
                currency = currCurrency
        } else {
            print ("Current currency \(currCurrency) is not of USD, EUR, GBP, or CAN type")
        }
        
    }

    func convertCurrency (amt : Double, convertTo : String) -> Double {
        switch self.currency {
            case "USD":
                if convertTo == "GBP" {
                    return (amt * 0.5)
                }
                
                if convertTo == "EUR" {
                    return (amt * 1.5)
                }
                
                if convertTo == "CAN" {
                    return (amt * 1.25)
                }
            case "GBP":
                if convertTo == "USD" {
                    return (amt * 2)
                }
                
                if convertTo == "EUR" {
                    return (amt * 2)
                }
                
                if convertTo == "CAN" {
                    return (amt * 2.50)
            }
            case "EUR":
                if convertTo == "USD" {
                    return (amt * 0.66)
                }
                
                if convertTo == "GBP" {
                    return (amt * 0.33)
                }
                
                if convertTo == "CAN" {
                    return (amt * 0.83)
            }
            case "CAN":
                if convertTo == "USD" {
                    return (amt * 0.80)
                }
                
                if convertTo == "GBP" {
                    return (amt * 0.4)
                }
                
                if convertTo == "EUR" {
                    return (amt * 1.2)
            }
            default:
                return -0.0
        }
        return -0.00
    }
    
    func add(value : Double , curr : String) -> Double {
        if self.currency == curr {
            return self.amount + value
        } else if self.currency != curr {
            let newAmt = convertCurrency(value, convertTo: curr)
            return self.amount + newAmt
        }
        return 0.0
    }
    
    func subtract(value : Double , curr : String) -> Double {
        if self.currency == curr {
            return self.amount - value
        } else if self.currency != curr {
            let newAmt = convertCurrency(value, convertTo: curr)
            return self.amount - newAmt
        }
        return 0.0
    }
    
}


var money = Money()



//////////JOB//////////

enum JobTitle {
    case BusinessAnalyst
    case MarketingAnalyst
    case HRAssistant
}

class Job {
    var jobTitle = ""
    var jobSalary = 0
    var salaryType = ""
    
    
    init(title : String, salary: Int, type: String){
        jobTitle = title
        jobSalary = salary
        salaryType = type
    }
    
    func calculateIncome (numHours : Int) -> Int {
        if self.salaryType == "Hour" || self.salaryType == "hour"{
            return (numHours * jobSalary)
        } else {
           return self.jobSalary
        }
    }
    
    func raise (percent : Double) -> Double {
        return (Double(jobSalary) * percent)
    }
    
}



var businessAnalyst = Job(title: "Business Analyst", salary: 75000, type: "year")
var marketAnalyst = Job(title: "Marketing Analyst", salary: 50000, type: "year")
var hrAssistant = Job(title: "HR Assistant", salary: 12, type: "hour")




//////////PERSON////////////

class Person {
    var firstName : String
    var lastName : String
    var age : Int32
    var job :  Job?
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
    
    func householdIncome () -> Int{
        var total = 0
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

print(newFam!.householdIncome())
newFam!.haveChild("Aleyna", lastName: "Yamaguchi")
