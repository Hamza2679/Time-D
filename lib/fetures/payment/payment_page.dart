import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';
import '../common/finish_page.dart';

class PaymentPage extends StatefulWidget {
  final double deliveryFee;
  final double totalFee;
  final double totalProductPrice;
  final String orderId;

  PaymentPage({
    required this.deliveryFee,
    required this.totalProductPrice,
    required this.totalFee,
    required this.orderId,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  bool isProcessingPayment = false;

  Future<void> _handlePayNow() async {
    const String url = 'https://hello-delivery.onrender.com/api/v1/payment';
    print('Order id: \$${widget.orderId}');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No access token found. Please log in again.'),
        ));
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "orderId": widget.orderId,
        }),

      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('Response JSON: $responseBody');

        if (responseBody['status'] == 'success' && responseBody['data'] != null && responseBody['data']['checkout_url'] != null) {
          String checkoutUrl = responseBody['data']['checkout_url'];
          Uri uri = Uri.parse(checkoutUrl);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Could not launch the payment URL.'),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Payment initiation failed: Missing checkout URL.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment request failed with status code: ${response.statusCode}'),
        ));
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: primaryTextColor)),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Product price: \$${widget.totalProductPrice.toStringAsFixed(2)}'),
            Text('Delivery Fee: \$${widget.deliveryFee.toStringAsFixed(2)}'),
            Text('Total Fee: \$${widget.totalFee.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text('Select Payment Method:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: Text('Pay Now'),
              value: 'now',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Pay After Delivery'),
              value: 'later',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (_selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a payment method')),
                  );
                  return;
                }

                setState(() {
                  isProcessingPayment = true;
                });

                if (_selectedPaymentMethod == 'now') {
                  await _handlePayNow();
                } else if (_selectedPaymentMethod == 'later') {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FinishPage()));
                }

                setState(() {
                  isProcessingPayment = false;
                });
              },
              child: isProcessingPayment
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryTextColor),
              )
                  : Text(
                'Confirm',
                style: TextStyle(color: primaryTextColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class PaymentWebView extends StatefulWidget {
  final String url;

  PaymentWebView({required this.url});

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
        backgroundColor: Colors.blue, // Customize the color as needed
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.url), // Use WebUri directly with string URL
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, // Ensure JavaScript is enabled for payment pages
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          print('Page started loading: $url');
        },
        onLoadStop: (controller, url) async {
          print('Page finished loading: $url');
        },
        onLoadError: (controller, url, code, message) {
          print('Error loading page: $message');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading page: $message')),
          );
        },
      ),
    );
  }
}
