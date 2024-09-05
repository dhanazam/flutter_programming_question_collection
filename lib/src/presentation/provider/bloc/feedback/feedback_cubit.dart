import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_programming_question_collection/src/config/network/connectivity_config.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/base/api_config.dart';
import 'package:flutter_programming_question_collection/src/domain/models/index.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit()
      : _connectivityService = ConnectivityService(),
        super(FeedbackState.unknown());

  void send({required Message message}) async {
    final templateParams = Message(
      email: message.message,
      message: message.message,
    );

    final hasConnection =
        await _connectivityService.hasActiveInternetConnection();
    if (!hasConnection) return null;

    try {
      emit(state.copyWith(loading: true));

      final response = await emailjs.send(
        EmailJS.serviceId,
        EmailJS.templateId,
        templateParams.toJson(),
        emailjs.Options(
          publicKey: ApiConfig().api.toString(),
          privateKey: 't2VnI9oXLNvuYOgc6rrwR',
        ),
      );
      debugPrint(response.toString());
      if (response.status == 200) {
        emit(state.copyWith(
          loading: false,
          event: FeedbackEvents.success,
        ));
        return;
      }
      emit(state.copyWith(
        loading: false,
        event: FeedbackEvents.failure,
        exception: ExceptionModel(description: "error"),
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
