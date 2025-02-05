import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';

extension EventTypeExt on EventType {
  String getName(){
    switch(this){
      case EventType.dinner:
        return 'Dinner';
      case EventType.development:
        return 'Development';
      case EventType.birthday:
        return 'Birthday';
      case EventType.special:
        return 'Special';
      default:
        return 'Unknown';
    }
  }

  String getColor(){
    switch(this){
      case EventType.dinner:
        return '#FF0000';
      case EventType.development:
        return '#0000FF';
      case EventType.birthday:
        return '#00FF00';
      case EventType.special:
        return '#FF00FF';
      default:
        return '#000000';
    }
  }

  String getAssetName(){
    switch(this){
      case EventType.dinner:
        return 'team_dinner.jpg';
      case EventType.development:
        return 'development.jpg';
      case EventType.birthday:
        return 'birthday.jpeg';
      case EventType.special:
        return 'special_event.jpg';
      default:
        return 'team_dinner.jpg';
    }
  }

  IconData getEventIcon() {
    switch (this) {
      case EventType.dinner:
        return Icons.restaurant;
      case EventType.development:
        return Icons.code;
      case EventType.birthday:
        return Icons.cake;
      case EventType.special:
        return Icons.event;
      default:
        return Icons.question_mark;
    }
  }

  int getEventIndex() {
    switch (this) {
      case EventType.dinner:
        return 0;
      case EventType.development:
        return 1;
      case EventType.birthday:
        return 2;
      case EventType.special:
        return 3;
      default:
        return 4;
    }
  }
}