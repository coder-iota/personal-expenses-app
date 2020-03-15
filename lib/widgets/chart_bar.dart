import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spedingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spedingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${this.spedingAmount.toStringAsFixed(0)}')),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    width: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.86,
                    heightFactor: this.spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(this.label))),
          ],
        );
      },
    );
  }
}
