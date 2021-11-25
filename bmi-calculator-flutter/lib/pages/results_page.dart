import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/services/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ResultsPage extends StatelessWidget {
  final Calculator calculator;

  ResultsPage({
    @required this.calculator,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 40,
              child: Text(
                'Your Results',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: ReusableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    calculator.getResults().toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    calculator.calculate(),
                    style: kResultNumberStyle,
                  ),
                  Text(
                    calculator.getComments(),
                    style: kResultCommentStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          BottomButton(
            title: 'CHANGE INPUTS',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
