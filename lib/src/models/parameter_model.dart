class ParameterModel {
  String name;
  int id;
  String createdAt;
  dynamic field;

  ParameterModel(this.id, this.createdAt, this.field);

  ParameterModel.create(
      String parameterName, int entryId, String createdTime, dynamic value) {
    name = parameterName;
    id = entryId;
    createdAt = createdTime;
    field = value;
  }
}
