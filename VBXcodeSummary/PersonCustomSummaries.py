import lldb
import datetime

def person_summary(valueObject, dictionary):
    dobAsString = valueObject.GetChildMemberWithName('_dateOfBirth').GetSummary()
    first_name = valueObject.GetChildMemberWithName('_firstName').GetSummary().replace("@","").replace("\"","")
    last_name = valueObject.GetChildMemberWithName('_lastName').GetSummary().replace("@","").replace("\"","")

    name = " ".join([first_name, last_name])
    
    dob = datetime.datetime.strptime(dobAsString,"%Y-%m-%d %H:%M:%S %Z")
    now = datetime.datetime.now()
    delta = now-dob

    summary = "name: %(name)s age: %(age)d" % {"age":int((delta.days)/365.25), "name":name}
    
    return summary

def __lldb_init_module(debugger, dict):
    debugger.HandleCommand('type summary add VBPerson -F PersonCustomSummaries.person_summary')