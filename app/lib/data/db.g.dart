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
          PrefetchHooks Function({bool matchesRefs})
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
          prefetchHooksCallback: ({matchesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchesRefs) db.matches],
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
      PrefetchHooks Function({bool matchesRefs})
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
}
