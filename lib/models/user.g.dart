// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 6;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      email: fields[0] as String,
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      gender: fields[3] as String,
      nationality: fields[4] as String,
      city: fields[5] as String,
      address: fields[6] as String,
      job: fields[7] as String,
      birthDate: fields[8] as DateTime,
      civilIdNo: fields[9] as String,
      civilIdNoExp: fields[10] as String,
      wifeCount: fields[11] as int,
      childrenNumber: fields[12] as int,
      height: fields[13] as double,
      weight: fields[14] as double,
      socialStatus: fields[15] as String,
      educationalStatus: fields[16] as String,
      more: fields[17] as dynamic,
      isBlock: fields[18] as bool,
      token: fields[20] as String,
      fcm: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.nationality)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.job)
      ..writeByte(8)
      ..write(obj.birthDate)
      ..writeByte(9)
      ..write(obj.civilIdNo)
      ..writeByte(10)
      ..write(obj.civilIdNoExp)
      ..writeByte(11)
      ..write(obj.wifeCount)
      ..writeByte(12)
      ..write(obj.childrenNumber)
      ..writeByte(13)
      ..write(obj.height)
      ..writeByte(14)
      ..write(obj.weight)
      ..writeByte(15)
      ..write(obj.socialStatus)
      ..writeByte(16)
      ..write(obj.educationalStatus)
      ..writeByte(17)
      ..write(obj.more)
      ..writeByte(18)
      ..write(obj.isBlock)
      ..writeByte(19)
      ..write(obj.fcm)
      ..writeByte(20)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
