import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/config/network/connectivity_config.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/base/api_config.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:http/http.dart' as http;

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit()
      : _connectivityService = ConnectivityService(),
        super(FeedbackState.unknown());

  void send({required Message message}) async {
    final emailJS = EmailJS(message: message);

    final hasConnection =
        await _connectivityService.hasActiveInternetConnection();
    if (!hasConnection) return null;

    try {
      emit(state.copyWith(loading: true));

      final response = await http.post(
        ApiConfig().api,
        headers: ApiConfig().headers,
        body: json.encode(emailJS.toJson()),
      );
      if (response.statusCode == 200) {
        emit(state.copyWith(
          loading: false,
          event: FeedbackEvents.success,
        ));
        return;
      }
      emit(state.copyWith(
        loading: false,
        event: FeedbackEvents.failure,
        exception: ExceptionModel(description: "${response.reasonPhrase}"),
      ));
    } on SocketException catch (exception) {
      emit(state.copyWith(
        loading: false,
        event: FeedbackEvents.failure,
        exception: ExceptionModel(description: exception.message),
      ));
    }
  }

  late final ConnectivityService _connectivityService;
}
