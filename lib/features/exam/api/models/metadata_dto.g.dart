// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataDTO _$MetadataDTOFromJson(Map<String, dynamic> json) => MetadataDTO(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataDTOToJson(MetadataDTO instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
    };
