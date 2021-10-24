import 'package:json_annotation/json_annotation.dart';

part 'icon_model.g.dart';

@JsonSerializable()

class IconModel{
   String unicode;
   String style;

  IconModel({this.unicode,this.style});

   factory IconModel.fromJson(Map<String, dynamic> json) => _$IconModelFromJson(json);
   Map<String, dynamic> toJson() => _$IconModelToJson(this);

}