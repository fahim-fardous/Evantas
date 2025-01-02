enum EventType{
  dinner,
  development,
  birthday,
  special;

  String get localizedString{
    switch(this){
      case EventType.dinner:
        return 'Dinner';
      case EventType.development:
        return 'Development';
      case EventType.birthday:
        return 'Birthday';
      case EventType.special:
        return 'Special';
    }
  }
}