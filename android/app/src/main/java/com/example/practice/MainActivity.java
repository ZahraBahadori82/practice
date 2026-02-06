package com.example.practice;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.calculator/native";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("calculate")) {
                        try {
                            Map<String, Object> arguments = (Map<String, Object>) call.arguments;
                            double num1 = (double) arguments.get("num1");
                            double num2 = (double) arguments.get("num2");
                            String operator = (String) arguments.get("operator");

                            Calculator calculator = new Calculator();
                            double calculationResult = calculator.performCalculation(num1, num2, operator);

                            result.success(calculationResult);
                        } catch (Exception e) {
                            result.error("CALCULATION_ERROR", e.getMessage(), null);
                        }
                    } else {
                        result.notImplemented();
                    }
                });
    }
}
