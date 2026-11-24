// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $RawNotificationsTable extends RawNotifications with TableInfo<$RawNotificationsTable, RawNotification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _packageMeta = const VerificationMeta('package');
  @override
  late final GeneratedColumn<String> package = GeneratedColumn<String>(
    'package',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postedAtMeta = const VerificationMeta('postedAt');
  @override
  late final GeneratedColumn<DateTime> postedAt = GeneratedColumn<DateTime>(
    'posted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawHashMeta = const VerificationMeta('rawHash');
  @override
  late final GeneratedColumn<String> rawHash = GeneratedColumn<String>(
    'raw_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _parsedMeta = const VerificationMeta('parsed');
  @override
  late final GeneratedColumn<bool> parsed = GeneratedColumn<bool>(
    'parsed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("parsed" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, package, title, body, postedAt, rawHash, parsed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_notifications';
  @override
  VerificationContext validateIntegrity(Insertable<RawNotification> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('package')) {
      context.handle(_packageMeta, package.isAcceptableOrUnknown(data['package']!, _packageMeta));
    } else if (isInserting) {
      context.missing(_packageMeta);
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(_bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('posted_at')) {
      context.handle(_postedAtMeta, postedAt.isAcceptableOrUnknown(data['posted_at']!, _postedAtMeta));
    } else if (isInserting) {
      context.missing(_postedAtMeta);
    }
    if (data.containsKey('raw_hash')) {
      context.handle(_rawHashMeta, rawHash.isAcceptableOrUnknown(data['raw_hash']!, _rawHashMeta));
    } else if (isInserting) {
      context.missing(_rawHashMeta);
    }
    if (data.containsKey('parsed')) {
      context.handle(_parsedMeta, parsed.isAcceptableOrUnknown(data['parsed']!, _parsedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawNotification(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      package: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}package'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      postedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}posted_at'])!,
      rawHash: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}raw_hash'])!,
      parsed: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}parsed'])!,
    );
  }

  @override
  $RawNotificationsTable createAlias(String alias) {
    return $RawNotificationsTable(attachedDatabase, alias);
  }
}

class RawNotification extends DataClass implements Insertable<RawNotification> {
  final int id;
  final String package;
  final String title;
  final String body;
  final DateTime postedAt;
  final String rawHash;
  final bool parsed;
  const RawNotification({
    required this.id,
    required this.package,
    required this.title,
    required this.body,
    required this.postedAt,
    required this.rawHash,
    required this.parsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['package'] = Variable<String>(package);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['posted_at'] = Variable<DateTime>(postedAt);
    map['raw_hash'] = Variable<String>(rawHash);
    map['parsed'] = Variable<bool>(parsed);
    return map;
  }

  RawNotificationsCompanion toCompanion(bool nullToAbsent) {
    return RawNotificationsCompanion(
      id: Value(id),
      package: Value(package),
      title: Value(title),
      body: Value(body),
      postedAt: Value(postedAt),
      rawHash: Value(rawHash),
      parsed: Value(parsed),
    );
  }

  factory RawNotification.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawNotification(
      id: serializer.fromJson<int>(json['id']),
      package: serializer.fromJson<String>(json['package']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      postedAt: serializer.fromJson<DateTime>(json['postedAt']),
      rawHash: serializer.fromJson<String>(json['rawHash']),
      parsed: serializer.fromJson<bool>(json['parsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'package': serializer.toJson<String>(package),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'postedAt': serializer.toJson<DateTime>(postedAt),
      'rawHash': serializer.toJson<String>(rawHash),
      'parsed': serializer.toJson<bool>(parsed),
    };
  }

  RawNotification copyWith({
    int? id,
    String? package,
    String? title,
    String? body,
    DateTime? postedAt,
    String? rawHash,
    bool? parsed,
  }) => RawNotification(
    id: id ?? this.id,
    package: package ?? this.package,
    title: title ?? this.title,
    body: body ?? this.body,
    postedAt: postedAt ?? this.postedAt,
    rawHash: rawHash ?? this.rawHash,
    parsed: parsed ?? this.parsed,
  );
  RawNotification copyWithCompanion(RawNotificationsCompanion data) {
    return RawNotification(
      id: data.id.present ? data.id.value : this.id,
      package: data.package.present ? data.package.value : this.package,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      postedAt: data.postedAt.present ? data.postedAt.value : this.postedAt,
      rawHash: data.rawHash.present ? data.rawHash.value : this.rawHash,
      parsed: data.parsed.present ? data.parsed.value : this.parsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawNotification(')
          ..write('id: $id, ')
          ..write('package: $package, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('postedAt: $postedAt, ')
          ..write('rawHash: $rawHash, ')
          ..write('parsed: $parsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, package, title, body, postedAt, rawHash, parsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawNotification &&
          other.id == this.id &&
          other.package == this.package &&
          other.title == this.title &&
          other.body == this.body &&
          other.postedAt == this.postedAt &&
          other.rawHash == this.rawHash &&
          other.parsed == this.parsed);
}

class RawNotificationsCompanion extends UpdateCompanion<RawNotification> {
  final Value<int> id;
  final Value<String> package;
  final Value<String> title;
  final Value<String> body;
  final Value<DateTime> postedAt;
  final Value<String> rawHash;
  final Value<bool> parsed;
  const RawNotificationsCompanion({
    this.id = const Value.absent(),
    this.package = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.postedAt = const Value.absent(),
    this.rawHash = const Value.absent(),
    this.parsed = const Value.absent(),
  });
  RawNotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String package,
    required String title,
    required String body,
    required DateTime postedAt,
    required String rawHash,
    this.parsed = const Value.absent(),
  }) : package = Value(package),
       title = Value(title),
       body = Value(body),
       postedAt = Value(postedAt),
       rawHash = Value(rawHash);
  static Insertable<RawNotification> custom({
    Expression<int>? id,
    Expression<String>? package,
    Expression<String>? title,
    Expression<String>? body,
    Expression<DateTime>? postedAt,
    Expression<String>? rawHash,
    Expression<bool>? parsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (package != null) 'package': package,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (postedAt != null) 'posted_at': postedAt,
      if (rawHash != null) 'raw_hash': rawHash,
      if (parsed != null) 'parsed': parsed,
    });
  }

  RawNotificationsCompanion copyWith({
    Value<int>? id,
    Value<String>? package,
    Value<String>? title,
    Value<String>? body,
    Value<DateTime>? postedAt,
    Value<String>? rawHash,
    Value<bool>? parsed,
  }) {
    return RawNotificationsCompanion(
      id: id ?? this.id,
      package: package ?? this.package,
      title: title ?? this.title,
      body: body ?? this.body,
      postedAt: postedAt ?? this.postedAt,
      rawHash: rawHash ?? this.rawHash,
      parsed: parsed ?? this.parsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (package.present) {
      map['package'] = Variable<String>(package.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (postedAt.present) {
      map['posted_at'] = Variable<DateTime>(postedAt.value);
    }
    if (rawHash.present) {
      map['raw_hash'] = Variable<String>(rawHash.value);
    }
    if (parsed.present) {
      map['parsed'] = Variable<bool>(parsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RawNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('package: $package, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('postedAt: $postedAt, ')
          ..write('rawHash: $rawHash, ')
          ..write('parsed: $parsed')
          ..write(')'))
        .toString();
  }
}

class $BankEventsTable extends BankEvents with TableInfo<$BankEventsTable, BankEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _rawHashMeta = const VerificationMeta('rawHash');
  @override
  late final GeneratedColumn<String> rawHash = GeneratedColumn<String>(
    'raw_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _bankMeta = const VerificationMeta('bank');
  @override
  late final GeneratedColumn<String> bank = GeneratedColumn<String>(
    'bank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountKoboMeta = const VerificationMeta('amountKobo');
  @override
  late final GeneratedColumn<int> amountKobo = GeneratedColumn<int>(
    'amount_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _counterpartyMeta = const VerificationMeta('counterparty');
  @override
  late final GeneratedColumn<String> counterparty = GeneratedColumn<String>(
    'counterparty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _narrationMeta = const VerificationMeta('narration');
  @override
  late final GeneratedColumn<String> narration = GeneratedColumn<String>(
    'narration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parserMeta = const VerificationMeta('parser');
  @override
  late final GeneratedColumn<String> parser = GeneratedColumn<String>(
    'parser',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('template'),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawHash,
    bank,
    direction,
    amountKobo,
    counterparty,
    narration,
    sessionId,
    occurredAt,
    parser,
    confidence,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_events';
  @override
  VerificationContext validateIntegrity(Insertable<BankEvent> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_hash')) {
      context.handle(_rawHashMeta, rawHash.isAcceptableOrUnknown(data['raw_hash']!, _rawHashMeta));
    } else if (isInserting) {
      context.missing(_rawHashMeta);
    }
    if (data.containsKey('bank')) {
      context.handle(_bankMeta, bank.isAcceptableOrUnknown(data['bank']!, _bankMeta));
    } else if (isInserting) {
      context.missing(_bankMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta, direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('amount_kobo')) {
      context.handle(_amountKoboMeta, amountKobo.isAcceptableOrUnknown(data['amount_kobo']!, _amountKoboMeta));
    } else if (isInserting) {
      context.missing(_amountKoboMeta);
    }
    if (data.containsKey('counterparty')) {
      context.handle(_counterpartyMeta, counterparty.isAcceptableOrUnknown(data['counterparty']!, _counterpartyMeta));
    }
    if (data.containsKey('narration')) {
      context.handle(_narrationMeta, narration.isAcceptableOrUnknown(data['narration']!, _narrationMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta, sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    }
    if (data.containsKey('occurred_at')) {
      context.handle(_occurredAtMeta, occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('parser')) {
      context.handle(_parserMeta, parser.isAcceptableOrUnknown(data['parser']!, _parserMeta));
    }
    if (data.containsKey('confidence')) {
      context.handle(_confidenceMeta, confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta));
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankEvent(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rawHash: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}raw_hash'])!,
      bank: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}bank'])!,
      direction: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}direction'])!,
      amountKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_kobo'])!,
      counterparty: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}counterparty']),
      narration: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}narration']),
      sessionId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}session_id']),
      occurredAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      parser: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}parser'])!,
      confidence: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
    );
  }

  @override
  $BankEventsTable createAlias(String alias) {
    return $BankEventsTable(attachedDatabase, alias);
  }
}

class BankEvent extends DataClass implements Insertable<BankEvent> {
  final int id;
  final String rawHash;
  final String bank;
  final String direction;
  final int amountKobo;
  final String? counterparty;
  final String? narration;
  final String? sessionId;
  final DateTime occurredAt;
  final String parser;
  final double confidence;
  const BankEvent({
    required this.id,
    required this.rawHash,
    required this.bank,
    required this.direction,
    required this.amountKobo,
    this.counterparty,
    this.narration,
    this.sessionId,
    required this.occurredAt,
    required this.parser,
    required this.confidence,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_hash'] = Variable<String>(rawHash);
    map['bank'] = Variable<String>(bank);
    map['direction'] = Variable<String>(direction);
    map['amount_kobo'] = Variable<int>(amountKobo);
    if (!nullToAbsent || counterparty != null) {
      map['counterparty'] = Variable<String>(counterparty);
    }
    if (!nullToAbsent || narration != null) {
      map['narration'] = Variable<String>(narration);
    }
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['parser'] = Variable<String>(parser);
    map['confidence'] = Variable<double>(confidence);
    return map;
  }

  BankEventsCompanion toCompanion(bool nullToAbsent) {
    return BankEventsCompanion(
      id: Value(id),
      rawHash: Value(rawHash),
      bank: Value(bank),
      direction: Value(direction),
      amountKobo: Value(amountKobo),
      counterparty: counterparty == null && nullToAbsent ? const Value.absent() : Value(counterparty),
      narration: narration == null && nullToAbsent ? const Value.absent() : Value(narration),
      sessionId: sessionId == null && nullToAbsent ? const Value.absent() : Value(sessionId),
      occurredAt: Value(occurredAt),
      parser: Value(parser),
      confidence: Value(confidence),
    );
  }

  factory BankEvent.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankEvent(
      id: serializer.fromJson<int>(json['id']),
      rawHash: serializer.fromJson<String>(json['rawHash']),
      bank: serializer.fromJson<String>(json['bank']),
      direction: serializer.fromJson<String>(json['direction']),
      amountKobo: serializer.fromJson<int>(json['amountKobo']),
      counterparty: serializer.fromJson<String?>(json['counterparty']),
      narration: serializer.fromJson<String?>(json['narration']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      parser: serializer.fromJson<String>(json['parser']),
      confidence: serializer.fromJson<double>(json['confidence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawHash': serializer.toJson<String>(rawHash),
      'bank': serializer.toJson<String>(bank),
      'direction': serializer.toJson<String>(direction),
      'amountKobo': serializer.toJson<int>(amountKobo),
      'counterparty': serializer.toJson<String?>(counterparty),
      'narration': serializer.toJson<String?>(narration),
      'sessionId': serializer.toJson<String?>(sessionId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'parser': serializer.toJson<String>(parser),
      'confidence': serializer.toJson<double>(confidence),
    };
  }

  BankEvent copyWith({
    int? id,
    String? rawHash,
    String? bank,
    String? direction,
    int? amountKobo,
    Value<String?> counterparty = const Value.absent(),
    Value<String?> narration = const Value.absent(),
    Value<String?> sessionId = const Value.absent(),
    DateTime? occurredAt,
    String? parser,
    double? confidence,
  }) => BankEvent(
    id: id ?? this.id,
    rawHash: rawHash ?? this.rawHash,
    bank: bank ?? this.bank,
    direction: direction ?? this.direction,
    amountKobo: amountKobo ?? this.amountKobo,
    counterparty: counterparty.present ? counterparty.value : this.counterparty,
    narration: narration.present ? narration.value : this.narration,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    occurredAt: occurredAt ?? this.occurredAt,
    parser: parser ?? this.parser,
    confidence: confidence ?? this.confidence,
  );
  BankEvent copyWithCompanion(BankEventsCompanion data) {
    return BankEvent(
      id: data.id.present ? data.id.value : this.id,
      rawHash: data.rawHash.present ? data.rawHash.value : this.rawHash,
      bank: data.bank.present ? data.bank.value : this.bank,
      direction: data.direction.present ? data.direction.value : this.direction,
      amountKobo: data.amountKobo.present ? data.amountKobo.value : this.amountKobo,
      counterparty: data.counterparty.present ? data.counterparty.value : this.counterparty,
      narration: data.narration.present ? data.narration.value : this.narration,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      occurredAt: data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      parser: data.parser.present ? data.parser.value : this.parser,
      confidence: data.confidence.present ? data.confidence.value : this.confidence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankEvent(')
          ..write('id: $id, ')
          ..write('rawHash: $rawHash, ')
          ..write('bank: $bank, ')
          ..write('direction: $direction, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('counterparty: $counterparty, ')
          ..write('narration: $narration, ')
          ..write('sessionId: $sessionId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('parser: $parser, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawHash,
    bank,
    direction,
    amountKobo,
    counterparty,
    narration,
    sessionId,
    occurredAt,
    parser,
    confidence,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankEvent &&
          other.id == this.id &&
          other.rawHash == this.rawHash &&
          other.bank == this.bank &&
          other.direction == this.direction &&
          other.amountKobo == this.amountKobo &&
          other.counterparty == this.counterparty &&
          other.narration == this.narration &&
          other.sessionId == this.sessionId &&
          other.occurredAt == this.occurredAt &&
          other.parser == this.parser &&
          other.confidence == this.confidence);
}

class BankEventsCompanion extends UpdateCompanion<BankEvent> {
  final Value<int> id;
  final Value<String> rawHash;
  final Value<String> bank;
  final Value<String> direction;
  final Value<int> amountKobo;
  final Value<String?> counterparty;
  final Value<String?> narration;
  final Value<String?> sessionId;
  final Value<DateTime> occurredAt;
  final Value<String> parser;
  final Value<double> confidence;
  const BankEventsCompanion({
    this.id = const Value.absent(),
    this.rawHash = const Value.absent(),
    this.bank = const Value.absent(),
    this.direction = const Value.absent(),
    this.amountKobo = const Value.absent(),
    this.counterparty = const Value.absent(),
    this.narration = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.parser = const Value.absent(),
    this.confidence = const Value.absent(),
  });
  BankEventsCompanion.insert({
    this.id = const Value.absent(),
    required String rawHash,
    required String bank,
    required String direction,
    required int amountKobo,
    this.counterparty = const Value.absent(),
    this.narration = const Value.absent(),
    this.sessionId = const Value.absent(),
    required DateTime occurredAt,
    this.parser = const Value.absent(),
    required double confidence,
  }) : rawHash = Value(rawHash),
       bank = Value(bank),
       direction = Value(direction),
       amountKobo = Value(amountKobo),
       occurredAt = Value(occurredAt),
       confidence = Value(confidence);
  static Insertable<BankEvent> custom({
    Expression<int>? id,
    Expression<String>? rawHash,
    Expression<String>? bank,
    Expression<String>? direction,
    Expression<int>? amountKobo,
    Expression<String>? counterparty,
    Expression<String>? narration,
    Expression<String>? sessionId,
    Expression<DateTime>? occurredAt,
    Expression<String>? parser,
    Expression<double>? confidence,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawHash != null) 'raw_hash': rawHash,
      if (bank != null) 'bank': bank,
      if (direction != null) 'direction': direction,
      if (amountKobo != null) 'amount_kobo': amountKobo,
      if (counterparty != null) 'counterparty': counterparty,
      if (narration != null) 'narration': narration,
      if (sessionId != null) 'session_id': sessionId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (parser != null) 'parser': parser,
      if (confidence != null) 'confidence': confidence,
    });
  }

  BankEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? rawHash,
    Value<String>? bank,
    Value<String>? direction,
    Value<int>? amountKobo,
    Value<String?>? counterparty,
    Value<String?>? narration,
    Value<String?>? sessionId,
    Value<DateTime>? occurredAt,
    Value<String>? parser,
    Value<double>? confidence,
  }) {
    return BankEventsCompanion(
      id: id ?? this.id,
      rawHash: rawHash ?? this.rawHash,
      bank: bank ?? this.bank,
      direction: direction ?? this.direction,
      amountKobo: amountKobo ?? this.amountKobo,
      counterparty: counterparty ?? this.counterparty,
      narration: narration ?? this.narration,
      sessionId: sessionId ?? this.sessionId,
      occurredAt: occurredAt ?? this.occurredAt,
      parser: parser ?? this.parser,
      confidence: confidence ?? this.confidence,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawHash.present) {
      map['raw_hash'] = Variable<String>(rawHash.value);
    }
    if (bank.present) {
      map['bank'] = Variable<String>(bank.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (amountKobo.present) {
      map['amount_kobo'] = Variable<int>(amountKobo.value);
    }
    if (counterparty.present) {
      map['counterparty'] = Variable<String>(counterparty.value);
    }
    if (narration.present) {
      map['narration'] = Variable<String>(narration.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (parser.present) {
      map['parser'] = Variable<String>(parser.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankEventsCompanion(')
          ..write('id: $id, ')
          ..write('rawHash: $rawHash, ')
          ..write('bank: $bank, ')
          ..write('direction: $direction, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('counterparty: $counterparty, ')
          ..write('narration: $narration, ')
          ..write('sessionId: $sessionId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('parser: $parser, ')
          ..write('confidence: $confidence')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aliasesMeta = const VerificationMeta('aliases');
  @override
  late final GeneratedColumn<String> aliases = GeneratedColumn<String>(
    'aliases',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sellPriceKoboMeta = const VerificationMeta('sellPriceKobo');
  @override
  late final GeneratedColumn<int> sellPriceKobo = GeneratedColumn<int>(
    'sell_price_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCostKoboMeta = const VerificationMeta('avgCostKobo');
  @override
  late final GeneratedColumn<int> avgCostKobo = GeneratedColumn<int>(
    'avg_cost_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyOnHandMeta = const VerificationMeta('qtyOnHand');
  @override
  late final GeneratedColumn<int> qtyOnHand = GeneratedColumn<int>(
    'qty_on_hand',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lowStockThresholdMeta = const VerificationMeta('lowStockThreshold');
  @override
  late final GeneratedColumn<int> lowStockThreshold = GeneratedColumn<int>(
    'low_stock_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    aliases,
    sellPriceKobo,
    avgCostKobo,
    qtyOnHand,
    lowStockThreshold,
    active,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('aliases')) {
      context.handle(_aliasesMeta, aliases.isAcceptableOrUnknown(data['aliases']!, _aliasesMeta));
    }
    if (data.containsKey('sell_price_kobo')) {
      context.handle(
        _sellPriceKoboMeta,
        sellPriceKobo.isAcceptableOrUnknown(data['sell_price_kobo']!, _sellPriceKoboMeta),
      );
    } else if (isInserting) {
      context.missing(_sellPriceKoboMeta);
    }
    if (data.containsKey('avg_cost_kobo')) {
      context.handle(_avgCostKoboMeta, avgCostKobo.isAcceptableOrUnknown(data['avg_cost_kobo']!, _avgCostKoboMeta));
    } else if (isInserting) {
      context.missing(_avgCostKoboMeta);
    }
    if (data.containsKey('qty_on_hand')) {
      context.handle(_qtyOnHandMeta, qtyOnHand.isAcceptableOrUnknown(data['qty_on_hand']!, _qtyOnHandMeta));
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
        _lowStockThresholdMeta,
        lowStockThreshold.isAcceptableOrUnknown(data['low_stock_threshold']!, _lowStockThresholdMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      aliases: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}aliases'])!,
      sellPriceKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sell_price_kobo'])!,
      avgCostKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}avg_cost_kobo'])!,
      qtyOnHand: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty_on_hand'])!,
      lowStockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_stock_threshold'],
      )!,
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;

  /// Other words buyers use for it, comma-separated ("gown, ankara, the blue gown").
  final String aliases;
  final int sellPriceKobo;

  /// Moving average of what each unit cost you; updated on restock.
  final int avgCostKobo;
  final int qtyOnHand;
  final int lowStockThreshold;
  final bool active;
  final DateTime createdAt;
  const Product({
    required this.id,
    required this.name,
    required this.aliases,
    required this.sellPriceKobo,
    required this.avgCostKobo,
    required this.qtyOnHand,
    required this.lowStockThreshold,
    required this.active,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['aliases'] = Variable<String>(aliases);
    map['sell_price_kobo'] = Variable<int>(sellPriceKobo);
    map['avg_cost_kobo'] = Variable<int>(avgCostKobo);
    map['qty_on_hand'] = Variable<int>(qtyOnHand);
    map['low_stock_threshold'] = Variable<int>(lowStockThreshold);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      aliases: Value(aliases),
      sellPriceKobo: Value(sellPriceKobo),
      avgCostKobo: Value(avgCostKobo),
      qtyOnHand: Value(qtyOnHand),
      lowStockThreshold: Value(lowStockThreshold),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      aliases: serializer.fromJson<String>(json['aliases']),
      sellPriceKobo: serializer.fromJson<int>(json['sellPriceKobo']),
      avgCostKobo: serializer.fromJson<int>(json['avgCostKobo']),
      qtyOnHand: serializer.fromJson<int>(json['qtyOnHand']),
      lowStockThreshold: serializer.fromJson<int>(json['lowStockThreshold']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'aliases': serializer.toJson<String>(aliases),
      'sellPriceKobo': serializer.toJson<int>(sellPriceKobo),
      'avgCostKobo': serializer.toJson<int>(avgCostKobo),
      'qtyOnHand': serializer.toJson<int>(qtyOnHand),
      'lowStockThreshold': serializer.toJson<int>(lowStockThreshold),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? aliases,
    int? sellPriceKobo,
    int? avgCostKobo,
    int? qtyOnHand,
    int? lowStockThreshold,
    bool? active,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    aliases: aliases ?? this.aliases,
    sellPriceKobo: sellPriceKobo ?? this.sellPriceKobo,
    avgCostKobo: avgCostKobo ?? this.avgCostKobo,
    qtyOnHand: qtyOnHand ?? this.qtyOnHand,
    lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      aliases: data.aliases.present ? data.aliases.value : this.aliases,
      sellPriceKobo: data.sellPriceKobo.present ? data.sellPriceKobo.value : this.sellPriceKobo,
      avgCostKobo: data.avgCostKobo.present ? data.avgCostKobo.value : this.avgCostKobo,
      qtyOnHand: data.qtyOnHand.present ? data.qtyOnHand.value : this.qtyOnHand,
      lowStockThreshold: data.lowStockThreshold.present ? data.lowStockThreshold.value : this.lowStockThreshold,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aliases: $aliases, ')
          ..write('sellPriceKobo: $sellPriceKobo, ')
          ..write('avgCostKobo: $avgCostKobo, ')
          ..write('qtyOnHand: $qtyOnHand, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, aliases, sellPriceKobo, avgCostKobo, qtyOnHand, lowStockThreshold, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.aliases == this.aliases &&
          other.sellPriceKobo == this.sellPriceKobo &&
          other.avgCostKobo == this.avgCostKobo &&
          other.qtyOnHand == this.qtyOnHand &&
          other.lowStockThreshold == this.lowStockThreshold &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> aliases;
  final Value<int> sellPriceKobo;
  final Value<int> avgCostKobo;
  final Value<int> qtyOnHand;
  final Value<int> lowStockThreshold;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.aliases = const Value.absent(),
    this.sellPriceKobo = const Value.absent(),
    this.avgCostKobo = const Value.absent(),
    this.qtyOnHand = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.aliases = const Value.absent(),
    required int sellPriceKobo,
    required int avgCostKobo,
    this.qtyOnHand = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       sellPriceKobo = Value(sellPriceKobo),
       avgCostKobo = Value(avgCostKobo);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? aliases,
    Expression<int>? sellPriceKobo,
    Expression<int>? avgCostKobo,
    Expression<int>? qtyOnHand,
    Expression<int>? lowStockThreshold,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (aliases != null) 'aliases': aliases,
      if (sellPriceKobo != null) 'sell_price_kobo': sellPriceKobo,
      if (avgCostKobo != null) 'avg_cost_kobo': avgCostKobo,
      if (qtyOnHand != null) 'qty_on_hand': qtyOnHand,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? aliases,
    Value<int>? sellPriceKobo,
    Value<int>? avgCostKobo,
    Value<int>? qtyOnHand,
    Value<int>? lowStockThreshold,
    Value<bool>? active,
    Value<DateTime>? createdAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      aliases: aliases ?? this.aliases,
      sellPriceKobo: sellPriceKobo ?? this.sellPriceKobo,
      avgCostKobo: avgCostKobo ?? this.avgCostKobo,
      qtyOnHand: qtyOnHand ?? this.qtyOnHand,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (aliases.present) {
      map['aliases'] = Variable<String>(aliases.value);
    }
    if (sellPriceKobo.present) {
      map['sell_price_kobo'] = Variable<int>(sellPriceKobo.value);
    }
    if (avgCostKobo.present) {
      map['avg_cost_kobo'] = Variable<int>(avgCostKobo.value);
    }
    if (qtyOnHand.present) {
      map['qty_on_hand'] = Variable<int>(qtyOnHand.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<int>(lowStockThreshold.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aliases: $aliases, ')
          ..write('sellPriceKobo: $sellPriceKobo, ')
          ..write('avgCostKobo: $avgCostKobo, ')
          ..write('qtyOnHand: $qtyOnHand, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'),
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<int> delta = GeneratedColumn<int>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostKoboMeta = const VerificationMeta('unitCostKobo');
  @override
  late final GeneratedColumn<int> unitCostKobo = GeneratedColumn<int>(
    'unit_cost_kobo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, productId, delta, reason, unitCostKobo, orderId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(Insertable<StockMovement> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(_deltaMeta, delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta));
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta, reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('unit_cost_kobo')) {
      context.handle(_unitCostKoboMeta, unitCostKobo.isAcceptableOrUnknown(data['unit_cost_kobo']!, _unitCostKoboMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      delta: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}delta'])!,
      reason: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      unitCostKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit_cost_kobo']),
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final int id;
  final int productId;
  final int delta;
  final String reason;
  final int? unitCostKobo;
  final int? orderId;
  final DateTime createdAt;
  const StockMovement({
    required this.id,
    required this.productId,
    required this.delta,
    required this.reason,
    this.unitCostKobo,
    this.orderId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['delta'] = Variable<int>(delta);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || unitCostKobo != null) {
      map['unit_cost_kobo'] = Variable<int>(unitCostKobo);
    }
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<int>(orderId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      productId: Value(productId),
      delta: Value(delta),
      reason: Value(reason),
      unitCostKobo: unitCostKobo == null && nullToAbsent ? const Value.absent() : Value(unitCostKobo),
      orderId: orderId == null && nullToAbsent ? const Value.absent() : Value(orderId),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovement.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      delta: serializer.fromJson<int>(json['delta']),
      reason: serializer.fromJson<String>(json['reason']),
      unitCostKobo: serializer.fromJson<int?>(json['unitCostKobo']),
      orderId: serializer.fromJson<int?>(json['orderId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'delta': serializer.toJson<int>(delta),
      'reason': serializer.toJson<String>(reason),
      'unitCostKobo': serializer.toJson<int?>(unitCostKobo),
      'orderId': serializer.toJson<int?>(orderId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovement copyWith({
    int? id,
    int? productId,
    int? delta,
    String? reason,
    Value<int?> unitCostKobo = const Value.absent(),
    Value<int?> orderId = const Value.absent(),
    DateTime? createdAt,
  }) => StockMovement(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    delta: delta ?? this.delta,
    reason: reason ?? this.reason,
    unitCostKobo: unitCostKobo.present ? unitCostKobo.value : this.unitCostKobo,
    orderId: orderId.present ? orderId.value : this.orderId,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      delta: data.delta.present ? data.delta.value : this.delta,
      reason: data.reason.present ? data.reason.value : this.reason,
      unitCostKobo: data.unitCostKobo.present ? data.unitCostKobo.value : this.unitCostKobo,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('unitCostKobo: $unitCostKobo, ')
          ..write('orderId: $orderId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, delta, reason, unitCostKobo, orderId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.delta == this.delta &&
          other.reason == this.reason &&
          other.unitCostKobo == this.unitCostKobo &&
          other.orderId == this.orderId &&
          other.createdAt == this.createdAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> delta;
  final Value<String> reason;
  final Value<int?> unitCostKobo;
  final Value<int?> orderId;
  final Value<DateTime> createdAt;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.delta = const Value.absent(),
    this.reason = const Value.absent(),
    this.unitCostKobo = const Value.absent(),
    this.orderId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int delta,
    required String reason,
    this.unitCostKobo = const Value.absent(),
    this.orderId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       delta = Value(delta),
       reason = Value(reason);
  static Insertable<StockMovement> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? delta,
    Expression<String>? reason,
    Expression<int>? unitCostKobo,
    Expression<int>? orderId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (delta != null) 'delta': delta,
      if (reason != null) 'reason': reason,
      if (unitCostKobo != null) 'unit_cost_kobo': unitCostKobo,
      if (orderId != null) 'order_id': orderId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? delta,
    Value<String>? reason,
    Value<int?>? unitCostKobo,
    Value<int?>? orderId,
    Value<DateTime>? createdAt,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      delta: delta ?? this.delta,
      reason: reason ?? this.reason,
      unitCostKobo: unitCostKobo ?? this.unitCostKobo,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<int>(delta.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (unitCostKobo.present) {
      map['unit_cost_kobo'] = Variable<int>(unitCostKobo.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('unitCostKobo: $unitCostKobo, ')
          ..write('orderId: $orderId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedAmountKoboMeta = const VerificationMeta('expectedAmountKobo');
  @override
  late final GeneratedColumn<int> expectedAmountKobo = GeneratedColumn<int>(
    'expected_amount_kobo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveryFeeKoboMeta = const VerificationMeta('deliveryFeeKobo');
  @override
  late final GeneratedColumn<int> deliveryFeeKobo = GeneratedColumn<int>(
    'delivery_fee_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    customerName,
    status,
    expectedAmountKobo,
    deliveryFeeKobo,
    createdAt,
    paidAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(_codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(_customerNameMeta, customerName.isAcceptableOrUnknown(data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('expected_amount_kobo')) {
      context.handle(
        _expectedAmountKoboMeta,
        expectedAmountKobo.isAcceptableOrUnknown(data['expected_amount_kobo']!, _expectedAmountKoboMeta),
      );
    }
    if (data.containsKey('delivery_fee_kobo')) {
      context.handle(
        _deliveryFeeKoboMeta,
        deliveryFeeKobo.isAcceptableOrUnknown(data['delivery_fee_kobo']!, _deliveryFeeKoboMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta, paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      customerName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      expectedAmountKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_amount_kobo'],
      ),
      deliveryFeeKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delivery_fee_kobo'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      paidAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String code;
  final String? customerName;
  final String status;
  final int? expectedAmountKobo;
  final int deliveryFeeKobo;
  final DateTime createdAt;
  final DateTime? paidAt;
  const Order({
    required this.id,
    required this.code,
    this.customerName,
    required this.status,
    this.expectedAmountKobo,
    required this.deliveryFeeKobo,
    required this.createdAt,
    this.paidAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || expectedAmountKobo != null) {
      map['expected_amount_kobo'] = Variable<int>(expectedAmountKobo);
    }
    map['delivery_fee_kobo'] = Variable<int>(deliveryFeeKobo);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      code: Value(code),
      customerName: customerName == null && nullToAbsent ? const Value.absent() : Value(customerName),
      status: Value(status),
      expectedAmountKobo: expectedAmountKobo == null && nullToAbsent ? const Value.absent() : Value(expectedAmountKobo),
      deliveryFeeKobo: Value(deliveryFeeKobo),
      createdAt: Value(createdAt),
      paidAt: paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      status: serializer.fromJson<String>(json['status']),
      expectedAmountKobo: serializer.fromJson<int?>(json['expectedAmountKobo']),
      deliveryFeeKobo: serializer.fromJson<int>(json['deliveryFeeKobo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'customerName': serializer.toJson<String?>(customerName),
      'status': serializer.toJson<String>(status),
      'expectedAmountKobo': serializer.toJson<int?>(expectedAmountKobo),
      'deliveryFeeKobo': serializer.toJson<int>(deliveryFeeKobo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
    };
  }

  Order copyWith({
    int? id,
    String? code,
    Value<String?> customerName = const Value.absent(),
    String? status,
    Value<int?> expectedAmountKobo = const Value.absent(),
    int? deliveryFeeKobo,
    DateTime? createdAt,
    Value<DateTime?> paidAt = const Value.absent(),
  }) => Order(
    id: id ?? this.id,
    code: code ?? this.code,
    customerName: customerName.present ? customerName.value : this.customerName,
    status: status ?? this.status,
    expectedAmountKobo: expectedAmountKobo.present ? expectedAmountKobo.value : this.expectedAmountKobo,
    deliveryFeeKobo: deliveryFeeKobo ?? this.deliveryFeeKobo,
    createdAt: createdAt ?? this.createdAt,
    paidAt: paidAt.present ? paidAt.value : this.paidAt,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      customerName: data.customerName.present ? data.customerName.value : this.customerName,
      status: data.status.present ? data.status.value : this.status,
      expectedAmountKobo: data.expectedAmountKobo.present ? data.expectedAmountKobo.value : this.expectedAmountKobo,
      deliveryFeeKobo: data.deliveryFeeKobo.present ? data.deliveryFeeKobo.value : this.deliveryFeeKobo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('expectedAmountKobo: $expectedAmountKobo, ')
          ..write('deliveryFeeKobo: $deliveryFeeKobo, ')
          ..write('createdAt: $createdAt, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, customerName, status, expectedAmountKobo, deliveryFeeKobo, createdAt, paidAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.code == this.code &&
          other.customerName == this.customerName &&
          other.status == this.status &&
          other.expectedAmountKobo == this.expectedAmountKobo &&
          other.deliveryFeeKobo == this.deliveryFeeKobo &&
          other.createdAt == this.createdAt &&
          other.paidAt == this.paidAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String> code;
  final Value<String?> customerName;
  final Value<String> status;
  final Value<int?> expectedAmountKobo;
  final Value<int> deliveryFeeKobo;
  final Value<DateTime> createdAt;
  final Value<DateTime?> paidAt;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.customerName = const Value.absent(),
    this.status = const Value.absent(),
    this.expectedAmountKobo = const Value.absent(),
    this.deliveryFeeKobo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    this.customerName = const Value.absent(),
    required String status,
    this.expectedAmountKobo = const Value.absent(),
    this.deliveryFeeKobo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.paidAt = const Value.absent(),
  }) : code = Value(code),
       status = Value(status);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? customerName,
    Expression<String>? status,
    Expression<int>? expectedAmountKobo,
    Expression<int>? deliveryFeeKobo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (customerName != null) 'customer_name': customerName,
      if (status != null) 'status': status,
      if (expectedAmountKobo != null) 'expected_amount_kobo': expectedAmountKobo,
      if (deliveryFeeKobo != null) 'delivery_fee_kobo': deliveryFeeKobo,
      if (createdAt != null) 'created_at': createdAt,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String?>? customerName,
    Value<String>? status,
    Value<int?>? expectedAmountKobo,
    Value<int>? deliveryFeeKobo,
    Value<DateTime>? createdAt,
    Value<DateTime?>? paidAt,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      expectedAmountKobo: expectedAmountKobo ?? this.expectedAmountKobo,
      deliveryFeeKobo: deliveryFeeKobo ?? this.deliveryFeeKobo,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (expectedAmountKobo.present) {
      map['expected_amount_kobo'] = Variable<int>(expectedAmountKobo.value);
    }
    if (deliveryFeeKobo.present) {
      map['delivery_fee_kobo'] = Variable<int>(deliveryFeeKobo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('expectedAmountKobo: $expectedAmountKobo, ')
          ..write('deliveryFeeKobo: $deliveryFeeKobo, ')
          ..write('createdAt: $createdAt, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES products (id)'),
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceKoboMeta = const VerificationMeta('unitPriceKobo');
  @override
  late final GeneratedColumn<int> unitPriceKobo = GeneratedColumn<int>(
    'unit_price_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostKoboMeta = const VerificationMeta('unitCostKobo');
  @override
  late final GeneratedColumn<int> unitCostKobo = GeneratedColumn<int>(
    'unit_cost_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [orderId, productId, qty, unitPriceKobo, unitCostKobo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(Insertable<OrderItem> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta, productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(_qtyMeta, qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta));
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_price_kobo')) {
      context.handle(
        _unitPriceKoboMeta,
        unitPriceKobo.isAcceptableOrUnknown(data['unit_price_kobo']!, _unitPriceKoboMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceKoboMeta);
    }
    if (data.containsKey('unit_cost_kobo')) {
      context.handle(_unitCostKoboMeta, unitCostKobo.isAcceptableOrUnknown(data['unit_cost_kobo']!, _unitCostKoboMeta));
    } else if (isInserting) {
      context.missing(_unitCostKoboMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, productId};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      productId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      qty: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}qty'])!,
      unitPriceKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit_price_kobo'])!,
      unitCostKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit_cost_kobo'])!,
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final int orderId;
  final int productId;
  final int qty;
  final int unitPriceKobo;

  /// Snapshot of the moving-average cost when paid, so a sale's profit never changes afterwards.
  final int unitCostKobo;
  const OrderItem({
    required this.orderId,
    required this.productId,
    required this.qty,
    required this.unitPriceKobo,
    required this.unitCostKobo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['product_id'] = Variable<int>(productId);
    map['qty'] = Variable<int>(qty);
    map['unit_price_kobo'] = Variable<int>(unitPriceKobo);
    map['unit_cost_kobo'] = Variable<int>(unitCostKobo);
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      orderId: Value(orderId),
      productId: Value(productId),
      qty: Value(qty),
      unitPriceKobo: Value(unitPriceKobo),
      unitCostKobo: Value(unitCostKobo),
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      orderId: serializer.fromJson<int>(json['orderId']),
      productId: serializer.fromJson<int>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      unitPriceKobo: serializer.fromJson<int>(json['unitPriceKobo']),
      unitCostKobo: serializer.fromJson<int>(json['unitCostKobo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'productId': serializer.toJson<int>(productId),
      'qty': serializer.toJson<int>(qty),
      'unitPriceKobo': serializer.toJson<int>(unitPriceKobo),
      'unitCostKobo': serializer.toJson<int>(unitCostKobo),
    };
  }

  OrderItem copyWith({int? orderId, int? productId, int? qty, int? unitPriceKobo, int? unitCostKobo}) => OrderItem(
    orderId: orderId ?? this.orderId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    unitPriceKobo: unitPriceKobo ?? this.unitPriceKobo,
    unitCostKobo: unitCostKobo ?? this.unitCostKobo,
  );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitPriceKobo: data.unitPriceKobo.present ? data.unitPriceKobo.value : this.unitPriceKobo,
      unitCostKobo: data.unitCostKobo.present ? data.unitCostKobo.value : this.unitCostKobo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceKobo: $unitPriceKobo, ')
          ..write('unitCostKobo: $unitCostKobo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(orderId, productId, qty, unitPriceKobo, unitCostKobo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.unitPriceKobo == this.unitPriceKobo &&
          other.unitCostKobo == this.unitCostKobo);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<int> orderId;
  final Value<int> productId;
  final Value<int> qty;
  final Value<int> unitPriceKobo;
  final Value<int> unitCostKobo;
  final Value<int> rowid;
  const OrderItemsCompanion({
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitPriceKobo = const Value.absent(),
    this.unitCostKobo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    required int orderId,
    required int productId,
    required int qty,
    required int unitPriceKobo,
    required int unitCostKobo,
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       productId = Value(productId),
       qty = Value(qty),
       unitPriceKobo = Value(unitPriceKobo),
       unitCostKobo = Value(unitCostKobo);
  static Insertable<OrderItem> custom({
    Expression<int>? orderId,
    Expression<int>? productId,
    Expression<int>? qty,
    Expression<int>? unitPriceKobo,
    Expression<int>? unitCostKobo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (unitPriceKobo != null) 'unit_price_kobo': unitPriceKobo,
      if (unitCostKobo != null) 'unit_cost_kobo': unitCostKobo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderItemsCompanion copyWith({
    Value<int>? orderId,
    Value<int>? productId,
    Value<int>? qty,
    Value<int>? unitPriceKobo,
    Value<int>? unitCostKobo,
    Value<int>? rowid,
  }) {
    return OrderItemsCompanion(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      unitPriceKobo: unitPriceKobo ?? this.unitPriceKobo,
      unitCostKobo: unitCostKobo ?? this.unitCostKobo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (unitPriceKobo.present) {
      map['unit_price_kobo'] = Variable<int>(unitPriceKobo.value);
    }
    if (unitCostKobo.present) {
      map['unit_cost_kobo'] = Variable<int>(unitCostKobo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('unitPriceKobo: $unitPriceKobo, ')
          ..write('unitCostKobo: $unitCostKobo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, SaleMatch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _bankEventIdMeta = const VerificationMeta('bankEventId');
  @override
  late final GeneratedColumn<int> bankEventId = GeneratedColumn<int>(
    'bank_event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES bank_events (id)'),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta('confidence');
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedByUserMeta = const VerificationMeta('confirmedByUser');
  @override
  late final GeneratedColumn<bool> confirmedByUser = GeneratedColumn<bool>(
    'confirmed_by_user',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("confirmed_by_user" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bankEventId, orderId, kind, confidence, confirmedByUser, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(Insertable<SaleMatch> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_event_id')) {
      context.handle(_bankEventIdMeta, bankEventId.isAcceptableOrUnknown(data['bank_event_id']!, _bankEventIdMeta));
    } else if (isInserting) {
      context.missing(_bankEventIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta, orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(_kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(_confidenceMeta, confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta));
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('confirmed_by_user')) {
      context.handle(
        _confirmedByUserMeta,
        confirmedByUser.isAcceptableOrUnknown(data['confirmed_by_user']!, _confirmedByUserMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleMatch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleMatch(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bankEventId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}bank_event_id'])!,
      orderId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order_id']),
      kind: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      confidence: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}confidence'])!,
      confirmedByUser: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}confirmed_by_user'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class SaleMatch extends DataClass implements Insertable<SaleMatch> {
  final int id;
  final int bankEventId;
  final int? orderId;
  final String kind;
  final double confidence;
  final bool confirmedByUser;
  final DateTime createdAt;
  const SaleMatch({
    required this.id,
    required this.bankEventId,
    this.orderId,
    required this.kind,
    required this.confidence,
    required this.confirmedByUser,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bank_event_id'] = Variable<int>(bankEventId);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<int>(orderId);
    }
    map['kind'] = Variable<String>(kind);
    map['confidence'] = Variable<double>(confidence);
    map['confirmed_by_user'] = Variable<bool>(confirmedByUser);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      bankEventId: Value(bankEventId),
      orderId: orderId == null && nullToAbsent ? const Value.absent() : Value(orderId),
      kind: Value(kind),
      confidence: Value(confidence),
      confirmedByUser: Value(confirmedByUser),
      createdAt: Value(createdAt),
    );
  }

  factory SaleMatch.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleMatch(
      id: serializer.fromJson<int>(json['id']),
      bankEventId: serializer.fromJson<int>(json['bankEventId']),
      orderId: serializer.fromJson<int?>(json['orderId']),
      kind: serializer.fromJson<String>(json['kind']),
      confidence: serializer.fromJson<double>(json['confidence']),
      confirmedByUser: serializer.fromJson<bool>(json['confirmedByUser']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bankEventId': serializer.toJson<int>(bankEventId),
      'orderId': serializer.toJson<int?>(orderId),
      'kind': serializer.toJson<String>(kind),
      'confidence': serializer.toJson<double>(confidence),
      'confirmedByUser': serializer.toJson<bool>(confirmedByUser),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleMatch copyWith({
    int? id,
    int? bankEventId,
    Value<int?> orderId = const Value.absent(),
    String? kind,
    double? confidence,
    bool? confirmedByUser,
    DateTime? createdAt,
  }) => SaleMatch(
    id: id ?? this.id,
    bankEventId: bankEventId ?? this.bankEventId,
    orderId: orderId.present ? orderId.value : this.orderId,
    kind: kind ?? this.kind,
    confidence: confidence ?? this.confidence,
    confirmedByUser: confirmedByUser ?? this.confirmedByUser,
    createdAt: createdAt ?? this.createdAt,
  );
  SaleMatch copyWithCompanion(MatchesCompanion data) {
    return SaleMatch(
      id: data.id.present ? data.id.value : this.id,
      bankEventId: data.bankEventId.present ? data.bankEventId.value : this.bankEventId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      kind: data.kind.present ? data.kind.value : this.kind,
      confidence: data.confidence.present ? data.confidence.value : this.confidence,
      confirmedByUser: data.confirmedByUser.present ? data.confirmedByUser.value : this.confirmedByUser,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleMatch(')
          ..write('id: $id, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('orderId: $orderId, ')
          ..write('kind: $kind, ')
          ..write('confidence: $confidence, ')
          ..write('confirmedByUser: $confirmedByUser, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bankEventId, orderId, kind, confidence, confirmedByUser, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleMatch &&
          other.id == this.id &&
          other.bankEventId == this.bankEventId &&
          other.orderId == this.orderId &&
          other.kind == this.kind &&
          other.confidence == this.confidence &&
          other.confirmedByUser == this.confirmedByUser &&
          other.createdAt == this.createdAt);
}

class MatchesCompanion extends UpdateCompanion<SaleMatch> {
  final Value<int> id;
  final Value<int> bankEventId;
  final Value<int?> orderId;
  final Value<String> kind;
  final Value<double> confidence;
  final Value<bool> confirmedByUser;
  final Value<DateTime> createdAt;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.bankEventId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.kind = const Value.absent(),
    this.confidence = const Value.absent(),
    this.confirmedByUser = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MatchesCompanion.insert({
    this.id = const Value.absent(),
    required int bankEventId,
    this.orderId = const Value.absent(),
    required String kind,
    required double confidence,
    this.confirmedByUser = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : bankEventId = Value(bankEventId),
       kind = Value(kind),
       confidence = Value(confidence);
  static Insertable<SaleMatch> custom({
    Expression<int>? id,
    Expression<int>? bankEventId,
    Expression<int>? orderId,
    Expression<String>? kind,
    Expression<double>? confidence,
    Expression<bool>? confirmedByUser,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankEventId != null) 'bank_event_id': bankEventId,
      if (orderId != null) 'order_id': orderId,
      if (kind != null) 'kind': kind,
      if (confidence != null) 'confidence': confidence,
      if (confirmedByUser != null) 'confirmed_by_user': confirmedByUser,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? bankEventId,
    Value<int?>? orderId,
    Value<String>? kind,
    Value<double>? confidence,
    Value<bool>? confirmedByUser,
    Value<DateTime>? createdAt,
  }) {
    return MatchesCompanion(
      id: id ?? this.id,
      bankEventId: bankEventId ?? this.bankEventId,
      orderId: orderId ?? this.orderId,
      kind: kind ?? this.kind,
      confidence: confidence ?? this.confidence,
      confirmedByUser: confirmedByUser ?? this.confirmedByUser,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bankEventId.present) {
      map['bank_event_id'] = Variable<int>(bankEventId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (confirmedByUser.present) {
      map['confirmed_by_user'] = Variable<bool>(confirmedByUser.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('orderId: $orderId, ')
          ..write('kind: $kind, ')
          ..write('confidence: $confidence, ')
          ..write('confirmedByUser: $confirmedByUser, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IgnoreRulesTable extends IgnoreRules with TableInfo<$IgnoreRulesTable, IgnoreRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IgnoreRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _senderKeyMeta = const VerificationMeta('senderKey');
  @override
  late final GeneratedColumn<String> senderKey = GeneratedColumn<String>(
    'sender_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, senderKey, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ignore_rules';
  @override
  VerificationContext validateIntegrity(Insertable<IgnoreRule> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sender_key')) {
      context.handle(_senderKeyMeta, senderKey.isAcceptableOrUnknown(data['sender_key']!, _senderKeyMeta));
    } else if (isInserting) {
      context.missing(_senderKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IgnoreRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IgnoreRule(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      senderKey: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}sender_key'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $IgnoreRulesTable createAlias(String alias) {
    return $IgnoreRulesTable(attachedDatabase, alias);
  }
}

class IgnoreRule extends DataClass implements Insertable<IgnoreRule> {
  final int id;
  final String senderKey;
  final DateTime createdAt;
  const IgnoreRule({required this.id, required this.senderKey, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sender_key'] = Variable<String>(senderKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IgnoreRulesCompanion toCompanion(bool nullToAbsent) {
    return IgnoreRulesCompanion(id: Value(id), senderKey: Value(senderKey), createdAt: Value(createdAt));
  }

  factory IgnoreRule.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IgnoreRule(
      id: serializer.fromJson<int>(json['id']),
      senderKey: serializer.fromJson<String>(json['senderKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'senderKey': serializer.toJson<String>(senderKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IgnoreRule copyWith({int? id, String? senderKey, DateTime? createdAt}) =>
      IgnoreRule(id: id ?? this.id, senderKey: senderKey ?? this.senderKey, createdAt: createdAt ?? this.createdAt);
  IgnoreRule copyWithCompanion(IgnoreRulesCompanion data) {
    return IgnoreRule(
      id: data.id.present ? data.id.value : this.id,
      senderKey: data.senderKey.present ? data.senderKey.value : this.senderKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IgnoreRule(')
          ..write('id: $id, ')
          ..write('senderKey: $senderKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, senderKey, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IgnoreRule &&
          other.id == this.id &&
          other.senderKey == this.senderKey &&
          other.createdAt == this.createdAt);
}

class IgnoreRulesCompanion extends UpdateCompanion<IgnoreRule> {
  final Value<int> id;
  final Value<String> senderKey;
  final Value<DateTime> createdAt;
  const IgnoreRulesCompanion({
    this.id = const Value.absent(),
    this.senderKey = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IgnoreRulesCompanion.insert({
    this.id = const Value.absent(),
    required String senderKey,
    this.createdAt = const Value.absent(),
  }) : senderKey = Value(senderKey);
  static Insertable<IgnoreRule> custom({
    Expression<int>? id,
    Expression<String>? senderKey,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (senderKey != null) 'sender_key': senderKey,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IgnoreRulesCompanion copyWith({Value<int>? id, Value<String>? senderKey, Value<DateTime>? createdAt}) {
    return IgnoreRulesCompanion(
      id: id ?? this.id,
      senderKey: senderKey ?? this.senderKey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (senderKey.present) {
      map['sender_key'] = Variable<String>(senderKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IgnoreRulesCompanion(')
          ..write('id: $id, ')
          ..write('senderKey: $senderKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _bankEventIdMeta = const VerificationMeta('bankEventId');
  @override
  late final GeneratedColumn<int> bankEventId = GeneratedColumn<int>(
    'bank_event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE REFERENCES bank_events (id)'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setByUserMeta = const VerificationMeta('setByUser');
  @override
  late final GeneratedColumn<bool> setByUser = GeneratedColumn<bool>(
    'set_by_user',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("set_by_user" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, bankEventId, category, setByUser];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_event_id')) {
      context.handle(_bankEventIdMeta, bankEventId.isAcceptableOrUnknown(data['bank_event_id']!, _bankEventIdMeta));
    } else if (isInserting) {
      context.missing(_bankEventIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta, category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('set_by_user')) {
      context.handle(_setByUserMeta, setByUser.isAcceptableOrUnknown(data['set_by_user']!, _setByUserMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bankEventId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}bank_event_id'])!,
      category: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      setByUser: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}set_by_user'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int bankEventId;
  final String category;
  final bool setByUser;
  const Expense({required this.id, required this.bankEventId, required this.category, required this.setByUser});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bank_event_id'] = Variable<int>(bankEventId);
    map['category'] = Variable<String>(category);
    map['set_by_user'] = Variable<bool>(setByUser);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      bankEventId: Value(bankEventId),
      category: Value(category),
      setByUser: Value(setByUser),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      bankEventId: serializer.fromJson<int>(json['bankEventId']),
      category: serializer.fromJson<String>(json['category']),
      setByUser: serializer.fromJson<bool>(json['setByUser']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bankEventId': serializer.toJson<int>(bankEventId),
      'category': serializer.toJson<String>(category),
      'setByUser': serializer.toJson<bool>(setByUser),
    };
  }

  Expense copyWith({int? id, int? bankEventId, String? category, bool? setByUser}) => Expense(
    id: id ?? this.id,
    bankEventId: bankEventId ?? this.bankEventId,
    category: category ?? this.category,
    setByUser: setByUser ?? this.setByUser,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      bankEventId: data.bankEventId.present ? data.bankEventId.value : this.bankEventId,
      category: data.category.present ? data.category.value : this.category,
      setByUser: data.setByUser.present ? data.setByUser.value : this.setByUser,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('category: $category, ')
          ..write('setByUser: $setByUser')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bankEventId, category, setByUser);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.bankEventId == this.bankEventId &&
          other.category == this.category &&
          other.setByUser == this.setByUser);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int> bankEventId;
  final Value<String> category;
  final Value<bool> setByUser;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.bankEventId = const Value.absent(),
    this.category = const Value.absent(),
    this.setByUser = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int bankEventId,
    required String category,
    this.setByUser = const Value.absent(),
  }) : bankEventId = Value(bankEventId),
       category = Value(category);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? bankEventId,
    Expression<String>? category,
    Expression<bool>? setByUser,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankEventId != null) 'bank_event_id': bankEventId,
      if (category != null) 'category': category,
      if (setByUser != null) 'set_by_user': setByUser,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<int>? bankEventId,
    Value<String>? category,
    Value<bool>? setByUser,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      bankEventId: bankEventId ?? this.bankEventId,
      category: category ?? this.category,
      setByUser: setByUser ?? this.setByUser,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bankEventId.present) {
      map['bank_event_id'] = Variable<int>(bankEventId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (setByUser.present) {
      map['set_by_user'] = Variable<bool>(setByUser.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('category: $category, ')
          ..write('setByUser: $setByUser')
          ..write(')'))
        .toString();
  }
}

class $PaymentClaimsTable extends PaymentClaims with TableInfo<$PaymentClaimsTable, PaymentClaim> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentClaimsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _appMeta = const VerificationMeta('app');
  @override
  late final GeneratedColumn<String> app = GeneratedColumn<String>(
    'app',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountKoboMeta = const VerificationMeta('amountKobo');
  @override
  late final GeneratedColumn<int> amountKobo = GeneratedColumn<int>(
    'amount_kobo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previewMeta = const VerificationMeta('preview');
  @override
  late final GeneratedColumn<String> preview = GeneratedColumn<String>(
    'preview',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previewHashMeta = const VerificationMeta('previewHash');
  @override
  late final GeneratedColumn<String> previewHash = GeneratedColumn<String>(
    'preview_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _claimedAtMeta = const VerificationMeta('claimedAt');
  @override
  late final GeneratedColumn<DateTime> claimedAt = GeneratedColumn<DateTime>(
    'claimed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankEventIdMeta = const VerificationMeta('bankEventId');
  @override
  late final GeneratedColumn<int> bankEventId = GeneratedColumn<int>(
    'bank_event_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES bank_events (id)'),
  );
  static const VerificationMeta _dismissedMeta = const VerificationMeta('dismissed');
  @override
  late final GeneratedColumn<bool> dismissed = GeneratedColumn<bool>(
    'dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("dismissed" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    app,
    sender,
    amountKobo,
    preview,
    previewHash,
    claimedAt,
    expiresAt,
    status,
    bankEventId,
    dismissed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_claims';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentClaim> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app')) {
      context.handle(_appMeta, app.isAcceptableOrUnknown(data['app']!, _appMeta));
    } else if (isInserting) {
      context.missing(_appMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(_senderMeta, sender.isAcceptableOrUnknown(data['sender']!, _senderMeta));
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('amount_kobo')) {
      context.handle(_amountKoboMeta, amountKobo.isAcceptableOrUnknown(data['amount_kobo']!, _amountKoboMeta));
    }
    if (data.containsKey('preview')) {
      context.handle(_previewMeta, preview.isAcceptableOrUnknown(data['preview']!, _previewMeta));
    }
    if (data.containsKey('preview_hash')) {
      context.handle(_previewHashMeta, previewHash.isAcceptableOrUnknown(data['preview_hash']!, _previewHashMeta));
    } else if (isInserting) {
      context.missing(_previewHashMeta);
    }
    if (data.containsKey('claimed_at')) {
      context.handle(_claimedAtMeta, claimedAt.isAcceptableOrUnknown(data['claimed_at']!, _claimedAtMeta));
    } else if (isInserting) {
      context.missing(_claimedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta, expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('bank_event_id')) {
      context.handle(_bankEventIdMeta, bankEventId.isAcceptableOrUnknown(data['bank_event_id']!, _bankEventIdMeta));
    }
    if (data.containsKey('dismissed')) {
      context.handle(_dismissedMeta, dismissed.isAcceptableOrUnknown(data['dismissed']!, _dismissedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentClaim map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentClaim(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      app: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}app'])!,
      sender: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}sender'])!,
      amountKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_kobo']),
      preview: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}preview']),
      previewHash: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}preview_hash'])!,
      claimedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}claimed_at'])!,
      expiresAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      bankEventId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}bank_event_id']),
      dismissed: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}dismissed'])!,
    );
  }

  @override
  $PaymentClaimsTable createAlias(String alias) {
    return $PaymentClaimsTable(attachedDatabase, alias);
  }
}

class PaymentClaim extends DataClass implements Insertable<PaymentClaim> {
  final int id;
  final String app;
  final String sender;
  final int? amountKobo;
  final String? preview;
  final String previewHash;
  final DateTime claimedAt;
  final DateTime expiresAt;
  final String status;
  final int? bankEventId;
  final bool dismissed;
  const PaymentClaim({
    required this.id,
    required this.app,
    required this.sender,
    this.amountKobo,
    this.preview,
    required this.previewHash,
    required this.claimedAt,
    required this.expiresAt,
    required this.status,
    this.bankEventId,
    required this.dismissed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['app'] = Variable<String>(app);
    map['sender'] = Variable<String>(sender);
    if (!nullToAbsent || amountKobo != null) {
      map['amount_kobo'] = Variable<int>(amountKobo);
    }
    if (!nullToAbsent || preview != null) {
      map['preview'] = Variable<String>(preview);
    }
    map['preview_hash'] = Variable<String>(previewHash);
    map['claimed_at'] = Variable<DateTime>(claimedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || bankEventId != null) {
      map['bank_event_id'] = Variable<int>(bankEventId);
    }
    map['dismissed'] = Variable<bool>(dismissed);
    return map;
  }

  PaymentClaimsCompanion toCompanion(bool nullToAbsent) {
    return PaymentClaimsCompanion(
      id: Value(id),
      app: Value(app),
      sender: Value(sender),
      amountKobo: amountKobo == null && nullToAbsent ? const Value.absent() : Value(amountKobo),
      preview: preview == null && nullToAbsent ? const Value.absent() : Value(preview),
      previewHash: Value(previewHash),
      claimedAt: Value(claimedAt),
      expiresAt: Value(expiresAt),
      status: Value(status),
      bankEventId: bankEventId == null && nullToAbsent ? const Value.absent() : Value(bankEventId),
      dismissed: Value(dismissed),
    );
  }

  factory PaymentClaim.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentClaim(
      id: serializer.fromJson<int>(json['id']),
      app: serializer.fromJson<String>(json['app']),
      sender: serializer.fromJson<String>(json['sender']),
      amountKobo: serializer.fromJson<int?>(json['amountKobo']),
      preview: serializer.fromJson<String?>(json['preview']),
      previewHash: serializer.fromJson<String>(json['previewHash']),
      claimedAt: serializer.fromJson<DateTime>(json['claimedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      status: serializer.fromJson<String>(json['status']),
      bankEventId: serializer.fromJson<int?>(json['bankEventId']),
      dismissed: serializer.fromJson<bool>(json['dismissed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'app': serializer.toJson<String>(app),
      'sender': serializer.toJson<String>(sender),
      'amountKobo': serializer.toJson<int?>(amountKobo),
      'preview': serializer.toJson<String?>(preview),
      'previewHash': serializer.toJson<String>(previewHash),
      'claimedAt': serializer.toJson<DateTime>(claimedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'status': serializer.toJson<String>(status),
      'bankEventId': serializer.toJson<int?>(bankEventId),
      'dismissed': serializer.toJson<bool>(dismissed),
    };
  }

  PaymentClaim copyWith({
    int? id,
    String? app,
    String? sender,
    Value<int?> amountKobo = const Value.absent(),
    Value<String?> preview = const Value.absent(),
    String? previewHash,
    DateTime? claimedAt,
    DateTime? expiresAt,
    String? status,
    Value<int?> bankEventId = const Value.absent(),
    bool? dismissed,
  }) => PaymentClaim(
    id: id ?? this.id,
    app: app ?? this.app,
    sender: sender ?? this.sender,
    amountKobo: amountKobo.present ? amountKobo.value : this.amountKobo,
    preview: preview.present ? preview.value : this.preview,
    previewHash: previewHash ?? this.previewHash,
    claimedAt: claimedAt ?? this.claimedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    status: status ?? this.status,
    bankEventId: bankEventId.present ? bankEventId.value : this.bankEventId,
    dismissed: dismissed ?? this.dismissed,
  );
  PaymentClaim copyWithCompanion(PaymentClaimsCompanion data) {
    return PaymentClaim(
      id: data.id.present ? data.id.value : this.id,
      app: data.app.present ? data.app.value : this.app,
      sender: data.sender.present ? data.sender.value : this.sender,
      amountKobo: data.amountKobo.present ? data.amountKobo.value : this.amountKobo,
      preview: data.preview.present ? data.preview.value : this.preview,
      previewHash: data.previewHash.present ? data.previewHash.value : this.previewHash,
      claimedAt: data.claimedAt.present ? data.claimedAt.value : this.claimedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      status: data.status.present ? data.status.value : this.status,
      bankEventId: data.bankEventId.present ? data.bankEventId.value : this.bankEventId,
      dismissed: data.dismissed.present ? data.dismissed.value : this.dismissed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentClaim(')
          ..write('id: $id, ')
          ..write('app: $app, ')
          ..write('sender: $sender, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('preview: $preview, ')
          ..write('previewHash: $previewHash, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('status: $status, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('dismissed: $dismissed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    app,
    sender,
    amountKobo,
    preview,
    previewHash,
    claimedAt,
    expiresAt,
    status,
    bankEventId,
    dismissed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentClaim &&
          other.id == this.id &&
          other.app == this.app &&
          other.sender == this.sender &&
          other.amountKobo == this.amountKobo &&
          other.preview == this.preview &&
          other.previewHash == this.previewHash &&
          other.claimedAt == this.claimedAt &&
          other.expiresAt == this.expiresAt &&
          other.status == this.status &&
          other.bankEventId == this.bankEventId &&
          other.dismissed == this.dismissed);
}

class PaymentClaimsCompanion extends UpdateCompanion<PaymentClaim> {
  final Value<int> id;
  final Value<String> app;
  final Value<String> sender;
  final Value<int?> amountKobo;
  final Value<String?> preview;
  final Value<String> previewHash;
  final Value<DateTime> claimedAt;
  final Value<DateTime> expiresAt;
  final Value<String> status;
  final Value<int?> bankEventId;
  final Value<bool> dismissed;
  const PaymentClaimsCompanion({
    this.id = const Value.absent(),
    this.app = const Value.absent(),
    this.sender = const Value.absent(),
    this.amountKobo = const Value.absent(),
    this.preview = const Value.absent(),
    this.previewHash = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.status = const Value.absent(),
    this.bankEventId = const Value.absent(),
    this.dismissed = const Value.absent(),
  });
  PaymentClaimsCompanion.insert({
    this.id = const Value.absent(),
    required String app,
    required String sender,
    this.amountKobo = const Value.absent(),
    this.preview = const Value.absent(),
    required String previewHash,
    required DateTime claimedAt,
    required DateTime expiresAt,
    required String status,
    this.bankEventId = const Value.absent(),
    this.dismissed = const Value.absent(),
  }) : app = Value(app),
       sender = Value(sender),
       previewHash = Value(previewHash),
       claimedAt = Value(claimedAt),
       expiresAt = Value(expiresAt),
       status = Value(status);
  static Insertable<PaymentClaim> custom({
    Expression<int>? id,
    Expression<String>? app,
    Expression<String>? sender,
    Expression<int>? amountKobo,
    Expression<String>? preview,
    Expression<String>? previewHash,
    Expression<DateTime>? claimedAt,
    Expression<DateTime>? expiresAt,
    Expression<String>? status,
    Expression<int>? bankEventId,
    Expression<bool>? dismissed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (app != null) 'app': app,
      if (sender != null) 'sender': sender,
      if (amountKobo != null) 'amount_kobo': amountKobo,
      if (preview != null) 'preview': preview,
      if (previewHash != null) 'preview_hash': previewHash,
      if (claimedAt != null) 'claimed_at': claimedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (status != null) 'status': status,
      if (bankEventId != null) 'bank_event_id': bankEventId,
      if (dismissed != null) 'dismissed': dismissed,
    });
  }

  PaymentClaimsCompanion copyWith({
    Value<int>? id,
    Value<String>? app,
    Value<String>? sender,
    Value<int?>? amountKobo,
    Value<String?>? preview,
    Value<String>? previewHash,
    Value<DateTime>? claimedAt,
    Value<DateTime>? expiresAt,
    Value<String>? status,
    Value<int?>? bankEventId,
    Value<bool>? dismissed,
  }) {
    return PaymentClaimsCompanion(
      id: id ?? this.id,
      app: app ?? this.app,
      sender: sender ?? this.sender,
      amountKobo: amountKobo ?? this.amountKobo,
      preview: preview ?? this.preview,
      previewHash: previewHash ?? this.previewHash,
      claimedAt: claimedAt ?? this.claimedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
      bankEventId: bankEventId ?? this.bankEventId,
      dismissed: dismissed ?? this.dismissed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (app.present) {
      map['app'] = Variable<String>(app.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (amountKobo.present) {
      map['amount_kobo'] = Variable<int>(amountKobo.value);
    }
    if (preview.present) {
      map['preview'] = Variable<String>(preview.value);
    }
    if (previewHash.present) {
      map['preview_hash'] = Variable<String>(previewHash.value);
    }
    if (claimedAt.present) {
      map['claimed_at'] = Variable<DateTime>(claimedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (bankEventId.present) {
      map['bank_event_id'] = Variable<int>(bankEventId.value);
    }
    if (dismissed.present) {
      map['dismissed'] = Variable<bool>(dismissed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentClaimsCompanion(')
          ..write('id: $id, ')
          ..write('app: $app, ')
          ..write('sender: $sender, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('preview: $preview, ')
          ..write('previewHash: $previewHash, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('status: $status, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('dismissed: $dismissed')
          ..write(')'))
        .toString();
  }
}

class $ReceiptChecksTable extends ReceiptChecks with TableInfo<$ReceiptChecksTable, ReceiptCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _amountKoboMeta = const VerificationMeta('amountKobo');
  @override
  late final GeneratedColumn<int> amountKobo = GeneratedColumn<int>(
    'amount_kobo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankMeta = const VerificationMeta('bank');
  @override
  late final GeneratedColumn<String> bank = GeneratedColumn<String>(
    'bank',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptTimeMeta = const VerificationMeta('receiptTime');
  @override
  late final GeneratedColumn<DateTime> receiptTime = GeneratedColumn<DateTime>(
    'receipt_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verdictMeta = const VerificationMeta('verdict');
  @override
  late final GeneratedColumn<String> verdict = GeneratedColumn<String>(
    'verdict',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonsMeta = const VerificationMeta('reasons');
  @override
  late final GeneratedColumn<String> reasons = GeneratedColumn<String>(
    'reasons',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankEventIdMeta = const VerificationMeta('bankEventId');
  @override
  late final GeneratedColumn<int> bankEventId = GeneratedColumn<int>(
    'bank_event_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES bank_events (id)'),
  );
  static const VerificationMeta _imageHashMeta = const VerificationMeta('imageHash');
  @override
  late final GeneratedColumn<String> imageHash = GeneratedColumn<String>(
    'image_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkedAtMeta = const VerificationMeta('checkedAt');
  @override
  late final GeneratedColumn<DateTime> checkedAt = GeneratedColumn<DateTime>(
    'checked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amountKobo,
    sender,
    bank,
    receiptTime,
    verdict,
    reasons,
    bankEventId,
    imageHash,
    checkedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_checks';
  @override
  VerificationContext validateIntegrity(Insertable<ReceiptCheck> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_kobo')) {
      context.handle(_amountKoboMeta, amountKobo.isAcceptableOrUnknown(data['amount_kobo']!, _amountKoboMeta));
    }
    if (data.containsKey('sender')) {
      context.handle(_senderMeta, sender.isAcceptableOrUnknown(data['sender']!, _senderMeta));
    }
    if (data.containsKey('bank')) {
      context.handle(_bankMeta, bank.isAcceptableOrUnknown(data['bank']!, _bankMeta));
    }
    if (data.containsKey('receipt_time')) {
      context.handle(_receiptTimeMeta, receiptTime.isAcceptableOrUnknown(data['receipt_time']!, _receiptTimeMeta));
    }
    if (data.containsKey('verdict')) {
      context.handle(_verdictMeta, verdict.isAcceptableOrUnknown(data['verdict']!, _verdictMeta));
    } else if (isInserting) {
      context.missing(_verdictMeta);
    }
    if (data.containsKey('reasons')) {
      context.handle(_reasonsMeta, reasons.isAcceptableOrUnknown(data['reasons']!, _reasonsMeta));
    } else if (isInserting) {
      context.missing(_reasonsMeta);
    }
    if (data.containsKey('bank_event_id')) {
      context.handle(_bankEventIdMeta, bankEventId.isAcceptableOrUnknown(data['bank_event_id']!, _bankEventIdMeta));
    }
    if (data.containsKey('image_hash')) {
      context.handle(_imageHashMeta, imageHash.isAcceptableOrUnknown(data['image_hash']!, _imageHashMeta));
    }
    if (data.containsKey('checked_at')) {
      context.handle(_checkedAtMeta, checkedAt.isAcceptableOrUnknown(data['checked_at']!, _checkedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptCheck(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amountKobo: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount_kobo']),
      sender: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}sender']),
      bank: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}bank']),
      receiptTime: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}receipt_time']),
      verdict: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}verdict'])!,
      reasons: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}reasons'])!,
      bankEventId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}bank_event_id']),
      imageHash: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}image_hash']),
      checkedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}checked_at'])!,
    );
  }

  @override
  $ReceiptChecksTable createAlias(String alias) {
    return $ReceiptChecksTable(attachedDatabase, alias);
  }
}

class ReceiptCheck extends DataClass implements Insertable<ReceiptCheck> {
  final int id;
  final int? amountKobo;
  final String? sender;
  final String? bank;
  final DateTime? receiptTime;
  final String verdict;
  final String reasons;
  final int? bankEventId;
  final String? imageHash;
  final DateTime checkedAt;
  const ReceiptCheck({
    required this.id,
    this.amountKobo,
    this.sender,
    this.bank,
    this.receiptTime,
    required this.verdict,
    required this.reasons,
    this.bankEventId,
    this.imageHash,
    required this.checkedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || amountKobo != null) {
      map['amount_kobo'] = Variable<int>(amountKobo);
    }
    if (!nullToAbsent || sender != null) {
      map['sender'] = Variable<String>(sender);
    }
    if (!nullToAbsent || bank != null) {
      map['bank'] = Variable<String>(bank);
    }
    if (!nullToAbsent || receiptTime != null) {
      map['receipt_time'] = Variable<DateTime>(receiptTime);
    }
    map['verdict'] = Variable<String>(verdict);
    map['reasons'] = Variable<String>(reasons);
    if (!nullToAbsent || bankEventId != null) {
      map['bank_event_id'] = Variable<int>(bankEventId);
    }
    if (!nullToAbsent || imageHash != null) {
      map['image_hash'] = Variable<String>(imageHash);
    }
    map['checked_at'] = Variable<DateTime>(checkedAt);
    return map;
  }

  ReceiptChecksCompanion toCompanion(bool nullToAbsent) {
    return ReceiptChecksCompanion(
      id: Value(id),
      amountKobo: amountKobo == null && nullToAbsent ? const Value.absent() : Value(amountKobo),
      sender: sender == null && nullToAbsent ? const Value.absent() : Value(sender),
      bank: bank == null && nullToAbsent ? const Value.absent() : Value(bank),
      receiptTime: receiptTime == null && nullToAbsent ? const Value.absent() : Value(receiptTime),
      verdict: Value(verdict),
      reasons: Value(reasons),
      bankEventId: bankEventId == null && nullToAbsent ? const Value.absent() : Value(bankEventId),
      imageHash: imageHash == null && nullToAbsent ? const Value.absent() : Value(imageHash),
      checkedAt: Value(checkedAt),
    );
  }

  factory ReceiptCheck.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptCheck(
      id: serializer.fromJson<int>(json['id']),
      amountKobo: serializer.fromJson<int?>(json['amountKobo']),
      sender: serializer.fromJson<String?>(json['sender']),
      bank: serializer.fromJson<String?>(json['bank']),
      receiptTime: serializer.fromJson<DateTime?>(json['receiptTime']),
      verdict: serializer.fromJson<String>(json['verdict']),
      reasons: serializer.fromJson<String>(json['reasons']),
      bankEventId: serializer.fromJson<int?>(json['bankEventId']),
      imageHash: serializer.fromJson<String?>(json['imageHash']),
      checkedAt: serializer.fromJson<DateTime>(json['checkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amountKobo': serializer.toJson<int?>(amountKobo),
      'sender': serializer.toJson<String?>(sender),
      'bank': serializer.toJson<String?>(bank),
      'receiptTime': serializer.toJson<DateTime?>(receiptTime),
      'verdict': serializer.toJson<String>(verdict),
      'reasons': serializer.toJson<String>(reasons),
      'bankEventId': serializer.toJson<int?>(bankEventId),
      'imageHash': serializer.toJson<String?>(imageHash),
      'checkedAt': serializer.toJson<DateTime>(checkedAt),
    };
  }

  ReceiptCheck copyWith({
    int? id,
    Value<int?> amountKobo = const Value.absent(),
    Value<String?> sender = const Value.absent(),
    Value<String?> bank = const Value.absent(),
    Value<DateTime?> receiptTime = const Value.absent(),
    String? verdict,
    String? reasons,
    Value<int?> bankEventId = const Value.absent(),
    Value<String?> imageHash = const Value.absent(),
    DateTime? checkedAt,
  }) => ReceiptCheck(
    id: id ?? this.id,
    amountKobo: amountKobo.present ? amountKobo.value : this.amountKobo,
    sender: sender.present ? sender.value : this.sender,
    bank: bank.present ? bank.value : this.bank,
    receiptTime: receiptTime.present ? receiptTime.value : this.receiptTime,
    verdict: verdict ?? this.verdict,
    reasons: reasons ?? this.reasons,
    bankEventId: bankEventId.present ? bankEventId.value : this.bankEventId,
    imageHash: imageHash.present ? imageHash.value : this.imageHash,
    checkedAt: checkedAt ?? this.checkedAt,
  );
  ReceiptCheck copyWithCompanion(ReceiptChecksCompanion data) {
    return ReceiptCheck(
      id: data.id.present ? data.id.value : this.id,
      amountKobo: data.amountKobo.present ? data.amountKobo.value : this.amountKobo,
      sender: data.sender.present ? data.sender.value : this.sender,
      bank: data.bank.present ? data.bank.value : this.bank,
      receiptTime: data.receiptTime.present ? data.receiptTime.value : this.receiptTime,
      verdict: data.verdict.present ? data.verdict.value : this.verdict,
      reasons: data.reasons.present ? data.reasons.value : this.reasons,
      bankEventId: data.bankEventId.present ? data.bankEventId.value : this.bankEventId,
      imageHash: data.imageHash.present ? data.imageHash.value : this.imageHash,
      checkedAt: data.checkedAt.present ? data.checkedAt.value : this.checkedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptCheck(')
          ..write('id: $id, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('sender: $sender, ')
          ..write('bank: $bank, ')
          ..write('receiptTime: $receiptTime, ')
          ..write('verdict: $verdict, ')
          ..write('reasons: $reasons, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('imageHash: $imageHash, ')
          ..write('checkedAt: $checkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, amountKobo, sender, bank, receiptTime, verdict, reasons, bankEventId, imageHash, checkedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptCheck &&
          other.id == this.id &&
          other.amountKobo == this.amountKobo &&
          other.sender == this.sender &&
          other.bank == this.bank &&
          other.receiptTime == this.receiptTime &&
          other.verdict == this.verdict &&
          other.reasons == this.reasons &&
          other.bankEventId == this.bankEventId &&
          other.imageHash == this.imageHash &&
          other.checkedAt == this.checkedAt);
}

class ReceiptChecksCompanion extends UpdateCompanion<ReceiptCheck> {
  final Value<int> id;
  final Value<int?> amountKobo;
  final Value<String?> sender;
  final Value<String?> bank;
  final Value<DateTime?> receiptTime;
  final Value<String> verdict;
  final Value<String> reasons;
  final Value<int?> bankEventId;
  final Value<String?> imageHash;
  final Value<DateTime> checkedAt;
  const ReceiptChecksCompanion({
    this.id = const Value.absent(),
    this.amountKobo = const Value.absent(),
    this.sender = const Value.absent(),
    this.bank = const Value.absent(),
    this.receiptTime = const Value.absent(),
    this.verdict = const Value.absent(),
    this.reasons = const Value.absent(),
    this.bankEventId = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.checkedAt = const Value.absent(),
  });
  ReceiptChecksCompanion.insert({
    this.id = const Value.absent(),
    this.amountKobo = const Value.absent(),
    this.sender = const Value.absent(),
    this.bank = const Value.absent(),
    this.receiptTime = const Value.absent(),
    required String verdict,
    required String reasons,
    this.bankEventId = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.checkedAt = const Value.absent(),
  }) : verdict = Value(verdict),
       reasons = Value(reasons);
  static Insertable<ReceiptCheck> custom({
    Expression<int>? id,
    Expression<int>? amountKobo,
    Expression<String>? sender,
    Expression<String>? bank,
    Expression<DateTime>? receiptTime,
    Expression<String>? verdict,
    Expression<String>? reasons,
    Expression<int>? bankEventId,
    Expression<String>? imageHash,
    Expression<DateTime>? checkedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amountKobo != null) 'amount_kobo': amountKobo,
      if (sender != null) 'sender': sender,
      if (bank != null) 'bank': bank,
      if (receiptTime != null) 'receipt_time': receiptTime,
      if (verdict != null) 'verdict': verdict,
      if (reasons != null) 'reasons': reasons,
      if (bankEventId != null) 'bank_event_id': bankEventId,
      if (imageHash != null) 'image_hash': imageHash,
      if (checkedAt != null) 'checked_at': checkedAt,
    });
  }

  ReceiptChecksCompanion copyWith({
    Value<int>? id,
    Value<int?>? amountKobo,
    Value<String?>? sender,
    Value<String?>? bank,
    Value<DateTime?>? receiptTime,
    Value<String>? verdict,
    Value<String>? reasons,
    Value<int?>? bankEventId,
    Value<String?>? imageHash,
    Value<DateTime>? checkedAt,
  }) {
    return ReceiptChecksCompanion(
      id: id ?? this.id,
      amountKobo: amountKobo ?? this.amountKobo,
      sender: sender ?? this.sender,
      bank: bank ?? this.bank,
      receiptTime: receiptTime ?? this.receiptTime,
      verdict: verdict ?? this.verdict,
      reasons: reasons ?? this.reasons,
      bankEventId: bankEventId ?? this.bankEventId,
      imageHash: imageHash ?? this.imageHash,
      checkedAt: checkedAt ?? this.checkedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amountKobo.present) {
      map['amount_kobo'] = Variable<int>(amountKobo.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (bank.present) {
      map['bank'] = Variable<String>(bank.value);
    }
    if (receiptTime.present) {
      map['receipt_time'] = Variable<DateTime>(receiptTime.value);
    }
    if (verdict.present) {
      map['verdict'] = Variable<String>(verdict.value);
    }
    if (reasons.present) {
      map['reasons'] = Variable<String>(reasons.value);
    }
    if (bankEventId.present) {
      map['bank_event_id'] = Variable<int>(bankEventId.value);
    }
    if (imageHash.present) {
      map['image_hash'] = Variable<String>(imageHash.value);
    }
    if (checkedAt.present) {
      map['checked_at'] = Variable<DateTime>(checkedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptChecksCompanion(')
          ..write('id: $id, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('sender: $sender, ')
          ..write('bank: $bank, ')
          ..write('receiptTime: $receiptTime, ')
          ..write('verdict: $verdict, ')
          ..write('reasons: $reasons, ')
          ..write('bankEventId: $bankEventId, ')
          ..write('imageHash: $imageHash, ')
          ..write('checkedAt: $checkedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(_keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(_valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(key: serializer.fromJson<String>(json['key']), value: serializer.fromJson<String>(json['value']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'key': serializer.toJson<String>(key), 'value': serializer.toJson<String>(value)};
  }

  AppSetting copyWith({String? key, String? value}) => AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is AppSetting && other.key == this.key && other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({required String key, required String value, this.rowid = const Value.absent()})
    : key = Value(key),
      value = Value(value);
  static Insertable<AppSetting> custom({Expression<String>? key, Expression<String>? value, Expression<int>? rowid}) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppSettingsCompanion(key: key ?? this.key, value: value ?? this.value, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$EriDb extends GeneratedDatabase {
  _$EriDb(QueryExecutor e) : super(e);
  $EriDbManager get managers => $EriDbManager(this);
  late final $RawNotificationsTable rawNotifications = $RawNotificationsTable(this);
  late final $BankEventsTable bankEvents = $BankEventsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $IgnoreRulesTable ignoreRules = $IgnoreRulesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $PaymentClaimsTable paymentClaims = $PaymentClaimsTable(this);
  late final $ReceiptChecksTable receiptChecks = $ReceiptChecksTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rawNotifications,
    bankEvents,
    products,
    stockMovements,
    orders,
    orderItems,
    matches,
    ignoreRules,
    expenses,
    paymentClaims,
    receiptChecks,
    appSettings,
  ];
}

typedef $$RawNotificationsTableCreateCompanionBuilder =
    RawNotificationsCompanion Function({
      Value<int> id,
      required String package,
      required String title,
      required String body,
      required DateTime postedAt,
      required String rawHash,
      Value<bool> parsed,
    });
typedef $$RawNotificationsTableUpdateCompanionBuilder =
    RawNotificationsCompanion Function({
      Value<int> id,
      Value<String> package,
      Value<String> title,
      Value<String> body,
      Value<DateTime> postedAt,
      Value<String> rawHash,
      Value<bool> parsed,
    });

class $$RawNotificationsTableFilterComposer extends Composer<_$EriDb, $RawNotificationsTable> {
  $$RawNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get package =>
      $composableBuilder(column: $table.package, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get postedAt =>
      $composableBuilder(column: $table.postedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawHash =>
      $composableBuilder(column: $table.rawHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get parsed =>
      $composableBuilder(column: $table.parsed, builder: (column) => ColumnFilters(column));
}

class $$RawNotificationsTableOrderingComposer extends Composer<_$EriDb, $RawNotificationsTable> {
  $$RawNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get package =>
      $composableBuilder(column: $table.package, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get postedAt =>
      $composableBuilder(column: $table.postedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawHash =>
      $composableBuilder(column: $table.rawHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get parsed =>
      $composableBuilder(column: $table.parsed, builder: (column) => ColumnOrderings(column));
}

class $$RawNotificationsTableAnnotationComposer extends Composer<_$EriDb, $RawNotificationsTable> {
  $$RawNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get package => $composableBuilder(column: $table.package, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body => $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get postedAt => $composableBuilder(column: $table.postedAt, builder: (column) => column);

  GeneratedColumn<String> get rawHash => $composableBuilder(column: $table.rawHash, builder: (column) => column);

  GeneratedColumn<bool> get parsed => $composableBuilder(column: $table.parsed, builder: (column) => column);
}

class $$RawNotificationsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $RawNotificationsTable,
          RawNotification,
          $$RawNotificationsTableFilterComposer,
          $$RawNotificationsTableOrderingComposer,
          $$RawNotificationsTableAnnotationComposer,
          $$RawNotificationsTableCreateCompanionBuilder,
          $$RawNotificationsTableUpdateCompanionBuilder,
          (RawNotification, BaseReferences<_$EriDb, $RawNotificationsTable, RawNotification>),
          RawNotification,
          PrefetchHooks Function()
        > {
  $$RawNotificationsTableTableManager(_$EriDb db, $RawNotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RawNotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RawNotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RawNotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> package = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> postedAt = const Value.absent(),
                Value<String> rawHash = const Value.absent(),
                Value<bool> parsed = const Value.absent(),
              }) => RawNotificationsCompanion(
                id: id,
                package: package,
                title: title,
                body: body,
                postedAt: postedAt,
                rawHash: rawHash,
                parsed: parsed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String package,
                required String title,
                required String body,
                required DateTime postedAt,
                required String rawHash,
                Value<bool> parsed = const Value.absent(),
              }) => RawNotificationsCompanion.insert(
                id: id,
                package: package,
                title: title,
                body: body,
                postedAt: postedAt,
                rawHash: rawHash,
                parsed: parsed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RawNotificationsTable, RawNotification>(table),
                  BaseReferences<_$EriDb, $RawNotificationsTable, RawNotification>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RawNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $RawNotificationsTable,
      RawNotification,
      $$RawNotificationsTableFilterComposer,
      $$RawNotificationsTableOrderingComposer,
      $$RawNotificationsTableAnnotationComposer,
      $$RawNotificationsTableCreateCompanionBuilder,
      $$RawNotificationsTableUpdateCompanionBuilder,
      (RawNotification, BaseReferences<_$EriDb, $RawNotificationsTable, RawNotification>),
      RawNotification,
      PrefetchHooks Function()
    >;
typedef $$BankEventsTableCreateCompanionBuilder =
    BankEventsCompanion Function({
      Value<int> id,
      required String rawHash,
      required String bank,
      required String direction,
      required int amountKobo,
      Value<String?> counterparty,
      Value<String?> narration,
      Value<String?> sessionId,
      required DateTime occurredAt,
      Value<String> parser,
      required double confidence,
    });
typedef $$BankEventsTableUpdateCompanionBuilder =
    BankEventsCompanion Function({
      Value<int> id,
      Value<String> rawHash,
      Value<String> bank,
      Value<String> direction,
      Value<int> amountKobo,
      Value<String?> counterparty,
      Value<String?> narration,
      Value<String?> sessionId,
      Value<DateTime> occurredAt,
      Value<String> parser,
      Value<double> confidence,
    });

final class $$BankEventsTableReferences extends BaseReferences<_$EriDb, $BankEventsTable, BankEvent> {
  $$BankEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatchesTable, List<SaleMatch>> _matchesRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.matches, aliasName: 'bank_events__id__matches__bank_event_id');

  $$MatchesTableProcessedTableManager get matchesRefs {
    final manager = $$MatchesTableTableManager(
      $_db,
      $_db.matches,
    ).filter((f) => f.bankEventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.expenses, aliasName: 'bank_events__id__expenses__bank_event_id');

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.bankEventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentClaimsTable, List<PaymentClaim>> _paymentClaimsRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.paymentClaims, aliasName: 'bank_events__id__payment_claims__bank_event_id');

  $$PaymentClaimsTableProcessedTableManager get paymentClaimsRefs {
    final manager = $$PaymentClaimsTableTableManager(
      $_db,
      $_db.paymentClaims,
    ).filter((f) => f.bankEventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentClaimsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReceiptChecksTable, List<ReceiptCheck>> _receiptChecksRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.receiptChecks, aliasName: 'bank_events__id__receipt_checks__bank_event_id');

  $$ReceiptChecksTableProcessedTableManager get receiptChecksRefs {
    final manager = $$ReceiptChecksTableTableManager(
      $_db,
      $_db.receiptChecks,
    ).filter((f) => f.bankEventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptChecksRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BankEventsTableFilterComposer extends Composer<_$EriDb, $BankEventsTable> {
  $$BankEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawHash =>
      $composableBuilder(column: $table.rawHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bank => $composableBuilder(column: $table.bank, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get counterparty =>
      $composableBuilder(column: $table.counterparty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get narration =>
      $composableBuilder(column: $table.narration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt =>
      $composableBuilder(column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parser =>
      $composableBuilder(column: $table.parser, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence =>
      $composableBuilder(column: $table.confidence, builder: (column) => ColumnFilters(column));

  Expression<bool> matchesRefs(Expression<bool> Function($$MatchesTableFilterComposer f) f) {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MatchesTableFilterComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentClaimsRefs(Expression<bool> Function($$PaymentClaimsTableFilterComposer f) f) {
    final $$PaymentClaimsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentClaims,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PaymentClaimsTableFilterComposer(
            $db: $db,
            $table: $db.paymentClaims,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptChecksRefs(Expression<bool> Function($$ReceiptChecksTableFilterComposer f) f) {
    final $$ReceiptChecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receiptChecks,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ReceiptChecksTableFilterComposer(
            $db: $db,
            $table: $db.receiptChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BankEventsTableOrderingComposer extends Composer<_$EriDb, $BankEventsTable> {
  $$BankEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawHash =>
      $composableBuilder(column: $table.rawHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bank =>
      $composableBuilder(column: $table.bank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get counterparty =>
      $composableBuilder(column: $table.counterparty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get narration =>
      $composableBuilder(column: $table.narration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt =>
      $composableBuilder(column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parser =>
      $composableBuilder(column: $table.parser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence =>
      $composableBuilder(column: $table.confidence, builder: (column) => ColumnOrderings(column));
}

class $$BankEventsTableAnnotationComposer extends Composer<_$EriDb, $BankEventsTable> {
  $$BankEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawHash => $composableBuilder(column: $table.rawHash, builder: (column) => column);

  GeneratedColumn<String> get bank => $composableBuilder(column: $table.bank, builder: (column) => column);

  GeneratedColumn<String> get direction => $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get amountKobo => $composableBuilder(column: $table.amountKobo, builder: (column) => column);

  GeneratedColumn<String> get counterparty =>
      $composableBuilder(column: $table.counterparty, builder: (column) => column);

  GeneratedColumn<String> get narration => $composableBuilder(column: $table.narration, builder: (column) => column);

  GeneratedColumn<String> get sessionId => $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt =>
      $composableBuilder(column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get parser => $composableBuilder(column: $table.parser, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(column: $table.confidence, builder: (column) => column);

  Expression<T> matchesRefs<T extends Object>(Expression<T> Function($$MatchesTableAnnotationComposer a) f) {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentClaimsRefs<T extends Object>(
    Expression<T> Function($$PaymentClaimsTableAnnotationComposer a) f,
  ) {
    final $$PaymentClaimsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentClaims,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PaymentClaimsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentClaims,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptChecksRefs<T extends Object>(
    Expression<T> Function($$ReceiptChecksTableAnnotationComposer a) f,
  ) {
    final $$ReceiptChecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receiptChecks,
      getReferencedColumn: (t) => t.bankEventId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ReceiptChecksTableAnnotationComposer(
            $db: $db,
            $table: $db.receiptChecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BankEventsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $BankEventsTable,
          BankEvent,
          $$BankEventsTableFilterComposer,
          $$BankEventsTableOrderingComposer,
          $$BankEventsTableAnnotationComposer,
          $$BankEventsTableCreateCompanionBuilder,
          $$BankEventsTableUpdateCompanionBuilder,
          (BankEvent, $$BankEventsTableReferences),
          BankEvent,
          PrefetchHooks Function({bool matchesRefs, bool expensesRefs, bool paymentClaimsRefs, bool receiptChecksRefs})
        > {
  $$BankEventsTableTableManager(_$EriDb db, $BankEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BankEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BankEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BankEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rawHash = const Value.absent(),
                Value<String> bank = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<int> amountKobo = const Value.absent(),
                Value<String?> counterparty = const Value.absent(),
                Value<String?> narration = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> parser = const Value.absent(),
                Value<double> confidence = const Value.absent(),
              }) => BankEventsCompanion(
                id: id,
                rawHash: rawHash,
                bank: bank,
                direction: direction,
                amountKobo: amountKobo,
                counterparty: counterparty,
                narration: narration,
                sessionId: sessionId,
                occurredAt: occurredAt,
                parser: parser,
                confidence: confidence,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String rawHash,
                required String bank,
                required String direction,
                required int amountKobo,
                Value<String?> counterparty = const Value.absent(),
                Value<String?> narration = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
                required DateTime occurredAt,
                Value<String> parser = const Value.absent(),
                required double confidence,
              }) => BankEventsCompanion.insert(
                id: id,
                rawHash: rawHash,
                bank: bank,
                direction: direction,
                amountKobo: amountKobo,
                counterparty: counterparty,
                narration: narration,
                sessionId: sessionId,
                occurredAt: occurredAt,
                parser: parser,
                confidence: confidence,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$BankEventsTable, BankEvent>(table), $$BankEventsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({matchesRefs = false, expensesRefs = false, paymentClaimsRefs = false, receiptChecksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (matchesRefs) db.matches,
                    if (expensesRefs) db.expenses,
                    if (paymentClaimsRefs) db.paymentClaims,
                    if (receiptChecksRefs) db.receiptChecks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (matchesRefs)
                        await $_getPrefetchedDataByColumns<BankEvent, $BankEventsTable, SaleMatch, $MatchesTable>(
                          currentTable: table,
                          referencedTable: $$BankEventsTableReferences._matchesRefsTable(db),
                          managerFromTypedResult: (p0) => $$BankEventsTableReferences(db, table, p0).matchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_event_id',
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedDataByColumns<BankEvent, $BankEventsTable, Expense, $ExpensesTable>(
                          currentTable: table,
                          referencedTable: $$BankEventsTableReferences._expensesRefsTable(db),
                          managerFromTypedResult: (p0) => $$BankEventsTableReferences(db, table, p0).expensesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_event_id',
                          typedResults: items,
                        ),
                      if (paymentClaimsRefs)
                        await $_getPrefetchedDataByColumns<
                          BankEvent,
                          $BankEventsTable,
                          PaymentClaim,
                          $PaymentClaimsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BankEventsTableReferences._paymentClaimsRefsTable(db),
                          managerFromTypedResult: (p0) => $$BankEventsTableReferences(db, table, p0).paymentClaimsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_event_id',
                          typedResults: items,
                        ),
                      if (receiptChecksRefs)
                        await $_getPrefetchedDataByColumns<
                          BankEvent,
                          $BankEventsTable,
                          ReceiptCheck,
                          $ReceiptChecksTable
                        >(
                          currentTable: table,
                          referencedTable: $$BankEventsTableReferences._receiptChecksRefsTable(db),
                          managerFromTypedResult: (p0) => $$BankEventsTableReferences(db, table, p0).receiptChecksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_event_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BankEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $BankEventsTable,
      BankEvent,
      $$BankEventsTableFilterComposer,
      $$BankEventsTableOrderingComposer,
      $$BankEventsTableAnnotationComposer,
      $$BankEventsTableCreateCompanionBuilder,
      $$BankEventsTableUpdateCompanionBuilder,
      (BankEvent, $$BankEventsTableReferences),
      BankEvent,
      PrefetchHooks Function({bool matchesRefs, bool expensesRefs, bool paymentClaimsRefs, bool receiptChecksRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> aliases,
      required int sellPriceKobo,
      required int avgCostKobo,
      Value<int> qtyOnHand,
      Value<int> lowStockThreshold,
      Value<bool> active,
      Value<DateTime> createdAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> aliases,
      Value<int> sellPriceKobo,
      Value<int> avgCostKobo,
      Value<int> qtyOnHand,
      Value<int> lowStockThreshold,
      Value<bool> active,
      Value<DateTime> createdAt,
    });

final class $$ProductsTableReferences extends BaseReferences<_$EriDb, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>> _stockMovementsRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.stockMovements, aliasName: 'products__id__stock_movements__product_id');

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>> _orderItemsRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.orderItems, aliasName: 'products__id__order_items__product_id');

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductsTableFilterComposer extends Composer<_$EriDb, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sellPriceKobo =>
      $composableBuilder(column: $table.sellPriceKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgCostKobo =>
      $composableBuilder(column: $table.avgCostKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qtyOnHand =>
      $composableBuilder(column: $table.qtyOnHand, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lowStockThreshold =>
      $composableBuilder(column: $table.lowStockThreshold, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> stockMovementsRefs(Expression<bool> Function($$StockMovementsTableFilterComposer f) f) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> orderItemsRefs(Expression<bool> Function($$OrderItemsTableFilterComposer f) f) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.productId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer extends Composer<_$EriDb, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sellPriceKobo =>
      $composableBuilder(column: $table.sellPriceKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgCostKobo =>
      $composableBuilder(column: $table.avgCostKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qtyOnHand =>
      $composableBuilder(column: $table.qtyOnHand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lowStockThreshold =>
      $composableBuilder(column: $table.lowStockThreshold, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer extends Composer<_$EriDb, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get aliases => $composableBuilder(column: $table.aliases, builder: (column) => column);

  GeneratedColumn<int> get sellPriceKobo =>
      $composableBuilder(column: $table.sellPriceKobo, builder: (column) => column);

  GeneratedColumn<int> get avgCostKobo => $composableBuilder(column: $table.avgCostKobo, builder: (column) => column);

  GeneratedColumn<int> get qtyOnHand => $composableBuilder(column: $table.qtyOnHand, builder: (column) => column);

  GeneratedColumn<int> get lowStockThreshold =>
      $composableBuilder(column: $table.lowStockThreshold, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> orderItemsRefs<T extends Object>(Expression<T> Function($$OrderItemsTableAnnotationComposer a) f) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.productId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool stockMovementsRefs, bool orderItemsRefs})
        > {
  $$ProductsTableTableManager(_$EriDb db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> aliases = const Value.absent(),
                Value<int> sellPriceKobo = const Value.absent(),
                Value<int> avgCostKobo = const Value.absent(),
                Value<int> qtyOnHand = const Value.absent(),
                Value<int> lowStockThreshold = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                aliases: aliases,
                sellPriceKobo: sellPriceKobo,
                avgCostKobo: avgCostKobo,
                qtyOnHand: qtyOnHand,
                lowStockThreshold: lowStockThreshold,
                active: active,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> aliases = const Value.absent(),
                required int sellPriceKobo,
                required int avgCostKobo,
                Value<int> qtyOnHand = const Value.absent(),
                Value<int> lowStockThreshold = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                aliases: aliases,
                sellPriceKobo: sellPriceKobo,
                avgCostKobo: avgCostKobo,
                qtyOnHand: qtyOnHand,
                lowStockThreshold: lowStockThreshold,
                active: active,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$ProductsTable, Product>(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({stockMovementsRefs = false, orderItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (stockMovementsRefs) db.stockMovements, if (orderItemsRefs) db.orderItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stockMovementsRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, StockMovement, $StockMovementsTable>(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences._stockMovementsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).stockMovementsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'product_id',
                      typedResults: items,
                    ),
                  if (orderItemsRefs)
                    await $_getPrefetchedDataByColumns<Product, $ProductsTable, OrderItem, $OrderItemsTable>(
                      currentTable: table,
                      referencedTable: $$ProductsTableReferences._orderItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProductsTableReferences(db, table, p0).orderItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'product_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool stockMovementsRefs, bool orderItemsRefs})
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required int productId,
      required int delta,
      required String reason,
      Value<int?> unitCostKobo,
      Value<int?> orderId,
      Value<DateTime> createdAt,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> delta,
      Value<String> reason,
      Value<int?> unitCostKobo,
      Value<int?> orderId,
      Value<DateTime> createdAt,
    });

final class $$StockMovementsTableReferences extends BaseReferences<_$EriDb, $StockMovementsTable, StockMovement> {
  $$StockMovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$EriDb db) =>
      db.products.createAlias('stock_movements__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StockMovementsTableFilterComposer extends Composer<_$EriDb, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get delta => $composableBuilder(column: $table.delta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitCostKobo =>
      $composableBuilder(column: $table.unitCostKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableOrderingComposer extends Composer<_$EriDb, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitCostKobo =>
      $composableBuilder(column: $table.unitCostKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableAnnotationComposer extends Composer<_$EriDb, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get delta => $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get reason => $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<int> get unitCostKobo => $composableBuilder(column: $table.unitCostKobo, builder: (column) => column);

  GeneratedColumn<int> get orderId => $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (StockMovement, $$StockMovementsTableReferences),
          StockMovement,
          PrefetchHooks Function({bool productId})
        > {
  $$StockMovementsTableTableManager(_$EriDb db, $StockMovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> delta = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int?> unitCostKobo = const Value.absent(),
                Value<int?> orderId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                productId: productId,
                delta: delta,
                reason: reason,
                unitCostKobo: unitCostKobo,
                orderId: orderId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int delta,
                required String reason,
                Value<int?> unitCostKobo = const Value.absent(),
                Value<int?> orderId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                productId: productId,
                delta: delta,
                reason: reason,
                unitCostKobo: unitCostKobo,
                orderId: orderId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockMovementsTable, StockMovement>(table),
                  $$StockMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockMovementsTableReferences._productIdTable(db),
                                referencedColumn: $$StockMovementsTableReferences._productIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (StockMovement, $$StockMovementsTableReferences),
      StockMovement,
      PrefetchHooks Function({bool productId})
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required String code,
      Value<String?> customerName,
      required String status,
      Value<int?> expectedAmountKobo,
      Value<int> deliveryFeeKobo,
      Value<DateTime> createdAt,
      Value<DateTime?> paidAt,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String?> customerName,
      Value<String> status,
      Value<int?> expectedAmountKobo,
      Value<int> deliveryFeeKobo,
      Value<DateTime> createdAt,
      Value<DateTime?> paidAt,
    });

final class $$OrdersTableReferences extends BaseReferences<_$EriDb, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>> _orderItemsRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.orderItems, aliasName: 'orders__id__order_items__order_id');

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MatchesTable, List<SaleMatch>> _matchesRefsTable(_$EriDb db) =>
      MultiTypedResultKey.fromTable(db.matches, aliasName: 'orders__id__matches__order_id');

  $$MatchesTableProcessedTableManager get matchesRefs {
    final manager = $$MatchesTableTableManager(
      $_db,
      $_db.matches,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrdersTableFilterComposer extends Composer<_$EriDb, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerName =>
      $composableBuilder(column: $table.customerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expectedAmountKobo =>
      $composableBuilder(column: $table.expectedAmountKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deliveryFeeKobo =>
      $composableBuilder(column: $table.deliveryFeeKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => ColumnFilters(column));

  Expression<bool> orderItemsRefs(Expression<bool> Function($$OrderItemsTableFilterComposer f) f) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> matchesRefs(Expression<bool> Function($$MatchesTableFilterComposer f) f) {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.orderId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MatchesTableFilterComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer extends Composer<_$EriDb, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerName =>
      $composableBuilder(column: $table.customerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expectedAmountKobo =>
      $composableBuilder(column: $table.expectedAmountKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deliveryFeeKobo =>
      $composableBuilder(column: $table.deliveryFeeKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => ColumnOrderings(column));
}

class $$OrdersTableAnnotationComposer extends Composer<_$EriDb, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code => $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get customerName =>
      $composableBuilder(column: $table.customerName, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get expectedAmountKobo =>
      $composableBuilder(column: $table.expectedAmountKobo, builder: (column) => column);

  GeneratedColumn<int> get deliveryFeeKobo =>
      $composableBuilder(column: $table.deliveryFeeKobo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt => $composableBuilder(column: $table.paidAt, builder: (column) => column);

  Expression<T> orderItemsRefs<T extends Object>(Expression<T> Function($$OrderItemsTableAnnotationComposer a) f) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> matchesRefs<T extends Object>(Expression<T> Function($$MatchesTableAnnotationComposer a) f) {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matches,
      getReferencedColumn: (t) => t.orderId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.matches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, $$OrdersTableReferences),
          Order,
          PrefetchHooks Function({bool orderItemsRefs, bool matchesRefs})
        > {
  $$OrdersTableTableManager(_$EriDb db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> expectedAmountKobo = const Value.absent(),
                Value<int> deliveryFeeKobo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                code: code,
                customerName: customerName,
                status: status,
                expectedAmountKobo: expectedAmountKobo,
                deliveryFeeKobo: deliveryFeeKobo,
                createdAt: createdAt,
                paidAt: paidAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                Value<String?> customerName = const Value.absent(),
                required String status,
                Value<int?> expectedAmountKobo = const Value.absent(),
                Value<int> deliveryFeeKobo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                code: code,
                customerName: customerName,
                status: status,
                expectedAmountKobo: expectedAmountKobo,
                deliveryFeeKobo: deliveryFeeKobo,
                createdAt: createdAt,
                paidAt: paidAt,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable<$OrdersTable, Order>(table), $$OrdersTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({orderItemsRefs = false, matchesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (orderItemsRefs) db.orderItems, if (matchesRefs) db.matches],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, OrderItem, $OrderItemsTable>(
                      currentTable: table,
                      referencedTable: $$OrdersTableReferences._orderItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).orderItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'order_id',
                      typedResults: items,
                    ),
                  if (matchesRefs)
                    await $_getPrefetchedDataByColumns<Order, $OrdersTable, SaleMatch, $MatchesTable>(
                      currentTable: table,
                      referencedTable: $$OrdersTableReferences._matchesRefsTable(db),
                      managerFromTypedResult: (p0) => $$OrdersTableReferences(db, table, p0).matchesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'order_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, $$OrdersTableReferences),
      Order,
      PrefetchHooks Function({bool orderItemsRefs, bool matchesRefs})
    >;
typedef $$OrderItemsTableCreateCompanionBuilder =
    OrderItemsCompanion Function({
      required int orderId,
      required int productId,
      required int qty,
      required int unitPriceKobo,
      required int unitCostKobo,
      Value<int> rowid,
    });
typedef $$OrderItemsTableUpdateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> orderId,
      Value<int> productId,
      Value<int> qty,
      Value<int> unitPriceKobo,
      Value<int> unitCostKobo,
      Value<int> rowid,
    });

final class $$OrderItemsTableReferences extends BaseReferences<_$EriDb, $OrderItemsTable, OrderItem> {
  $$OrderItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$EriDb db) => db.orders.createAlias('order_items__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _productIdTable(_$EriDb db) => db.products.createAlias('order_items__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager($_db, $_db.products).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$OrderItemsTableFilterComposer extends Composer<_$EriDb, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get qty => $composableBuilder(column: $table.qty, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitPriceKobo =>
      $composableBuilder(column: $table.unitPriceKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitCostKobo =>
      $composableBuilder(column: $table.unitCostKobo, builder: (column) => ColumnFilters(column));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableOrderingComposer extends Composer<_$EriDb, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get qty => $composableBuilder(column: $table.qty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitPriceKobo =>
      $composableBuilder(column: $table.unitPriceKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitCostKobo =>
      $composableBuilder(column: $table.unitCostKobo, builder: (column) => ColumnOrderings(column));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableAnnotationComposer extends Composer<_$EriDb, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get qty => $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get unitPriceKobo =>
      $composableBuilder(column: $table.unitPriceKobo, builder: (column) => column);

  GeneratedColumn<int> get unitCostKobo => $composableBuilder(column: $table.unitCostKobo, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $OrderItemsTable,
          OrderItem,
          $$OrderItemsTableFilterComposer,
          $$OrderItemsTableOrderingComposer,
          $$OrderItemsTableAnnotationComposer,
          $$OrderItemsTableCreateCompanionBuilder,
          $$OrderItemsTableUpdateCompanionBuilder,
          (OrderItem, $$OrderItemsTableReferences),
          OrderItem,
          PrefetchHooks Function({bool orderId, bool productId})
        > {
  $$OrderItemsTableTableManager(_$EriDb db, $OrderItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> unitPriceKobo = const Value.absent(),
                Value<int> unitCostKobo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsCompanion(
                orderId: orderId,
                productId: productId,
                qty: qty,
                unitPriceKobo: unitPriceKobo,
                unitCostKobo: unitCostKobo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int orderId,
                required int productId,
                required int qty,
                required int unitPriceKobo,
                required int unitCostKobo,
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsCompanion.insert(
                orderId: orderId,
                productId: productId,
                qty: qty,
                unitPriceKobo: unitPriceKobo,
                unitCostKobo: unitCostKobo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$OrderItemsTable, OrderItem>(table), $$OrderItemsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({orderId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderItemsTableReferences._orderIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences._orderIdTable(db).id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$OrderItemsTableReferences._productIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences._productIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $OrderItemsTable,
      OrderItem,
      $$OrderItemsTableFilterComposer,
      $$OrderItemsTableOrderingComposer,
      $$OrderItemsTableAnnotationComposer,
      $$OrderItemsTableCreateCompanionBuilder,
      $$OrderItemsTableUpdateCompanionBuilder,
      (OrderItem, $$OrderItemsTableReferences),
      OrderItem,
      PrefetchHooks Function({bool orderId, bool productId})
    >;
typedef $$MatchesTableCreateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      required int bankEventId,
      Value<int?> orderId,
      required String kind,
      required double confidence,
      Value<bool> confirmedByUser,
      Value<DateTime> createdAt,
    });
typedef $$MatchesTableUpdateCompanionBuilder =
    MatchesCompanion Function({
      Value<int> id,
      Value<int> bankEventId,
      Value<int?> orderId,
      Value<String> kind,
      Value<double> confidence,
      Value<bool> confirmedByUser,
      Value<DateTime> createdAt,
    });

final class $$MatchesTableReferences extends BaseReferences<_$EriDb, $MatchesTable, SaleMatch> {
  $$MatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BankEventsTable _bankEventIdTable(_$EriDb db) =>
      db.bankEvents.createAlias('matches__bank_event_id__bank_events__id');

  $$BankEventsTableProcessedTableManager get bankEventId {
    final $_column = $_itemColumn<int>('bank_event_id')!;

    final manager = $$BankEventsTableTableManager($_db, $_db.bankEvents).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrdersTable _orderIdTable(_$EriDb db) => db.orders.createAlias('matches__order_id__orders__id');

  $$OrdersTableProcessedTableManager? get orderId {
    final $_column = $_itemColumn<int>('order_id');
    if ($_column == null) return null;
    final manager = $$OrdersTableTableManager($_db, $_db.orders).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MatchesTableFilterComposer extends Composer<_$EriDb, $MatchesTable> {
  $$MatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get confidence =>
      $composableBuilder(column: $table.confidence, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get confirmedByUser =>
      $composableBuilder(column: $table.confirmedByUser, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BankEventsTableFilterComposer get bankEventId {
    final $$BankEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableFilterComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchesTableOrderingComposer extends Composer<_$EriDb, $MatchesTable> {
  $$MatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get confidence =>
      $composableBuilder(column: $table.confidence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get confirmedByUser =>
      $composableBuilder(column: $table.confirmedByUser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BankEventsTableOrderingComposer get bankEventId {
    final $$BankEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableOrderingComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchesTableAnnotationComposer extends Composer<_$EriDb, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind => $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(column: $table.confidence, builder: (column) => column);

  GeneratedColumn<bool> get confirmedByUser =>
      $composableBuilder(column: $table.confirmedByUser, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BankEventsTableAnnotationComposer get bankEventId {
    final $$BankEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchesTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $MatchesTable,
          SaleMatch,
          $$MatchesTableFilterComposer,
          $$MatchesTableOrderingComposer,
          $$MatchesTableAnnotationComposer,
          $$MatchesTableCreateCompanionBuilder,
          $$MatchesTableUpdateCompanionBuilder,
          (SaleMatch, $$MatchesTableReferences),
          SaleMatch,
          PrefetchHooks Function({bool bankEventId, bool orderId})
        > {
  $$MatchesTableTableManager(_$EriDb db, $MatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bankEventId = const Value.absent(),
                Value<int?> orderId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<bool> confirmedByUser = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MatchesCompanion(
                id: id,
                bankEventId: bankEventId,
                orderId: orderId,
                kind: kind,
                confidence: confidence,
                confirmedByUser: confirmedByUser,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bankEventId,
                Value<int?> orderId = const Value.absent(),
                required String kind,
                required double confidence,
                Value<bool> confirmedByUser = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MatchesCompanion.insert(
                id: id,
                bankEventId: bankEventId,
                orderId: orderId,
                kind: kind,
                confidence: confidence,
                confirmedByUser: confirmedByUser,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$MatchesTable, SaleMatch>(table), $$MatchesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bankEventId = false, orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankEventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankEventId,
                                referencedTable: $$MatchesTableReferences._bankEventIdTable(db),
                                referencedColumn: $$MatchesTableReferences._bankEventIdTable(db).id,
                              )
                              as T;
                    }
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$MatchesTableReferences._orderIdTable(db),
                                referencedColumn: $$MatchesTableReferences._orderIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $MatchesTable,
      SaleMatch,
      $$MatchesTableFilterComposer,
      $$MatchesTableOrderingComposer,
      $$MatchesTableAnnotationComposer,
      $$MatchesTableCreateCompanionBuilder,
      $$MatchesTableUpdateCompanionBuilder,
      (SaleMatch, $$MatchesTableReferences),
      SaleMatch,
      PrefetchHooks Function({bool bankEventId, bool orderId})
    >;
typedef $$IgnoreRulesTableCreateCompanionBuilder =
    IgnoreRulesCompanion Function({Value<int> id, required String senderKey, Value<DateTime> createdAt});
typedef $$IgnoreRulesTableUpdateCompanionBuilder =
    IgnoreRulesCompanion Function({Value<int> id, Value<String> senderKey, Value<DateTime> createdAt});

class $$IgnoreRulesTableFilterComposer extends Composer<_$EriDb, $IgnoreRulesTable> {
  $$IgnoreRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senderKey =>
      $composableBuilder(column: $table.senderKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$IgnoreRulesTableOrderingComposer extends Composer<_$EriDb, $IgnoreRulesTable> {
  $$IgnoreRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senderKey =>
      $composableBuilder(column: $table.senderKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$IgnoreRulesTableAnnotationComposer extends Composer<_$EriDb, $IgnoreRulesTable> {
  $$IgnoreRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get senderKey => $composableBuilder(column: $table.senderKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$IgnoreRulesTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $IgnoreRulesTable,
          IgnoreRule,
          $$IgnoreRulesTableFilterComposer,
          $$IgnoreRulesTableOrderingComposer,
          $$IgnoreRulesTableAnnotationComposer,
          $$IgnoreRulesTableCreateCompanionBuilder,
          $$IgnoreRulesTableUpdateCompanionBuilder,
          (IgnoreRule, BaseReferences<_$EriDb, $IgnoreRulesTable, IgnoreRule>),
          IgnoreRule,
          PrefetchHooks Function()
        > {
  $$IgnoreRulesTableTableManager(_$EriDb db, $IgnoreRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$IgnoreRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$IgnoreRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$IgnoreRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> senderKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IgnoreRulesCompanion(id: id, senderKey: senderKey, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String senderKey,
                Value<DateTime> createdAt = const Value.absent(),
              }) => IgnoreRulesCompanion.insert(id: id, senderKey: senderKey, createdAt: createdAt),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IgnoreRulesTable, IgnoreRule>(table),
                  BaseReferences<_$EriDb, $IgnoreRulesTable, IgnoreRule>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IgnoreRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $IgnoreRulesTable,
      IgnoreRule,
      $$IgnoreRulesTableFilterComposer,
      $$IgnoreRulesTableOrderingComposer,
      $$IgnoreRulesTableAnnotationComposer,
      $$IgnoreRulesTableCreateCompanionBuilder,
      $$IgnoreRulesTableUpdateCompanionBuilder,
      (IgnoreRule, BaseReferences<_$EriDb, $IgnoreRulesTable, IgnoreRule>),
      IgnoreRule,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required int bankEventId,
      required String category,
      Value<bool> setByUser,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({Value<int> id, Value<int> bankEventId, Value<String> category, Value<bool> setByUser});

final class $$ExpensesTableReferences extends BaseReferences<_$EriDb, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BankEventsTable _bankEventIdTable(_$EriDb db) =>
      db.bankEvents.createAlias('expenses__bank_event_id__bank_events__id');

  $$BankEventsTableProcessedTableManager get bankEventId {
    final $_column = $_itemColumn<int>('bank_event_id')!;

    final manager = $$BankEventsTableTableManager($_db, $_db.bankEvents).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpensesTableFilterComposer extends Composer<_$EriDb, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get setByUser =>
      $composableBuilder(column: $table.setByUser, builder: (column) => ColumnFilters(column));

  $$BankEventsTableFilterComposer get bankEventId {
    final $$BankEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableFilterComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer extends Composer<_$EriDb, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get setByUser =>
      $composableBuilder(column: $table.setByUser, builder: (column) => ColumnOrderings(column));

  $$BankEventsTableOrderingComposer get bankEventId {
    final $$BankEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableOrderingComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer extends Composer<_$EriDb, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category => $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get setByUser => $composableBuilder(column: $table.setByUser, builder: (column) => column);

  $$BankEventsTableAnnotationComposer get bankEventId {
    final $$BankEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool bankEventId})
        > {
  $$ExpensesTableTableManager(_$EriDb db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bankEventId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> setByUser = const Value.absent(),
              }) => ExpensesCompanion(id: id, bankEventId: bankEventId, category: category, setByUser: setByUser),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bankEventId,
                required String category,
                Value<bool> setByUser = const Value.absent(),
              }) =>
                  ExpensesCompanion.insert(id: id, bankEventId: bankEventId, category: category, setByUser: setByUser),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$ExpensesTable, Expense>(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bankEventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankEventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankEventId,
                                referencedTable: $$ExpensesTableReferences._bankEventIdTable(db),
                                referencedColumn: $$ExpensesTableReferences._bankEventIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool bankEventId})
    >;
typedef $$PaymentClaimsTableCreateCompanionBuilder =
    PaymentClaimsCompanion Function({
      Value<int> id,
      required String app,
      required String sender,
      Value<int?> amountKobo,
      Value<String?> preview,
      required String previewHash,
      required DateTime claimedAt,
      required DateTime expiresAt,
      required String status,
      Value<int?> bankEventId,
      Value<bool> dismissed,
    });
typedef $$PaymentClaimsTableUpdateCompanionBuilder =
    PaymentClaimsCompanion Function({
      Value<int> id,
      Value<String> app,
      Value<String> sender,
      Value<int?> amountKobo,
      Value<String?> preview,
      Value<String> previewHash,
      Value<DateTime> claimedAt,
      Value<DateTime> expiresAt,
      Value<String> status,
      Value<int?> bankEventId,
      Value<bool> dismissed,
    });

final class $$PaymentClaimsTableReferences extends BaseReferences<_$EriDb, $PaymentClaimsTable, PaymentClaim> {
  $$PaymentClaimsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BankEventsTable _bankEventIdTable(_$EriDb db) =>
      db.bankEvents.createAlias('payment_claims__bank_event_id__bank_events__id');

  $$BankEventsTableProcessedTableManager? get bankEventId {
    final $_column = $_itemColumn<int>('bank_event_id');
    if ($_column == null) return null;
    final manager = $$BankEventsTableTableManager($_db, $_db.bankEvents).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentClaimsTableFilterComposer extends Composer<_$EriDb, $PaymentClaimsTable> {
  $$PaymentClaimsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get app => $composableBuilder(column: $table.app, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previewHash =>
      $composableBuilder(column: $table.previewHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get claimedAt =>
      $composableBuilder(column: $table.claimedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get dismissed =>
      $composableBuilder(column: $table.dismissed, builder: (column) => ColumnFilters(column));

  $$BankEventsTableFilterComposer get bankEventId {
    final $$BankEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableFilterComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentClaimsTableOrderingComposer extends Composer<_$EriDb, $PaymentClaimsTable> {
  $$PaymentClaimsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get app =>
      $composableBuilder(column: $table.app, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previewHash =>
      $composableBuilder(column: $table.previewHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get claimedAt =>
      $composableBuilder(column: $table.claimedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get dismissed =>
      $composableBuilder(column: $table.dismissed, builder: (column) => ColumnOrderings(column));

  $$BankEventsTableOrderingComposer get bankEventId {
    final $$BankEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableOrderingComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentClaimsTableAnnotationComposer extends Composer<_$EriDb, $PaymentClaimsTable> {
  $$PaymentClaimsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get app => $composableBuilder(column: $table.app, builder: (column) => column);

  GeneratedColumn<String> get sender => $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<int> get amountKobo => $composableBuilder(column: $table.amountKobo, builder: (column) => column);

  GeneratedColumn<String> get preview => $composableBuilder(column: $table.preview, builder: (column) => column);

  GeneratedColumn<String> get previewHash =>
      $composableBuilder(column: $table.previewHash, builder: (column) => column);

  GeneratedColumn<DateTime> get claimedAt => $composableBuilder(column: $table.claimedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt => $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get dismissed => $composableBuilder(column: $table.dismissed, builder: (column) => column);

  $$BankEventsTableAnnotationComposer get bankEventId {
    final $$BankEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentClaimsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $PaymentClaimsTable,
          PaymentClaim,
          $$PaymentClaimsTableFilterComposer,
          $$PaymentClaimsTableOrderingComposer,
          $$PaymentClaimsTableAnnotationComposer,
          $$PaymentClaimsTableCreateCompanionBuilder,
          $$PaymentClaimsTableUpdateCompanionBuilder,
          (PaymentClaim, $$PaymentClaimsTableReferences),
          PaymentClaim,
          PrefetchHooks Function({bool bankEventId})
        > {
  $$PaymentClaimsTableTableManager(_$EriDb db, $PaymentClaimsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PaymentClaimsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PaymentClaimsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PaymentClaimsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> app = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<int?> amountKobo = const Value.absent(),
                Value<String?> preview = const Value.absent(),
                Value<String> previewHash = const Value.absent(),
                Value<DateTime> claimedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> bankEventId = const Value.absent(),
                Value<bool> dismissed = const Value.absent(),
              }) => PaymentClaimsCompanion(
                id: id,
                app: app,
                sender: sender,
                amountKobo: amountKobo,
                preview: preview,
                previewHash: previewHash,
                claimedAt: claimedAt,
                expiresAt: expiresAt,
                status: status,
                bankEventId: bankEventId,
                dismissed: dismissed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String app,
                required String sender,
                Value<int?> amountKobo = const Value.absent(),
                Value<String?> preview = const Value.absent(),
                required String previewHash,
                required DateTime claimedAt,
                required DateTime expiresAt,
                required String status,
                Value<int?> bankEventId = const Value.absent(),
                Value<bool> dismissed = const Value.absent(),
              }) => PaymentClaimsCompanion.insert(
                id: id,
                app: app,
                sender: sender,
                amountKobo: amountKobo,
                preview: preview,
                previewHash: previewHash,
                claimedAt: claimedAt,
                expiresAt: expiresAt,
                status: status,
                bankEventId: bankEventId,
                dismissed: dismissed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentClaimsTable, PaymentClaim>(table),
                  $$PaymentClaimsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bankEventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankEventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankEventId,
                                referencedTable: $$PaymentClaimsTableReferences._bankEventIdTable(db),
                                referencedColumn: $$PaymentClaimsTableReferences._bankEventIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentClaimsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $PaymentClaimsTable,
      PaymentClaim,
      $$PaymentClaimsTableFilterComposer,
      $$PaymentClaimsTableOrderingComposer,
      $$PaymentClaimsTableAnnotationComposer,
      $$PaymentClaimsTableCreateCompanionBuilder,
      $$PaymentClaimsTableUpdateCompanionBuilder,
      (PaymentClaim, $$PaymentClaimsTableReferences),
      PaymentClaim,
      PrefetchHooks Function({bool bankEventId})
    >;
typedef $$ReceiptChecksTableCreateCompanionBuilder =
    ReceiptChecksCompanion Function({
      Value<int> id,
      Value<int?> amountKobo,
      Value<String?> sender,
      Value<String?> bank,
      Value<DateTime?> receiptTime,
      required String verdict,
      required String reasons,
      Value<int?> bankEventId,
      Value<String?> imageHash,
      Value<DateTime> checkedAt,
    });
typedef $$ReceiptChecksTableUpdateCompanionBuilder =
    ReceiptChecksCompanion Function({
      Value<int> id,
      Value<int?> amountKobo,
      Value<String?> sender,
      Value<String?> bank,
      Value<DateTime?> receiptTime,
      Value<String> verdict,
      Value<String> reasons,
      Value<int?> bankEventId,
      Value<String?> imageHash,
      Value<DateTime> checkedAt,
    });

final class $$ReceiptChecksTableReferences extends BaseReferences<_$EriDb, $ReceiptChecksTable, ReceiptCheck> {
  $$ReceiptChecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BankEventsTable _bankEventIdTable(_$EriDb db) =>
      db.bankEvents.createAlias('receipt_checks__bank_event_id__bank_events__id');

  $$BankEventsTableProcessedTableManager? get bankEventId {
    final $_column = $_itemColumn<int>('bank_event_id');
    if ($_column == null) return null;
    final manager = $$BankEventsTableTableManager($_db, $_db.bankEvents).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankEventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReceiptChecksTableFilterComposer extends Composer<_$EriDb, $ReceiptChecksTable> {
  $$ReceiptChecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bank => $composableBuilder(column: $table.bank, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get receiptTime =>
      $composableBuilder(column: $table.receiptTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get verdict =>
      $composableBuilder(column: $table.verdict, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reasons =>
      $composableBuilder(column: $table.reasons, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageHash =>
      $composableBuilder(column: $table.imageHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => ColumnFilters(column));

  $$BankEventsTableFilterComposer get bankEventId {
    final $$BankEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableFilterComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptChecksTableOrderingComposer extends Composer<_$EriDb, $ReceiptChecksTable> {
  $$ReceiptChecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountKobo =>
      $composableBuilder(column: $table.amountKobo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bank =>
      $composableBuilder(column: $table.bank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get receiptTime =>
      $composableBuilder(column: $table.receiptTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get verdict =>
      $composableBuilder(column: $table.verdict, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reasons =>
      $composableBuilder(column: $table.reasons, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageHash =>
      $composableBuilder(column: $table.imageHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => ColumnOrderings(column));

  $$BankEventsTableOrderingComposer get bankEventId {
    final $$BankEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableOrderingComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptChecksTableAnnotationComposer extends Composer<_$EriDb, $ReceiptChecksTable> {
  $$ReceiptChecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountKobo => $composableBuilder(column: $table.amountKobo, builder: (column) => column);

  GeneratedColumn<String> get sender => $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get bank => $composableBuilder(column: $table.bank, builder: (column) => column);

  GeneratedColumn<DateTime> get receiptTime =>
      $composableBuilder(column: $table.receiptTime, builder: (column) => column);

  GeneratedColumn<String> get verdict => $composableBuilder(column: $table.verdict, builder: (column) => column);

  GeneratedColumn<String> get reasons => $composableBuilder(column: $table.reasons, builder: (column) => column);

  GeneratedColumn<String> get imageHash => $composableBuilder(column: $table.imageHash, builder: (column) => column);

  GeneratedColumn<DateTime> get checkedAt => $composableBuilder(column: $table.checkedAt, builder: (column) => column);

  $$BankEventsTableAnnotationComposer get bankEventId {
    final $$BankEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankEventId,
      referencedTable: $db.bankEvents,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BankEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptChecksTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $ReceiptChecksTable,
          ReceiptCheck,
          $$ReceiptChecksTableFilterComposer,
          $$ReceiptChecksTableOrderingComposer,
          $$ReceiptChecksTableAnnotationComposer,
          $$ReceiptChecksTableCreateCompanionBuilder,
          $$ReceiptChecksTableUpdateCompanionBuilder,
          (ReceiptCheck, $$ReceiptChecksTableReferences),
          ReceiptCheck,
          PrefetchHooks Function({bool bankEventId})
        > {
  $$ReceiptChecksTableTableManager(_$EriDb db, $ReceiptChecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ReceiptChecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ReceiptChecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ReceiptChecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> amountKobo = const Value.absent(),
                Value<String?> sender = const Value.absent(),
                Value<String?> bank = const Value.absent(),
                Value<DateTime?> receiptTime = const Value.absent(),
                Value<String> verdict = const Value.absent(),
                Value<String> reasons = const Value.absent(),
                Value<int?> bankEventId = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<DateTime> checkedAt = const Value.absent(),
              }) => ReceiptChecksCompanion(
                id: id,
                amountKobo: amountKobo,
                sender: sender,
                bank: bank,
                receiptTime: receiptTime,
                verdict: verdict,
                reasons: reasons,
                bankEventId: bankEventId,
                imageHash: imageHash,
                checkedAt: checkedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> amountKobo = const Value.absent(),
                Value<String?> sender = const Value.absent(),
                Value<String?> bank = const Value.absent(),
                Value<DateTime?> receiptTime = const Value.absent(),
                required String verdict,
                required String reasons,
                Value<int?> bankEventId = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<DateTime> checkedAt = const Value.absent(),
              }) => ReceiptChecksCompanion.insert(
                id: id,
                amountKobo: amountKobo,
                sender: sender,
                bank: bank,
                receiptTime: receiptTime,
                verdict: verdict,
                reasons: reasons,
                bankEventId: bankEventId,
                imageHash: imageHash,
                checkedAt: checkedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReceiptChecksTable, ReceiptCheck>(table),
                  $$ReceiptChecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bankEventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankEventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankEventId,
                                referencedTable: $$ReceiptChecksTableReferences._bankEventIdTable(db),
                                referencedColumn: $$ReceiptChecksTableReferences._bankEventIdTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReceiptChecksTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $ReceiptChecksTable,
      ReceiptCheck,
      $$ReceiptChecksTableFilterComposer,
      $$ReceiptChecksTableOrderingComposer,
      $$ReceiptChecksTableAnnotationComposer,
      $$ReceiptChecksTableCreateCompanionBuilder,
      $$ReceiptChecksTableUpdateCompanionBuilder,
      (ReceiptCheck, $$ReceiptChecksTableReferences),
      ReceiptCheck,
      PrefetchHooks Function({bool bankEventId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({required String key, required String value, Value<int> rowid});
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({Value<String> key, Value<String> value, Value<int> rowid});

class $$AppSettingsTableFilterComposer extends Composer<_$EriDb, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer extends Composer<_$EriDb, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer extends Composer<_$EriDb, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key => $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value => $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$EriDb,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSetting, BaseReferences<_$EriDb, $AppSettingsTable, AppSetting>),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$EriDb db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({required String key, required String value, Value<int> rowid = const Value.absent()}) =>
                  AppSettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$EriDb, $AppSettingsTable, AppSetting>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$EriDb,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, BaseReferences<_$EriDb, $AppSettingsTable, AppSetting>),
      AppSetting,
      PrefetchHooks Function()
    >;

class $EriDbManager {
  final _$EriDb _db;
  $EriDbManager(this._db);
  $$RawNotificationsTableTableManager get rawNotifications =>
      $$RawNotificationsTableTableManager(_db, _db.rawNotifications);
  $$BankEventsTableTableManager get bankEvents => $$BankEventsTableTableManager(_db, _db.bankEvents);
  $$ProductsTableTableManager get products => $$ProductsTableTableManager(_db, _db.products);
  $$StockMovementsTableTableManager get stockMovements => $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$OrdersTableTableManager get orders => $$OrdersTableTableManager(_db, _db.orders);
  $$OrderItemsTableTableManager get orderItems => $$OrderItemsTableTableManager(_db, _db.orderItems);
  $$MatchesTableTableManager get matches => $$MatchesTableTableManager(_db, _db.matches);
  $$IgnoreRulesTableTableManager get ignoreRules => $$IgnoreRulesTableTableManager(_db, _db.ignoreRules);
  $$ExpensesTableTableManager get expenses => $$ExpensesTableTableManager(_db, _db.expenses);
  $$PaymentClaimsTableTableManager get paymentClaims => $$PaymentClaimsTableTableManager(_db, _db.paymentClaims);
  $$ReceiptChecksTableTableManager get receiptChecks => $$ReceiptChecksTableTableManager(_db, _db.receiptChecks);
  $$AppSettingsTableTableManager get appSettings => $$AppSettingsTableTableManager(_db, _db.appSettings);
}
