enum GenderPerson { 
  male, 
  female,
  other
}

String? toMapEnumGenderPerson(GenderPerson? genderPerson){
  if(genderPerson == null){
    return null;
  }
  else if(genderPerson == GenderPerson.male){
    return 'Male';
  }
  else if(genderPerson == GenderPerson.female){
    return 'Female';
  }
  else{
    return 'Other';
  }
}

GenderPerson fromMapEnumGenderPerson(String genderPerson){
  if(genderPerson == 'Male'){
    return GenderPerson.male;
  }
  else if(genderPerson == 'Female'){
    return GenderPerson.female;
  }
  else{
    return GenderPerson.other;
  }
}

getGenderValue(GenderPerson gender, controller){
    if(gender == GenderPerson.male){
      return 'Masculino';
    }
    else if(gender == GenderPerson.female){
      return 'Feminino';
    }
    else if(gender == GenderPerson.other){
      return controller.text;
    }
  }